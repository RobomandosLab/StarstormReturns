-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/fork.png", 1, false, false, 16, 16)

-- local item = Item.create("starstorm", "fork")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.common)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

-- Item.add_callback(item, "onPickup", function(actor, stack)
-- 	actor.damage_base = actor.damage_base + 3
-- end)

-- Item.add_callback(item, "onRemove", function(actor, stack)
-- 	actor.damage_base = actor.damage_base - 3
-- end)
 local sprite = Resources.sprite_load("starstormreturns", "item/fork", PATH.."Sprites/Items/fork.png", 1, 16, 16)


    local item = Item.new("starstormreturns", "fork")
    item:set_sprite(sprite)
    item:set_tier(Item.TIER.common)
    item:set_loot_tags(Item.LOOT_TAG.category_damage)
        


    item:onPostStatRecalc(function(actor)
    actor.damage = actor.damage + 5
    end)

    item:onRemove(actor, stack_count)
    item:onPostStatRecalc(function(actor)
    actor.damage = actor.damage + 5
    end)
