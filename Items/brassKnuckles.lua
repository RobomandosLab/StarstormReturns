local sprite = Resources.sprite_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sprites/Items/brassKnuckles.png"), 1, 15, 12)
local sound = Resources.sfx_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sounds/brassKnuckles.ogg"))

local brassKnuckles = Item.new(NAMESPACE, "brassKnuckles")
brassKnuckles:set_sprite(sprite)
brassKnuckles:set_tier(Item.TIER.common)
brassKnuckles:set_loot_tags(Item.LOOT_TAG.category_damage)

brassKnuckles:clear_callbacks()
brassKnuckles:onDraw(function(actor, stack)
	if actor.visible == 0.0 then return end -- remove once the toolkit handles this correctly

	local radius = 30 + stack * 30
	gm.draw_set_alpha(0.185)
	gm.draw_set_colour(0)
	gm.draw_circle(actor.x, actor.y, radius-1, true)
	gm.draw_circle(actor.x, actor.y, radius+1, true)
	gm.draw_set_alpha(1)
end)

-- toolkit's Item:onHit callback doesn't provide the per-hit info struct, and we *need* it in order to modify the damage, so...
Callback.add("onAttackHit", "SSBrassKnuckles", function(self, other, result, args)
	local hit_info = args[2].value
	local actor = Instance.wrap(hit_info.inflictor)

	if not actor:exists() then return end -- chain lightning effects have an inflictor of -4 ...

	local stack = actor:item_stack_count(brassKnuckles)

	if stack > 0 then
		local attack_info = hit_info.attack_info
		local victim = Instance.wrap(hit_info.target_true)

		local radius = 35 + stack * 30
		local dx = victim.x - actor.x
		local dy = victim.y - actor.y
		if (dx * dx + dy * dy) <= (radius * radius) then
			hit_info.damage = hit_info.damage * 1.35
			actor:sound_play(sound, 0.55, 0.8 + math.random() * 0.4)

			gm.draw_damage(victim.x, victim.bbox_top+2, math.ceil(attack_info.damage*0.35), attack_info.critical, 12632256, attack_info.team, attack_info.climb)
		end
	end
end)
