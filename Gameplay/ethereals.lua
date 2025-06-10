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

local sound_big_teleporter = Resources.sfx_load(NAMESPACE, "BigTeleporter", path.combine(PATH, "Sounds/Interactables/etherealTeleporter.ogg"))

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

-- copy important properties from original difficulties
for orig_id, eth in pairs(ethereal_map) do
	local orig = Difficulty.wrap(orig_id)
	eth.diff_scale = orig.diff_scale
	eth.general_scale = orig.general_scale
	eth.point_scale = orig.point_scale
	eth.is_monsoon_or_higher = orig.is_monsoon_or_higher
	eth.allow_blight_spawns = orig.allow_blight_spawns
end

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

-- maps room ids to teleporter locations
-- only to be filled out for vanilla stages! ssr stages should place the ethearal tp object in the rorlvl
-- some have depth specified for cases where it needs adjustment to look good
local ethereal_tp_locations = {}

do
	local desolateForest_rooms = List.wrap(Stage.find("ror", "desolateForest").room_list)
	local driedLake_rooms = List.wrap(Stage.find("ror", "driedLake").room_list)
	local dampCaverns_rooms = List.wrap(Stage.find("ror", "dampCaverns").room_list)
	local skyMeadow_rooms = List.wrap(Stage.find("ror", "skyMeadow").room_list)
	local ancientValley_rooms = List.wrap(Stage.find("ror", "ancientValley").room_list)
	local sunkenTombs_rooms = List.wrap(Stage.find("ror", "sunkenTombs").room_list)
	local hiveCluster_rooms = List.wrap(Stage.find("ror", "hiveCluster").room_list)
	local magmaBarracks_rooms = List.wrap(Stage.find("ror", "magmaBarracks").room_list)
	local templeOfTheElders_rooms = List.wrap(Stage.find("ror", "templeOfTheElders").room_list)

	ethereal_tp_locations[desolateForest_rooms[2]] = {x = 71, y = 97}
	ethereal_tp_locations[desolateForest_rooms[4]] = {x = 342, y = 100}
	ethereal_tp_locations[driedLake_rooms[1]] = {x = 222, y = 56}
	ethereal_tp_locations[driedLake_rooms[2]] = {x = 222, y = 56}
	ethereal_tp_locations[driedLake_rooms[3]] = {x = 223, y = 62}
	ethereal_tp_locations[dampCaverns_rooms[1]] = {x = 193, y = 14}
	ethereal_tp_locations[dampCaverns_rooms[2]] = {x = 137, y = 14}
	ethereal_tp_locations[dampCaverns_rooms[3]] = {x = 168, y = 15}
	ethereal_tp_locations[skyMeadow_rooms[1]] = {x = 25, y = 76}
	ethereal_tp_locations[skyMeadow_rooms[2]] = {x = 26, y = 76}
	ethereal_tp_locations[skyMeadow_rooms[3]] = {x = 25, y = 76}
	ethereal_tp_locations[ancientValley_rooms[1]] = {x = 31, y = 215}
	ethereal_tp_locations[ancientValley_rooms[2]] = {x = 32, y = 215}
	ethereal_tp_locations[ancientValley_rooms[3]] = {x = 32, y = 215}
	ethereal_tp_locations[sunkenTombs_rooms[1]] = {x = 161, y = 129, depth = 350}
	ethereal_tp_locations[sunkenTombs_rooms[2]] = {x = 160, y = 129}
	ethereal_tp_locations[sunkenTombs_rooms[3]] = {x = 160, y = 129}
	ethereal_tp_locations[hiveCluster_rooms[1]] = {x = 198, y = 9, depth = 155}
	ethereal_tp_locations[hiveCluster_rooms[2]] = {x = 198, y = 9, depth = 155}
	ethereal_tp_locations[hiveCluster_rooms[3]] = {x = 198, y = 9, depth = 155}
	ethereal_tp_locations[magmaBarracks_rooms[1]] = {x = 12, y = 79}
	ethereal_tp_locations[magmaBarracks_rooms[2]] = {x = 9, y = 73}
	ethereal_tp_locations[magmaBarracks_rooms[3]] = {x = 9, y = 73}
	ethereal_tp_locations[templeOfTheElders_rooms[1]] = {x = 152, y = 128}
	ethereal_tp_locations[templeOfTheElders_rooms[2]] = {x = 152, y = 128}
	ethereal_tp_locations[templeOfTheElders_rooms[3]] = {x = 152, y = 128}
end

-- constants

local ETHEREAL_TELEPORTER_BONUS_TIME = 30 * 60

-- the juicy stuff begins

local current_hardmode_level = 0 -- starts at 0 and increments after every ethereal teleporter
local hardmode_increase_queued = false -- when true, the next stage transition calls hardmode_increase

-- state for "Difficulty Up" notification
local difficulty_notif_active = false
local difficulty_notif_timer
local difficulty_notif_alpha

local function hardmode_increase()
	current_hardmode_level = current_hardmode_level + 1
	gm.sound_play_global(gm.constants.wDifficulty, 1, 1)

	difficulty_notif_active = true
	difficulty_notif_alpha = 0
	difficulty_notif_timer = 0

	local replacement_diff = ethereal_map[Global.diff_level]
	if replacement_diff then
		-- syncs from host to clients. how nice of it.
		gm.difficulty_set_active(replacement_diff.value)
	end
end

local function make_tp_ethereal(tp)
	tp.is_ethereal = true -- magic variable used to identify ethereal teleporters

	tp.maxtime = tp.maxtime + ETHEREAL_TELEPORTER_BONUS_TIME

	-- setup animations
	tp.sprite_idle = sprite_teleporter_ethereal
	tp.sprite_charging = sprite_teleporter_ethereal
	--tp.sprite_fidget
	tp.sprite_finished = sprite_teleporter_ethereal

	-- these are used for offscreen culling
	-- need to expand them a bit to accommodate the bigger sprite
	tp.cam_rect_x1 = tp.cam_rect_x1 - 64
	tp.cam_rect_x2 = tp.cam_rect_x2 + 64
	tp.cam_rect_y1 = tp.cam_rect_y1 - 72

	tp.mask_index = sprite_teleporter_ethereal -- widen the interaction zone

	--GM.interactable_init_name(tp, "TeleporterEthereal")
	tp.text = Language.translate_token("interactable.TeleporterEthereal.text")
end

local objEtherealTeleporter = Object.new(NAMESPACE, "TeleporterEthereal")
objEtherealTeleporter.obj_sprite = sprite_teleporter_ethereal
objEtherealTeleporter.obj_depth = 12

objEtherealTeleporter:clear_callbacks()
objEtherealTeleporter:onStep(function(self)
	local tp = GM.instance_create(self.x, self.y, gm.constants.oTeleporter)
	tp.depth = self.depth
	make_tp_ethereal(tp)

	self:destroy()
end)

Callback.add(Callback.TYPE.onGameStart, "SSEtherealStart", function()
	current_hardmode_level = 0
	hardmode_increase_queued = false
end)
Callback.add(Callback.TYPE.onStageStart, "SSEtherealStageStart", function()
	if hardmode_increase_queued then
		hardmode_increase()
		hardmode_increase_queued = false
	end

	local data = ethereal_tp_locations[gm._mod_room_get_current()]
	if data then
		local tp = objEtherealTeleporter:create(data.x * 32 + 16, data.y * 32)
		tp.depth = data.depth or tp.depth
	end
end)

gm.pre_code_execute("gml_Object_pTeleporter_Step_2", function(self, other)
	if not self.is_ethereal then return end

	if self.active == 1 then
		if not self._did_warning then
			-- prevent activation and warn the player
			self.active = 0

			self.text = Language.translate_token("interactable.TeleporterEthereal.text2")

			self:screen_shake(3)
			self:sound_play(gm.constants.wShrine1, 1, 1.2)

			self._did_warning = true -- another one-off magic variable lol
		elseif self.just_activated == 0 then
			-- runs once when the ethereal tp is activated for real.
			hardmode_increase_queued = true

			self:sound_play(sound_big_teleporter, 1, 1)
			self:screen_shake(25)
		end
	end
end)

-- difficulty up notification
Callback.add(Callback.TYPE.onHUDDraw, "SSEtherealHUDDraw", function()
	if not difficulty_notif_active then return end

	difficulty_notif_timer = difficulty_notif_timer + 1

	if difficulty_notif_timer < 90 then return end

	if difficulty_notif_timer < 6 * 60 then
		difficulty_notif_alpha = math.min(1, difficulty_notif_alpha + 0.02)
	else
		difficulty_notif_alpha = difficulty_notif_alpha - 0.02

		if difficulty_notif_alpha <= 0 then
			difficulty_notif_active = false
			return
		end
	end

	gm.draw_set_alpha(difficulty_notif_alpha)

	local tx = Global.___view_l_x + Global.___view_l_w * 0.5
	local ty = Global.___view_l_y + Global.___view_l_h * 0.5 - 100 -- offset to appear just above stage title name

	local text = Language.translate_token("alert.difficultyUp")

	-- white text with dark gray outline ..
	gm.scribble_set_starting_format("fntLarge", Color.WHITE, 1)
	gm.scribble_set_blend(Color.DKGRAY, difficulty_notif_alpha)
	gm.scribble_draw(tx-1, ty,   text)
	gm.scribble_draw(tx+1, ty,   text)
	gm.scribble_draw(tx-1, ty-1, text)
	gm.scribble_draw(tx+1, ty-1, text)
	gm.scribble_draw(tx,   ty-1, text)
	gm.scribble_draw(tx,   ty+1, text)
	gm.scribble_draw(tx-1, ty+1, text)
	gm.scribble_draw(tx+1, ty+1, text)
	gm.scribble_set_blend(Color.WHITE, difficulty_notif_alpha)
	gm.scribble_draw(tx, ty, text)

	-- draw difficulty sprite
	local diff_sprite = Difficulty.wrap(Global.diff_level).sprite_loadout_id
	gm.draw_sprite(diff_sprite, 1, tx, ty - 40)

	gm.scribble_set_blend(Color.WHITE, 1)
	gm.draw_set_alpha(1)
end)