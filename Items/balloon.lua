local sprite_item = Resources.sprite_load(NAMESPACE, "Balloon", path.combine(PATH, "Sprites/Items/balloon.png"), 1, 17, 17)
local sprite_effect = Resources.sprite_load(NAMESPACE, "EfBalloon", path.combine(PATH, "Sprites/Items/Effects/balloon.png"), 6, 4, 6)

local balloon = Item.new(NAMESPACE, "balloon")
balloon:set_sprite(sprite_item)
balloon:set_tier(Item.TIER.uncommon)
balloon:set_loot_tags(Item.LOOT_TAG.category_utility)

balloon:clear_callbacks()
balloon:onAcquire(function(actor, stack)
	local data = actor:get_data()
	if not data.balloons then
		data.balloons = {}
	end

	local b = {
		x = actor.x,
		y = actor.y,
		rot = 0,
	}

	table.insert(data.balloons, b)
end)
balloon:onRemove(function(actor, stack)
	local data = actor:get_data()
	if stack == 1 then
		data.balloons = nil
	elseif stack > 1 then
		data.balloons[stack] = nil
	end
end)

balloon:onPostStatRecalc(function(actor, stack)
	local exponent = stack ^ 0.7 -- try and somewhat reduce the potency of stacking

	-- modifying downward/default gravity is iffy, jetpack doesn't do this and doing it makes falling uncontrollably slower
	--actor.pGravity1 = actor.pGravity1 * 0.70 ^ exponent
	actor.pGravity2 = actor.pGravity2 * 0.65 ^ exponent

	print(1 - 0.65 ^ exponent)
end)

local golden_ratio = (math.pi * 360) / 137.50776405004

balloon:onPostStep(function(actor, stack)
	local data = actor:get_data()
	for i=1, stack do
		local b = data.balloons[i]

		local tx = actor.ghost_x
		local ty = actor.ghost_y-50

		local ang = math.floor(i * 0.5) * golden_ratio
		local mag = math.sqrt(ang) * 1.75

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

balloon:onPreDraw(function(actor, stack)
	local data = actor:get_data()
	gm.draw_set_colour(Color.WHITE)
	for i=1, stack do
		local b = data.balloons[i]
		gm.draw_sprite(sprite_effect, (i-1)%6, b.x, b.y)
		--local rot = gm.point_direction(b.x, b.y, actor.x, actor.y) + 90
		--gm.draw_sprite_ext( sprite_effect, 0, b.x, b.y, 1, 1, rot, Color.WHITE, 1 )
		gm.draw_set_alpha(0.3)
		gm.draw_line(b.x, b.y, actor.ghost_x, actor.ghost_y)
		gm.draw_set_alpha(1)
	end
end)
