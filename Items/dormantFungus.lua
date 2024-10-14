-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/dormantFungus.png", 1, false, false, 18, 18)
-- local sound = Resources.sfx_load(PATH.."Sounds/dormantFungus.ogg")

-- -- local item = Item.create("starstorm", "dormantFungus")
-- -- Item.set_sprite(item, sprite)
-- -- Item.set_tier(item, Item.TIER.common)
-- -- Item.set_loot_tags(item, Item.LOOT_TAG.category_healing)

-- Item.add_callback(item, "onStep", function(actor, stack)
--     if stack > 0 then
--         if actor.pHspeed ~= 0 or actor.pVspeed ~= 0 then
--             if not actor.starstorm_dungusTimer then
--                 actor.starstorm_dungusTimer = 120
--             end
--             if actor.hp < actor.maxhp then
--                 if actor.starstorm_dungusTimer <= 0 then
--                     actor.starstorm_dungusTimer = 120
--                     local dfregen = math.ceil(actor.maxhp * (1 - 1 / (0.02 * stack + 1)))
--                     gm.sound_play_at(sound, 1, (0.9 + math.random() * 0.2), actor.x, actor.y, false)
--                     Actor.heal(actor, dfregen)
--                 else
--                     actor.starstorm_dungusTimer = actor.starstorm_dungusTimer - 1
--                 end
--             end
--         end
--     end
-- end)


