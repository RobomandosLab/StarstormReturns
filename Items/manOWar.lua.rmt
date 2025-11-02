local item_sprite = Resources.sprite_load(NAMESPACE, "ManOWar", path.combine(PATH, "Sprites/Items/manOWar.png"), 1, 16, 18)

local EFFECT_COLOR = Color.from_hex(0xC6AAFF)

local manOWar = Item.new(NAMESPACE, "manOWar")
manOWar:set_sprite(item_sprite)
manOWar:set_tier(Item.TIER.uncommon)
manOWar:set_loot_tags(Item.LOOT_TAG.category_damage)

manOWar:clear_callbacks()
manOWar:onKillProc(function(killer, victim, stack)
	local lightning = GM.instance_create(victim.x, victim.y, gm.constants.oChainLightning)
	lightning.team = killer.team
	lightning.damage = killer.damage * (0.6 + 0.4 * stack)
	lightning.bounce = 2
	lightning.blend = EFFECT_COLOR

	gm.sound_play_at(gm.constants.wChainLightning, 1.1 + math.random() * 0.2, 0.5, victim.x, victim.y)
end)
