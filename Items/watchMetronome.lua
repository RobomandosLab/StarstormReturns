local sprite = Resources.sprite_load(NAMESPACE, "WatchMetronome", path.combine(PATH, "Sprites/Items/watchMetronome.png"), 1, 15, 12)
local bar_sprite = Resources.sprite_load(NAMESPACE, "MetronomeBar2", path.combine(PATH, "Sprites/Items/Effects/metronomeBar.png"), 1, 26, 5)
--local bar_sprite_big = Resources.sprite_load(NAMESPACE, "MetronomeBarBig", path.combine(PATH, "Sprites/Items/Effects/metronomeBarBig.png"), 1, 2, 8)

local MAX_CHARGE = 2.4

local watchMetronome = Item.new(NAMESPACE, "watchMetronome")
watchMetronome:set_sprite(sprite)
watchMetronome:set_tier(Item.TIER.uncommon)
watchMetronome:set_loot_tags(Item.LOOT_TAG.category_utility, Item.LOOT_TAG.item_blacklist_engi_turrets)

watchMetronome:clear_callbacks()
watchMetronome:onPickup(function(actor, stack)
	local data = actor:get_data()
	if not data.chrono_charge then
		data.chrono_charge_last = 0
		data.chrono_charge = MAX_CHARGE * 0.5
	end
end)
watchMetronome:onNewStage(function(actor, stack)
	local data = actor:get_data()
	data.chrono_charge = MAX_CHARGE
end)

watchMetronome:onRemove(function(actor, stack)
	local data = actor:get_data()
	if stack == 1 and data.chrono_charge then
		data.chrono_charge_last = nil
		data.chrono_charge = nil
	end
end)
watchMetronome:onStatRecalc(function(actor, stack)
	local data = actor:get_data()
	actor.pHmax = actor.pHmax + data.chrono_charge
end)

local stateClimbID = State.find("ror", "climb").value

watchMetronome:onStep(function(actor, stack)
	local data = actor:get_data()
	local new_charge = data.chrono_charge

	if (actor.pHspeed == 0 and actor.actor_state_current_id ~= stateClimbID) -- when actor ISN'T climbing
	or (actor.actor_state_current_id == stateClimbID and not gm.bool(actor.ropeUp) and not gm.bool(actor.ropeDown)) then -- when actor IS climbing
		new_charge = math.min(new_charge + 0.01, MAX_CHARGE)
	else
		if data.chrono_charge > 0 then
			local calc = 0.015 / stack
			new_charge = math.max(0.0, new_charge - calc)
		end
	end

	local diff = new_charge - data.chrono_charge_last
	actor.pHmax = actor.pHmax + diff

	data.chrono_charge = new_charge
	data.chrono_charge_last = new_charge
end)

local color_bar = Color.from_rgb(130, 157, 255)
--local color_outline = Color.from_rgb(64, 64, 64)

local drifter_id = Survivor.find("ror", "drifter").value

watchMetronome:onDraw(function(actor, stack)
	local data = actor:get_data()

	local x = actor.ghost_x + 1
	local y = actor.ghost_y + 19
	-- her scrap bar gets in the way, move ours further down
	if actor.class == drifter_id then
		y = actor.bbox_bottom + 27
	end

	local bar_left		= x - 20
	local bar_right		= x + 20
	local bar_top		= y - 2
	local bar_bottom	= y + 2

	local fraction = data.chrono_charge / MAX_CHARGE

	--[[
	gm.draw_set_alpha(fraction * 0.65)

	gm.draw_set_colour(color_outline)
	gm.draw_rectangle(bar_left, bar_top, bar_right, bar_bottom, true)
	gm.draw_set_colour(0)
	gm.draw_rectangle(bar_left, bar_top, bar_right, bar_bottom, false)

	gm.draw_set_colour(color_bar)
	gm.draw_rectangle(bar_left, bar_top, gm.lerp(bar_left, bar_right, fraction), bar_bottom, false)
	gm.draw_set_alpha(1.0)
	]]--

	gm.draw_set_colour(color_bar)
	gm.draw_rectangle(bar_left, bar_top, gm.lerp(bar_left, bar_right, fraction), bar_bottom, false)

	gm.draw_sprite(bar_sprite, 0, x, y)
end)
