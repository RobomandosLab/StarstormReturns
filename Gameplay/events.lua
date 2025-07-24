local PATH_SOUND = path.combine(PATH, "Sounds/Ambience/")

local STORM_BONUS_SPAWN_RATE = 7
local STORM_POINT_BONUS_BASE = 15

local buffStorm = Buff.new(NAMESPACE, "storm")
buffStorm.is_timed = false
buffStorm.show_icon = false

buffStorm:clear_callbacks()
buffStorm:onStatRecalc(function(actor, stack)
	actor.attack_speed = actor.attack_speed + 0.15
	actor.pHmax = actor.pHmax + 0.7
	actor.armor = actor.armor + 95
end)
buffStorm:onPostDraw(function(actor, stack)
	gm.gpu_push_state()
	gm.gpu_set_fog(true, Color.WHITE, 0, 0)
	local x, y = actor.ghost_x, actor.ghost_y

	x = x + math.random(-1, 1)
	y = y + math.random(-1, 1)

	gm.gpu_set_blendmode(1)
	gm.draw_sprite_ext(actor.sprite_index, actor.image_index, x, y, 1.1 * actor.image_xscale, 1.1 * actor.image_yscale, 0, Color.WHITE, 0.18 * actor.image_alpha)
	gm.gpu_pop_state()
end)

local partRain2 = Particle.find("ror", "Rain2")

local eventStorm = EventManager.new_event("storm")
eventStorm.alert_token = "alert.event.storm"
eventStorm.duration = 45
eventStorm.soundscape = Resources.sfx_load(NAMESPACE, "AmbienceRain", path.combine(PATH_SOUND, "rain1.ogg"))

local storm_soundscape_random = {
	Resources.sfx_load(NAMESPACE, "AmbienceStorm1", path.combine(PATH_SOUND, "rainStorm1.ogg")),
	Resources.sfx_load(NAMESPACE, "AmbienceStorm2", path.combine(PATH_SOUND, "rainStorm2.ogg")),
	Resources.sfx_load(NAMESPACE, "AmbienceStorm3", path.combine(PATH_SOUND, "rainStorm3.ogg")),
	Resources.sfx_load(NAMESPACE, "AmbienceStorm4", path.combine(PATH_SOUND, "rainStorm4.ogg")),
}

eventStorm.on_start = function(tier, data)
	data.frame_counter = 0
	data.time_since_strike = 0

	local director = gm._mod_game_getDirector()
	director.bonus_rate = director.bonus_rate + STORM_BONUS_SPAWN_RATE
end
eventStorm.on_step = function(tier, data)
	data.frame_counter = data.frame_counter + 1

	local vx = Global.___view_l_x
	local vy = Global.___view_l_y
	local vw = Global.___view_l_w

	if not EventManager.is_active_event_ending() then
		for i=1, Global.__pref_graphics_quality * 2 do
			partRain2:create(vx + vw * math.random(), vy, 1, Particle.SYSTEM.background )
		end
	end

	if data.frame_counter % 60 == 0 then
		local director = gm._mod_game_getDirector()
		director.points = director.points + STORM_POINT_BONUS_BASE * director.enemy_buff

		if math.random() < data.time_since_strike * 0.01 then
			-- TODO: cool lightning strike visual effect in the bg?
			local screenflash = GM.instance_create(0, 0, gm.constants.oWhiteFlash)
			screenflash.rate = 0.01
			screenflash.image_alpha = 0.1

			gm._mod_game_shakeScreen_global(math.random(1, 5))

			local sound = storm_soundscape_random[math.random(#storm_soundscape_random)]

			data.time_since_strike = 0

			gm.sound_play_global(sound, 1, 1)
		end

		data.time_since_strike = data.time_since_strike + 1

		if gm._mod_net_isHost() then
			for _, actor in ipairs(Instance.find_all(gm.constants.pEnemy)) do
				if actor.team == 2 and actor:buff_stack_count(buffStorm) == 0 then
					actor:buff_apply(buffStorm)
				end
			end
		end
	end
end
eventStorm.on_end = function(tier, data)
	local director = gm._mod_game_getDirector()
	director.bonus_rate = director.bonus_rate - STORM_BONUS_SPAWN_RATE

	if gm._mod_net_isHost() then
		for _, actor in ipairs(Instance.find_all(gm.constants.pEnemy)) do
			if actor:buff_stack_count(buffStorm) > 0 then
				actor:buff_remove(buffStorm)
			end
		end
	end
end