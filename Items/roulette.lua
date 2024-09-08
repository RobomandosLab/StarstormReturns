local sprite = Resources.sprite_load(PATH.."Sprites/Items/Roulette/roulette.png", 1, false, false, 16, 16)

local item = Item.create("starstorm", "roulette")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.uncommon)
Item.set_loot_tags(item, Item.LOOT_TAG.category_utility)

Item.add_callback(item, "onStep", function(actor, stack)
    if stack > 0 then
        if not actor.ssr_roulette_cooldown then
            actor.ssr_roulette_cooldown = 60
        end

        if actor.ssr_roulette_cooldown <= 0 then
            actor.ssr_roulette_cooldown = 60
            log.info("Roulette triggered!!")
        else
            actor.ssr_roulette_cooldown = actor.ssr_roulette_cooldown - 1
        end
    end
end)