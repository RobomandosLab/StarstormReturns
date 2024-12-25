local sprite = Resources.sprite_load(NAMESPACE, "x4Stimulant", path.combine(PATH, "Sprites/Items/x4Stimulant.png"), 1, 16, 16)

local x4Stimulant = Item.new(NAMESPACE, "x4Stimulant")
x4Stimulant:set_sprite(sprite)
x4Stimulant:set_tier(Item.TIER.common)
x4Stimulant:set_loot_tags(Item.LOOT_TAG.category_utility)

x4Stimulant:clear_callbacks()
x4Stimulant:onStatRecalc(function(actor, stack)
	local secondary = actor:get_active_skill(Skill.SLOT.secondary)

	-- counts in frames. has to be rounded otherwise the cooldown stopwatch breaks !
	local mult = 0.9 ^ stack
	secondary.cooldown = math.ceil(secondary.cooldown * mult)
end)

local x4Buff = Buff.new(NAMESPACE, "x4Stimulant")
x4Buff.show_icon = false

x4Stimulant:onSecondaryUse(function(actor, stack)
	actor:buff_apply(x4Buff, 60 * 3)
end)

local REGEN = 2 / 60
local REGEN_STACK = 1 / 60

x4Buff:clear_callbacks()
x4Buff:onStatRecalc(function(actor, stack)
	actor.hp_regen = actor.hp_regen + REGEN + REGEN_STACK * (actor:item_stack_count(x4Stimulant) - 1)
end)
