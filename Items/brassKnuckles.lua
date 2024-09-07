local sprite = Resources.sprite_load(PATH.."Sprites/Items/brassKnuckles.png", 1, false, false, 15, 12)

local item = Item.create("starstorm", "brassKnuckles")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

Item.add_callback(item, "onHit", function(actor, victim, damager, stack)
	if stack > 0 then
		dis = (stack * 30) + 30
		dx = victim.x - actor.x
		dy = victim.y - actor.y
		if (dx * dx + dy * dy) <= (dis * dis) then
			Actor.damage(victim, actor, damager.damage * 0.35, victim.x + 20, victim.y - 35, 12632256, false)
		end
	end
end)

Item.add_callback(item, "onAttackHandleStart", function(actor, victim, damager, stack)
	log.info("attackhandlestart!!!")
end)

Item.add_callback(item, "onDraw", function(actor, stack)
	if stack > 0 then
		dis = (stack * 30) + 30
		gm.draw_set_alpha(0.185)
		gm.draw_set_colour(0)
		gm.draw_circle(actor.x, actor.y, dis, true)
		gm.draw_set_alpha(1)
	end
end)