if HOTLOADING then return end
if not ssr_chirrsmas_active then return end -- christmas lasts from december 15th to january 15th
if Settings.chirrsmas == 2 then return end -- if chirrsmas is disabled in the config then we dont do anything

-- Stage resources
local snow = Object.new("SnowyRORSnow")

Callback.add(snow.on_create, function(self)
	local data = Instance.get_data(self)
	data.quality = Global.__pref_graphics_quality
	data.timer = 0
end)

Callback.add(snow.on_step, function(self)
	local data = Instance.get_data(self)
	
	if data.timer <= 3 then
		data.timer = data.timer + 1
	else
		data.timer = 0
	end
	
	for i=0, data.quality do
		if data.quality >= 2 and data.timer % 3 == 0 then
			Particle.find("Snow"):create((Global.___view_l_x - (Global.___view_l_w / 2)) + math.random(Global.___view_l_w * 1.5), Global.___view_l_y, data.quality - 1)
		end
	end
end)

Sprite.new("RiskofRainTile_Snowy", 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRiskofRainTile.png"), 2, 0, 0)
Sprite.new("RoR_Containers_Snowy", 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRoR_Containers.png"), 2, 0, 0)

gm.sprite_replace(gm.constants.bSpacer_M_CL, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M_CL.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSpacer_M2_CL, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M2_CL.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRoR_BG, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRoR_BG.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRange1, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRange1.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRange2, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRange2.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bWater_CL, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyWater_CL.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds2, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds2.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds3, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds3.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds4, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds4.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunrise2, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunrise2.png"), 2, false, false, 0, 0)

GM.background_set_megasprite(gm.constants.bRange1)
GM.background_set_megasprite(gm.constants.bRange2)
GM.background_set_megasprite(gm.constants.bWater_CL)
GM.background_set_megasprite(gm.constants.bSunsetClouds4)
GM.tile_render_init_final(Sprite.find("RiskofRainTile_Snowy"))
GM.tile_render_init_final(Sprite.find("RoR_Containers_Snowy"))

-- Stage
local cl_stage = Stage.new("riskOfRainSnowy")
cl_stage.music_id = Stage.find("riskOfRain").music_id
cl_stage.token_name = Stage.find("riskOfRain").token_name
cl_stage.token_subname = Stage.find("riskOfRain").token_subname
cl_stage.teleporter_index = Stage.find("riskOfRain").teleporter_index
cl_stage.interactable_spawn_points = Stage.find("riskOfRain").interactable_spawn_points
cl_stage.spawn_interactable_rarity = Stage.find("riskOfRain").spawn_interactable_rarity
cl_stage.spawn_enemies = Stage.find("riskOfRain").spawn_enemies
cl_stage.spawn_enemies_loop = Stage.find("riskOfRain").spawn_enemies_loop
cl_stage.spawn_interactables = Stage.find("riskOfRain").spawn_interactables
cl_stage.spawn_interactables_loop = Stage.find("riskOfRain").spawn_interactables_loop
cl_stage.allow_mountain_shrine_spawn = Stage.find("riskOfRain").allow_mountain_shrine_spawn
cl_stage.is_new_stage = Stage.find("riskOfRain").is_new_stage
cl_stage.populate_biome_properties = Stage.find("riskOfRain").populate_biome_properties
cl_stage.log_id = Stage.find("riskOfRain").log_id

-- Spawn list
cl_stage:add_interactable(InteractableCard.find("chirrsmasPresent"))
cl_stage:add_monster(MonsterCard.find("golem"))

-- Rooms
Stage.add_room(cl_stage, path.combine(PATH.."/Stages/SnowyRiskOfRain", "riskOfRain1_snowy.rorlvl"))
Stage.add_room(cl_stage, path.combine(PATH.."/Stages/SnowyRiskOfRain", "riskOfRain2_snowy.rorlvl"))