-- core system for everything Event-related

local DEBUG = true

EventManager = {}

-- event tiers
-- 1: light
-- 2: medium
-- 3: heavy
local EVENT_TIER_PROGRESSION = {
	[1] = {
		1, 2, 2,
	},
	[2] = {
		1, 2, 3,
	},
	[3] = {
		2, 2, 3,
	},
	[4] = {
		2, 3,
	},
	[5] = {
		3,
	},
}

 -- holds all Event data
local events = {}

-- stage IDs within which, events never happen
local stage_event_blacklist = {}

local alert_state = {
	active = false,
	text = ":3",
	sprite,
	sprite_frame = 0,
	timer,
	alpha,
}

-- state pertaining to the current event
local active_event = nil
local active_event_tier = 0
local active_event_duration = 0
local active_event_is_ending = false
local active_event_data = {}
local active_event_fade = 0 -- controls overlay and soundscape fading

if active_event_audio_loop then
	gm.audio_stop_sound(active_event_audio_loop)
end

active_event_audio_loop = nil

-- used to track which event tier to use
local events_this_stage = 0
local stage_sequence = 1

-- pre-event state
local events_enabled = true
local event_timer = 0
local next_event_countdown = -1
local next_event = nil

-- shows an alert popup on the screen. optionally takes in a sprite icon.
-- language tokens are localized automatically.
function EventManager.show_alert(text, sprite, sprite_frame)
	text = gm.translate(text)
	sprite_frame = sprite_frame or 0

	alert_state.active = true
	alert_state.text = text
	alert_state.sprite = sprite
	alert_state.sprite_frame = sprite_frame
	alert_state.alpha = 0
	alert_state.timer = 0
end

function EventManager.new_event(name)
	if type(name) ~= "string" then error("argument of type string expected, got "..type(name), 2) end

	local ev = events[name]
	if ev then
		return ev
	end

	ev = {
		name = name,
		alert_token = "An event is starting...",
		duration = 30,
		min_tier = 1,
		max_tier = 3,
		overlay_color = Color.WHITE,
		overlay_alpha = 0.1,
		soundscape = nil,
	}

	events[name] = ev
	return ev
end

function EventManager.set_events_enabled(enabled)
	if type(enabled) ~= "boolean" then error("argument of type bool expected, got "..type(enabled), 2) end
	events_enabled = enabled
end

function EventManager.get_next_event_time()
	return math.random(3, 4) * 60
end

function EventManager.is_event_available(event)
	return event ~= nil
end

function EventManager.select_next_event()
	local ev = events["storm"]
	return ev
end

function EventManager.set_active_event(event)
	if type(event) == "string" then event = events[event] end

	if event ~= nil and not events[event.name] then
		error("Event does not exist", 2)
	end

	if active_event == event then return end

	if active_event and active_event.on_end then
		active_event.on_end(active_event_tier, active_event_data)
	end

	if active_event_audio_loop then
		gm.audio_stop_sound(active_event_audio_loop)
	end

	print(string.format("EventManager: setting active_event to %s", event and event.name))

	active_event = event
	active_event_is_ending = false
	active_event_fade = 0
	active_event_data = {}

	if active_event then
		overlay_color = active_event.overlay_color

		active_event_duration = active_event.duration

		local stage_tier_data = EVENT_TIER_PROGRESSION[ math.min(stage_sequence, #EVENT_TIER_PROGRESSION) ]
		local tier = stage_tier_data[ math.min(events_this_stage, #stage_tier_data) ] or 2

		tier = math.min(active_event.max_tier, tier)
		tier = math.max(active_event.min_tier, tier)
		active_event_tier = tier

		if active_event.on_start then
			active_event.on_start(active_event_tier, active_event_data)
		end

		if active_event.soundscape then
			active_event_audio_loop = gm.audio_play_sound(active_event.soundscape, 1000, true)
		end
	end
end

function EventManager.reset_active_event()
	EventManager.set_active_event(nil)

	next_event = EventManager.select_next_event()
	next_event_countdown = EventManager.get_next_event_time()
end

-- called when the game ends, ensures looping audio doesn't persist
function EventManager.clean_up()
	EventManager.set_active_event(nil)
end

function EventManager.get_active_event_duration()
	if active_event then
		return active_event_duration
	end
	return -1
end

function EventManager.is_active_event_ending()
	if active_event then
		return active_event_is_ending
	end
	return false
end

Callback.add(Callback.TYPE.onGameStart, "SSEventManagerGameStart", function()
	stage_sequence = 0
end)

Callback.add(Callback.TYPE.onStageStart, "SSEventManagerStageStart", function()
	if not events_enabled then return end

	EventManager.reset_active_event()

	events_this_stage = 0
	stage_sequence = stage_sequence + 1
end)

Callback.add(Callback.TYPE.onGameEnd, "SSEventManagerCleanup", EventManager.clean_up)

Callback.add(Callback.TYPE.onSecond, "SSEventManagerSecond", function(min, sec)
	if not events_enabled then return end

	-- if there's an active event, just wait for it to be done
	if active_event then
		active_event_duration = active_event_duration - 1

		if active_event_duration <= 0 then
			active_event_is_ending = true -- see onStep callback below for event ending
		end

		return
	end

	if EventManager.is_event_available(next_event) then
		-- if there's no active event, count down to the next one and all that
		next_event_countdown = next_event_countdown - 1

		-- "An event is starting.." popup
		if next_event_countdown == 5 then
			EventManager.show_alert(next_event.alert_token)
		end

		-- actually start the event.
		if next_event_countdown <= 0 then
			events_this_stage = events_this_stage + 1

			EventManager.set_active_event(next_event)

			next_event = nil
			next_event_time = -1
		end
	end
end)

Callback.add(Callback.TYPE.onStep, "SSEventManagerStep", function()
	if not active_event then return end

	if active_event_is_ending then
		active_event_fade = math.max(0, active_event_fade - 0.01)

		-- actually end the event once it has faded out
		if active_event_fade <= 0 then
			EventManager.reset_active_event()
			return
		end
	else
		active_event_fade = math.min(1, active_event_fade + 0.01)
	end

	if active_event_audio_loop then
		gm.audio_sound_gain(active_event_audio_loop, Global.__pref_sound_volume * active_event_fade, 0)
	end

	if active_event and active_event.on_step then
		active_event.on_step(active_event_tier, active_event_data)
	end
end)

Callback.add(Callback.TYPE.preHUDDraw, "SSEventManagerPreHUDDraw", function()
	if not active_event then return end

	gm.draw_screen(active_event.overlay_alpha * active_event_fade, active_event.overlay_color)
end)

-- draw event alert
Callback.add(Callback.TYPE.onHUDDraw, "SSEventManagerHUDDraw", function()
	if DEBUG then
		local tx = Global.___view_l_x + 20
		local ty = Global.___view_l_y + 60
		gm.scribble_set_starting_format("fntNormal", Color.WHITE, 0)
		if active_event then
			gm.scribble_draw(tx, ty, string.format("event duration : %ds", active_event_duration))
			gm.scribble_draw(tx, ty+16, string.format("event tier : %d", active_event_tier))
		else
			gm.scribble_draw(tx, ty, string.format("next event '%s' in : %ds", next_event and next_event.name, next_event_countdown))
		end

		gm.scribble_draw(tx, ty+32, string.format("stage_sequence : %d", stage_sequence))
		gm.scribble_draw(tx, ty+48, string.format("events_this_stage : %d", events_this_stage))

		--[[
		local width = 130
		local height = 32

		local tx = Global.___view_l_x + Global.___view_l_w * 0.5
		local ty = Global.___view_l_y + Global.___view_l_h * 0.5 - 100
		local icon = Difficulty.wrap(Global.diff_level).sprite_loadout_id

		gm.draw_set_colour(0)
		gm.draw_set_alpha(0.4)

		gm.draw_rectangle(tx - width, ty - height, tx + width, ty + height, false)
		gm.draw_set_alpha(1)

		gm.draw_sprite(icon, 2, tx - width + 32, ty, 2, 2, 0, Color.WHITE, 1)
		gm.scribble_set_starting_format("fntLarge", Color.WHITE, 0)
		gm.scribble_draw(tx - width + 64, ty - 22, "Difficulty")
		gm.scribble_set_starting_format("fntNormal", Color.WHITE, 0)
		gm.scribble_draw(tx - width + 64, ty + 8, "fuck fuck fuck fuck fuck")
		--]]
	end

	if not alert_state.active then return end

	alert_state.timer = alert_state.timer + 1

	if alert_state.timer < 4 * 60 then
		alert_state.alpha = math.min(1, alert_state.alpha + 0.02)
	else
		alert_state.alpha = alert_state.alpha - 0.02

		if alert_state.alpha <= 0 then
			alert_state.active = false
			return
		end
	end

	gm.draw_set_alpha(alert_state.alpha)

	local tx = Global.___view_l_x + Global.___view_l_w * 0.5
	local ty = Global.___view_l_y + Global.___view_l_h * 0.5 - 100 -- offset to appear just above stage title name

	local text = alert_state.text

	-- white text with dark gray outline ..
	gm.scribble_set_starting_format("fntLarge", Color.WHITE, 1)
	gm.scribble_set_blend(Color.DKGRAY, alert_state.alpha)
	gm.scribble_draw(tx-1, ty,   text)
	gm.scribble_draw(tx+1, ty,   text)
	gm.scribble_draw(tx-1, ty-1, text)
	gm.scribble_draw(tx+1, ty-1, text)
	gm.scribble_draw(tx,   ty-1, text)
	gm.scribble_draw(tx,   ty+1, text)
	gm.scribble_draw(tx-1, ty+1, text)
	gm.scribble_draw(tx+1, ty+1, text)
	gm.scribble_set_blend(Color.WHITE, alert_state.alpha)
	gm.scribble_draw(tx, ty, text)

	-- draw alert icon, if it was provided
	if alert_state.sprite then
		gm.draw_sprite(alert_state.sprite, alert_state.sprite_frame, tx, ty - 40)
	end

	gm.scribble_set_blend(Color.WHITE, 1)
	gm.draw_set_alpha(1)
end)

if mods["RandomCatDude-EnableConsole"] then
    mods["RandomCatDude-EnableConsole"].auto()

	Console.add_command("event_set_time (time)", function(args)
		if active_event then
			active_event_duration = args[1] or math.huge
		else
			next_event_countdown = args[1] or math.huge
		end
	end)

	Console.add_command("event_set_next (event) (time)", function(args)
		next_event = events[args[1]]
		next_event_countdown = args[2] or 10
	end)

	Console.add_command("event_set_active (event) (time)", function(args)
		EventManager.set_active_event(args[1] or nil)
		if args[2] then
			active_event_duration = args[2]
		end
	end)
end