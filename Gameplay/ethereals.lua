require("Gameplay/typhoon.lua") -- terrible jank to force typhoon to load first, REMOVE LATER!!!!!

local SPRITE_PATH = path.combine(PATH, "Sprites/Menu")

-- assets
local sprite_teleporter_ethereal = Resources.sprite_load(NAMESPACE, "TeleporterEthereal", path.combine(PATH, "Sprites/Interactables/etherealTeleporter.png"), 1, 114, 128)

local sprite_deluge_small    = Resources.sprite_load(NAMESPACE, "DifficultyDeluge",      path.combine(SPRITE_PATH, "DifficultyDeluge.png"), 5, 9, 8)
local sprite_deluge_large    = Resources.sprite_load(NAMESPACE, "DifficultyDeluge2x",    path.combine(SPRITE_PATH, "DifficultyDeluge2x.png"), 4, 17, 17)
local sprite_tempest_small   = Resources.sprite_load(NAMESPACE, "DifficultyTempest",     path.combine(SPRITE_PATH, "DifficultyTempest.png"), 5, 11, 9)
local sprite_tempest_large   = Resources.sprite_load(NAMESPACE, "DifficultyTempest2x",   path.combine(SPRITE_PATH, "DifficultyTempest2x.png"), 4, 24, 19)
local sprite_cyclone_small   = Resources.sprite_load(NAMESPACE, "DifficultyCyclone",     path.combine(SPRITE_PATH, "DifficultyCyclone.png"), 5, 15, 9)
local sprite_cyclone_large   = Resources.sprite_load(NAMESPACE, "DifficultyCyclone2x",   path.combine(SPRITE_PATH, "DifficultyCyclone2x.png"), 4, 32, 20)
local sprite_hurricane_small = Resources.sprite_load(NAMESPACE, "DifficultyHurricane",   path.combine(SPRITE_PATH, "DifficultyHurricane.png"), 5, 15, 14)
local sprite_hurricane_large = Resources.sprite_load(NAMESPACE, "DifficultyHurricane2x", path.combine(SPRITE_PATH, "DifficultyHurricane2x.png"), 4, 31, 27)

-- setup ethereal difficulties
local diffDeluge = Difficulty.new(NAMESPACE, "easyEthereal")
local diffTempest = Difficulty.new(NAMESPACE, "normalEthereal")
local diffCyclone = Difficulty.new(NAMESPACE, "hardEthereal")
local diffHurricane = Difficulty.new(NAMESPACE, "typhoonEthereal")

diffDeluge:set_sprite(sprite_deluge_small, sprite_deluge_large)
diffTempest:set_sprite(sprite_tempest_small, sprite_tempest_large)
diffCyclone:set_sprite(sprite_cyclone_small, sprite_cyclone_large)
diffHurricane:set_sprite(sprite_hurricane_small, sprite_hurricane_large)

-- map normal difficulty ids to their ethereal counterparts
local ethereal_map = {
	[Difficulty.find("ror", "easy").value] = diffDeluge,
	[Difficulty.find("ror", "normal").value] = diffTempest,
	[Difficulty.find("ror", "hard").value] = diffCyclone,
	[Difficulty.find(NAMESPACE, "typhoon").value] = diffHurricane,
}

do
	local difficulty_display_list = List.wrap(Global.difficulty_display_list)

	-- delete the ethereal difficulties from the display list
	-- prevent them from appearing in the select
	for _, _diff1 in pairs(ethereal_map) do
		for i, _id in ipairs(difficulty_display_list) do
			if _diff1.value == _id then
				difficulty_display_list:delete(i-1)
				break
			end
		end
	end
end

-- the juicy stuff begins

local current_hardmode_level = 0 -- starts at 0 and increments after every ethereal teleporter
local hardmode_increase_queued = false -- when true, the next stage transition increments current_hardmode_level

local function hardmode_increase()
	current_hardmode_level = current_hardmode_level + 1
	gm.sound_play_global(gm.constants.wDifficulty, 1, 1)

	local replacement_diff = ethereal_map[Global.diff_level]
	if replacement_diff then
		-- syncs from host to clients. how nice of it.
		gm.difficulty_set_active(replacement_diff.value)
	end
end

Callback.add(Callback.TYPE.onGameStart, "SSEtherealStart", function()
	current_hardmode_level = 0
	hardmode_increase_queued = false
end)
Callback.add(Callback.TYPE.onStageStart, "SSEtherealStageStart", function()
	if hardmode_increase_queued then
		hardmode_increase()
		hardmode_increase_queued = false
	end
end)

local function make_tp_ethereal(tp)
	tp.sprite_idle = sprite_teleporter_ethereal
	tp.sprite_charging = sprite_teleporter_ethereal
	--tp.sprite_fidget
	tp.sprite_finished = sprite_teleporter_ethereal
	--tp.interact_scroll_index = 3

	tp.mask_index = sprite_teleporter_ethereal -- widen the interaction zone

	tp.depth = 12

	GM.interactable_init_name(tp, "TeleporterEthereal")

	tp.maxtime = tp.maxtime * (1 + ((1 + current_hardmode_level) * 0.25))
end

local objEtherealTeleporter = Object.new(NAMESPACE, "TeleporterEthereal")
objEtherealTeleporter.obj_sprite = sprite_teleporter_ethereal

objEtherealTeleporter:clear_callbacks()
objEtherealTeleporter:onStep(function(self)
	local tp = GM.instance_create(self.x, self.y, gm.constants.oTeleporter)
	make_tp_ethereal(tp)

	self:destroy()
end)