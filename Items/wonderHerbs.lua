local sprite = Sprite.new("WonderHerbs", path.combine(PATH, "Sprites/Items/wonderHerbs.png"), 1, 16, 16)

local wonderHerbs = Item.new("wonderHerbs")
wonderHerbs:set_sprite(sprite)
wonderHerbs:set_tier(ItemTier.COMMON)
wonderHerbs.loot_tags = Item.LootTag.CATEGORY_HEALING

ItemLog.new_from_item(wonderHerbs)

local HEAL_COLOR = Color.from_rgb(143, 255, 38)

Callback.add(Callback.ON_HEAL, function(actor_unwrapped, amount)
	local actor = Instance.wrap(actor_unwrapped)
	if not Instance.exists(actor) then return end
	
	local stack = actor:item_count(wonderHerbs)
	if stack <= 0 then return end
	
	-- non-regen healing will always be increased by atleast 1
	new_amount = math.max(amount.value * (1 + stack * 0.12), amount.value + 1)
		
	local diff = new_amount - amount.value

	if Net.client then return end -- healing amount cant be changed as client
	amount.value = new_amount
end)

RecalculateStats.add(function(actor)
	local stack = actor:item_count(wonderHerbs)
    if stack <= 0 then return end
	
	actor.hp_regen = actor.hp_regen * (1 + stack * 0.12)
end)
