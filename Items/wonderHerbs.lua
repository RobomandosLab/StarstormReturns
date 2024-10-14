-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/wonderHerbs.png", 1, false, false, 16, 16)

-- local item = Item.create("starstorm", "wonderHerbs")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.common)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_healing)

-- Item.add_callback(item, "onStep", function(actor, stack)
-- 	if stack > 0 then
-- 		if not actor.starstorm_herbLastHP then
-- 			actor.starstorm_herbLastHP = actor.hp
-- 		end
-- 		if actor.starstorm_herbLastHP < actor.hp then
-- 			local dif = actor.hp - actor.starstorm_herbLastHP
-- 			local add = dif * (0.12 * stack)
-- 			actor.hp = actor.hp + add
-- --[[ 			if math.chance(3 + stack) then
-- 				spore particle how???
-- 			end ]]
-- 		end
-- 	end
-- end)

--[[ Item.add_callback(item, "onHeal", function(actor, amount, stack)
	if stack > 0 then
		amount = amount * 9999
	end
end) ]]
