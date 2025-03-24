local item_sprite = Resources.sprite_load(NAMESPACE, "GuardingAmulet", path.combine(PATH, "Sprites/Items/guardingAmulet.png"), 1, 17, 17)
local effect_sprite = Resources.sprite_load(NAMESPACE, "EfGuardingAmulet", path.combine(PATH, "Sprites/Items/Effects/guardingAmulet.png"), 1, 4, 9)
local sound = Resources.sfx_load(NAMESPACE, "GuardingAmulet", path.combine(PATH, "Sounds/Items/guardingAmulet.ogg"))

local DAMAGE_MULTIPLIER = 0.6

local guardingAmulet = Item.new(NAMESPACE, "guardingAmulet")
guardingAmulet:set_sprite(item_sprite)
guardingAmulet:set_tier(Item.TIER.common)
guardingAmulet:set_loot_tags(Item.LOOT_TAG.category_utility)

local packetAmuletProc = Packet.new()
local function do_guard_fx(actor)
	actor:get_data().amulet_pulse = 10
	actor:sound_play(sound, 1, 0.9 + math.random() * 0.2)
	actor:sound_play(gm.constants.wMercenary_Parry_Deflection, 0.5, 1.5 + math.random() * 0.5)

	if gm._mod_net_isOnline() and gm._mod_net_isHost() then
		local msg = packetAmuletProc:message_begin()
		msg:write_instance(actor)
		msg:send_to_all()
	end
end
packetAmuletProc:onReceived(function(buffer)
	local actor = buffer:read_instance()
	if actor:exists() then
		do_guard_fx(actor)
	end
end)

Callback.add(Callback.TYPE.onAttackHit, "SSGuardingAmulet", function(hit_info)
	local stack = hit_info.target:item_stack_count(guardingAmulet)
	if stack == 0 then return end
	if not Instance.exists(hit_info.inflictor) then return end

	local victim = hit_info.target
	local attacker = hit_info.inflictor

	local block = false
	local attack_x = attacker.x

	if gm.sign(victim.x - attack_x) == victim.image_xscale then
		block = true
	end

	if block then
		do_guard_fx(victim)
		hit_info.damage = math.ceil(hit_info.damage * DAMAGE_MULTIPLIER ^ stack)
	end
end)

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
	local f = Global._current_frame
	local x = actor.ghost_x - 10 * actor.image_xscale
	local y = actor.ghost_y + math.sin(f * 0.04)
	local a = 0.75 + math.sin(f * 0.02) * 0.1

	local pulse = actor:get_data().amulet_pulse * 0.2
	local xscale = (1 + pulse) * actor.image_xscale
	local yscale = 1 + pulse

	gm.gpu_set_blendmode(1)
	gm.draw_sprite_ext( effect_sprite, 0, x, y, xscale, yscale, 0, Color.WHITE, a)
	if pulse > 0 then
		gm.draw_sprite_ext( effect_sprite, 0, x, y, xscale, yscale, 0, Color.WHITE, pulse * 3)
	end
	gm.gpu_set_blendmode(0)
end)
