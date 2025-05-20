-- todo add comments later
local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Gatekeeper")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Gatekeeper")

local sprite_mask			= Resources.sprite_load(NAMESPACE, "GatekeeperMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 38, 59)
local sprite_laser_mask		= Resources.sprite_load(NAMESPACE, "GatekeeperLaserMask",	path.combine(SPRITE_PATH, "laserMask.png"), 1, 6, 20)
local sprite_palette		= Resources.sprite_load(NAMESPACE, "GatekeeperPalette",		path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn			= Resources.sprite_load(NAMESPACE, "GatekeeperSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 22, 72, 106)
local sprite_idle			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle",		path.combine(SPRITE_PATH, "idle.png"), 1, 58, 90)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle2",		path.combine(SPRITE_PATH, "idle2.png"), 1, 58, 90)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "GatekeeperWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 57, 90)
local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 7, 60, 91)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 17, 60, 91)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2a",		path.combine(SPRITE_PATH, "shoot2a.png"), 5, 60, 91)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2b",		path.combine(SPRITE_PATH, "shoot2b.png"), 5, 60, 91)
local sprite_death			= Resources.sprite_load(NAMESPACE, "GatekeeperDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 85, 113)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "GatekeeperPortrait",	path.combine(SPRITE_PATH, "portrait.png"))
local sprite_laser_par		= Resources.sprite_load(NAMESPACE, "GatekeeperLaserPar",	path.combine(SPRITE_PATH, "laserPar.png"), 6, 6, 6)

gm.elite_generate_palettes(sprite_palette)

local sound_spawn			= Resources.sfx_load(NAMESPACE, "GatekeeperSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_laser_hit		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserHit",			path.combine(SOUND_PATH, "laserHit.ogg"))
local sound_laser_fire		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserFire",		path.combine(SOUND_PATH, "laserFire.ogg"))
local sound_laser_fire2		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserFire2",		path.combine(SOUND_PATH, "laserFire2.ogg"))
local sound_laser_charge	= Resources.sfx_load(NAMESPACE, "GatekeeperLaserCharge",		path.combine(SOUND_PATH, "laserCharge.ogg"))
local sound_death			= Resources.sfx_load(NAMESPACE, "GatekeeperDeath",			path.combine(SOUND_PATH, "death.ogg"))

local keeper = Object.new(NAMESPACE, "Gatekeeper", Object.PARENT.enemyClassic)
local keeper_id = keeper.value
keeper:clear_callbacks()

local laserPar = Particle.new(NAMESPACE, "GatekeeperLaserPar")
laserPar:set_sprite(sprite_laser_par, true, true, false)
laserPar:set_alpha2(1, 0)
laserPar:set_life(60, 60)
laserPar:set_alpha1(0.9)
laserPar:set_speed(8, 9, -8 / 30, 0)

local laserTrail = Particle.new(NAMESPACE, "GatekeeperLaserTrail")
laserTrail:set_sprite(sprite_laser_par, true, true, false)
laserTrail:set_alpha2(1, 0)
laserTrail:set_life(60, 60)
laserTrail:set_alpha1(0.9)
laserTrail:set_speed(0, 0.3, 0.02, 0)
laserTrail:set_direction(70, 110, 0, -1)

local fortified = Buff.new(NAMESPACE, "GatekeeperFortified")
fortified.show_icon = false
fortified:clear_callbacks()

fortified:onStatRecalc(function(actor, stack)
	actor.armor = actor.armor + 100
	actor.pHmax = actor.pHmax - 40
end)

local objLaser = Object.new(NAMESPACE, "GatekeeperLaser")
objLaser.obj_depth = -5
objLaser:clear_callbacks()

objLaser:onCreate(function(self)
	local data = self:get_data()
	self:instance_sync()
	self.mask = sprite_laser_mask
	self.sprite_index = sprite_laser_mask
	self.image_alpha = 0
	self:move_contact_solid(270, 200)
	self.direction = 0
	self.speed = 0
	data.parent = -4
	data.charge = 0
	data.timer = 30
	data.pulse = 1
	data.color = Color.from_hex(0x81CADC)
end)

objLaser:onStep(function(self)
	local data = self:get_data()
	local parent = Instance.wrap(data.parent)
	
	self:move_contact_solid(270, 200)
	
	while self:is_colliding(gm.constants.pBlock, self.x, self.y) do
		self.y = self.y - 1
	end
	
	if data.timer > 0 then
		data.timer = data.timer - 1
	else
		if data.charge < 110 then
			data.charge = data.charge + 1
		else
			self:destroy()
		end
		
		if data.colorCheck == nil and parent and parent:exists() then
			if parent.elite_type and parent.elite_type ~= -1 then
				data.color = Elite.wrap(parent.elite_type).blend_col
			end
			data.colorCheck = true
		end
		
		if data.charge % 6 == 0 then
			if Instance.exists(parent) then
				local attack = parent:fire_explosion_local(self.x, self.y - 500, (44 - math.max(22, data.charge * 0.4)) * 4, 1000, 1 * data.charge * 0.005)
				attack.attack_info.y = self.y
				local attack = parent:fire_explosion_local(parent.x, parent.y - 650, (44 / 1.5 - math.max(22 / 1.5, data.charge * 0.4 / 1.5)) * 4, 1009, 0.5 * data.charge * 0.005)
				attack.attack_info.y = 0
			end
			self:screen_shake(1)
			self:sound_play(sound_laser_hit, ((110 - math.max(55, data.charge))) / 55 * 0.6, 0.9 + math.random() * 0.2)
			data.pulse = 1.18
		end
		
		if data.pulse > 1 then
			data.pulse = data.pulse - 0.03
		end
		
		if data.charge % 2 == 0 and data.charge <= 90 then
			if math.random() >= 0.5 then
				laserPar:set_direction(0, 0, 0, 0)
			else
				laserPar:set_direction(180, 180, 0, 0)
			end
			laserPar:create(self.x, self.y - math.random(1000), 1, Particle.SYSTEM.middle)
		end
		if data.charge % 2 == 0 and math.random(1, data.charge) / 2 <= 11 then
			laserTrail:create(self.x, self.y - 8, 1, Particle.SYSTEM.middle)
		end
		
		if data.charge == 1 then
			self:screen_shake(5)
		end
	end
	
	if Instance.exists(parent) and parent.image_index >= 5 then
		parent.image_index = 3
	end
end)

objLaser:onDraw(function(self)
	local data = self:get_data()
	local parent = Instance.wrap(data.parent)
	local offset = 150
	
	if parent and Instance.exists(parent) then
		if data.timer > 0 then
			local width = 44 - gm.round(data.timer * 1.46)
			
			gm.draw_set_colour(data.color)
			gm.draw_set_alpha((30 - data.timer) / 30 * 0.75)
			gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
			
			gm.draw_set_colour(data.color)
			gm.draw_set_alpha((30 - data.timer) / 30 * 0.75)
			gm.draw_rectangle(parent.x - width / 1.5, 0, parent.x + width / 1.5, parent.y - offset, false)
			gm.draw_set_colour(Color.WHITE)
			gm.draw_set_alpha(1)
			
			gm.draw_circle(parent.x, parent.y - offset, width, false)
		else
			if data.charge > 10 then
				local width = (44 - math.max(22, data.charge * 0.4)) * 2 * data.pulse
				local width2 = (44 / 2 - math.max(22 / 2, data.charge * 0.4 / 2)) * 2 * data.pulse
				local width3 = (44 / 1.5 - math.max(22 / 1.5, data.charge * 0.4 / 1.5)) * 2 * data.pulse
				local width4 = (44 / 3 - math.max(22 / 3, data.charge * 0.4 / 3)) * 2 * data.pulse
				
				gm.draw_set_colour(data.color)
				gm.draw_set_alpha(0.75)
				gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
				gm.draw_set_colour(Color.WHITE)
				gm.draw_set_alpha(0.9)
				gm.draw_rectangle(self.x - width2, 0, self.x + width2, self.y - 1, false)
				
				gm.draw_set_colour(data.color)
				gm.draw_set_alpha(0.75)
				gm.draw_rectangle(parent.x - width3, 0, parent.x + width3, parent.y - offset, false)
				gm.draw_set_colour(Color.WHITE)
				gm.draw_set_alpha(0.9)
				gm.draw_rectangle(parent.x - width4, 0, parent.x + width4, parent.y - offset, false)
				gm.draw_set_alpha(1)
			
				gm.draw_circle(parent.x, parent.y - offset, (44 - math.max(22, data.charge * 0.4)) * 2, false)
			else
				local width = 44 * (0.5 + 2 ^ -(data.charge / 10))
			
				gm.draw_set_colour(data.color)
				gm.draw_set_alpha(0.75)
				gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
				gm.draw_set_colour(Color.WHITE)
				gm.draw_set_alpha(0.9)
				gm.draw_rectangle(self.x - width / 2, 0, self.x + width / 2, self.y - 1, false)
				
				gm.draw_set_colour(data.color)
				gm.draw_set_alpha(0.75)
				gm.draw_rectangle(parent.x - width / 1.5, 0, parent.x + width / 1.5, parent.y - offset, false)
				gm.draw_set_colour(Color.WHITE)
				gm.draw_set_alpha(0.9)
				gm.draw_rectangle(parent.x - width / 3, 0, parent.x + width / 3, parent.y - offset, false)
				gm.draw_set_alpha(1)
				
				gm.draw_circle(parent.x, parent.y - offset, width, false)
			end
		end
	end
end)

objLaser:onSerialize(function(self, buffer)
	buffer:write_half(self.speed)
	buffer:write_instance(self:get_data().parent)
end)

objLaser:onDeserialize(function(self, buffer)
	self.speed = buffer:read_half()
	self:get_data().parent = buffer:read_instance()
end)

keeper.obj_sprite = sprite_idle
keeper.obj_depth = 11 -- depth of vanilla pEnemyClassic objects
keeper:clear_callbacks()

local keeperPrimary = Skill.new(NAMESPACE, "gatekeeperZ")
keeperPrimary.cooldown = 4 * 60
keeperPrimary.is_primary = true
keeperPrimary.is_utility = false
keeperPrimary.does_change_activity_state = true
keeperPrimary:clear_callbacks()

local keeperSecondary = Skill.new(NAMESPACE, "gatekeeperX")

keeper:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_idle
	actor.sprite_jump_peak = sprite_idle
	actor.sprite_fall = sprite_idle
	actor.sprite_death = sprite_death

	actor.can_jump = false
	actor.can_drop = false

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wGuardHit
	actor.sound_death = sound_death

	actor:enemy_stats_init(24, 800, math.huge, 67)
	actor.pHmax_base = 1.4
	actor.knockback_immune = true
	actor.stun_immune = true
	actor.z_range = 800
	actor.y_range = 400
	actor.x_range = 600
	actor:get_data().attack_mode = 1

	actor:set_default_skill(Skill.SLOT.primary, keeperPrimary)
	actor:set_default_skill(Skill.SLOT.secondary, keeperSecondary)

	actor:init_actor_late()
	actor:move_contact_solid(270, -1)
end)

keeper:onStep(function(actor)
	if actor:get_data().attack_mode == 2 then
		actor.moveLeft = 0
		actor.moveRight = 0
	end
end)

keeper:onDraw(function(actor) 
	local stdata = actor.actor_state_current_data_table
	local color = Color.from_hex(0x81CADC)
	
	if actor.elite_type and actor.elite_type ~= -1 then
		color = Elite.wrap(actor.elite_type).blend_col
	end
	
	if stdata.trx and stdata.try then
		if actor.sprite_index == sprite_shoot1b and stdata.fired < 1 then
			gm.draw_set_colour(color)
			gm.draw_set_alpha(0.64)
			local angle = gm.point_direction(actor.x - 35, actor.y + 9, stdata.trx, stdata.try)
			local xend = gm.lengthdir_x(5000, angle)
			local yend = gm.lengthdir_y(5000, angle)
			actor:collision_line_advanced(actor.x - 35, actor.y + 9, actor.x - 35 + xend, actor.y + 9 + yend, gm.constants.pBlock, true, true)
			local xx = gm.variable_global_get("collision_x")
			local yy = gm.variable_global_get("collision_y")
			gm.draw_line_width(actor.x - 35, actor.y + 9, xx, yy, 2)
			gm.draw_set_alpha(1)
		end
		
		if actor.sprite_index == sprite_shoot1b and stdata.fired < 2 then
			gm.draw_set_colour(color)
			gm.draw_set_alpha(0.64)
			angle = gm.point_direction(actor.x + 35, actor.y + 9, stdata.trx, stdata.try)
			xend = gm.lengthdir_x(5000, angle)
			yend = gm.lengthdir_y(5000, angle)
			actor:collision_line_advanced(actor.x + 35, actor.y + 9, actor.x - 35 + xend, actor.y + 9 + yend, gm.constants.pBlock, true, true)
			xx = gm.variable_global_get("collision_x")
			yy = gm.variable_global_get("collision_y")
			gm.draw_line_width(actor.x + 35, actor.y + 9, xx, yy, 2)
			gm.draw_set_alpha(1)
		end
	end
end)

local tracer_color = Color.from_hex(0x81CADC)
local tracer, tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)
	local t = GM.instance_create(x1, y1, gm.constants.oEfLaserLine)
	t.xend = x2
	t.yend = y2
	t.length = 60
	t.width = 6
	t.image_blend = tracer_color
	t.rate = 0.4
	t:alarm_set(0, math.max(1, dist / t.speed))
end)

local stateKeeperPrimaryA = State.new(NAMESPACE, "gatekeeperPrimaryA")
local stateKeeperPrimaryB = State.new(NAMESPACE, "gatekeeperPrimaryB")
stateKeeperPrimaryA:clear_callbacks()
stateKeeperPrimaryB:clear_callbacks()

local primarySync = Packet.new()
primarySync:onReceived(function(msg)
	local actor = msg:read_instance()
	local state = msg:read_byte()
	
	if not actor:exists() then return end
	
	if state == 1 then
		actor:enter_state(stateKeeperPrimaryA)
	elseif state == 2 then
		actor:enter_state(stateKeeperPrimaryB)
	else
		actor:refresh_skill(Skill.SLOT.primary)
	end
end)

local function sync_primary(actor, state)
	if not gm._mod_net_isHost() then
		log.warning("sync_primary called on client!")
		return
	end

	local msg = primarySync:message_begin()
	msg:write_instance(actor)
	msg:write_byte(state)
	msg:send_to_all()
end

keeperPrimary:onActivate(function(actor)
	if gm._mod_net_isHost() then
		local state = 3
		if actor:get_data().attack_mode == 1 then
			state = 1
		else
			local target = actor.target.parent
			local collisionlist = List.new()
			actor:collision_line_list(actor.x, actor.y + 9, target.x, target.y, gm.constants.pBlock, false, false, collisionlist, false)
			if #collisionlist == 0 then
				state = 2
			end
			collisionlist:destroy()
		end
		
		if state == 1 then
			actor:enter_state(stateKeeperPrimaryA)
		elseif state == 2 then
			actor:enter_state(stateKeeperPrimaryB)
		else
			actor:refresh_skill(Skill.SLOT.primary)
		end
		
		if gm._mod_net_isOnline() then
			sync_primary(actor, state)
		end
	end
end)

stateKeeperPrimaryA:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.trx = nil
	data.try = nil
	data.trmoving = 0
	actor:get_data().laser = nil
	actor:sound_play(sound_laser_fire, 1, 0.8 + math.random() * 0.2)
end)

stateKeeperPrimaryA:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1a, 0.16)
	
	local target = nil
	if actor.target and Instance.exists(actor.target) then
		if actor.target.parent and Instance.exists(actor.target.parent) then
			target = actor.target.parent
		end
	end
	
	if actor.image_index < 3 and data.fired == 0 then
		if target and target:exists() then
			if data.trx and data.try then
				local dif = data.trx - target.x
				if data.trx < target.x then
					data.trx = math.min(target.x, data.trx + math.abs(dif * 0.6))
				end
				if data.trx > target.x then
					data.trx = math.max(target.x, data.trx - math.abs(dif * 0.6))
				end
				
				dif = data.try - target.y
				if data.try < target.y then
					data.try = math.min(target.y, data.try + math.abs(dif * 0.6))
				end
				if data.try > target.y then
					data.try = math.max(target.y, data.try - math.abs(dif * 0.6))
				end
				
				data.trmoving = target.pHspeed
			else
				data.trx = target.x
				data.try = target.y
				data.trmoving = 0
			end
		end
	end
	
	if actor.image_index >= 3 and data.fired == 0 then
		
		if target and target:exists() then
			data.fired = 1
			if gm._mod_net_isHost() then
				actor:get_data().laser = objLaser:create(data.trx, data.try)
				actor:get_data().laser:get_data().parent = actor
				actor:get_data().laser.speed = data.trmoving
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

local targetSync = Packet.new()
targetSync:onReceived(function(msg)
	local target = msg:read_instance()
	local actor = msg:read_instance()
	
	if not Instance.exists(target) then return end
	
	actor.actor_state_current_data_table.targetvalue = target.value
end)

local function sync_target(target, actor)
	if not gm._mod_net_isHost() then
		log.warning("sync_target called on client!")
		return
	end

	local msg = targetSync:message_begin()
	msg:write_instance(target)
	msg:write_instance(actor)
	msg:send_to_all()
end

stateKeeperPrimaryB:onEnter(function(actor, data)
	actor.image_index = 0
	data.trx = nil
	data.try = nil
	data.fired = 0
	data.locked = 0
	
	if gm._mod_net_isHost() and gm._mod_net_isOnline() then
		sync_target(actor.target.parent, actor)
	end
	if actor.target and Instance.exists(actor.target) then
		if actor.target.parent and Instance.exists(actor.target.parent) then
			data.targetvalue = actor.target.parent.value
		end
	end
end)

stateKeeperPrimaryB:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1b, 0.16)
	
	if gm._mod_net_isHost() then
		if actor.target and Instance.exists(actor.target) then
			if actor.target.parent and Instance.exists(actor.target.parent) then
				if data.targetvalue ~= actor.target.parent.value then
					data.targetvalue = actor.target.parent.value
					if gm._mod_net_isOnline() then
						sync_target(actor.target.parent.value, actor)
					end
				end
			end
		end
	end
	
	local target = Instance.wrap(data.targetvalue)
	
	if actor.image_index >= 13 and data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_laser_fire2, 0.6, 0.9 + math.random() * 0.2)
		
		if data.trx and data.try then
			if gm._mod_net_isHost() then
				local xx = actor.x - 35 * actor.image_xscale
				local yy = actor.y + 9
				local angle = gm.point_direction(xx, yy, data.trx, data.try)
				local attack = actor:fire_bullet(xx, yy, 5000, angle, 1, 1, gm.constants.sSparks2, tracer,  true)
			end
		end
	elseif actor.image_index >= 15 and data.fired == 1 then
		data.fired = 2
		actor:sound_play(sound_laser_fire2, 0.6, 0.9 + math.random() * 0.2)
		
		if data.trx and data.try then
			if gm._mod_net_isHost() then
				local xx = actor.x + 35 * actor.image_xscale
				local yy = actor.y + 9
				local angle = gm.point_direction(xx, yy, data.trx, data.try)
				local attack = actor:fire_bullet(xx, yy, 5000, angle, 1, 1, gm.constants.sSparks2, tracer, true)
			end
		end
	end
	
	if data.locked == 0 and data.fired < 2 then
		if target and Instance.exists(target) then
			if data.trx and data.try then
				local dif = data.trx - target.x
				if data.trx < target.x then
					data.trx = math.min(target.x, data.trx + math.abs(dif * 0.18))
				end
				if data.trx > target.x then
					data.trx = math.max(target.x, data.trx - math.abs(dif * 0.18))
				end
				
				dif = data.try - target.y
				if data.try < target.y then
					data.try = math.min(target.y, data.try + math.abs(dif * 0.18))
				end
				if data.try > target.y then
					data.try = math.max(target.y, data.try - math.abs(dif * 0.18))
				end 
			else
				data.trx = target.x
				data.try = target.y
			end
		end
	end
	
	if data.locked == 0 and actor.image_index >= 10 then
		data.locked = 1
	end

	actor:skill_util_exit_state_on_anim_end()
end)

local keeperSecondary = Skill.new(NAMESPACE, "gatekeeperX")
keeperSecondary.cooldown = 7 * 60
keeperSecondary.is_primary = false
keeperSecondary.is_utility = false
keeperSecondary.does_change_activity_state = true
keeperSecondary:clear_callbacks()

local stateKeeperSecondaryA = State.new(NAMESPACE, "gatekeeperSecondaryA")
local stateKeeperSecondaryB = State.new(NAMESPACE, "gatekeeperSecondaryB")
stateKeeperSecondaryA:clear_callbacks()
stateKeeperSecondaryB:clear_callbacks()

local secondarySync = Packet.new()
secondarySync:onReceived(function(msg)
	local actor = msg:read_instance()
	local state = msg:read_byte()
	if not actor:exists() then return end
	
	if state == 1 then
		actor:enter_state(stateKeeperSecondaryA)
	elseif state == 2 then
		actor:enter_state(stateKeeperSecondaryB)
	else
		actor:refresh_skill(Skill.SLOT.secondary)
	end
end)

local function sync_secondary(actor, state)
	if not gm._mod_net_isHost() then
		log.warning("sync_secondary called on client!")
		return
	end

	local msg = secondarySync:message_begin()
	msg:write_instance(actor)
	msg:write_byte(state)
	msg:send_to_all()
end

keeperSecondary:onActivate(function(actor)
	if gm._mod_net_isHost() then
		local state = 3
		if actor:get_data().attack_mode == 1 then
			local target = actor.target.parent
			local collisionlist = List.new()
			actor:collision_line_list(actor.x, actor.y + 9, target.x, target.y, gm.constants.pBlock, false, false, collisionlist, false)
			if #collisionlist == 0 then
				state = 1
			end
			collisionlist:destroy()
		else
			state = 2
		end
		
		if state == 1 then
			actor:enter_state(stateKeeperSecondaryA)
		elseif state == 2 then
			actor:enter_state(stateKeeperSecondaryB)
		else
			actor:refresh_skill(Skill.SLOT.secondary)
		end
		if gm._mod_net_isOnline() then
			sync_secondary(actor, state)
		end
	end
end)

stateKeeperSecondaryA:onEnter(function(actor, data)
	actor.image_index = 0
	actor:refresh_skill(Skill.SLOT.primary)
	actor:buff_apply(fortified, 9999)
	actor:get_data().attack_mode = 2
	actor.sprite_idle = sprite_idle2
end)

stateKeeperSecondaryA:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2a, 0.15)
	actor:skill_util_exit_state_on_anim_end()
end)

stateKeeperSecondaryB:onEnter(function(actor, data)
	actor.image_index = 0
	actor:refresh_skill(Skill.SLOT.primary)
	actor:buff_remove(fortified)
	actor:get_data().attack_mode = 1
	actor.sprite_idle = sprite_idle
end)

stateKeeperSecondaryB:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2b, 0.15)
	actor:skill_util_exit_state_on_anim_end()
end)

local monsterCardGatekeeper = Monster_Card.new(NAMESPACE, "gatekeeper")
monsterCardGatekeeper.object_id = keeper_id
monsterCardGatekeeper.spawn_cost = 780
monsterCardGatekeeper.spawn_type = Monster_Card.SPAWN_TYPE.classic
monsterCardGatekeeper.can_be_blighted = true

if HOTLOADING then return end

local stages = {
	"ror-templeOfTheElders",
	"ror-riskOfRain",
}

local postLoopStages = {
	"ror-desolateForest",
	"ror-skyMeadow",
	"ror-sunkenTombs",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	--stage:add_monster(monsterCardGatekeeper)
end

for _, s in ipairs(postLoopStages) do
	local stage = Stage.find(s)
	--stage:add_monster_loop(monsterCardGatekeeper)
end