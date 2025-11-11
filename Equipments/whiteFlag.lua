local sprite_item			= Sprite.new("WhiteFlag", path.combine(PATH, "Sprites/Equipments/whiteFlag.png"), 2, 15, 16)
local sprite_flag_spawn		= Sprite.new("EfWhiteFlagSpawn", path.combine(PATH, "Sprites/Equipments/Effects/whiteFlagSpawn.png"), 13, 32, 45)
local sprite_flag_idle		= Sprite.new("EfWhiteFlagIdle", path.combine(PATH, "Sprites/Equipments/Effects/whiteFlagIdle.png"), 5, 15, 26)
local sprite_buff			= Sprite.new("BuffPeace", path.combine(PATH, "Sprites/Buffs/peace.png"), 1, 10, 10)
local sprite_skill			= Sprite.new("SkillPeace", path.combine(PATH, "Sprites/Buffs/peaceLock.png"), 1, 2, 1)
local sound 				= Sound.new("WhiteFlag", path.combine(PATH, "Sounds/Items/whiteFlag.ogg"))

local whiteFlag = Equipment.new("whiteFlag")
whiteFlag:set_sprite(sprite_item)
whiteFlag.cooldown = 45 * 60
whiteFlag.loot_tags = Item.LootTag.CATEGORY_UTILITY + Item.LootTag.EQUIPMENT_BLACKLIST_CHAOS

ItemLog.new_from_equipment(whiteFlag)

local buff = Buff.new("peace")
buff.icon_sprite = sprite_buff

local skill = Skill.new("peace")
skill.sprite = sprite_skill
skill.is_primary = true -- prevent icon from graying out

-- ensure this "skill" cannot be activated
skill.max_stock = -math.huge -- prevent backup mag and afterburner from giving it extra stocks
skill.auto_restock = false
skill.start_with_stock = false

local efFlag = Object.new("EfWhiteFlag")
efFlag:set_sprite(sprite_flag_idle)

Callback.add(whiteFlag.on_use, function(self, embryo)
	local flag = efFlag:create(self.x, self.y)
	if embryo then
		self.life = self.life * 2
	end
end)

Callback.add(efFlag.on_create, function(self)
	self:move_contact_solid(270, -1)
	self.radius = 160
	self.life = 8 * 60

	self.image_speed = 0.25
	self.sprite_index = sprite_flag_spawn

	self:sound_play(sound, 1, 1)
end)

Callback.add(efFlag.on_step, function(self)
	if self.life % 5 == 0 then
		for _, target in ipairs(self:get_collisions_circle(gm.constants.pActor, self.radius, self.x, self.y)) do
			if gm.actor_is_classic(target.id) then
				if target:buff_count(buff) == 0 then
					target:buff_apply(buff, 10)
				else
					GM.set_buff_time_nosync(target, buff, 10)
				end
			end
		end
	end

	if self.sprite_index == sprite_flag_spawn and self.image_index + self.image_speed >= 13 then
		self.image_index = 0
		self.sprite_index = sprite_flag_idle
	end

	self.life = self.life - 1
	self.image_alpha = self.life / 15
	if self.life < 0 then
		self:destroy()
	end
end)

Callback.add(efFlag.on_draw, function(self)
	local a = 0.1 + math.sin(Global._current_frame * 0.02) * 0.05
	a = a * math.min(1, self.life / 15)

	local r1 = self.radius
	local pulse = (self.life % 60) / 60
	local r2 = r1 * (1 - pulse)

	gm.draw_set_alpha(a * 10)
	gm.draw_set_colour(Color.WHITE)
	gm.draw_circle(self.x, self.y, r1, true)

	gm.draw_set_alpha(a)
	gm.draw_circle(self.x, self.y, r1, false)

	gm.draw_set_alpha(a * pulse)
	gm.draw_circle(self.x, self.y, r2, false)

	gm.draw_set_alpha(1)
end)

Callback.add(buff.on_apply, function(actor)
	for i = 0, 3 do
		actor:add_skill_override(i, skill, math.huge)
	end
end)

Callback.add(buff.on_remove, function(actor)
	for i = 0, 3 do
		actor:remove_skill_override(i, skill, math.huge)
	end
end)
