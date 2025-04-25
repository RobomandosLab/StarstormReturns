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
local EnvironmentWhistlingBasin = Resources.sprite_load(NAMESPACE, "EnvironmentWhistlingBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "EnvironmentWhistlingBasin.png"))
local GroundStripWhistlingBasin = Resources.sprite_load(NAMESPACE, "GroundStripWhistlingBasin", path.combine(PATH.."/Sprites/Stages/WhistlingBasin", "GroundStripWhistlingBasin.png"))

--Stage
local basin_stage = Stage.new(NAMESPACE, "whistlingBasin")
basin_stage.music_id = gm.sound_add_w(NAMESPACE, "musicWhistlingBasin", path.combine(PATH.."/Sounds/Music", "musicWhistlingBasin.ogg"))
basin_stage.token_name = "Whistling Basin"
basin_stage.token_subname = "Dwindling Oasis"
basin_stage.teleporter_index = 0
basin_stage:set_index(2)

--Rooms
basin_stage:clear_rooms()
basin_stage:add_room(path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin1.rorlvl"))
basin_stage:add_room(path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin2.rorlvl"))
basin_stage:add_room(path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin3.rorlvl"))
basin_stage:add_room(path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin4.rorlvl"))
basin_stage:add_room(path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin5.rorlvl"))
basin_stage:add_room(path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin6.rorlvl"))

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

--- TORRID OUTLANDS ---
Resources.sprite_load(NAMESPACE, "Tile16Outlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Tile16Outlands.png"), 1, 0, 0)
Resources.sprite_load(NAMESPACE, "MoonOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "MoonOutlands.png"), 1, 0, 0)
Resources.sprite_load(NAMESPACE, "Arch2TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Arch2TorridOutlands.png"), 1, 0, 0)
Resources.sprite_load(NAMESPACE, "Arch1TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Arch1TorridOutlands.png"), 1, 0, 0)
Resources.sprite_load(NAMESPACE, "CanyonsBack2TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "CanyonsBack2TorridOutlands.png"), 1, 0, 0)
Resources.sprite_load(NAMESPACE, "Clouds1TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Clouds1TorridOutlands.png"), 1, 0, 0)
Resources.sprite_load(NAMESPACE, "CanyonsBack1TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "CanyonsBack1TorridOutlands.png"), 1, 0, 0)

local outlands_stage = Stage.new(NAMESPACE, "torridOutlands")
outlands_stage.music_id = gm.sound_add_w(NAMESPACE, "musicTorridOutlands", path.combine(PATH.."/Music", "musicTorridOutlands.ogg"))
outlands_stage.token_name = "Torrid Outlands"
outlands_stage.token_subname = "Silent Sunburn" 
outlands_stage:set_index(3)

outlands_stage:add_room(path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands1.rorlvl"))

outlands_stage:add_monster({
    "wisp",
    "imp",
    "bison",
    "spitter",
    "colossus",
    "toxicBeast",
    "scavenger"
})

outlands_stage:add_interactable({
    "barrel1",
    "barrelEquipment",
    "chest1",
    "chest4",
    "chest3",
    "drone6",
    "drone4",
    "shrine2",
    "equipmentActivator",
    "droneRecycler"
})

