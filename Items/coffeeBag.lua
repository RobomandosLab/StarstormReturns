local item_sprite = Resources.sprite_load(NAMESPACE, "CoffeeBag", path.combine(PATH, "Sprites/Items/coffeeBag.png"), 1, 16, 16)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffCoffee", path.combine(PATH, "Sprites/Buffs/coffeeBuff.png"), 8, 7, 7)

local coffeeBuff = Buff.new(NAMESPACE, "coffeeBuff")

local coffeeBag = Item.new(NAMESPACE, "coffeeBag")
coffeeBag:set_sprite(item_sprite)
coffeeBag:set_tier(Item.TIER.common)
coffeeBag:set_loot_tags(Item.LOOT_TAG.category_utility)

coffeeBag:clear_callbacks()
coffeeBag:onInteractableActivate(function(actor, stack, interactable)
    actor:buff_apply(coffeeBuff, 60 * (5 + stack * 5))
end)

coffeeBuff.icon_sprite = buff_sprite
coffeeBuff.icon_frame_speed = 0.2

coffeeBuff:clear_callbacks()
coffeeBuff:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax + 0.6
	actor.attack_speed = actor.attack_speed + 0.22
end)
