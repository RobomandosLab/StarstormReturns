local sprite = Sprite.new("CoffeeBag", path.combine(PATH, "Sprites/Items/coffeeBag.png"), 1, 16, 16)
local buff_sprite = Sprite.new("BuffCoffee", path.combine(PATH, "Sprites/Buffs/coffeeBuff.png"), 8, 7, 7)

local coffeeBuff = Buff.new("coffeeBuff")
coffeeBuff.icon_sprite = buff_sprite
coffeeBuff.icon_frame_speed = 0.2

local coffeeBag = Item.new("coffeeBag")
coffeeBag:set_sprite(sprite)
coffeeBag:set_tier(ItemTier.COMMON)
coffeeBag.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(coffeeBag)

Callback.add(Callback.ON_INTERACTABLE_ACTIVATE, function(interactable, actor)
	local stack = actor:item_count(coffeeBag)
	if stack <= 0 then return end
	
	actor:buff_apply(coffeeBuff, 60 * (5 + stack * 5))
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(coffeeBuff)
	if stack <= 0 then return end 
	
	actor.pHmax = actor.pHmax + 0.6
	actor.attack_speed = actor.attack_speed + 0.22	
end)