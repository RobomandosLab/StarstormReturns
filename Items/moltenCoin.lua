local sprite = Resources.sprite_load(PATH.."Sprites/Items/moltenCoin.png", 1, false, false, 16, 16)

local item = Item.create("starstorm", "moltenCoin")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

Item.add_callback(item, "onHit", function(actor, victim, damager, stack)
	if stack > 0 then
		if Helper.chance(0.06) then
            log.info("Molten Coin triggered!!")
            --[[ TODO: Play a sound effect here, and grant money
            ]]
			Buff.apply(victim, Buff.find("hot"), (4 * stack))

            -- Idk if this is gonna work
            gm.drop_gold_and_exp(actor.x, actor.y, 500)
		end
	end
end)