local sprite = Resources.sprite_load(NAMESPACE, "DormantFungus", path.combine(PATH, "Sprites/Items/dormantFungus.png"), 1, 18, 18)
local sound = Resources.sfx_load(NAMESPACE, "DormantFungus", path.combine(PATH, "Sounds/Items/dormantFungus.ogg"))

local dormantFungus = Item.new(NAMESPACE, "dormantFungus")
dormantFungus:set_sprite(sprite)
dormantFungus:set_tier(Item.TIER.common)
dormantFungus:set_loot_tags(Item.LOOT_TAG.category_healing)

dormantFungus:clear_callbacks()
dormantFungus:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	if (math.abs(actor.pHspeed) >= actor.pHmax * 0.98) or actor.pVspeed ~= 0 then
		local actor_data = actor:get_data()

		if not actor_data.dungusTimer then
			actor_data.dungusTimer = 120
		end
		if actor.hp < actor.maxhp then
			if actor_data.dungusTimer <= 0 then
				actor_data.dungusTimer = 120

				local regen = math.ceil(actor.maxhp * (1 - 1 / (0.02 * stack + 1)))
				actor:heal(regen)
				gm.sound_play_networked(sound, 1, (0.9 + math.random() * 0.2), actor.x, actor.y)
			else
				actor_data.dungusTimer = actor_data.dungusTimer - 1
			end
		end
	end
end)


