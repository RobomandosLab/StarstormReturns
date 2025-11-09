local sprite_item = Sprite.new("StrangeCan", path.combine(PATH, "Sprites/Equipments/strangeCan.png"), 2, 15, 15)
local sprite_projectile = Sprite.new("EfStrangeCan", path.combine(PATH, "Sprites/Equipments/effects/strangeCan.png"), 1, 12, 7)
local sprite_explosion = Sprite.new("EfStrangeCanExplosion", path.combine(PATH, "Sprites/Equipments/effects/strangeCanExplosion.png"), 5, 48, 38)
local sprite_buff = Sprite.new("BuffIntoxication", path.combine(PATH, "Sprites/Buffs/intoxication.png"), 1, 11, 12)

local INTOXICATION_COLOR = Color.from_rgb(126, 182, 134)
local INTOXICATION_RADIUS = 75
local GAS_WIDTH = 200
local GAS_HEIGHT = 50

local sound = Sound.new("IntoxicateApply", path.combine(PATH, "Sounds/Items/strangeCan.ogg"))

local strangeCan = Equipment.new("strangeCan")
strangeCan:set_sprite(sprite_item)
strangeCan.cooldown = 60 * 30
strangeCan.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_equipment(strangeCan)

local efTossedCan = Object.new("EfCan")
efTossedCan:set_sprite(sprite_projectile)
efTossedCan:set_depth(-10)

local efCanGas = Object.new("EfCanGas")

local buff = Buff.new("intoxication")
buff.show_icon = true
buff.icon_sprite = sprite_buff
buff.is_debuff = true
buff.is_timed = false

local radioactive = Particle.find("Radioactive")

local particle = Particle.new("StrangeGas")
particle:set_sprite(gm.constants.sEfCloud, 0, false, false, false)
particle:set_alpha3(0, 0.3, 0)
particle:set_colour1(INTOXICATION_COLOR)
particle:set_orientation(0, 360, 0.5, 0, 0)
particle:set_size(0.4, 1, 0, 0.01)
particle:set_life(90, 120)

Callback.add(strangeCan.on_use, function(actor, embryo)
	local cans = 0
	if embryo then cans = 1 end

	for i = 0, cans do
		local inst = efTossedCan:create(actor.x + 8 * actor.image_xscale, actor.y - 6)
		inst.direction = 90 - actor.image_xscale * (60 - 10 * i)
		inst.speed = 6.5
		inst.team = actor.team
	end
end)

local quality = 3

Callback.add(efTossedCan.on_create, function(self)
	self.gravity = 0.3
	self.team = 1
	quality = Global.__pref_graphics_quality
end)

Callback.add(efTossedCan.on_step, function(self)
	self.image_angle = self.image_angle + 8
	
	if math.random() <= 0.5 * (quality - 1) then
		radioactive:create_color(self.x, self.y, INTOXICATION_COLOR, 1)
	end

	if self:is_colliding(gm.constants.pBlock) or self:is_colliding(gm.constants.pEnemy) then
		local inst = Object.find("EfExplosion"):create(self.x, self.y)
		inst.sprite_index = sprite_explosion

		self:sound_play(gm.constants.wClayDeath, 1, 1.5)
		self:screen_shake(7)

		local target
		local target_hp = -math.huge
		for _, candidate in ipairs(self:get_collisions_circle(gm.constants.pActor, INTOXICATION_RADIUS, self.x, self.y)) do
			if candidate.team ~= self.team then
				-- find enemy that has the highest maxhp, isn't intoxicated, and isn't immune to intoxication
				if candidate.maxhp > target_hp and candidate:buff_count(buff) == 0 and not candidate.buff_immune:get(buff) then
					target = candidate
					target_hp = candidate.maxhp
				end
			end
		end

		if target then
			target:buff_apply(buff, 60)
		end

		self:destroy()
	end
end)

Callback.add(buff.on_apply, function(actor, stack)
	actor:sound_play(sound, 1, 1)
	actor:sound_play(gm.constants.wMushShoot1, 1, 0.7)
end)

Callback.add(Callback.ON_KILL_PROC, function(victim, killer)
	if victim:buff_count(buff) <= 0 then return end
	
	local gas = efCanGas:create(victim.x, victim.bbox_bottom - GAS_HEIGHT * 0.5)
	gas.parent = killer
	gas.team = killer.team
	gas.damage = victim.maxhp * 0.025
end)

Callback.add(efCanGas.on_create, function(self)
	self.parent = -4
	self.team = 1
	self.life = 5 * 60

	self.damage = 10
	self:sound_play(gm.constants.wArtiShoot3_2, 0.5, 0.9 + math.random() * 0.1)

	self:instance_sync()
end)

Callback.add(efCanGas.on_step, function(self)
	if self.life % 2 == 0 then
		local px = self.x - GAS_WIDTH * 0.5 + math.random(GAS_WIDTH)
		local py = self.y - GAS_HEIGHT * 0.5 + math.random(GAS_HEIGHT)
		particle:create(px, py, 1)
	end

	if self.life % 15 == 0 and Net.host then
		for _, target in ipairs(self:get_collisions_rectangle(gm.constants.pActor, self.x - GAS_WIDTH * 0.5, self.y - GAS_HEIGHT * 0.5, self.x + GAS_WIDTH * 0.5, self.y + GAS_HEIGHT * 0.5)) do
			if target.team ~= self.team then
				gm.damage_inflict(target.id, self.damage, 0, self.parent, target.x, target.y, self.damage, self.team, INTOXICATION_COLOR)
			end
		end
	end

	self.life = self.life - 1

	if self.life < 0 then
		self:destroy()
	end
end)
