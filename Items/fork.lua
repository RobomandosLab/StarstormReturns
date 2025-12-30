local sprite_fork = Sprite.new("Fork", path.combine(PATH, "Sprites/Items/fork.png"), 1, 16, 16)

local fork = Item.new("fork")
fork:set_sprite(sprite_fork)
fork:set_tier(ItemTier.COMMON)
fork.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(fork)

RecalculateStats.add(function(actor, api)
	local stack = actor:item_count(fork)
    if stack <= 0 then return end
	
	api.damage_add(3 * stack)
end)
