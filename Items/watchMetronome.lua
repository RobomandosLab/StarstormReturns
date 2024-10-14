-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/watchMetronome.png", 1, false, false, 15, 12)

-- local item = Item.create("starstorm", "watchMetronome")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.uncommon)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_utility)

-- Item.add_callback(item, "onPickup", function(actor, stack)
-- 	log.info("pHmax"..actor.pHmax)
-- 	if stack == 1 then
-- 		--actor.pHmax = actor.pHmax + 2.4
-- 	end
-- end)

-- Item.add_callback(item, "onRemove", function(actor, stack)
-- 	if stack <= 0 then
-- 		--actor.pHmax = actor.pHmax - 2.4
-- 		actor.starstorm_chronoCharge = 0
-- 		actor.starstorm_lastChronoCharge = 0
-- 	end
-- end)

-- Item.add_callback(item, "onStep", function(actor, stack)
-- 	if stack > 0 then
-- 		if not actor.starstorm_lastChronoCharge then actor.starstorm_lastChronoCharge = 0 end
-- 		if not actor.starstorm_chronoCharge then actor.starstorm_chronoCharge = 0 end

		--log.info("chronoCharge"..actor.starstorm_chronoCharge)
		--log.info("lastChrono"..actor.starstorm_lastChronoCharge)

-- 		if actor.pHspeed == 0 or (actor.ropeUp == 0 and actor.ropeDown == 0) then
-- 			actor.starstorm_chronoCharge = math.min(actor.starstorm_chronoCharge + 0.01, 2.4)
-- 		else
-- 			if actor.starstorm_chronoCharge > 0 then
-- 				local calc = 0.01333 / stack
-- 				actor.starstorm_chronoCharge = math.max(actor.starstorm_chronoCharge - calc, 0)
-- 			end
-- 		end
-- 	end
-- 	if actor.starstorm_chronoCharge then
-- 		if actor.starstorm_chronoCharge ~= actor.starstorm_lastChronoCharge then
-- 			local dif = actor.starstorm_chronoCharge - actor.starstorm_lastChronoCharge
-- 			actor.pHmax = actor.pHmax + dif
-- 			--log.info("pHmax"..actor.pHmax)
-- 			--log.info("dif"..dif)
-- 			actor.starstorm_lastChronoCharge = actor.starstorm_chronoCharge
-- 		end
-- 	end
-- end)
