local sprite_item = Resources.sprite_load(NAMESPACE, "Needles", path.combine(PATH, "Sprites/Items/needles.png"), 1, 16, 15)
local sprite_buff = Resources.sprite_load(NAMESPACE, "BuffNeedles", path.combine(PATH, "Sprites/Buffs/needles.png"), 1, 9, 8)
local sound = Resources.sfx_load(NAMESPACE, "Needles", path.combine(PATH, "Sounds/Items/needles.ogg"))

local needles = Item.new(NAMESPACE, "needles")
needles:set_sprite(sprite_item)
needles:set_tier(Item.TIER.common)
needles:set_loot_tags(Item.LOOT_TAG.category_damage)

local buffNeedles = Buff.new(NAMESPACE, "Needles")
buffNeedles.icon_sprite = sprite_buff
buffNeedles.is_debuff = true

buffNeedlesID = buffNeedles.value

needles:clear_callbacks()
needles:onHitProc(function(actor, victim, stack, hit_info)
	local force_proc = hit_info.attack_info:get_attack_flag(Attack_Info.ATTACK_FLAG.force_proc)
	if (math.random() <= 0.01 + stack * 0.02 or force_proc) and victim:buff_stack_count(buffNeedles) == 0 then
		victim:buff_apply(buffNeedles, 190)
	end
end)

buffNeedles:clear_callbacks()
buffNeedles:onApply(function(actor)
	actor:sound_play(sound, 1, 1)
end)

-- onAttackHit callbacks and such can't be used to increase the damage because by then the visual damage number and crit sound were already decided on.

-- signature:
-- damager_calculate_damage(hit_info, true_hit, hit, damage, critical, parent, proc, attack_flags, damage_col, team, climb, percent_hp, xscale, hit_x, hit_y)
gm.pre_script_hook(gm.constants.damager_calculate_damage, function(self, other, result, args)
	-- RValues, access underlying value using .value
	local _hit = args[3]
	local _damage = args[4]
	local _critical = args[5]

	local needled = gm.has_buff(_hit.value or -4, buffNeedlesID)
	if needled and not gm.bool(_critical.value) then
		_critical.value = true
		_damage.value = _damage.value * 2
	end
end)
