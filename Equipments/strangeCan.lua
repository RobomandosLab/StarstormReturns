local sprite_item = Resources.sprite_load(NAMESPACE, "StrangeCan", path.combine(PATH, "Sprites/Equipments/strangeCan.png"), 2, 15, 15)
local sprite_projectile = Resources.sprite_load(NAMESPACE, "EfStrangeCan", path.combine(PATH, "Sprites/Equipments/effects/strangeCan.png"), 1, 12, 7)
local sprite_explosion = Resources.sprite_load(NAMESPACE, "EfStrangeCanExplosion", path.combine(PATH, "Sprites/Equipments/effects/strangeCanExplosion.png"), 5, 48, 38)
local sprite_buff = Resources.sprite_load(NAMESPACE, "BuffIntoxication", path.combine(PATH, "Sprites/Buffs/intoxication.png"), 1, 11, 12)

local INTOXICATION_COLOR = Color.from_rgb(126, 182, 134)
local INTOXICATION_RADIUS = 96

local sound = Resources.sfx_load(NAMESPACE, "IntoxicateApply", path.combine(PATH, "Sounds/Items/strangeCan.ogg"))

local strangeCan = Equipment.new(NAMESPACE, "strangeCan")
strangeCan:set_sprite(sprite_item)
strangeCan:set_cooldown(45)

local objTossedCan = Object.new(NAMESPACE, "EfCan")
objTossedCan.obj_sprite = sprite_projectile
objTossedCan.obj_depth = -10

local buffIntoxication = Buff.new(NAMESPACE, "intoxication")
buffIntoxication.show_icon = true
buffIntoxication.icon_sprite = sprite_buff
buffIntoxication.is_debuff = true

local particleRadioactive = Particle.find("ror", "Radioactive")

strangeCan:clear_callbacks()
strangeCan:onUse(function(actor, embryo)
	local obj = objTossedCan:create(actor.x + 8 * actor.image_xscale, actor.y-6)
	obj.direction = 90 - actor.image_xscale * 60
	obj.speed = 6
	obj.team = actor.team

	if embryo then
		local obj = objTossedCan:create(actor.x - 8 * actor.image_xscale, actor.y-6)
		obj.direction = 90 + actor.image_xscale * 60
		obj.speed = 6
		obj.team = actor.team
	end
end)

objTossedCan:clear_callbacks()
objTossedCan:onCreate(function(self)
	self.gravity = 0.3
	self.team = 1
end)
objTossedCan:onStep(function(self)
	self.image_angle = self.image_angle + 8
	particleRadioactive:create_color(self.x, self.y, INTOXICATION_COLOR, 1)

	if self:is_colliding(gm.constants.pBlock) then
		local ef = GM.instance_create(self.x, self.y, gm.constants.oEfExplosion)
		ef.sprite_index = sprite_explosion

		self:sound_play(gm.constants.wClayDeath, 1, 1.5)
		self:sound_play(gm.constants.wArtiShoot3_2, 0.5, 0.9 + math.random() * 0.1)
		self:screen_shake(7)

		local victims = List.wrap(self:find_characters_circle(self.x, self.y, INTOXICATION_RADIUS, false, self.team))
		for _, victim in ipairs(victims) do
			victim:buff_apply(buffIntoxication, 7 * 60)
		end

		self:destroy()
	end
end)

buffIntoxication:clear_callbacks()
buffIntoxication:onApply(function(actor, stack)
	actor:get_data().intoxication_timer = 0
	actor:sound_play(sound, 1, 1)
end)
buffIntoxication:onPostStep(function(actor, stack)
	local data = actor:get_data()
	data.intoxication_timer = data.intoxication_timer + 1

	if data.intoxication_timer >= 90 then
		data.intoxication_timer = 0
		local time_left = GM.get_buff_time(actor, buffIntoxication)
		if time_left then
			gm.instance_create(actor.x, actor.y, gm.constants.oBugGuts)
			gm.instance_create(actor.x, actor.y, gm.constants.oBugGuts)

			if gm._mod_net_isHost() then
				local dmg = math.ceil(actor.hp * 0.03 * time_left / 60)
				gm.damage_inflict(actor.id, dmg, 0, -4, actor.x, actor.y, dmg, 1, INTOXICATION_COLOR)
			end
		end
	end
end)
