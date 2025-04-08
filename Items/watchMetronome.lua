local sprite = Resources.sprite_load(NAMESPACE, "WatchMetronome", path.combine(PATH, "Sprites/Items/watchMetronome.png"), 1, 15, 12)
local bar_sprite = Resources.sprite_load(NAMESPACE, "MetronomeBar2", path.combine(PATH, "Sprites/Items/Effects/metronomeBar.png"), 1, 26, 5)
--local bar_sprite_big = Resources.sprite_load(NAMESPACE, "MetronomeBarBig", path.combine(PATH, "Sprites/Items/Effects/metronomeBarBig.png"), 1, 2, 8)

local sound_tick1 = Resources.sfx_load(NAMESPACE, "MetronomeTick1", path.combine(PATH, "Sounds/Items/watchTick1.ogg"))
local sound_tick2 = Resources.sfx_load(NAMESPACE, "MetronomeTick2", path.combine(PATH, "Sounds/Items/watchTick2.ogg"))

local CHARGE_RATE = 1 / (60 * 3)
local TICK_INTERVAL = 1 / 9

local watchMetronome = Item.new(NAMESPACE, "watchMetronome")
watchMetronome:set_sprite(sprite)
watchMetronome:set_tier(Item.TIER.uncommon)
watchMetronome:set_loot_tags(Item.LOOT_TAG.category_utility, Item.LOOT_TAG.item_blacklist_engi_turrets)

local buffChrono = Buff.new(NAMESPACE, "chrono")
buffChrono.show_icon = false
buffChrono.is_timed = false

local objMetronomeBar = Object.new(NAMESPACE, "MetronomeBar")
objMetronomeBar.obj_depth = -400

watchMetronome:clear_callbacks()
watchMetronome:onAcquire(function(actor, stack)
	local data = actor:get_data()
	if not data.chrono_charge then
		data.chrono_charge = 0
		data.chrono_tick = 0
	end
end)
watchMetronome:onRemove(function(actor, stack)
	local data = actor:get_data()
	if stack == 1 then
		data.chrono_charge = nil
		data.chrono_tick = nil
		if data.chrono_bar:exists() then
			data.chrono_bar:destroy()
		end

		actor:buff_remove(buffChrono)
	end
end)
watchMetronome:onPostStep(function(actor, stack)
	local data = actor:get_data()

	if not Instance.exists(data.chrono_bar) then
		data.chrono_bar = objMetronomeBar:create()
		data.chrono_bar.parent = actor
	end

	local charged = actor:buff_stack_count(buffChrono) > 0
	local motion_frac = math.abs(actor.pHspeed) / actor.pHmax

	if gm.actor_state_is_climb_state(actor.actor_state_current_id) then
		motion_frac = 0

		if gm.bool(actor.ropeUp) or gm.bool(actor.ropeDown) then
			motion_frac = 1
		end
	end

	if not charged then
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
end)

local BAR_COLOR = Color.from_rgb(130, 157, 255)
local BAR_COLOR_LIT = Color.from_rgb(178, 211, 255)

-- account for survivor bars and such
local class_offsets = {
	[Survivor.find("ror", "drifter").value] = 19,
	[Survivor.find("ror", "sniper").value] = 22,
}

objMetronomeBar:clear_callbacks()
objMetronomeBar:onCreate(function(self)
	self.parent = -4
	self.persistent = true
end)
objMetronomeBar:onStep(function(self)
	if not GM.actor_is_alive(self.parent) then
		self:destroy()
	end
end)
objMetronomeBar:onDraw(function(self)
	if not Instance.exists(self.parent) then return end
	if not gm.bool(self.parent.visible) then return end

	local actor = self.parent
	local data = actor:get_data()

	local x, y = math.floor(actor.ghost_x+0.5), math.floor(actor.ghost_y+0.5)

	local x = x + 1
	local y = y + 19

	local offset = class_offsets[actor.class]
	if offset then
		y = y + offset
	end

	local bar_left		= x - 20
	local bar_right		= x + 20
	local bar_width		= bar_right - bar_left
	local bar_top		= y - 2
	local bar_bottom	= y + 2

	local fraction = data.chrono_charge or 0
	local charged = actor:buff_stack_count(buffChrono) > 0

	if charged then
		gm.draw_set_colour(BAR_COLOR_LIT)
	else
		gm.draw_set_colour(BAR_COLOR)
	end
	gm.draw_rectangle(bar_left, bar_top, bar_left + bar_width * fraction, bar_bottom, false)

	gm.draw_sprite(bar_sprite, 0, x, y)
end)

buffChrono:clear_callbacks()
buffChrono:onApply(function(actor, stack)
	actor:sound_play(gm.constants.wChefShoot2_1, 0.8, 1.5)

	local ef = GM.instance_create(0, 0, gm.constants.oEfFlash)
	ef.parent = actor
	ef.image_blend = BAR_COLOR_LIT
	ef.rate = 0.04
end)
buffChrono:onRemove(function(actor, stack)
	actor:sound_play(gm.constants.wWispSpawn, 0.8, 1.5)

	local ef = GM.instance_create(0, 0, gm.constants.oEfFlash)
	ef.parent = actor
	ef.image_blend = Color.WHITE
	ef.rate = 0.08
end)
buffChrono:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax + 1.4
end)
