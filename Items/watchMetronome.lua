local sprite = Sprite.new("WatchMetronome", path.combine(PATH, "Sprites/Items/watchMetronome.png"), 1, 17, 15)
local bar_sprite = Sprite.new("MetronomeBar2", path.combine(PATH, "Sprites/Items/Effects/metronomeBar.png"), 1, 26, 5)

local sound_tick1 = Sound.new("MetronomeTick1", path.combine(PATH, "Sounds/Items/watchTick1.ogg"))
local sound_tick2 = Sound.new("MetronomeTick2", path.combine(PATH, "Sounds/Items/watchTick2.ogg"))

local CHARGE_RATE = 1 / (60 * 3)
local TICK_INTERVAL = 1 / 9

local BAR_COLOR = Color.from_rgb(130, 157, 255)
local BAR_COLOR_LIT = Color.from_rgb(178, 211, 255)

-- account for survivor bars and such
local class_offsets = {
	[Survivor.find("drifter").value] = 19,
	[Survivor.find("sniper").value] = 22,
}

local buffChrono = Buff.new("chrono")
buffChrono.show_icon = false
buffChrono.is_timed = false

local watchMetronome = Item.new("watchMetronome")
watchMetronome:set_sprite(sprite)
watchMetronome:set_tier(ItemTier.UNCOMMON)
watchMetronome.loot_tags = Item.LootTag.CATEGORY_UTILITY + Item.LootTag.ITEM_BLACKLIST_ENGI_TURRETS

ItemLog.new_from_item(watchMetronome)

watchMetronome.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	
	local x = actor.x + 1
	local y = actor.y + 19

	local offset = class_offsets[actor.class]
	if offset then
		y = y + offset
	end

	local bar_left		= x - 20
	local bar_right		= x + 20
	local bar_width		= bar_right - bar_left
	local bar_top		= y - 2
	local bar_bottom	= y + 2

	local fraction = Instance.get_data(actor).chrono_charge or 0

	if actor:buff_count(buffChrono) > 0 then
		gm.draw_set_colour(BAR_COLOR_LIT)
	else
		gm.draw_set_colour(BAR_COLOR)
	end
	
	gm.draw_rectangle(bar_left, bar_top, bar_left + bar_width * fraction, bar_bottom, false)
	GM.draw_sprite(bar_sprite, 0, x, y)
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(watchMetronome.on_acquired, function(actor, stack)
	local data = Instance.get_data(actor)
	
	if not data.chrono_charge then
		data.chrono_charge = 0
		data.chrono_tick = 0
	end
end)

Callback.add(watchMetronome.on_removed, function(actor, stack)
	local data = Instance.get_data(actor)
	
	if stack == 1 then
		data.chrono_charge = nil
		data.chrono_tick = nil

		actor:buff_remove(buffChrono)
	end
end)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(watchMetronome:get_holding_actors()) do
		if Instance.exists(actor) then
			local stack = actor:item_count(watchMetronome)
			local data = Instance.get_data(actor)
			local motion_frac = math.abs(actor.pHspeed) / actor.pHmax

			if actor:is_climbing() then
				motion_frac = 0

				if Util.bool(actor.ropeUp) or Util.bool(actor.ropeDown) then
					motion_frac = 1
				end
			end

			if actor:buff_count(buffChrono) <= 0 then
				motion_frac = 1 - motion_frac
				
				if motion_frac > 0.01 then
					data.chrono_charge = math.min(1, data.chrono_charge + motion_frac * CHARGE_RATE)

					if data.chrono_charge >= 0.666 and data.chrono_tick + TICK_INTERVAL < data.chrono_charge then
						actor:sound_play(sound_tick1, 0.8, 1.0)
						data.chrono_tick = data.chrono_charge
					end

					if data.chrono_charge >= 1 then
						actor:buff_apply(buffChrono, 60)
						data.chrono_tick = 1
					end
				end
			else
				if motion_frac > 0.01 then
					local decay_reduction = 1 / (1 + (stack - 1) * 0.333)

					data.chrono_charge = math.max(0, data.chrono_charge - motion_frac * CHARGE_RATE * decay_reduction)

					if data.chrono_charge <= 0.333 * decay_reduction and data.chrono_tick - TICK_INTERVAL * decay_reduction > data.chrono_charge then
						actor:sound_play(sound_tick2, 0.8, 1.0)
						data.chrono_tick = data.chrono_charge
					end

					if data.chrono_charge <= 0 then
						actor:buff_remove(buffChrono)
						data.chrono_tick = 0
					end
				end
			end
		end
	end
end)

Callback.add(buffChrono.on_apply, function(actor, stack)
	actor:sound_play(gm.constants.wChefShoot2_1, 0.8, 1.5)

	-- the charge value isn't synced, but the buff *is*
	-- so just incase the clients' charge desyncs, it gets corrected by this
	Instance.get_data(actor).chrono_charge = 1

	local flash = Object.find("EfFlash"):create(actor.x, actor.y)
	flash.parent = actor
	flash.image_blend = BAR_COLOR_LIT
	flash.rate = 0.04
end)

Callback.add(buffChrono.on_remove, function(actor, stack)
	actor:sound_play(gm.constants.wWispSpawn, 0.8, 1.5)
	Instance.get_data(actor).chrono_charge = 0

	local flash = Object.find("EfFlash"):create(actor.x, actor.y)
	flash.parent = actor
	flash.image_blend = Color.WHITE
	flash.rate = 0.08
end)

RecalculateStats.add(function(actor, api)
	local stack = actor:buff_count(buffChrono)
    if stack <= 0 then return end
	
	api.pHmax_add(1.4)
end)
