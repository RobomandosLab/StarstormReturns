local sprite_item = Resources.sprite_load(NAMESPACE, "StrangeCan", path.combine(PATH, "Sprites/Equipments/strangeCan.png"), 2, 15, 15)
local sprite_projectile = Resources.sprite_load(NAMESPACE, "EfStrangeCan", path.combine(PATH, "Sprites/Equipments/effects/strangeCan.png"), 1, 12, 7)
local sprite_explosion = Resources.sprite_load(NAMESPACE, "EfStrangeCanExplosion", path.combine(PATH, "Sprites/Equipments/effects/strangeCanExplosion.png"), 5, 48, 38)
local sprite_buff = Resources.sprite_load(NAMESPACE, "BuffIntoxication", path.combine(PATH, "Sprites/Buffs/intoxication.png"), 1, 11, 12)

local INTOXICATION_COLOR = Color.from_rgb(126, 182, 134)
local INTOXICATION_RADIUS = 75
local GAS_WIDTH = 200
local GAS_HEIGHT = 50

local sound = Resources.sfx_load(NAMESPACE, "IntoxicateApply", path.combine(PATH, "Sounds/Items/strangeCan.ogg"))

local strangeCan = Equipment.new(NAMESPACE, "strangeCan")
strangeCan:set_sprite(sprite_item)
strangeCan:set_cooldown(30)
strangeCan:set_loot_tags(Item.LOOT_TAG.category_damage)

local objTossedCan = Object.new(NAMESPACE, "EfCan")
objTossedCan.obj_sprite = sprite_projectile
objTossedCan.obj_depth = -10

local objCanGas = Object.new(NAMESPACE, "EfCanGas")

local buffIntoxication = Buff.new(NAMESPACE, "intoxication")
buffIntoxication.show_icon = true
buffIntoxication.icon_sprite = sprite_buff
buffIntoxication.is_debuff = true
buffIntoxication.is_timed = false

local particleRadioactive = Particle.find("ror", "Radioactive")

local particleGas = Particle.new(NAMESPACE, "StrangeGas")
particleGas:set_sprite(gm.constants.sEfCloud, 0, false, false, false)
particleGas:set_alpha3(0, 0.3, 0)
particleGas:set_colour1(INTOXICATION_COLOR)
particleGas:set_orientation(0, 360, 0.5, 0, 0)
particleGas:set_size(0.4, 1, 0, 0.01)
particleGas:set_life(90, 120)

strangeCan:clear_callbacks()
strangeCan:onUse(function(actor, embryo)
	local c = 1
	if embryo then c = 2 end

	for i=1, c do
		local obj = objTossedCan:create(actor.x + 8 * actor.image_xscale, actor.y-6)
		obj.direction = 90 - actor.image_xscale * 60
		obj.speed = 6.5
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

	if self:is_colliding(gm.constants.pBlock) or self:is_colliding(gm.constants.pEnemy) then
		local ef = GM.instance_create(self.x, self.y, gm.constants.oEfExplosion)
		ef.sprite_index = sprite_explosion

		self:sound_play(gm.constants.wClayDeath, 1, 1.5)
		self:screen_shake(7)

		local victims = List.wrap(self:find_characters_circle(self.x, self.y, INTOXICATION_RADIUS, false, self.team))
		local target
		local target_hp = -math.huge
		for _, candidate in ipairs(victims) do
			-- find enemy that has the highest maxhp, isn't intoxicated, and isn't immune to intoxication
			if candidate.maxhp > target_hp and candidate:buff_stack_count(buffIntoxication) == 0 and not candidate.buff_immune:get(buffIntoxication) then
				target = candidate
				target_hp = candidate.maxhp
			end
		end

		if target then
			target:buff_apply(buffIntoxication, 60)
		end

		self:destroy()
	end
end)

buffIntoxication:clear_callbacks()
buffIntoxication:onApply(function(actor, stack)
	actor:sound_play(sound, 1, 1)
	actor:sound_play(gm.constants.wMushShoot1, 1, 0.7)
end)

Callback.add(Callback.TYPE.onKillProc, "SSStrangeCanDetonate", function(victim, killer)
	if victim:buff_stack_count(buffIntoxication) > 0 then
		local gas = objCanGas:create(victim.x, victim.bbox_bottom - GAS_HEIGHT * 0.5)
		gas.parent = killer
		gas.team = killer.team
		gas.damage = victim.maxhp * 0.025
	end
end)

objCanGas:clear_callbacks()
objCanGas:onCreate(function(self)
	self.parent = -4
	self.team = 1
	self.life = 5 * 60

	self.damage = 10
	self:sound_play(gm.constants.wArtiShoot3_2, 0.5, 0.9 + math.random() * 0.1)

	self:instance_sync()
end)
objCanGas:onStep(function(self)
	if self.life % 2 == 0 then
		local px = self.x - GAS_WIDTH * 0.5 + math.random(GAS_WIDTH)
		local py = self.y - GAS_HEIGHT * 0.5 + math.random(GAS_HEIGHT)
		particleGas:create(px, py, 1)
	end

	if self.life % 15 == 0 and gm._mod_net_isHost() then
		local victims = List.wrap(self:find_characters_rectangle(self.x - GAS_WIDTH*0.5, self.y - GAS_HEIGHT*0.5, self.x + GAS_WIDTH*0.5, self.y + GAS_HEIGHT*0.5, self.team, false))
		for _, target in ipairs(victims) do
			gm.damage_inflict(target.id, self.damage, 0, self.parent, target.x, target.y, self.damage, self.team, INTOXICATION_COLOR)
		end
	end

	self.life = self.life - 1

	if self.life < 0 then
		self:destroy()
	end
end)
