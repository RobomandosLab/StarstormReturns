local SPRITE_PATH = path.combine(PATH, "Sprites/Stages/VerdantWoodland")
local SOUND_PATH = path.combine(PATH, "Sounds/Music")

-- Stage Resources
Sprite.new("Tile16Woodland", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "Tile16Woodland.png"), 1, 0, 0)
Sprite.new("BackTilesWoodland", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "BackTilesWoodland.png"), 1, 0, 0)
Sprite.new("VerdantTrees1", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "VerdantTrees1.png"), 1, 0, 0)
Sprite.new("VerdantTrees2", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "VerdantTrees2.png"), 1, 0, 0)
Sprite.new("VerdantTrees3", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "VerdantTrees3.png"), 1, 0, 0)
Sprite.new("VerdantTrees4", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "VerdantTrees4.png"), 1, 0, 0)
Sprite.new("VerdantGodRays", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "VerdantGodRays.png"), 1, 0, 0)

-- Menu Resources
local EnvironmentVerdantWoodland = Sprite.new("EnvironmentVerdantWoodland", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "EnvironmentVerdantWoodland.png"))
local GroundStripVerdantWoodland_1 = Sprite.new("GroundStripVerdantWoodland_1", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "GroundStripVerdantWoodland_1.png"))
local GroundStripVerdantWoodland_2 = Sprite.new("GroundStripVerdantWoodland_2", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "GroundStripVerdantWoodland_2.png"))
local GroundStripVerdantWoodland_3 = Sprite.new("GroundStripVerdantWoodland_3", path.combine(PATH.."/Sprites/Stages/VerdantWoodland", "GroundStripVerdantWoodland_3.png"))

local grounds = {
	GroundStripVerdantWoodland_1,
	GroundStripVerdantWoodland_2,
	GroundStripVerdantWoodland_3,
}

-- Stage
local woodland_stage = Stage.new("verdantWoodland")
woodland_stage.music_id = Sound.new("musicVerdantWoodland", path.combine(SOUND_PATH, "musicVerdantWoodland.ogg"))
woodland_stage.token_name = gm.translate("stage.verdantWoodland.name")
woodland_stage.token_subname = gm.translate("stage.verdantWoodland.subname")
woodland_stage.teleporter_index = 0
woodland_stage.interactable_spawn_points = 920
woodland_stage:set_tier(4)

Stage.add_room(woodland_stage, path.combine(PATH.."/Stages/VerdantWoodland", "verdantWoodland1.rorlvl"))
Stage.add_room(woodland_stage, path.combine(PATH.."/Stages/VerdantWoodland", "verdantWoodland2.rorlvl"))
Stage.add_room(woodland_stage, path.combine(PATH.."/Stages/VerdantWoodland", "verdantWoodland3.rorlvl"))
Stage.add_room(woodland_stage, path.combine(PATH.."/Stages/VerdantWoodland", "verdantWoodland4.rorlvl"))
Stage.add_room(woodland_stage, path.combine(PATH.."/Stages/VerdantWoodland", "verdantWoodland5.rorlvl"))
Stage.add_room(woodland_stage, path.combine(PATH.."/Stages/VerdantWoodland", "verdantWoodland6.rorlvl"))

-- Spawn list
woodland_stage:add_monster({
    "mushrum",
    "greaterWisp",
    "wanderingVagrant",
    "lynxTribe",
    "impOverlord",
    "jellyfish",
    "golem",
    "gup",
    "archerBug",
    "spitter",
    "bramble",
    "scavenger"
})

woodland_stage:add_monster_loop({
    "impOverlord",
    "lemrider"
})

woodland_stage:add_interactable({
    "barrel2",
    "barrelEquipment",
    "chest1",
    "chest2",
    "shop1",
    "drone7",
    "equipmentActivator",
    "shrine2",
    "chestHealing1",
    "droneUpgrader"
})

woodland_stage:add_interactable_loop({
    "chestHealing2",
    "shrine3S",
    "chest5",
    "equipmentActivator",
    "droneRecycler"
})

if ssr_chirrsmas_active then
	woodland_stage:add_interactable(InteractableCard.find("chirrsmasPresent"))
end

-- Main Menu
woodland_stage:set_title_screen_properties(grounds[math.random(3)])

Callback.add(Callback.ON_GAME_START, function()
	woodland_stage:set_title_screen_properties(grounds[math.random(3)])
end)

-- Environment Log
local stage_log = EnvironmentLog.new_from_stage(woodland_stage)
stage_log.spr_icon = EnvironmentVerdantWoodland
stage_log:set_initial_camera_position(2591, 4075)