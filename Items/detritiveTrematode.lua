local item_sprite = Resources.sprite_load(NAMESPACE, "DetritiveTrematode", path.combine(PATH, "Sprites/Items/detritiveTrematode.png"), 1, 16, 20)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffDisease", path.combine(PATH, "Sprites/Buffs/disease.png"), 1, 8, 8)

local detritiveTrematode = Item.new(NAMESPACE, "detritiveTrematode")
detritiveTrematode:set_sprite(item_sprite)
detritiveTrematode:set_tier(Item.TIER.common)
detritiveTrematode:set_loot_tags(Item.LOOT_TAG.category_damage)

local buffDisease = Buff.new(NAMESPACE, "disease")

detritiveTrematode:clear_callbacks()
detritiveTrematode:onAttackHit(function(actor, victim, stack, hit_info)
	victim = GM.attack_collision_resolve(victim)

	if not Instance.exists(victim) then return end

	--local threshold = ((0.9 + stack / 1.2) * 0.033)
	threshold = 0.05 + 0.05 * stack
	threshold = GM.actor_get_maxhp_total(victim) * threshold
	if victim.hp - hit_info.damage < threshold then
		victim:buff_apply(buffDisease, 7 * 60)
	end
end)

local effect_blend_color = Color.from_rgb(128, 128, 0)
detritiveTrematode:onPostDraw(function(actor, stack)
	local preserve_alpha, preserve_blend = actor.image_alpha, actor.image_blend

	actor.image_alpha = 0.25
	actor.image_blend = effect_blend_color
	gm.actor_drawscript_call(actor.value, actor.ghost_x, actor.ghost_y, 0, 0)

	actor.image_alpha = preserve_alpha
	actor.image_blend = preserve_blend
end)

buffDisease.icon_sprite = buff_sprite
buffDisease.is_debuff = true

local disease_damage_color = Color.from_rgb(187, 211, 91)

buffDisease:clear_callbacks()
buffDisease:onApply(function(actor, stack)
	actor:get_data().disease_timer = 0
end)
buffDisease:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	local data = actor:get_data()
	if data.disease_timer >= 30 then
		data.disease_timer = 0
		local dmg = actor.maxhp * 0.01
		actor:damage_inflict(actor, dmg, 0, -4, actor.x, actor.y, dmg, 1, disease_damage_color)
	else
		data.disease_timer = data.disease_timer + 1
	end
end)
