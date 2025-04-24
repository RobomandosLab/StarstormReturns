local sprite_item			= Resources.sprite_load(NAMESPACE, "WhiteFlag", path.combine(PATH, "Sprites/Equipments/whiteFlag.png"), 2, 15, 16)
local sprite_flag_spawn		= Resources.sprite_load(NAMESPACE, "EfWhiteFlagSpawn", path.combine(PATH, "Sprites/Equipments/Effects/whiteFlagSpawn.png"), 13, 32, 45)
local sprite_flag_idle		= Resources.sprite_load(NAMESPACE, "EfWhiteFlagIdle", path.combine(PATH, "Sprites/Equipments/Effects/whiteFlagIdle.png"), 5, 15, 26)
local sprite_buff			= Resources.sprite_load(NAMESPACE, "BuffPeace", path.combine(PATH, "Sprites/Buffs/peace.png"), 1, 10, 10)
local sprite_skill			= Resources.sprite_load(NAMESPACE, "SkillPeace", path.combine(PATH, "Sprites/Buffs/peaceLock.png"), 1, 2, 1)
local sound = Resources.sfx_load(NAMESPACE, "WhiteFlag", path.combine(PATH, "Sounds/Items/whiteFlag.ogg"))

local whiteFlag = Equipment.new(NAMESPACE, "whiteFlag")
whiteFlag:set_sprite(sprite_item)
whiteFlag:set_cooldown(45)
whiteFlag:set_loot_tags(Item.LOOT_TAG.category_utility, Item.LOOT_TAG.equipment_blacklist_chaos)

local buffPeace = Buff.new(NAMESPACE, "peace")
buffPeace.icon_sprite = sprite_buff

local skillPeace = Skill.new(NAMESPACE, "peace")
skillPeace.sprite = sprite_skill
skillPeace.is_primary = true -- prevent icon from graying out
-- ensure this "skill" cannot be activated
skillPeace.max_stock = -math.huge -- prevent backup mag and afterburner from giving it extra stocks
skillPeace.auto_restock = false
skillPeace.start_with_stock = false

local objFlag = Object.new(NAMESPACE, "EfWhiteFlag")
objFlag.obj_sprite = sprite_flag_idle

whiteFlag:clear_callbacks()
whiteFlag:onUse(function(actor, embryo)
	local flag = objFlag:create(actor.x, actor.y)
	if embryo then
		self.life = self.life * 2
	end
end)

objFlag:clear_callbacks()
objFlag:onCreate(function(self)
	self:move_contact_solid(270, -1)
	self.radius = 160
	self.life = 8 * 60

	self.image_speed = 0.25
	self.sprite_index = sprite_flag_spawn

	self:sound_play(sound, 1, 1)
end)
objFlag:onStep(function(self)
	if self.life % 5 == 0 then
		local to_peace = List.wrap(self:find_characters_circle(self.x, self.y, self.radius, false, 3))

		for _, target in ipairs(to_peace) do
			if gm.actor_is_classic(target.id) then
				if target:buff_stack_count(buffPeace) == 0 then
					target:buff_apply(buffPeace, 10)
				else
					GM.set_buff_time_nosync(target, buffPeace, 10)
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
objFlag:onDraw(function(self)
	local a = 0.1 + math.sin(Global._current_frame * 0.02) * 0.05
	a = a * math.min(1, self.life / 15)

	local r1 = self.radius
	local pulse = (self.life % 60) / 60
	local r2 = r1 * (1 - pulse)

	gm.draw_set_alpha(a*10)
	gm.draw_set_colour(Color.WHITE)
	gm.draw_circle(self.x, self.y, r1, true)

	gm.draw_set_alpha(a)
	gm.draw_circle(self.x, self.y, r1, false)

	gm.draw_set_alpha(a * pulse)
	gm.draw_circle(self.x, self.y, r2, false)

	gm.draw_set_alpha(1)
end)

--[[
enum SKILL_OVERRIDE_PRIORITY {
	upgrade,
	boosted,
	reload,
	cancel,
	SIZE
}
--]]
buffPeace:clear_callbacks()
buffPeace:onApply(function(actor)
	for i=1, 4 do
		local slot = actor.skills[i]
		GM._mod_ActorSkillSlot_addOverride(slot, skillPeace, 4) -- SKILL_OVERRIDE_PRIORITY.SIZE
	end
end)
buffPeace:onRemove(function(actor)
	for i=1, 4 do
		local slot = actor.skills[i]
		GM._mod_ActorSkillSlot_removeOverride(slot, skillPeace, 4) -- SKILL_OVERRIDE_PRIORITY.SIZE
	end
end)
