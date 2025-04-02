local item_sprite = Resources.sprite_load(NAMESPACE, "DetritiveTrematode", path.combine(PATH, "Sprites/Items/detritiveTrematode.png"), 1, 16, 20)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffDisease", path.combine(PATH, "Sprites/Buffs/disease.png"), 1, 8, 8)

local DAMAGE_COLOR = Color.from_rgb(187, 211, 91)

local detritiveTrematode = Item.new(NAMESPACE, "detritiveTrematode")
detritiveTrematode:set_sprite(item_sprite)
detritiveTrematode:set_tier(Item.TIER.common)
detritiveTrematode:set_loot_tags(Item.LOOT_TAG.category_damage)
local detritiveTrematodeID = detritiveTrematode.value

local buffDisease = Buff.new(NAMESPACE, "disease")
buffDisease.icon_sprite = buff_sprite
buffDisease.is_debuff = true
buffDisease.is_timed = false
buffDiseaseID = buffDisease.value

detritiveTrematode:clear_callbacks()
-- this effect honestly looks ugly ..?? idk
--[[
local effect_blend_color = Color.from_rgb(128, 128, 0)
detritiveTrematode:onPostDraw(function(actor, stack)
	local preserve_alpha, preserve_blend = actor.image_alpha, actor.image_blend

	actor.image_alpha = 0.25
	actor.image_blend = effect_blend_color
	gm.actor_drawscript_call(actor.value, actor.ghost_x, actor.ghost_y, 0, 0)

	actor.image_alpha = preserve_alpha
	actor.image_blend = preserve_blend
end)
--]]

buffDisease:clear_callbacks()
buffDisease:onApply(function(actor, stack)
	actor:sound_play(gm.constants.wBrambleShoot1, 0.8, 0.4 + math.random() * 0.2)
end)
buffDisease:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end
	if Global._current_frame % 30 == 0 then
		local dmg = actor.__ssr_trematode_damage or 1
		gm.damage_inflict(actor.id, dmg, 0, -4, actor.x, actor.y, dmg, 1, DAMAGE_COLOR)
	end
end)

-- can't use attack callbacks because they run before the actual hp is decreased, so just hook this instead
gm.post_script_hook(gm.constants.damager_hit_process, function(self, other, result, args)
	local _hit_info = args[1].value
	local _target = args[2].value
	local _parent = _hit_info.parent

	if gm.instance_exists(_target) == 0.0 then return end
	if gm.instance_exists(_parent) == 0.0 then return end
	if gm.get_buff_stack(_target, buffDiseaseID) > 0 then return end

	local count = gm.item_count(_parent or -4, detritiveTrematodeID) or 0

	if count > 0 then
		local target = Instance.wrap(_target) -- sometimes _target is an instance ID, so gotta wrap it for the dot syntax
		if target.hp <= 0 then return end

		local threshold = 0.1 + 0.05 * count

		if target.hp <= target.maxhp * threshold then
			target:buff_apply(buffDisease, 60)
			target.__ssr_trematode_damage = _parent.damage * 0.5
		end
	end
end)
