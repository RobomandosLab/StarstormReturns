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
	if math.random() <= 0.02 + stack * 0.02 then
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
	--local _true_hit = args[2]
	local _hit = args[3]
	local _damage = args[4]
	local _critical = args[5]
	--local _parent = args[6]
	--local _proc = args[7]
	--local _attack_flags = args[8]
	--local _damage_col = args[9]
	--local _team = args[10]
	--local _climb = args[11]
	--local _percent_hp = args[12]
	--local _xscale = args[13]
	--local _hit_x = args[14]
	--local _hit_y = args[15]

	if gm.get_buff_stack(_hit.value, buffNeedlesID) > 0 and Helper.is_false(_critical.value) then
		_critical.value = true
		_damage.value = _damage.value * 2
	end
end)
