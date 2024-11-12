local item_sprite = Resources.sprite_load(NAMESPACE, "DetritiveTrematode", path.combine(PATH, "Sprites/Items/detritiveTrematode.png"), 1, 16, 20)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffDisease", path.combine(PATH, "Sprites/Buffs/disease.png"), 1, 8, 8)

local buffDisease = Buff.new(NAMESPACE, "disease")

local detritiveTrematode = Item.new(NAMESPACE, "detritiveTrematode")
detritiveTrematode:set_sprite(item_sprite)
detritiveTrematode:set_tier(Item.TIER.common)
detritiveTrematode:set_loot_tags(Item.LOOT_TAG.category_damage)

detritiveTrematode:clear_callbacks()
detritiveTrematode:onHit(function(actor, victim, damager, stack)
	if victim.parent then victim = victim.parent end -- account for brambles and other such sillies

	if not victim.maxhp then -- ran into this error once but couldn't replicate it -- i wanna catch it next time
		error("victim has no maxhp?? name: ", victim.value.object_name)
	end

	local threshold = ((0.9 + stack / 1.2) * 0.033)
	threshold = victim.maxhp * threshold
	if victim.hp - damager.damage < threshold then
		victim:buff_apply(buffDisease, 7 * 60)
	end
end, true)

detritiveTrematode:onDraw(function(actor, stack)
	if actor.visible == 0.0 then return end
	local preserve_alpha, preserve_blend = actor.image_alpha, actor.image_blend

	actor.image_alpha = 0.25
	actor.image_blend = 32896
	gm.actor_drawscript_call(actor.value, actor.x, actor.y, 0, 0)

	actor.image_alpha = preserve_alpha
	actor.image_blend = preserve_blend
end)

buffDisease.icon_sprite = buff_sprite
buffDisease.icon_stack_subimage = false
buffDisease.draw_stack_number = false
buffDisease.max_stack = 1
buffDisease.is_debuff = true

local disease_damage_color = Color.from_rgb(187, 211, 91)

buffDisease:clear_callbacks()
buffDisease:onStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	if math.fmod(gm.variable_global_get("_current_frame"), 60) == 0 then
		local dmg = actor.maxhp * 0.04
		actor:damage_inflict(actor, dmg, 0, -4, actor.x, actor.y, dmg, 1, disease_damage_color)
	end
end)
