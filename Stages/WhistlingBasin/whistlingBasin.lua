local SPRITE_PATH = path.combine(PATH, "Sprites/Stages/WhistlingBasin")
local SOUND_PATH = path.combine(PATH, "Sounds/Music")

-- Stage Resources
Sprite.new("tile16basin", path.combine(SPRITE_PATH, "tile16basin.png"), 1, 0, 0)
Sprite.new("BackTilesModded2", path.combine(SPRITE_PATH, "BackTilesModded2.png"), 1, 0, 0)
Sprite.new("LandCloudWhistlingBasin", path.combine(SPRITE_PATH, "LandCloudWhistlingBasin.png"), 1, 0, 0)
Sprite.new("SkyBasin", path.combine(SPRITE_PATH, "SkyBasin.png"), 1, 0, 0)
Sprite.new("MoonBasin", path.combine(SPRITE_PATH, "MoonBasin.png"), 1, 0, 0)
Sprite.new("MountainsBasinNew", path.combine(SPRITE_PATH, "MountainsBasinNew.png"), 1, 0, 0)
Sprite.new("MountainsBasinNew2", path.combine(SPRITE_PATH, "MountainsBasinNew2.png"), 1, 0, 0)
Sprite.new("LandCloud4WhistlingBasin", path.combine(SPRITE_PATH, "LandCloud4WhistlingBasin.png"), 1, 0, 0)
Sprite.new("LandCloud5WhistlingBasin", path.combine(SPRITE_PATH, "LandCloud5WhistlingBasin.png"), 1, 0, 0)

-- Menu Resources
local EnvironmentWhistlingBasin = Sprite.new("EnvironmentWhistlingBasin", path.combine(SPRITE_PATH, "EnvironmentWhistlingBasin.png"))
local GroundStripWhistlingBasin = Sprite.new("GroundStripWhistlingBasin", path.combine(SPRITE_PATH, "GroundStripWhistlingBasin.png"))

-- Stage
local basin_stage = Stage.new("whistlingBasin")
basin_stage.music_id = Sound.new("musicWhistlingBasin", path.combine(SOUND_PATH, "musicWhistlingBasin.ogg"))
basin_stage.token_name = gm.translate("stage.whistlingBasin.name")
basin_stage.token_subname = gm.translate("stage.whistlingBasin.subname")
basin_stage.teleporter_index = 0
basin_stage:set_tier(2)

-- Rooms
Stage.add_room(basin_stage, path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin1.rorlvl"))
Stage.add_room(basin_stage, path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin2.rorlvl"))
Stage.add_room(basin_stage, path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin3.rorlvl"))
Stage.add_room(basin_stage, path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin4.rorlvl"))
Stage.add_room(basin_stage, path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin5.rorlvl"))
Stage.add_room(basin_stage, path.combine(PATH.."/Stages/WhistlingBasin", "whistlingBasin6.rorlvl"))

-- Spawn list
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
    "lemrider",
	MonsterCard.find("admonitor")
})

basin_stage:add_interactable({
    "barrel1",
    "barrelEquipment",
    "chest1",
    "chest2",
    "shop1",
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

-- Main Menu
basin_stage:set_title_screen_properties(GroundStripWhistlingBasin)

-- Environment Log
local stage_log = EnvironmentLog.new_from_stage(basin_stage)
stage_log.spr_icon = EnvironmentWhistlingBasin
stage_log:set_initial_camera_position(4900, 1900)