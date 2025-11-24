local sprite = Sprite.new("DormantFungus", path.combine(PATH, "Sprites/Items/dormantFungus.png"), 1, 18, 18)
local sprite_footstep = Sprite.new("DormantFungusFootstep", path.combine(PATH, "Sprites/Items/Effects/dungus.png"), 8, 14, 24)
local sound = Sound.new("DormantFungus", path.combine(PATH, "Sounds/Items/dormantFungus.ogg"))

local dungus = Item.new("dormantFungus")
dungus:set_sprite(sprite)
dungus:set_tier(ItemTier.COMMON)
dungus.loot_tags = Item.LootTag.CATEGORY_HEALING

ItemLog.new_from_item(dungus)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(dungus:get_holding_actors()) do
		if Instance.exists(actor) then
			local stack = actor:item_count(dungus)
			
			if (math.abs(actor.pHspeed) >= actor.pHmax * 0.98) or actor.pVspeed ~= 0 then
				local data = Instance.get_data(actor)

				if not data.dungusTimer then
					data.dungusTimer = 120
				end
				if data.dungusTimer <= 0 then
					data.dungusTimer = 120
					
					if Net.host then
						actor:heal(math.ceil(actor.maxhp * (1 - 1 / (0.02 * stack + 1))))
					end
					
					actor:sound_play(sound, 1, 0.9 + math.random() * 0.2)
					
					-- copied and pasted from uranium horseshoe basically
					if actor:is_grounded() then
						ssr_create_fadeout(actor.x, actor.bbox_bottom + 1, 1, sprite_footstep, 0.25, 0.05)
					end
				else
					data.dungusTimer = data.dungusTimer - 1
				end
			end
		end
	end
end)


