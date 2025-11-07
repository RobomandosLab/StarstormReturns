local item_sprite = Sprite.new("ManOWar", path.combine(PATH, "Sprites/Items/manOWar.png"), 1, 16, 18)

local manOWar = Item.new("manOWar")
manOWar:set_sprite(item_sprite)
manOWar:set_tier(ItemTier.UNCOMMON)
manOWar.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(manOWar)

Callback.add(Callback.ON_KILL_PROC, function(victim, killer)
	local stack = killer:item_count(manOWar)
    if stack <= 0 then return end
	
	local lightning = Object.find("ChainLightning"):create(victim.x, victim.y)
	lightning.team = killer.team
	lightning.damage = killer.damage * (0.6 + 0.4 * stack)
	lightning.bounce = 2
	lightning.blend = Color.from_hex(0xC6AAFF)
	lightning:sound_play(gm.constants.wChainLightning, 0.5, 1.1 + math.random() * 0.2)
end)
