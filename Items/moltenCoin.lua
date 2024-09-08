local sprite = Resources.sprite_load(PATH.."Sprites/Items/detritiveTrematode.png", 1, false, false, 16, 20)

local item = Item.create("starstorm", "moltenCoin")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)