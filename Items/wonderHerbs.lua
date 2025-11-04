local sprite = Sprite.new("WonderHerbs", path.combine(PATH, "Sprites/Items/wonderHerbs.png"), 1, 16, 16)

local wonderHerbs = Item.new("wonderHerbs")
wonderHerbs:set_sprite(sprite)
wonderHerbs:set_tier(ItemTier.COMMON)
wonderHerbs.loot_tags = Item.LootTag.CATEGORY_HEALING

ItemLog.new_from_item(wonderHerbs)

local HEAL_COLOR = Color.from_rgb(143, 255, 38)

local preserve_number

Hook.add_pre(gm.constants.actor_heal_networked, function(self, other, result, args)
	local actor = args[1].value
	if not Instance.exists(actor) then return end
	
	local stack = actor:item_count(wonderHerbs)
	if stack <= 0 then return end
	
	local in_amount = args[2].value
	local is_passive = args[3].value
	preserve_number = in_amount

	local mult = 1 + stack * 0.12
	
	-- non-regen healing will always be increased by atleast 1
	new_amount = math.max(in_amount * mult, in_amount + 1)
		
	local diff = new_amount - in_amount
	gm.draw_damage(actor.x, actor.bbox_top + 8, diff, 0, HEAL_COLOR, 4, 0)

	args[2].value = new_amount
end, Callback.Priority.AFTER)

-- the argument is set back to its unmodified value to avoid weird inconsistencies where some cases end up modifying the vanilla healing number and others don't
-- it's weird and annoying and stupid and i hate it, but it is what it is
Hook.add_post(gm.constants.actor_heal_networked, function(self, other, result, args)
	if preserve_number then
		args[2].value = preserve_number
		preserve_number = nil
	end
end)

RecalculateStats.add(function(actor)
	local stack = actor:item_count(wonderHerbs)
    if stack <= 0 then return end
	
	actor.hp_regen = actor.hp_regen * (1 + stack * 0.12)
end)
