-- hi its azuline again
-- this is my fav artifact from ss1 btw :3 anyways this one is pretty simple i wont be explaining much
-- btw this should prolly be redone a bit to account for nucleus gems when that gets added

local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringLoadout", path.combine(PATH, "Sprites/Artifacts/Gathering/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringPickup", path.combine(PATH, "Sprites/Artifacts/Gathering/pickup.png"), 1, 20, 20)

local gathering = Artifact.new(NAMESPACE, "gathering")
gathering:set_sprites(loadout, pickup)

Callback.add(Callback.TYPE.postStep, "Gathering", function()
	if not gathering.active then return end
	
	for _, gold in ipairs(Instance.find_all(gm.constants.oEfGold)) do
		local data = gold:get_data()
		if not data.gatheringGold then
			data.gatheringGold = true
			gold.value.value = gold.value.value * 2 -- we have to use value.value because value is already a thing that returns a cinstance in rmt
			data.life = 1000
		end
		if gold:alarm_get(1) ~= -1 then -- alarm 1 controls whether the gold is homing in on the player or not
			gold:alarm_set(1, -1) -- setting it to -1 if it isnt already -1 makes it not home in
		end
		-- alarm 2 controls whether the gold is being picked up
		-- whether this alarm is active or not is based on alarm 1, and since we stopped alarm 1 this wont work on its own
		if gold:alarm_get(2) == -1 and gold:is_colliding(gm.constants.oP) then -- solution? activate the alarm manually when a coin is colliding with a player object
			gold:alarm_set(2, 3)
		end
		local n = 0
		while gold:is_colliding(gm.constants.pBlock, gold.x, gold.y) and n < 20 do -- if a coin is inside collision we push it up a little so it doesnt get stuck
			gold.y = gold.y - 1
			n = n + 1
		end
		if (data.life or 0) > 0 then
			data.life = data.life - 1
			if data.life < 100 and data.life % 10 < 2 then -- make it blink when about to dissapear!!
				gold.visible = false
			else
				gold.visible = true
			end
		else
			gold:destroy()
		end
	end
end)