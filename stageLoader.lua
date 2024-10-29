mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

PATH = _ENV["!plugins_mod_folder_path"]

NAMESPACE = "ssr"



Initialize(function()
    --local EnvPlaceholder = Resources.sprite_load(NAMESPACE, "EnvPlaceholder", path.combine(PATH, "EnvironmentPlaceholder.png"))

    --- WHISTLING BASIN ---

    --Stage Resources
    Resources.sprite_load(NAMESPACE, "tile16basin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "tile16basin.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "BackTilesModded2", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "BackTilesModded2.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "LandCloudWhistlingBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "LandCloudWhistlingBasin.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "SkyBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "SkyBasin.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "MoonBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "MoonBasin.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "MountainsBasinNew", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "MountainsBasinNew.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "MountainsBasinNew2", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "MountainsBasinNew2.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "LandCloud4WhistlingBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "LandCloud4WhistlingBasin.png"), 1, 0, 0)
    Resources.sprite_load(NAMESPACE, "LandCloud5WhistlingBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "LandCloud5WhistlingBasin.png"), 1, 0, 0)

    --Menu Resources
    local EnvironmentWhistlingBasin = Resources.sprite_load(NAMESPACE, "EnvironmentWhistlingBasin", path.combine(PATH.."/Sprites/Stages/Sprites/Stages/WhistlingBasin", "EnvironmentWhistlingBasin.png"))
    local GroundStripWhistlingBasin = Resources.sprite_load(NAMESPACE, "GroundStripWhistlingBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "GroundStripWhistlingBasin.png"))

    --Stage
    local basin_stage = Stage.new(NAMESPACE, "whistlingBasin")
    basin_stage.music_id = gm.sound_add_w(NAMESPACE, "musicWhistlingBasin", path.combine(PATH.."/Music", "musicWhistlingBasin.ogg"))
    basin_stage.token_name = "Whistling Basin"
    basin_stage.token_subname = "Dwindling Oasis" 
    basin_stage:set_index(2)

    --Rooms
    basin_stage:add_room(path.combine(PATH.."/Stages", "whistlingBasin1.rorlvl"))
    basin_stage:add_room(path.combine(PATH.."/Stages", "whistlingBasin2.rorlvl"))
    basin_stage:add_room(path.combine(PATH.."/Stages", "whistlingBasin3.rorlvl"))
    basin_stage:add_room(path.combine(PATH.."/Stages", "whistlingBasin4.rorlvl"))
    basin_stage:add_room(path.combine(PATH.."/Stages", "whistlingBasin5.rorlvl"))

    --Spawn list
    basin_stage:add_monster({
        "lemurian",
        "wisp",
        "imp",
        "crab",
        "greaterWisp",
        "ancientWisp",
        "archaicWisp",
        "bramble",
        "scavenger"
    })
    basin_stage:add_monster_loop({
        "impOverlord",
        "lemrider"
    })

    basin_stage:add_interactable({
        "barrel1",
        "barrelEquipment",
        "chest1",
        "chest2",
        "chest3",
        "drone3",
        "drone4",
        "shrine2",
        "chestHealing1",
        "equipmentActivator",
        "droneRecycler"
    })
    basin_stage:add_interactable_loop({
        "chestHealing2",
        "chest4",
        "shrine3S",
        "barrel2",
        "chest5"
    })

    --Environment Log
    basin_stage:set_log_icon(EnvironmentWhistlingBasin)

    --Main Menu
    basin_stage:set_title_screen_properties(GroundStripWhistlingBasin)
--[[
    --- TORRID OUTLANDS ---
    Resources.sprite_load(NAMESPACE, "Tile16Outlands", path.combine(PATH.."/TorridOutlands", "Tile16Outlands.png"), 1, 0, 0)

    local outlands_stage = Stage.new(NAMESPACE, "TorridOutlands")
    outlands_stage.music_id = gm.sound_add_w(NAMESPACE, "musicTorridOutlands", path.combine(PATH.."/TorridOutlands", "musicTorridOutlands.ogg"))
    outlands_stage.token_name = "Torrid Outlands"
    outlands_stage.token_subname = "Silent Sunburn" 
    outlands_stage:set_index(1)

    outlands_stage:add_room(path.combine(PATH.."/TorridOutlands", "torridOutlands_test.rorlvl"))

    outlands_stage:add_monster({
        "lemurian",
        "wisp",
        "imp",
        "crab",
        "greaterWisp",
        "colossus",
        "archaicWisp",
        "bramble",
        "scavenger"
    })

    outlands_stage:set_log_icon(EnvPlaceholder)
    ]]
end)

