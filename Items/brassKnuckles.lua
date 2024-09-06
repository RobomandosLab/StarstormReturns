--[[ local sprite = Resources.sprite_load(PATH.."Sprites/Items/fork.png", 1, false, false, 16, 16)

local item = Item.create("starstorm", "brassKnuckles")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

Item.add_callback(item, "onAttack", function(actor, damager, stack)
	dis = ((stack * 13) + 17) * 2
	if damager.x-dis <= actor.x and damager.x+dis >= actor.x and damager.y-dis <= actor.y and damager.y+dis >= actor.y then
		log.info("brass knuckles proc")
	end		
end)

Item.add_callback(item, "onDraw", function(actor, stack)
	if stack > 0 then
		dis = (12 + stack * 13) * 2
		gm.draw_set_alpha(0.185)
		gm.draw_set_colour(c_black)
		gm.draw_circle(actor.x, actor.y, dis, true)
	end
end) ]]