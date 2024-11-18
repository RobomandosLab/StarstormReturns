local sprite = Resources.sprite_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sprites/Items/brassKnuckles.png"), 1, 15, 12)
local sound = Resources.sfx_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sounds/Items/brassKnuckles.ogg"))

local brassKnuckles = Item.new(NAMESPACE, "brassKnuckles")
brassKnuckles:set_sprite(sprite)
brassKnuckles:set_tier(Item.TIER.common)
brassKnuckles:set_loot_tags(Item.LOOT_TAG.category_damage)

brassKnuckles:clear_callbacks()
brassKnuckles:onHit(function(actor, victim, attack_info, stack, hit_info)
	local radius = 35 + stack * 30
	local dx = victim.x - actor.x
	local dy = victim.y - actor.y
	if (dx * dx + dy * dy) <= (radius * radius) then
		hit_info.damage = hit_info.damage * 1.35
		gm.sound_play_networked(sound, 0.55, 0.8 + math.random() * 0.4, actor.x, actor.y)

		gm.draw_damage_networked(victim.x, victim.bbox_top+2, math.ceil(attack_info.damage*0.35), attack_info.critical, damage_color, attack_info.team, attack_info.climb)
	end
end, true) -- "all_damage" ..

damage_color = Color.from_rgb(192, 192, 192)
brassKnuckles:onDraw(function(actor, stack)
	local radius = 30 + stack * 30
	gm.draw_set_alpha(0.2)
	gm.draw_set_colour(0)
	gm.draw_circle(actor.ghost_x, actor.ghost_y, radius-1, true)
	gm.draw_circle(actor.ghost_x, actor.ghost_y, radius+1, true)
	gm.draw_set_alpha(1)
end)
