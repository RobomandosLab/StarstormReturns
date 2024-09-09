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
			local dot = gm.instance_create(victim.x, victim.y, gm.constants.oDot)
            dot.target = victim -- maybe needs to be victim.id
            dot.parent = actor
            dot.damage= 1 -- use actual damage
            dot.ticks= 5
            dot.team= actor.team
            --dot.textColor = gm.constants.C_ORANGE
            dot.sprite_index = gm.constants.sSparks9

            -- Idk if this is gonna work but cant seem to find a way to add gold, maybe its an instance variable on actor?
            gm.drop_gold_and_exp(actor.x, actor.y, 2)
		end
	end
end)