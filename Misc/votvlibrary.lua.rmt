--All my functions! And sometimes some constants

--Check if a point is colliding with the stage
function is_point_colliding_stage(x, y, actor)
	local collision = actor:collision_point(x, y, gm.constants.pBlock, false, true)
	if not collision or (type(collision) == "number" and collision < 0) then
		return false
	end
	return true
end

--Same thing, but with an instance instead
function is_colliding_stage(inst, x, y)
	return inst:is_colliding(gm.constants.pBlock, x or inst.x, y or inst.y)
end

--Move a point in a specified direction until it collides with the stage, or has reached the max amount
---90 is down, 270 up, 180 left, and 0/360 right
function move_point_contact_solid(x, y, angle, amount, actor)
	amount = amount or 1000
	local totalMoved = 0
	local xx = math.cos(math.rad(angle))
	local yy = math.sin(math.rad(angle))
	while totalMoved < amount do
		x = x + xx * 32
		y = y + yy * 32
		totalMoved = totalMoved + 32
		if totalMoved >= amount then
			x = x - xx * (totalMoved - amount)
			y = y - yy * (totalMoved - amount)
			break
		end
		if is_point_colliding_stage(x, y, actor) then
			for i = 0, 31 do
				x = x - xx
				y = y - yy
				if not is_point_colliding_stage(x, y, actor) then
					break
				end
			end
			break
		end
	end
	return x, y
end

--Same as move_point_contact_solid, but stops after *exiting* terrain instead
function move_point_contact_air(x, y, angle, amount, actor)
	amount = amount or 1000
	local totalMoved = 0
	local xx = math.cos(math.rad(angle))
	local yy = math.sin(math.rad(angle))
	while totalMoved < amount do
		x = x + xx * 32
		y = y + yy * 32
		totalMoved = totalMoved + 32
		if totalMoved >= amount then
			x = x - xx * (totalMoved - amount)
			y = y - yy * (totalMoved - amount)
			break
		end
		if not is_point_colliding_stage(x, y, actor) then
			for i = 0, 31 do
				x = x - xx
				y = y - yy
				if is_point_colliding_stage(x, y, actor) then
					x = x + xx
					y = y + yy
					break
				end
			end
			break
		end
	end
	return x, y
end

--Same as move_point_contact_solid, but with an instance instead
function move_contact_solid(inst, angle, amount)
	amount = amount or 1000
	local totalMoved = 0
	local xx = math.cos(math.rad(angle))
	local yy = math.sin(math.rad(angle))
	while totalMoved < amount do
		inst.x = inst.x + xx * 32
		inst.y = inst.y + yy * 32
		totalMoved = totalMoved + 32
		if totalMoved >= amount then
			inst.x = inst.x - xx * (totalMoved - amount)
			inst.y = inst.y - yy * (totalMoved - amount)
		end
		if is_colliding_stage(inst) then
			for i = 0, 31 do
				inst.x = inst.x - xx
				inst.y = inst.y - yy
				if not is_colliding_stage(inst) then
					break
				end
			end
			break
		end
	end
	return x, y
end

--Same as move_point_contact_air, but with an instance instead
function move_contact_air(inst, angle, amount)
	amount = amount or 1000
	local totalMoved = 0
	local xx = math.cos(math.rad(angle))
	local yy = math.sin(math.rad(angle))
	while totalMoved < amount do
		inst.x = inst.x + xx * 32
		inst.y = inst.y + yy * 32
		totalMoved = totalMoved + 32
		if totalMoved >= amount then
			inst.x = inst.x - xx * (totalMoved - amount)
			inst.y = inst.y - yy * (totalMoved - amount)
		end
		if not is_colliding_stage(inst) then
			for i = 0, 31 do
				inst.x = inst.x - xx
				inst.y = inst.y - yy
				if is_colliding_stage(inst) then
					inst.x = inst.x + xx
					inst.y = inst.y + yy
					break
				end
			end
			break
		end
	end
	return x, y
end

--Kinda useless but whatever... Feels better anyways
function get_tiles(x)
	return (x or 1) * 32
end

--Better is_grounded, I think?
function is_grounded(actor)
	return not gm.bool(actor.free)
end

--Retrieves a sprite previously loaded
function sprite_find(namespace, identifier)
	return gm.sprite_find(namespace.."-"..identifier)
end

--Sets the achievement to the Survivors category, locks the survivor behind it, and sets the sprites and unlock text ("X" unlocked.)
function set_survivor_achievement(achievement, survivor)
	achievement.group = Achievement.GROUP.character
	achievement.token_unlock_name = survivor.token_name
	achievement:set_sprite(survivor.sprite_portrait, 0)
	survivor:set_survivor_achievement(achievement)
end

--Adds X to the achievement's progress (Achievement completes when progress reaches the requirement)
function progress_achievement(achievement, value)
	gm.achievement_add_progress(achievement.value, value)
end

--Simple, makes the attack not proc the damage number yellow
function setNoProc(attack_info)
	attack_info.proc = false
	attack_info.damage_color = Color.from_hex(0xC9B736)
end