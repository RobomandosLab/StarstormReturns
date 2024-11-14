local sprite = Resources.sprite_load(NAMESPACE, "MoltenCoin", path.combine(PATH, "Sprites/Items/moltenCoin.png"), 1, 16, 16)
local sound = Resources.sfx_load(NAMESPACE, "MoltenCoin", path.combine(PATH, "Sounds/Items/moltenCoin.ogg"))

local moltenCoin = Item.new(NAMESPACE, "moltenCoin")

moltenCoin:set_sprite(sprite)
moltenCoin:set_tier(Item.TIER.common)
moltenCoin:set_loot_tags(Item.LOOT_TAG.category_damage)

moltenCoin:clear_callbacks()
moltenCoin:onHit(function(actor, victim, damager, stack)
	local force_proc = damager.attack_flags & (1 << 29) ~= 0
	if math.random() <= 0.06 or force_proc then
		local dot = gm.instance_create(victim.x, victim.y, gm.constants.oDot)
		dot.target = victim.value -- unwrap the Instance
		dot.parent = actor.value
		dot.damage = damager.damage * 0.2
		dot.ticks = 2 + stack * 4
		dot.team = actor.team
		dot.textColor = 4235519
		dot.sprite_index = gm.constants.sSparks9

		actor:sound_play(sound, 1.0, 0.9 + math.random() * 0.2)

		local g = gm.instance_create(victim.x, victim.y, gm.constants.oEfGold)
		g.hspeed = -4 + math.random() * 8
		g.vspeed = -4 + math.random() * 8
		g.value = stack
	end
end)
