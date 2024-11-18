local item_sprite = Resources.sprite_load(NAMESPACE, "MoltenCoin", path.combine(PATH, "Sprites/Items/moltenCoin.png"), 1, 16, 16)
local coin_sprite = Resources.sprite_load(NAMESPACE, "EfGoldMoltenCoin", path.combine(PATH, "Sprites/Items/Effects/moltenCoin.png"), 6, 5, 5)
local sound = Resources.sfx_load(NAMESPACE, "MoltenCoin", path.combine(PATH, "Sounds/Items/moltenCoin.ogg"))

local moltenCoin = Item.new(NAMESPACE, "moltenCoin")

local packetMoltenCoinProc = Packet.new()

moltenCoin:set_sprite(item_sprite)
moltenCoin:set_tier(Item.TIER.common)
moltenCoin:set_loot_tags(Item.LOOT_TAG.category_damage)

moltenCoin:clear_callbacks()
moltenCoin:onHit(function(actor, victim, damager, stack)
	if math.random() <= 0.06 or damager.attack_flags & Damager.ATTACK_FLAG.force_proc ~= 0 then
		local dot = gm.instance_create(victim.x, victim.y, gm.constants.oDot)
		dot.target = victim.value -- unwrap the Instance
		dot.parent = actor.value
		dot.damage = damager.damage * 0.2
		dot.ticks = 2 + stack * 4
		dot.team = actor.team
		dot.textColor = 4235519
		dot.sprite_index = gm.constants.sSparks9

		victim:sound_play(sound, 1.0, 0.9 + math.random() * 0.2)

		local g = gm.instance_create(victim.x, victim.y, gm.constants.oEfGold)
		g.hspeed = -4 + math.random() * 8
		g.vspeed = -4 + math.random() * 8
		g.sprite_index = coin_sprite
		g.value = stack

		if gm._mod_net_isOnline() then
			local msg = packetMoltenCoinProc:message_begin()
			msg:write_int(victim.x)
			msg:write_int(victim.y)
			msg:write_uint(stack)
			msg:send_to_all()
		end
	end
end)

packetMoltenCoinProc:onReceived(function(msg)
	local x = msg:read_int()
	local y = msg:read_int()
	local stack = msg:read_uint()

	gm.sound_play_at(sound, 1.0, 0.9 + math.random() * 0.2, x, y)

	local g = gm.instance_create(x, y, gm.constants.oEfGold)
	g.hspeed = -4 + math.random() * 8
	g.vspeed = -4 + math.random() * 8
	g.sprite_index = coin_sprite
	g.value = stack
end)
