local item_sprite = Resources.sprite_load(NAMESPACE, "GuardingAmulet", path.combine(PATH, "Sprites/Items/guardingAmulet.png"), 1, 19, 16)
local effect_sprite = Resources.sprite_load(NAMESPACE, "EfGuardingAmulet", path.combine(PATH, "Sprites/Items/Effects/guardingAmulet.png"), 1, 4, 9)
local sound = Resources.sfx_load(NAMESPACE, "GuardingAmulet", path.combine(PATH, "Sounds/Items/guardingAmulet.ogg"))

local DAMAGE_MULTIPLIER = 0.6

local guardingAmulet = Item.new(NAMESPACE, "guardingAmulet")
guardingAmulet:set_sprite(item_sprite)
guardingAmulet:set_tier(Item.TIER.common)
guardingAmulet:set_loot_tags(Item.LOOT_TAG.category_utility)

local guardingAmuletID = guardingAmulet.value

local function get_true_xscale(actor)
	if actor.object_index == gm.constants.oEngiTurret then
		return actor.image_xscale2
	end
	return actor.image_xscale
end

local function should_amulet_be_active(actor)
	if gm.actor_state_is_climb_state(actor.actor_state_current_id) then
		return false
	end
	return true
end

guardingAmulet:clear_callbacks()
guardingAmulet:onAcquire(function(actor, stack)
	actor:get_data().amulet_pulse = 0
end)
guardingAmulet:onPostStep(function(actor, stack)
	local data = actor:get_data()
	if data.amulet_pulse > 0 then
		data.amulet_pulse = data.amulet_pulse - 1
	end
end)
guardingAmulet:onPostDraw(function(actor, stack)
	if not should_amulet_be_active(actor) then return end

	local actor_xscale = get_true_xscale(actor)

	local x, y = math.floor(actor.ghost_x+0.5), math.floor(actor.ghost_y+0.5)

	local f = Global._current_frame
	local x = x - 10 * actor_xscale
	local y = y + math.sin(f * 0.04)
	local a = 0.75 + math.sin(f * 0.02) * 0.1

	local pulse = actor:get_data().amulet_pulse * 0.2
	local xscale = (1 + pulse) * actor_xscale
	local yscale = 1 + pulse

	gm.gpu_set_blendmode(1)
	gm.draw_sprite_ext( effect_sprite, 0, x, y, xscale, yscale, 0, Color.WHITE, a)
	if pulse > 0 then
		gm.draw_sprite_ext( effect_sprite, 0, x, y, xscale, yscale, 0, Color.WHITE, pulse * 3)
	end
	gm.gpu_set_blendmode(0)
end)


-- onAttackHit callbacks and such can't be used to modify the damage because by then the visual damage number was already drawn.

-- signature:
-- damager_calculate_damage(hit_info, true_hit, hit, damage, critical, parent, proc, attack_flags, damage_col, team, climb, percent_hp, xscale, hit_x, hit_y)
gm.pre_script_hook(gm.constants.damager_calculate_damage, function(self, other, result, args)
	--local _true_hit = args[2]
	local _hit = args[3]
	local _damage = args[4]
	--local _critical = args[5]
	local _parent = args[6]
	--local _proc = args[7]
	--local _attack_flags = args[8]
	--local _damage_col = args[9]
	--local _team = args[10]
	--local _climb = args[11]
	--local _percent_hp = args[12]
	--local _xscale = args[13]
	local _hit_x = args[14]
	local _hit_y = args[15]

	local count = gm.item_count(_hit.value or -4, guardingAmuletID) or 0
	if count > 0 then
		local attacker = Instance.wrap(_parent.value)
		local target = Instance.wrap(_hit.value)

		if not should_amulet_be_active(target) then return end

		local attack_x = attacker.x or _hit_x.value

		-- use the x locations of the actors to determine blocking .... not ideal but it works?
		if gm.sign(target.x - attack_x) == get_true_xscale(target) then
			_damage.value = math.ceil(_damage.value * DAMAGE_MULTIPLIER ^ count)

			target:get_data().amulet_pulse = 10
			target:sound_play(sound, 1, 0.9 + math.random() * 0.2)
			target:sound_play(gm.constants.wMercenary_Parry_Deflection, 0.5, 1.5 + math.random() * 0.5)
		end
	end
end)
