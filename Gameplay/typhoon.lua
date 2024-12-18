local SPRITE_PATH = path.combine(PATH, "Sprites/Menu")
local SOUND_PATH = path.combine(PATH, "Sounds/Menu")

local sprite_small = Resources.sprite_load(NAMESPACE, "DifficultyTyphoon", path.combine(SPRITE_PATH, "DifficultyTyphoon.png"), 5, 11, 9)
local sprite_large = Resources.sprite_load(NAMESPACE, "DifficultyTyphoon2X", path.combine(SPRITE_PATH, "DifficultyTyphoon_2x.png"), 4, 22, 20)

local sound_select = Resources.sfx_load(NAMESPACE, "UI_Diff_Typhoon", path.combine(SOUND_PATH, "UI_Diff_Typhoon.ogg"))

local typhoon = Difficulty.new(NAMESPACE, "typhoon")
typhoon:set_sprite(sprite_small, sprite_large)
typhoon:set_primary_color(Color.from_rgb(195, 28, 124))
typhoon:set_sound(sound_select)
typhoon:set_scaling(0.2, 4.0, 1.7)
typhoon:set_monsoon_or_higher(true)

Callback.add("onGameStart", "SSTyphoonStart", function(self, other, result, args)
	-- self is oDirectorControl
	if typhoon:is_active() then
		--self.enemy_buff = self.enemy_buff + 0.5 -- this is dogshit lol
		self.elite_spawn_chance = 0.4 --0.8
	end
end)

Callback.add("onDirectorPopulateSpawnArrays", "SSTyphoonPreLoopMonsters", function(self, other, result, args)
	if self.loops == 0 and typhoon:is_active() then
		-- add loop-exclusive spawns to pre-loop
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
		local actor = Instance.wrap(self)
		actor.damage = actor.damage + actor.damage_base * 0.15
		actor.attack_speed = actor.attack_speed + actor.attack_speed_base * 0.15
		actor.pHmax_raw = actor.pHmax_raw + actor.pHmax_base * 0.15
		actor.pHmax = actor.pHmax + actor.pHmax_base * 0.15

		-- the cdr variable does nothing at this point. handle skill cdr manually.
		local skills = {
			actor:get_active_skill(Skill.SLOT.primary),
			actor:get_active_skill(Skill.SLOT.secondary),
			actor:get_active_skill(Skill.SLOT.utility),
			actor:get_active_skill(Skill.SLOT.special),
		}
		for _, skill in ipairs(skills) do
			skill.cooldown = math.ceil(skill.cooldown * 0.85)
		end
	end
end)

gm.post_script_hook(gm.constants.enemy_stats_init, function(self, other, result, args)
	if typhoon:is_active() then
		self.exp_worth = self.exp_worth * 0.7
	end
end)
