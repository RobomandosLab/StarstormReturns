local sprite = Sprite.new("x4Stimulant", path.combine(PATH, "Sprites/Items/x4Stimulant.png"), 1, 16, 16)

local REGEN = 2 / 60
local REGEN_STACK = 1 / 60

local x4Stimulant = Item.new("x4Stimulant")
x4Stimulant:set_sprite(sprite)
x4Stimulant:set_tier(ItemTier.COMMON)
x4Stimulant.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(x4Stimulant)

local x4Buff = Buff.new("x4Stimulant")
x4Buff.show_icon = false

local particleHeal = Particle.find("Heal")

RecalculateStats.add(function(actor, api)
	local stack = actor:buff_count(x4Buff)
    if stack <= 0 then return end
	
	api.hp_regen_mult(REGEN + REGEN_STACK * (actor:item_count(x4Stimulant) - 1))
end)

RecalculateStats.add(function(actor)
	local stack = actor:item_count(x4Stimulant)
    if stack <= 0 then return end
	
	local secondary = actor:get_active_skill(Skill.Slot.SECONDARY)

	-- counts in frames. has to be rounded otherwise the cooldown stopwatch breaks !
	local mult = 0.9 ^ stack
	secondary.cooldown = math.ceil(secondary.cooldown * mult)
end)

Callback.add(Callback.ON_SKILL_ACTIVATE, function(actor, slot)
    if slot ~= Skill.Slot.SECONDARY then return end

    local stack = actor:item_count(x4Stimulant)
    if stack <= 0 then return end
	
    actor:buff_apply(x4Buff, 60 * 3)
end)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(x4Buff:get_holding_actors()) do
		if Instance.exists(actor) then
			if math.random() < 0.15 then
				particleHeal:create(actor.x - 4 + math.random() * 8, actor.y - 6 + math.random() * 12, 1)
			end
		end
	end
end)