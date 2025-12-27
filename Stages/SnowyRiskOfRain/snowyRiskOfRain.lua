--if HOTLOADING then return end
if not ssr_chirrsmas_active then return end -- christmas lasts from december 15th to january 15th
if Settings.chirrsmas == 2 then return end -- if chirrsmas is disabled in the config then we dont do anything

gm.sprite_replace(gm.constants.bRiskofRainTile, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRiskofRainTile.png"), 2, false, false, 0, 0)
GM.tile_render_init_final(gm.constants.bRiskofRainTile)
gm.sprite_replace(gm.constants.bRoR_Containers, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRoR_Containers.png"), 2, false, false, 0, 0)
GM.tile_render_init_final(gm.constants.bRoR_Containers)
gm.sprite_replace(gm.constants.bBackTiles9, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyBackTiles9.png"), 1, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRoR_BG, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRoR_BG.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bRange1, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRange1.png"), 4, false, false, 0, 0)
GM.background_set_megasprite(gm.constants.bRange1)
gm.sprite_replace(gm.constants.bRange2, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyRange2.png"), 4, false, false, 0, 0)
GM.background_set_megasprite(gm.constants.bRange2)
gm.sprite_replace(gm.constants.bWater_CL, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowyWater_CL.png"), 4, false, false, 0, 0)
GM.background_set_megasprite(gm.constants.bWater_CL)
gm.sprite_replace(gm.constants.bSunsetClouds, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds2, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds2.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds3, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds3.png"), 2, false, false, 0, 0)
gm.sprite_replace(gm.constants.bSunsetClouds4, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunsetClouds4.png"), 4, false, false, 0, 0)
GM.background_set_megasprite(gm.constants.bSunsetClouds4)
gm.sprite_replace(gm.constants.bSunrise2, path.combine(PATH, "Sprites/Stages/SnowyRiskOfRain/snowySunrise2.png"), 2, false, false, 0, 0)