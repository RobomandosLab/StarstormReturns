local sprite_item = Resources.sprite_load(NAMESPACE, "Balloon", path.combine(PATH, "Sprites/Items/balloon.png"), 1, 17, 19)
local sprite_effect = Resources.sprite_load(NAMESPACE, "EfBalloon", path.combine(PATH, "Sprites/Items/Effects/balloon.png"), 6, 4, 6)
local sound_pop = Resources.sfx_load(NAMESPACE, "BalloonPop", path.combine(PATH, "Sounds/Items/balloonPop.ogg"))

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

local particlePop = Particle.new(NAMESPACE, "BalloonPop")
particlePop:set_direction(0, 360, false, false, false)
particlePop:set_shape(Particle.SHAPE.disk)
particlePop:set_size(0.08, 0.12, -0.005, 0.02)
particlePop:set_speed(1, 4, -0.08, 0)
particlePop:set_gravity(0.1, 270)
particlePop:set_life(20, 40)

local balloon = Item.new(NAMESPACE, "balloon")
balloon:set_sprite(sprite_item)
balloon:set_tier(Item.TIER.uncommon)
balloon:set_loot_tags(Item.LOOT_TAG.category_utility)

local buff = Buff.new(NAMESPACE, "balloon")
buff.show_icon = false
buff.is_timed = false

balloon:clear_callbacks()
balloon:onPreStep(function(actor, stack)
	if actor.in_danger_last_frame < Global._current_frame and actor:buff_stack_count(buff) == 0 then
		actor:buff_apply(buff, 1)
	end
end)
balloon:onRemove(function(actor, stack)
	local data = actor:get_data()
	if data.balloons then
		table.remove(data.balloons, #data.balloons)
	end

	if stack == 1 then
		actor:buff_remove(buff)
	end
end)

buff:clear_callbacks()
buff:onPostStatRecalc(function(actor, _)
	local stack = actor:item_stack_count(balloon)
	local exponent = stack ^ 0.7 -- try and somewhat reduce the potency of stacking

	-- modifying downward/default gravity is iffy, rusty jetpack doesn't do this and doing it makes falling uncontrollably slower
	-- ... but also, let mimics/non-players benefit from balloon
	if actor.object_index ~= gm.constants.oP then
		actor.pGravity1 = actor.pGravity1 * 0.65 ^ exponent
	end
	actor.pGravity2 = actor.pGravity2 * 0.65 ^ exponent
end)

buff:onPostStep(function(actor, _)
	local stack = actor:item_stack_count(balloon)

	if actor.in_danger_last_frame > Global._current_frame then
		actor:buff_remove(buff)
		return
	end

	local data = actor:get_data()
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

	for i=1, stack do
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

		b.x = gm.lerp(b.x, tx, lerp)
		b.y = gm.lerp(b.y, ty, lerp)
	end
end)

buff:onPreDraw(function(actor, _)
	local stack = actor:item_stack_count(balloon)
	local data = actor:get_data()
	gm.draw_set_colour(Color.WHITE)

	local start_x = actor.ghost_x
	local start_y = actor.ghost_y - gm.sprite_get_yoffset(actor.sprite_idle) + 3

	for i, b in ipairs(data.balloons) do
		local b = data.balloons[i]
		gm.draw_sprite(sprite_effect, (i-1)%6, b.x, b.y)
		gm.draw_set_alpha(0.3)
		gm.draw_line(b.x, b.y, start_x, start_y)
		gm.draw_set_alpha(1)
	end
end)

buff:onRemove(function(actor)
	local data = actor:get_data()

	if data.balloons and #data.balloons > 0 then
		actor:screen_shake(7)
		actor:sound_play(sound_pop, 1, 1)

		for i, b in ipairs(data.balloons) do
			local color = BALLOON_COLORS[(i-1)%6] or Color.WHITE
			particlePop:create_color(b.x, b.y, color, 8)
		end
		actor:get_data().balloons = nil
	end
end)
