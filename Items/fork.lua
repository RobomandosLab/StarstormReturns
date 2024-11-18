local sprite_fork = Resources.sprite_load(NAMESPACE, "Fork", path.combine(PATH, "Sprites/Items/fork.png"), 1, 16, 16)

local fork = Item.new(NAMESPACE, "fork")
fork:set_sprite(sprite_fork)
fork:set_tier(Item.TIER.common)
fork:set_loot_tags(Item.LOOT_TAG.category_damage)

fork:clear_callbacks()
fork:onStatRecalc(function(actor, stack)
	actor.damage = actor.damage + 3 * stack
end)
