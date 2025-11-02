local SPRITE_PATH = path.combine(PATH, "Sprites/Menu")
local SOUND_PATH = path.combine(PATH, "Sounds/Menu")

local sprite_small = Sprite.new("DifficultyTyphoon", path.combine(SPRITE_PATH, "DifficultyTyphoon.png"), 5, 11, 9)
local sprite_large = Sprite.new("DifficultyTyphoon2X", path.combine(SPRITE_PATH, "DifficultyTyphoon_2x.png"), 4, 22, 20)

local sound_select = Sound.new("UI_Diff_Typhoon", path.combine(SOUND_PATH, "UI_Diff_Typhoon.ogg"))

local typhoon = Difficulty.new("typhoon")
typhoon.sprite_id = sprite_small
typhoon.sprite_loadout_id = sprite_large
typhoon.primary_color = Color.from_rgb(195, 28, 124)
typhoon.sound_id = sound_select
typhoon.diff_scale = 0.2
typhoon.general_scale = 4.0
typhoon.point_scale = 1.7
typhoon.is_monsoon_or_higher = true
typhoon.allow_blight_spawns = true

--[[
Callback.add(Callback.TYPE.onGameStart, "SSTyphoonStart", function()
	if typhoon:is_active() then
		local director = GM._mod_game_getDirector()
		director.elite_spawn_chance = 0.4
	end
end)

Callback.add(Callback.TYPE.onDirectorPopulateSpawnArrays, "SSTyphoonPreLoopMonsters", function()
	local director = GM._mod_game_getDirector()
	if director.loops == 0 and typhoon:is_active() then
		-- add loop-exclusive spawns to pre-loop
		local director_spawn_array = director.monster_spawn_array
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
		--actor.damage = actor.damage + actor.damage_base * 0.15 -- excessive
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
]]--
