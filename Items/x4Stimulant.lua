local sprite = Resources.sprite_load(PATH.."Sprites/Items/x4Stimulant.png", 1, false, false, 16, 16)

local item = Item.create("starstorm", "x4Stimulant")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_utility)

local cooldownReduction = 0.10

Item.add_callback(item, "onPickup", function(actor, stack)
	--[[ TODO: Lower secondary skill cooldown]]
    log.info("X4 onPickup triggered!!")
    gm.array_get(actor.skills, 1).active_skill.cooldown = 1
end)

Item.add_callback(item, "onRemove", function(actor, stack)
	--[[ TODO: Undo changes to secondary skill cooldown]]
    log.info("X4 onRemove triggered!!")
    gm.array_get(actor.skills, 1).active_skill.cooldown = 1
end)
