-- hi its azuline again
-- this is my fav artifact from ss1 btw :3 anyways this one is pretty simple i wont be explaining much
-- btw this should prolly be redone a bit to account for nucleus gems when that gets added

local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringLoadout", path.combine(PATH, "Sprites/Artifacts/Gathering/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringPickup", path.combine(PATH, "Sprites/Artifacts/Gathering/pickup.png"), 1, 20, 20)

local gathering = Artifact.new(NAMESPACE, "gathering")
gathering:set_sprites(loadout, pickup)

-- OLD CODE THAT DOESNT USE post_code_execute BUT RUNS LIKE SHIT
-- TBH post_code_execute CODE STILL RUNS LIKE SHIT JUST A BIT LESS SO
-- GOD IM HOPING RETURNS API COMES OUT SOONER THAN LATER

--Callback.add(Callback.TYPE.postStep, "GatheringCoins", function()
--	if not gathering.active then return end
--	
--	for _, gold in ipairs(Instance.find_all(gm.constants.oEfGold)) do
--		local data = gold:get_data()

--		if not data.gatheringGold then
--			data.gatheringGold = true
--			gold.value.value = gold.value.value * 2 -- we have to use value.value because value is already a thing that returns a cinstance in rmt
--			data.life = 1000
--		end

--		if gold:alarm_get(1) ~= -1 then -- alarm 1 controls whether the gold is homing in on the player or not
--			gold:alarm_set(1, -1) -- setting it to -1 if it isnt already -1 makes it not home in
--		end

--		-- alarm 2 controls whether the gold is being picked up
--		-- whether this alarm is active or not is based on alarm 1, and since we stopped alarm 1 this wont work on its own
--		if gold:alarm_get(2) == -1 and gold:is_colliding(gm.constants.oP) then -- solution? activate the alarm manually when a coin is colliding with a player object
--			gold:alarm_set(2, 3)
--		end

--		if (data.life or 0) > 0 then
--			data.life = data.life - 1
--			if data.life < 100 and data.life % 10 < 2 then -- make it blink when about to disappear!!
--				gold.visible = false
--			else
--				gold.visible = true
--			end
--		else
--			gold:destroy()
--		end
--	end
--end)

gm.post_code_execute("gml_Object_oEfGold_Create_0", function(gold, other)
	if not gathering.active then return end
	gold.life = 1000
end)

gm.pre_code_execute("gml_Object_oEfGold_Step_2", function(gold, other)
	if not gathering.active then return end
	if not gold.gathering then -- for some reason this doesnt work if set in post create code
		gold.value = gold.value * 2 -- we have to use value.value because value is already a thing that returns a cinstance in rmt
		gold.gathering = true
	end
	
	if gold:alarm_get(1) ~= -1 then -- alarm 1 controls whether the gold is homing in on the player or not
		gold:alarm_set(1, -1) -- setting it to -1 if it isnt already -1 makes it not home in
	end
	
	-- alarm 2 controls whether the gold is being picked up
	-- whether this alarm is active or not is based on alarm 1, and since we stopped alarm 1 this wont work on its own
	if gold:alarm_get(2) == -1 and gold:place_meeting(gold.x, gold.y, gm.constants.oP) == 1.0 then -- solution? activate the alarm manually when a coin is colliding with a player object
		gold:alarm_set(2, 3)
	end
	
	if (gold.life or 0) > 0 then
		gold.life = gold.life - 1
		if gold.life < 100 and gold.life % 10 < 2 then -- make it blink when about to disappear!!
			gold.visible = false
		else
			gold.visible = true
		end
	else
		gm.instance_destroy(gold)
	end
end)
