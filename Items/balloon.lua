local sprite_item = Sprite.new("Balloon", path.combine(PATH, "Sprites/Items/balloon.png"), 1, 17, 19)
local sprite_effect = Sprite.new("EfBalloon", path.combine(PATH, "Sprites/Items/Effects/balloon.png"), 6, 4, 6)
local sound_pop = Sound.new("BalloonPop", path.combine(PATH, "Sounds/Items/balloonPop.ogg"))

-- used for popping particles
local BALLOON_COLORS = {
	[0] = Color.from_rgb(128, 221, 225),
	[1] = Color.from_rgb(225, 128, 128),
	[2] = Color.from_rgb(206, 128, 225),
	[3] = Color.from_rgb(128, 225, 135),
	[4] = Color.from_rgb(225, 218, 128),
	[5] = Color.from_rgb(225, 128, 184),
}

local GOLDEN_RATIO = (math.pi * 360) / 137.50776405004 -- magical constant used in balloon positioning

local particlePop = Particle.new("BalloonPop")
particlePop:set_direction(0, 360, false, false, false)
particlePop:set_shape(Particle.Shape.DISK)
particlePop:set_size(0.08, 0.12, -0.005, 0.02)
particlePop:set_speed(1, 4, -0.08, 0)
particlePop:set_gravity(0.1, 270)
particlePop:set_life(20, 40)

local buff = Buff.new("balloon")
buff.show_icon = false
buff.is_timed = false

local balloon = Item.new("balloon")
balloon:set_sprite(sprite_item)
balloon:set_tier(ItemTier.UNCOMMON)
balloon.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(balloon)

balloon.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	if actor:buff_count(buff) == 0 then return end
	
	local stack = actor:item_count(balloon)
	local data = Instance.get_data(actor)
	
	gm.draw_set_colour(Color.WHITE)

	local start_x = actor.ghost_x
	local start_y = actor.ghost_y - gm.sprite_get_yoffset(actor.sprite_idle) + 3
	
	for i, balloon in ipairs(data.balloons) do
		local balloon = data.balloons[i]
		GM.draw_sprite(sprite_effect, (i - 1) % 6, balloon.x, balloon.y)
		gm.draw_set_alpha(0.3)
		gm.draw_line(balloon.x, balloon.y, start_x, start_y)
		gm.draw_set_alpha(1)
	end
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(balloon:get_holding_actors()) do
		if actor.in_danger_last_frame < Global._current_frame and actor:buff_count(buff) == 0 then
			actor:buff_apply(buff, 1)
		end
	end
	
	for _, actor in ipairs(buff:get_holding_actors()) do
		local stack = actor:item_count(balloon)
		local data = Instance.get_data(actor)

		if not data.balloons then
			data.balloons = {}
		end

		while #data.balloons < stack do
			table.insert(data.balloons, {
				x = actor.x,
				y = actor.y,
				rot = 0,
			})
		end

		for i = 1, stack do
			local b = data.balloons[i]

			local tx = actor.ghost_x
			local ty = actor.ghost_y-50

			local ang = math.floor(i * 0.5) * GOLDEN_RATIO
			local mag = math.sqrt(ang) * 1.8

			if i % 2 == 0 then
				mag = -mag
			end

			tx = tx + math.sin(ang) * mag
			ty = ty + math.cos(ang) * mag

			local lerp = 0.05 * (0.95 ^ i ) + 0.05

			b.x = Math.lerp(b.x, tx, lerp)
			b.y = Math.lerp(b.y, ty, lerp)
		end
		
		if actor.in_danger_last_frame > Global._current_frame then
			actor:buff_remove(buff)
		end
	end
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buff)
	if stack <= 0 then return end
	
	local exponent = stack ^ 0.7 -- try and somewhat reduce the potency of stacking

	-- modifying downward/default gravity is iffy, rusty jetpack doesn't do this and doing it makes falling uncontrollably slower
	-- ... but also, let mimics/non-players benefit from balloon
	if actor.object_index ~= gm.constants.oP then
		actor.pGravity1 = actor.pGravity1 * 0.65 ^ exponent
	end
	
	actor.pGravity2 = actor.pGravity2 * 0.65 ^ exponent
end)

Callback.add(balloon.on_removed, function(actor, stack)
	local data = Instance.get_data(actor)
	
	if data.balloons then
		table.remove(data.balloons, #data.balloons)
	end

	if stack == 1 then
		actor:buff_remove(buff)
	end
end)

Callback.add(buff.on_remove, function(actor)
	local data = Instance.get_data(actor)

	if data.balloons and #data.balloons > 0 then
		actor:screen_shake(7)
		actor:sound_play(sound_pop, 1, 1)

		for i, balloon in ipairs(data.balloons) do
			local color = BALLOON_COLORS[(i - 1) % 6] or Color.WHITE
			particlePop:create_color(balloon.x, balloon.y, color, 8)
		end
		
		data.balloons = nil
	end
end)
