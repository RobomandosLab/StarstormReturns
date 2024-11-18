local SPRITE_PATH =  path.combine(PATH, "Sprites/Menu")
local SOUND_PATH =  path.combine(PATH, "Sounds/Menu")

local sprite_small = Resources.sprite_load(NAMESPACE, "DifficultyTyphoon", path.combine(SPRITE_PATH, "DifficultyTyphoon.png"), 5, 11, 9)
local sprite_large = Resources.sprite_load(NAMESPACE, "DifficultyTyphoon2X", path.combine(SPRITE_PATH, "DifficultyTyphoon_2x.png"), 4, 22, 20)

local sound_select = Resources.sfx_load(NAMESPACE, "UI_Diff_Typhoon", path.combine(SOUND_PATH, "UI_Diff_Typhoon.ogg"))

local typhoon = Difficulty.new(NAMESPACE, "typhoon")
typhoon:set_sprite(sprite_small, sprite_large)
typhoon:set_primary_color(Color.from_rgb(195, 28, 124))
typhoon:set_sound(sound_select)

typhoon:set_scaling(0.2, 4.0, 1.7) --`diff_scale`, `general_scale`, `point_scale`
typhoon:set_monsoon_or_higher(true)
typhoon:set_allow_blight_spawns(true)

Callback.add("onGameStart", "SSTyphoonStart", function(self, other, result, args)
	-- self is oDirectorControl
	if typhoon:is_active() then
		self.enemy_buff = self.enemy_buff + 0.5
		self.elite_spawn_chance = 0.8
	end
end)

Callback.add("onDirectorPopulateSpawnArrays", "SSTyphoonPreLoopMonsters", function(self, other, result, args)
	if self.loops == 0 and typhoon:is_active() then
		-- add loop-exclusive spawns to before loop
		local director_spawn_array = Array.wrap(self.monster_spawn_array)
		local current_stage = Stage.wrap(GM._mod_game_getCurrentStage())

		local loop_spawns = List.wrap(current_stage.spawn_enemies_loop)

		for _, card_id in ipairs(loop_spawns) do
			director_spawn_array:push(card_id)
		end
	end
end)

gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
	if self.team == 2.0 and typhoon:is_active() then
		self.attack_speed = self.attack_speed * 1.15
		self.cdr = 1-((1-self.cdr)*0.85)
		self.pHmax_raw = self.pHmax_raw * 1.15
		self.pHmax = self.pHmax * 1.15
	end
end)

gm.post_script_hook(gm.constants.enemy_stats_init, function(self, other, result, args)
	if typhoon:is_active() then
		self.exp_worth = self.exp_worth * 0.7
	end
end)
