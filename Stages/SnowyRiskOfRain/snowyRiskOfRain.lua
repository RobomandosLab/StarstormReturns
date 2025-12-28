--if HOTLOADING then return end
if not ssr_chirrsmas_active then return end -- christmas lasts from december 15th to january 15th
if Settings.chirrsmas == 2 then return end -- if chirrsmas is disabled in the config then we dont do anything

-- Stage resources
Sprite.new("RiskofRainTile_Snowy", 				 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRiskofRainTile.png"), 2, 0, 0)
Sprite.new("RoR_Containers_Snowy", 				 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRoR_Containers.png"), 2, 0, 0)
Sprite.new("Spacer_M_CL_Snowy", 				 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M_CL.png"), 1, 0, 0)
Sprite.new("Spacer_M2_CL_Snowy", 				 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M2_CL.png"), 1, 0, 0)

gm.sprite_replace(gm.constants.bRoR_BG, 		 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRoR_BG.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRange1, 		 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRange1.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRange2, 			path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRange2.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bWater_CL, 		 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyWater_CL.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds, 	 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds2,	 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds2.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds3, 	 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds3.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds4, 	 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds4.png"), 4, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunrise2, 		 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunrise2.png"), 2, false, false, 0, 0)

gm.sprite_replace(gm.constants.sBlastdoorBroken, 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyBlastdoorBroken.png"), 2, false, false, -6, 484)
gm.sprite_replace(gm.constants.sBlastdoorLeftFrame, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyBlastdoorLeftFrame.png"), 4, false, false, 0, 512)
gm.sprite_replace(gm.constants.sBlastdoorRight, 	path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyBlastdoorRight.png"), 2, false, false, 0, 512)

GM.sprite_set_speed(Sprite.find("Spacer_M_CL_Snowy"), 1, 2)
GM.sprite_set_speed(Sprite.find("Spacer_M2_CL_Snowy"), 1, 2)
GM.background_set_megasprite(gm.constants.bRange1)
GM.background_set_megasprite(gm.constants.bRange2)
GM.background_set_megasprite(gm.constants.bWater_CL)
GM.background_set_megasprite(gm.constants.bSunsetClouds4)
GM.tile_render_init_final(Sprite.find("RiskofRainTile_Snowy"))
GM.tile_render_init_final(Sprite.find("RoR_Containers_Snowy"))

-- Menu Resources
local GroundStripSnowyRiskOfRain = Sprite.new("GroundStripRiskOfRain_Snowy", path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyGroundStripRiskOfRain.png"), 1, 0, 0)

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

-- Spawn list
cl_stage:add_interactable(InteractableCard.find("chirrsmasPresent"))
cl_stage:add_monster(MonsterCard.find("golem"))
cl_stage:remove_monster(MonsterCard.find("exploder")) -- green and ruins christmas. grinch basically

-- Rooms
Stage.add_room(cl_stage, path.combine(PATH.."/Stages/SnowyRiskOfRain", "riskOfRain1_snowy.rorlvl"))
Stage.add_room(cl_stage, path.combine(PATH.."/Stages/SnowyRiskOfRain", "riskOfRain2_snowy.rorlvl"))

-- Main Menu
cl_stage:set_title_screen_properties(GroundStripSnowyRiskOfRain)

-- Log
local stage_log = EnvironmentLog.new_from_stage(cl_stage)
stage_log.spr_icon = Sprite.new("EnvironmentFinal_Snowy", path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyEnvironmentFinal.png"), 1, 0, 0)
stage_log:set_initial_camera_position(9591, 2818)
stage_log.token_name = EnvironmentLog.find("riskOfRain").token_name
stage_log.token_story = EnvironmentLog.find("riskOfRain").token_story

local list = Global.environment_log_display_list

if list:find(EnvironmentLog.find("riskOfRain").value) then
	list:insert(list:find(EnvironmentLog.find("riskOfRain").value), stage_log.value)
	list:delete_value(EnvironmentLog.find("riskOfRain").value)
	list:delete((#list) - 1)
end

-- Special
local snow = Object.new("SnowyRORSnow")

Callback.add(snow.on_create, function(self)
	local data = Instance.get_data(self)
	data.quality = Global.__pref_graphics_quality
	data.timer = 0
	data.toggle = 1
	data.setup = 0
	
	Particle.find("Snow"):set_life(240, 840)
end)

Callback.add(snow.on_step, function(self)
	local data = Instance.get_data(self)
	
	if data.timer <= 5 then
		data.timer = data.timer + 1
	else
		data.timer = 0
	end
	
	if data.setup == 0 then
		data.setup = 1
		
		if Net.host then
			local amount = math.random(3)
			for _, barrel in ipairs(ssr_table_shuffle(Instance.find_all(Object.find("Barrel3")))) do
				barrel.save = false
				
				if amount > 0 then
					barrel.save = true
					amount = amount - 1
				end
				
				if not barrel.save then
					barrel:destroy()
				end
			end
			
			for _, cab in ipairs(Instance.find_all(Object.find("Medcab"))) do
				if Util.chance(0.66) then
					cab:destroy()
				end
			end
			
			for _, gun in ipairs(Instance.find_all(Object.find("Gunchest"))) do
				if Util.chance(0.66) then
					gun:destroy()
				end
			end
			
			for _, rift in ipairs(Instance.find_all(Object.find("RiftChest1"))) do
				if gm.save_get_rift_chest_content() ~= -1 or not Global.__game_lobby.rulebook.game_style.new_interactables then
					rift:destroy()
				end
			end
		else
			for _, barrel in ipairs(ssr_table_shuffle(Instance.find_all(Object.find("Barrel3")))) do
				barrel:destroy()
			end
			
			for _, cab in ipairs(Instance.find_all(Object.find("Medcab"))) do
				cab:destroy()
			end
			
			for _, gun in ipairs(Instance.find_all(Object.find("Gunchest"))) do
				gun:destroy()
			end
			
			for _, rift in ipairs(Instance.find_all(Object.find("RiftChest1"))) do
				rift:destroy()
			end
		end
	end
	
	if data.quality >= 2 and data.timer % 5 == 0 then
		for i=0, data.quality do
			Particle.find("Snow"):create((Global.___view_l_x - (Global.___view_l_w / 2)) + math.random(Global.___view_l_w * 1.5), Global.___view_l_y, data.quality - 1)
		end
	end
	
	local toggle = Global.tileset_final_toggle

	if toggle == 0 and data.toggle ~= toggle then
		gm.sprite_replace(Sprite.find("Spacer_M_CL_Snowy").value, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M_CL.png"), 1, false, false, 0, 0)
		gm.sprite_replace(Sprite.find("Spacer_M2_CL_Snowy").value, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M2_CL.png"), 1, false, false, 0, 0)
		data.toggle = toggle
	elseif toggle == 1 and data.toggle ~= toggle then
		gm.sprite_replace(Sprite.find("Spacer_M_CL_Snowy").value, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M_CL_end.png"), 1, false, false, 0, 0)
		gm.sprite_replace(Sprite.find("Spacer_M2_CL_Snowy").value, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M_CL_end.png"), 1, false, false, 0, 0)
		data.toggle = toggle
	elseif toggle > 0 and toggle < 1 and data.toggle ~= 3 then
		gm.sprite_replace(Sprite.find("Spacer_M_CL_Snowy").value, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M_CL_trans.png"), 13, false, false, 0, 0)
		gm.sprite_replace(Sprite.find("Spacer_M2_CL_Snowy").value, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySpacer_M2_CL_trans.png"), 13, false, false, 0, 0)
		data.toggle = 3
	end
end)

Callback.add(Callback.ON_STAGE_START, function()
	if Global.stage_id ~= cl_stage.value then return end
    
	snow:create(0, 0)
end)

Hook.add_post(gm.constants.stage_roll_next, function(self, other, result, args)
	if result.value == Stage.find("riskOfRain").value then
		result.value = cl_stage.value
	end
end)