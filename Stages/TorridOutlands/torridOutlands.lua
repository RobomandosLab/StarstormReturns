local SPRITE_PATH = path.combine(PATH, "Sprites/Stages/TorridOutlands")
local SOUND_PATH = path.combine(PATH, "Sounds/Music")

-- Stage Resources
Sprite.new("Tile16Outlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Tile16Outlands.png"), 1, 0, 0)
Sprite.new("BackTilesOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "BackTilesOutlands.png"), 1, 0, 0)
Sprite.new("MoonOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "MoonOutlands.png"), 1, 0, 0)
Sprite.new("Arch2TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Arch2TorridOutlands.png"), 1, 0, 0)
Sprite.new("Arch1TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Arch1TorridOutlands.png"), 1, 0, 0)
Sprite.new("Arch3TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Arch3TorridOutlands.png"), 1, 0, 0)
Sprite.new("CanyonsBack2TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "CanyonsBack2TorridOutlands.png"), 1, 0, 0)
Sprite.new("Clouds1TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "Clouds1TorridOutlands.png"), 1, 0, 0)
Sprite.new("CanyonsBack1TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "CanyonsBack1TorridOutlands.png"), 1, 0, 0)
Sprite.new("CanyonsBack3TorridOutlands", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "CanyonsBack3TorridOutlands.png"), 1, 0, 0)
Sprite.new("EelBone", path.combine(PATH.."/Sprites/Stages/TorridOutlands", "skeelton.png"), 1, 0, 0)

-- Menu Resources
local EnvironmentTorridOutlands = Sprite.new("EnvironmentTorridOutlands", path.combine(SPRITE_PATH, "EnvironmentTorridOutlands.png"))
local GroundStripTorridOutlands = Sprite.new("GroundStripTorridOutlands", path.combine(SPRITE_PATH, "GroundStripTorridOutlands.png"))

-- Stage
local outlands_stage = Stage.new("torridOutlands")
outlands_stage.music_id = Sound.new("musicTorridOutlands", path.combine(SOUND_PATH, "musicTorridOutlands.ogg"))
outlands_stage.token_name = gm.translate("stage.torridOutlands.name")
outlands_stage.token_subname = gm.translate("stage.torridOutlands.subname")
outlands_stage.teleporter_index = 0
outlands_stage.interactable_spawn_points = 900
outlands_stage:set_tier(3)

-- Rooms
Stage.add_room(outlands_stage, path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands1.rorlvl"))
Stage.add_room(outlands_stage, path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands2.rorlvl"))
Stage.add_room(outlands_stage, path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands3.rorlvl"))
Stage.add_room(outlands_stage, path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands4.rorlvl"))
Stage.add_room(outlands_stage, path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands5.rorlvl"))
Stage.add_room(outlands_stage, path.combine(PATH.."/Stages/TorridOutlands", "torridOutlands6.rorlvl"))

-- Spawn list
outlands_stage:add_monster({
    "wisp",
    "imp",
    "bison",
    "spitter",
	"tuber",
    "colossus",
    "clayMan",
    "toxicBeast",
    "scavenger",
	MonsterCard.find("admonitor")
})

outlands_stage:add_monster_loop({
    "greaterWisp",
    "archaicWisp",
})

outlands_stage:add_interactable({
    "barrel1",
    "barrelEquipment",
    "chest1",
    "chest4",
    "shop1",
    "drone6",
    "drone4",
    "shrine2",
    "equipmentActivator",
    "droneRecycler",
	"droneUpgrader"
})

outlands_stage:add_interactable_loop({
    "shrine3S"
})

if ssr_chirrsmas_active then
	outlands_stage:add_interactable(InteractableCard.find("chirrsmasPresent"))
end

-- Main Menu
outlands_stage:set_title_screen_properties(GroundStripTorridOutlands)

-- Environment Log
local stage_log = EnvironmentLog.new_from_stage(outlands_stage)
stage_log.spr_icon = EnvironmentTorridOutlands
stage_log:set_initial_camera_position(9247, 2300)