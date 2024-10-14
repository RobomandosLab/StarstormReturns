-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/crypticSource.png", 1, false, false, 16, 16)

-- local item = Item.create("starstorm", "crypticSource")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.uncommon)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_utility)

-- Item.add_callback(item, "onStep", function(actor, stack)
--     if stack > 0 then
--         if not actor.ssr_lastxscale then actor.ssr_lastxscale = actor.xscale end

--         if not actor.ssr_cscd then
-- 			if actor.ssr_lastxscale == actor.xscale * -1 then
-- 				log.info("Crypitc Source triggered!!")
--                 actor.ssr_cscd = 10
--                 actor.ssr_lastxscale = actor.xscale
				
-- 				-- TODO: Clean up this code
-- 				local t = gm.instance_create(actor.x, actor.y, gm.constants.oChainLightning)
-- 				t.parent = actor
-- 				t.team = actor.team
-- 				t.damage = 5 --damage / 3 * (critical + 1)
-- 				--t.critical = critical
-- 			end
-- 		else
-- 			if actor.ssr_cscd > 0 then
-- 				actor.ssr_cscd = actor.ssr_cscd - 1
-- 			else
-- 				actor.ssr_cscd = nil
-- 			end
-- 		end
        
--     end
-- end)

