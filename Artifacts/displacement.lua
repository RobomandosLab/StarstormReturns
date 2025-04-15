-- hey its me azzy!! azzy-artifacts!!
-- ill be refering to the stage number as its "tier" here. for example: dried lake is tier 1, magma barracks is tier 4, temple of the elders is 5, risk of rain is 6, etc
-- ill be refering to the stage itself as "environment"
local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfDisplacementLoadout", path.combine(PATH, "Sprites/Artifacts/Displacement/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfDisplacementPickup", path.combine(PATH, "Sprites/Artifacts/Displacement/pickup.png"), 1, 20, 20)

local displacement = Artifact.new(NAMESPACE, "displacement")
displacement:set_sprites(loadout, pickup)

local validStages = List.new() -- the stages that the artifact can bring you to
	for i = 1, 5 do -- go through 5 tiers of stages, we exclude tier 6 because we dont want to randomly go to risk of rain
		local progression = List.wrap(gm._mod_stage_get_pool_list(i)) -- get all environments in a tier
		for _, stage in ipairs(progression) do
			validStages:add(stage) -- add each environment to a list called validStages
		end
	end

Callback.add(Callback.TYPE.onStageStart, "DisplacementSetStage", function()
	if not displacement.active then return end
	
	local currentStage = gm._mod_game_getCurrentStage() -- get the current environment
	local director = GM._mod_game_getDirector() -- get the director
	local randomStage = math.random(1, #validStages) -- pick a random environment from validStages list
	local displacedStage = validStages[randomStage]
	while displacedStage == currentStage do -- we dont want the same environment to repeat twice in a row
		displacedStage = math.random(1, #validStages) -- so if the current environment is the same as the upcoming one, set the next environment to a different random one
	end
	director.stage_queue_index = displacedStage -- make the director transport you to the selected environment once you activate the teleporter
end)