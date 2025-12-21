-- TEMPORARY RETURNS API UNFINISHED THINGS --
-- basically lifted from rmt since returns api doesnt have them yet, once rapi adds them delete all this shit and use that instead

-- MONSTER LOGS
function ssr_set_monster_log_boss(self, is_boss)
	if type(is_boss) ~= "boolean" then log.error("is_boss should be a boolean, got a "..type(is_boss), 2) return end

	if is_boss then
		self.log_backdrop_index = 1
	else
		self.log_backdrop_index = 0
	end

	-- Remove previous monster log position (if found)
	local monster_log_order = List.wrap(gm.variable_global_get("monster_log_display_list"))
	local pos = monster_log_order:find(self)
	if pos then monster_log_order:delete(pos) end

	local pos = monster_log_order:size()
	for i, id in ipairs(monster_log_order) do
		if MonsterLog.wrap(id).log_backdrop_index > self.log_backdrop_index then
			pos = i
			break
		end
	end
	
	monster_log_order:insert(pos - 1, self)
end

function ssr_create_monster_log(identifier)
	-- check if monster_log already exists
	local monster_log = MonsterLog.find(identifier)
    if monster_log then return monster_log end

    -- create monster_log
    monster_log = MonsterLog.wrap(gm.monster_log_create("ssr", identifier))

    monster_log.sprite_id = gm.constants.sLizardWalk
    monster_log.portrait_id = gm.constants.sPortrait
	
	ssr_set_monster_log_boss(monster_log, false)

    return monster_log
end

-- ELITES
function ssr_create_elite(identifier)
	-- check if monster_log already exists
	local elite = Elite.find(identifier)
    if elite then return elite end

    -- create monster_log
    elite = Elite.wrap(gm.elite_type_create("ssr", identifier))

    return elite
end

-- END OF TEMPORARY RETURNS API UNFINISHED THINGS --

-- play animation and then fade it out object
local SSREfFadeout = Object.new("SSREfFadeout")

Callback.add(SSREfFadeout.on_create, function(self)
	self.fadeout_rate = 0.2
end)

Callback.add(SSREfFadeout.on_step, function(self)
	if self.image_index + self.image_speed >= gm.sprite_get_number(self.sprite_index) then
		self.image_speed = 0
	end
	
	if self.image_speed == 0 then
		self.image_alpha = self.image_alpha - self.fadeout_rate
		if self.image_alpha <= 0 then
			self:destroy()
		end
	end
end)

function ssr_create_fadeout(x, y, xscale, sprite, animation_speed, rate)
	local fadeout = Object.find("SSREfFadeout"):create(x, y)
	fadeout.image_xscale = xscale
	fadeout.sprite_index = sprite
	fadeout.image_speed = animation_speed
	fadeout.fadeout_rate = rate
	
	return fadeout
end

-- used for skins
obj_sprite_layer = Object.new("sprite_layer")
obj_sprite_layer:set_sprite(gm.constants.sEfChestRain)
obj_sprite_layer:set_depth(1)

Callback.add(obj_sprite_layer.on_create, function(inst)
	inst.image_speed = 0
end)

Callback.add(obj_sprite_layer.on_step, function(inst)
	if not inst.parent or not Instance.exists(inst.parent) then
		inst:destroy()
	end
end)

Callback.add(obj_sprite_layer.on_draw, function(inst)
	if inst.skinnable then
		inst:actor_skin_skinnable_draw_self()
	end
end)

-- math.approach from rorml
function ssr_approach(current, target, change)
	if current < target then 
		return math.min(target, current + change)
	elseif current > target then
		return math.max(target, current - change)
	end
end

-- check if a point is colliding with the stage
function ssr_is_point_colliding_stage(x, y, actor)
	local collision = actor:collision_point(x, y, gm.constants.pBlock, false, true)
	
	if not collision or (type(collision) == "number" and collision < 0) then
		return false
	end
	
	return true
end

-- check if an instance is colliding with the stage
function ssr_is_colliding_stage(inst, x, y)
	return inst:is_colliding(gm.constants.pBlock, x or inst.x, y or inst.y)
end

-- move a point in a specified direction until it collides with the stage, or has reached the max amount
-- 90 is down, 270 up, 180 left, and 0/360 right
function ssr_move_point_contact_solid(x, y, angle, amount, actor)
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
		
		if ssr_is_point_colliding_stage(x, y, actor) then
			for i = 0, 31 do
				x = x - xx
				y = y - yy
				if not ssr_is_point_colliding_stage(x, y, actor) then
					break
				end
			end
			break
		end
	end
	
	return x, y
end

-- move a point in a specified direction until it stops colliding with the stage, or has reached the max amount
-- 90 is down, 270 up, 180 left, and 0/360 right
function ssr_move_point_contact_air(x, y, angle, amount, actor)
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
		
		if not ssr_is_point_colliding_stage(x, y, actor) then
			for i = 0, 31 do
				x = x - xx
				y = y - yy
				
				if ssr_is_point_colliding_stage(x, y, actor) then
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

-- move an instance in a specified direction until it collides with the stage, or has reached the max amount
-- 90 is down, 270 up, 180 left, and 0/360 right
function ssr_move_contact_solid(inst, angle, amount)
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
		
		if ssr_is_colliding_stage(inst) then
			for i = 0, 31 do
				inst.x = inst.x - xx
				inst.y = inst.y - yy
				
				if not ssr_is_colliding_stage(inst) then
					break
				end
			end
			break
		end
	end
	
	return x, y
end

-- move an instance in a specified direction until it stops colliding with the stage, or has reached the max amount
-- 90 is down, 270 up, 180 left, and 0/360 right
function ssr_move_contact_air(inst, angle, amount)
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
		
		if not ssr_is_colliding_stage(inst) then
			for i = 0, 31 do
				inst.x = inst.x - xx
				inst.y = inst.y - yy
				
				if ssr_is_colliding_stage(inst) then
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

-- kinda useless but whatever... feels better anyways
function ssr_get_tiles(x)
	return (x or 1) * 32
end

-- sets the achievement to the survivors category, locks the survivor behind it, and sets the sprites and unlock text ("X" unlocked.)
function ssr_set_survivor_achievement(achievement, survivor)
	achievement.group = Achievement.GROUP.character
	achievement.token_unlock_name = survivor.token_name
	achievement:set_sprite(survivor.sprite_portrait, 0)
	survivor:set_survivor_achievement(achievement)
end

-- adds X to the achievement's progress (achievement completes when progress reaches the requirement)
function ssr_progress_achievement(achievement, value)
	gm.achievement_add_progress(achievement.value, value)
end

-- makes the attack not proc the damage number yellow
function ssr_set_no_proc(attack_info)
	attack_info.proc = false
	attack_info.damage_color = Color.from_hex(0xC9B736)
end

-- return true if there is no collision between the first set of coordinates and the second one
function ssr_line_of_sight(inst, x1, y1, x2, y2, edges)
	local list = List.new()
	
	inst:collision_line_list(x1, y1, x2, y2, gm.constants.pBlock, false, true, list, false)
	
	local flag = true
	
	for _, block in ipairs(list) do
		if block then
			flag = false
			break
		end
	end
	
	list:destroy()
	
	return flag
end

function ssr_instance_line_of_sight(inst, inst2)
	local list = List.new()
	local flag = false
	
	local coords = {
		{inst2.x, inst2.y}, 
		{inst2.bbox_left, inst2.bbox_top}, 
		{inst2.bbox_right, inst2.bbox_top}, 
		{inst2.bbox_left, inst2.bbox_bottom}, 
		{inst2.bbox_right, inst2.bbox_bottom}
	}
	
	for _, coord in ipairs(coords) do
		inst:collision_line_list(inst.x, inst.y, coord[1], coord[2], gm.constants.pBlock, false, true, list, false)
		
		local flag2 = true
		
		for _, block in ipairs(list) do
			if block then
				flag2 = false
				break
			end
		end
		
		if flag2 == true then
			flag = true
			break
		end
		
		list:clear()
	end
	
	list:destroy()
	
	return flag
end

function ssr_is_near_ground(inst, radius)
	local flag = false
	for _, block in ipairs(inst:get_collisions_circle(gm.constants.oB, radius)) do
		if block then
			flag = true
			break
		end
	end
	
	return flag
end

-- easy shortcut for checking if chirrsmas is active
ssr_chirrsmas_active = ((os.date("%m") == 12 and os.date("%d") >= 15) or (os.date("%m") == 1 and os.date("%d") <= 15) or Settings.chirrsmas == 1)