local sprite = Resources.sprite_load(PATH.."Sprites/Items/crypticSource.png", 1, false, false, 16, 16)

local item = Item.create("starstorm", "crypticSource")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.uncommon)
Item.set_loot_tags(item, Item.LOOT_TAG.category_utility)

Item.add_callback(item, "onStep", function(actor, stack)
    if stack > 0 then
        if not actor.lastxscale then actor.lastxscale = actor.xscale end

        if not actor.cscd then
			if actor.lastxscale == actor.xscale * -1 then
				log.info("Crypitc Source triggered!!")
                actor.cscd = 10
                actor.lastxscale = actor.xscale
			end
		else
			if actor.cscd > 0 then
				actor.cscd = actor.cscd - 1
			else
				actor.cscd = nil
			end
		end
        
    end
end)

