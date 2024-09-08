local sprite = Resources.sprite_load(PATH.."Sprites/Items/CoffeeBag/coffeeBag.png", 1, false, false, 16, 16)

-- Item 
local item = Item.create("starstorm", "coffeeBag")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_utility)

Item.add_callback(item, "onInteract", function(actor, interactable, stack)
    Buff.apply(actor, Buff.find("starstorm-coffeeBuff"), (4 * stack))
end)

-- Buff
local increase = 2.8 * 0.4 -- TODO: Change this to the actual value

local buff = Buff.create("starstorm", "coffeeBuff")
Buff.set_property(buff, Buff.PROPERTY.icon_sprite, sprite)
Buff.set_property(buff, Buff.PROPERTY.icon_stack_subimage, false)

Buff.add_callback(buff, "onApply", function(actor, stack)
    actor.pHmax_base = actor.pHmax_base + increase
    -- TODO: Do I need to do attack speed I forget....
end)

Buff.add_callback(buff, "onRemove", function(actor, stack)
    actor.pHmax_base = actor.pHmax_base - increase
    -- TODO: Do I need to do attack speed I forget....
end)