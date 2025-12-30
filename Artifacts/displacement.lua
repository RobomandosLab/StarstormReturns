-- hey its me azzy!! azzy-artifacts!! (this joke probably wont work since the branch will be merged with winslows) (oh well)
-- this one is kinda hard so ill try to explain literally everything lmao
-- ill be refering to the stage number as its "tier" here. for example, without the artifact of displacement active dried lake is tier 1, magma barracks is tier 4, temple of the elders is 5, risk of rain is 6, etc
-- ill be refering to the stage itself as "environment" or "env"
local loadout = Sprite.new("ArtifactOfDisplacementLoadout", path.combine(PATH, "Sprites/Artifacts/Displacement/loadout.png"), 3, 19, 19)
local pickup = Sprite.new("ArtifactOfDisplacementPickup", path.combine(PATH, "Sprites/Artifacts/Displacement/pickup.png"), 1, 20, 20)

local displacement = Artifact.new("displacement")
displacement.sprite_loadout_id = loadout
displacement.sprite_pickup_id = pickup

local potentialEnvs = List.new() -- this is where we will put environments that are available for random selection
local validEnvs = List.new() -- this is where we will put all valid environments (no boar beach cuz its a secret and no risk of rain cuz its a final environment for example)
	
local hook = Hook.add_post(gm.constants.stage_roll_next, function(self, other, result, args)
	if not displacement.active then return end
	
	validEnvs:clear()
	
	for i = 1, 4 do -- go through 4 tiers of stages, we exclude tier 6 because we dont want to randomly go to risk of rain, and we exclude tier 5 stages because artifact of tempus can easily be cheesed if temple of the elders is chosen as one of the first stages (it also breaks the onstep code of the artifact's object for some reason? no clue why)
		local envs = List.wrap(gm._mod_stage_get_pool_list(i)) -- get all environments in a tier
		for _, env in ipairs(envs) do
			validEnvs:add(env) -- add each environment to validEnvs
		end
	end
	
	if not validEnvs:contains(result.value) then return end -- if the original environment isnt a valid one, dont run the rest of the code
	
	-- reset the list of potential environments every time you wouldve visited a tier 1 environment (so essentially after looping or starting the game)
	if args[1].value == 1 then -- if the upcoming stage is tier 1 >>
		potentialEnvs:clear() -- >> clear the list of potential environments
		-- >> restore the list to include all environments again
		for i = 1, 4 do
			local envs = List.wrap(gm._mod_stage_get_pool_list(i))
			for _, env in ipairs(envs) do
				potentialEnvs:add(env)
			end
		end
	end
	
	local randomEnv = math.random(1, #potentialEnvs) -- pick a random environment from list of potential environments
	local upcomingEnv = potentialEnvs[randomEnv] -- set the next environment to the one picked above
	
	result.value = upcomingEnv -- make the script transport you to the upcoming environment instead of the usual one
	
	-- delete the selected environment from the list of potential ones so we dont encounter it again
	for _, env in ipairs(potentialEnvs) do
		if env == upcomingEnv then
			potentialEnvs:delete(potentialEnvs:find(env))
		end
	end
end)

-- disable the artifact initially
hook:toggle(false)

Callback.add(displacement.on_set_active, function(active)
	hook:toggle(active)
end)

