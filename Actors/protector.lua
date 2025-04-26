-- todo add comments later
local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Protector")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Gatekeeper")

local sprite_mask			= Resources.sprite_load(NAMESPACE, "ProtectorMask",			path.combine(SPRITE_PATH, "mask.png"), 1, 38, 59)
local sprite_laser_mask		= Resources.sprite_load(NAMESPACE, "ProtectorLaserMask",	path.combine(SPRITE_PATH, "laserMask.png"), 1, 6, 20)
local sprite_spawn			= Resources.sprite_load(NAMESPACE, "ProtectorSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 20, 74, 113)
local sprite_idle			= Resources.sprite_load(NAMESPACE, "ProtectorIdle",			path.combine(SPRITE_PATH, "idle.png"), 1, 58, 90)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "ProtectorIdle2",		path.combine(SPRITE_PATH, "idle2.png"), 1, 58, 90)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "ProtectorWalk",			path.combine(SPRITE_PATH, "walk.png"), 6, 64, 91)
local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "ProtectorShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 7, 58, 91)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "ProtectorShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 17, 58, 91)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "ProtectorShoot2a",		path.combine(SPRITE_PATH, "shoot2a.png"), 5, 58, 91)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "ProtectorShoot2b",		path.combine(SPRITE_PATH, "shoot2b.png"), 5, 58, 91)
local sprite_death			= Resources.sprite_load(NAMESPACE, "ProtectorDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 85, 113)
local sprite_laser_par		= Resources.sprite_load(NAMESPACE, "ProtectorLaserPar",		path.combine(SPRITE_PATH, "laserPar.png"), 6, 6, 6)

local sound_spawn			= Resources.sfx_load(NAMESPACE, "ProtectorSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_laser_hit		= Resources.sfx_load(NAMESPACE, "ProtectorLaserHit",		path.combine(SOUND_PATH, "laserHit.ogg"))
local sound_laser_fire		= Resources.sfx_load(NAMESPACE, "ProtectorLaserFire",		path.combine(SOUND_PATH, "laserFire.ogg"))
local sound_laser_fire2		= Resources.sfx_load(NAMESPACE, "ProtectorLaserFire2",		path.combine(SOUND_PATH, "laserFire2.ogg"))
local sound_laser_charge	= Resources.sfx_load(NAMESPACE, "ProtectorLaserCharge",		path.combine(SOUND_PATH, "laserCharge.ogg"))
local sound_death			= Resources.sfx_load(NAMESPACE, "ProtectorDeath",			path.combine(SOUND_PATH, "death.ogg"))

local protector = Object.new(NAMESPACE, "Protector", Object.PARENT.bossClassic)
local protector_id = protector.value
protector:clear_callbacks()

local laserPar = Particle.new(NAMESPACE, "ProtectorLaserPar")
laserPar:set_sprite(sprite_laser_par, true, true, false)
laserPar:set_alpha2(1, 0)
laserPar:set_life(60, 60)
laserPar:set_alpha1(0.9)
laserPar:set_speed(9, 11, -8 / 30, 0)

local fortified = Buff.new(NAMESPACE, "ProtectorFortified")
fortified.show_icon = false
fortified:clear_callbacks()

fortified:onStatRecalc(function(actor, stack)
	actor.armor = actor.armor + 100
	actor.pHmax = actor.pHmax - 100
end)

local objLaser = Object.new(NAMESPACE, "ProtectorLaser")
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
	self.small = 0
	self.timer = 30
	data.parent = -4
	data.charge = 0
	data.pulse = 1
	data.color = Color.from_hex(0xCC5951)
end)

objLaser:onStep(function(self)
	local data = self:get_data()
	local parent = Instance.wrap(data.parent)
	
	self:move_contact_solid(270, 200)
	
	while self:is_colliding(gm.constants.pBlock, self.x, self.y) do
		self.y = self.y - 1
	end
	
	if self.timer > 0 then
		self.timer = self.timer - 1
	else
		if data.charge < 110 then
			data.charge = data.charge + 1
		else
			self:destroy()
		end
		
		if data.charge % 6 == 0 then
			if parent:exists() then
				if self.small == 0 then
					local attack = parent:fire_explosion_local(self.x, self.y - 500, (44 - math.max(22, data.charge * 0.4)) * 4, 1000, 1 * data.charge * 0.005)
					attack.attack_info.y = self.y
				else
					local attack = parent:fire_explosion_local(self.x, self.y - 500, (44 - math.max(22, data.charge * 0.4)) * 2, 1000, 1 * data.charge * 0.005)
					attack.attack_info.y = self.y
				end
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
	
	if self.timer > 0 then
		local width = 44 - gm.round(self.timer * 1.46)
		
		if self.small == 1 then
			width = width / 2
		end
		
		gm.draw_set_colour(data.color)
		gm.draw_set_alpha((30 - self.timer) / 30 * 0.75)
		gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
		gm.draw_set_alpha(1)
	else
		if data.charge > 10 then
			local width = (44 - math.max(22, data.charge * 0.4)) * 2 * data.pulse
			local width2 = (44 / 2 - math.max(22 / 2, data.charge * 0.4 / 2)) * 2 * data.pulse
			
			if self.small == 1 then
				width = width / 2
			end
			if self.small == 1 then
				width2 = width2 / 2
			end
			
			gm.draw_set_colour(data.color)
			gm.draw_set_alpha(0.75)
			gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
			gm.draw_set_colour(Color.WHITE)
			gm.draw_set_alpha(0.9)
			gm.draw_rectangle(self.x - width2, 0, self.x + width2, self.y - 1, false)
			gm.draw_set_alpha(1)
		else
			local width = 44 * (0.5 + 2 ^ -(data.charge / 10))
			
			if self.small == 1 then
				width = width / 2
			end
			
			gm.draw_set_colour(data.color)
			gm.draw_set_alpha(0.75)
			gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
			gm.draw_set_colour(Color.WHITE)
			gm.draw_set_alpha(0.9)
			gm.draw_rectangle(self.x - width / 2, 0, self.x + width / 2, self.y - 1, false)
			gm.draw_set_alpha(1)
		end
	end
end)

objLaser:onSerialize(function(self, buffer)
	buffer:write_int(self.timer)
	buffer:write_byte(self.small)
	buffer:write_half(self.speed)
	buffer:write_instance(self:get_data().parent)
end)

objLaser:onDeserialize(function(self, buffer)
	self.timer = buffer:read_int()
	self.small = buffer:read_byte()
	self.speed = buffer:read_half()
	self:get_data().parent = buffer:read_instance()
end)

protector.obj_sprite = sprite_idle
protector.obj_depth = 11 -- depth of vanilla pEnemyClassic objects
protector:clear_callbacks()

local protectorPrimary = Skill.new(NAMESPACE, "protectorZ")
protectorPrimary.cooldown = 4 * 60
protectorPrimary.is_primary = true
protectorPrimary.is_utility = false
protectorPrimary.does_change_activity_state = true
protectorPrimary:clear_callbacks()

local protectorSecondary = Skill.new(NAMESPACE, "protectorX")

protector:onCreate(function(actor)
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

	actor:enemy_stats_init(34, 1400, math.huge, 116)
	actor.pHmax_base = 1.6
	actor.armor = 25
	actor.knockback_immune = true
	actor.stun_immune = true
	actor.z_range = 800
	actor.y_range = 800
	actor.x_range = 600
	actor:get_data().attack_mode = 1

	actor:set_default_skill(Skill.SLOT.primary, protectorPrimary)
	actor:set_default_skill(Skill.SLOT.secondary, protectorSecondary)
	
	local arr = Array.new({actor})
	local party = GM.actor_create_enemy_party_from_ids(arr)
	local director = GM._mod_game_getDirector()
	director:register_boss_party_gml_Object_oDirectorControl_Create_0(party)

	actor:init_actor_late()
	actor:move_contact_solid(270, -1)
end)

protector:onStep(function(actor)
	if actor:get_data().attack_mode == 2 then
		actor.moveLeft = 0
		actor.moveRight = 0
	end
end)

protector:onDraw(function(actor)
	local stdata = actor.actor_state_current_data_table
	
	if stdata.trx and stdata.try then
		if actor.sprite_index == sprite_shoot1b and stdata.fired < 1 then
			gm.draw_set_colour(Color.from_hex(0xCC5951))
			gm.draw_set_alpha(0.6)
			gm.draw_line_width(stdata.trx - 20, stdata.try, stdata.trx - 4, stdata.try, 4)
			gm.draw_line_width(stdata.trx + 4, stdata.try, stdata.trx + 20, stdata.try, 4)
			gm.draw_line_width(stdata.trx, stdata.try - 20, stdata.trx, stdata.try - 4, 4)
			gm.draw_line_width(stdata.trx, stdata.try + 4, stdata.trx, stdata.try + 20, 4)
			gm.draw_set_alpha(1)
		end
	end
end)

local stateProtectorPrimaryA = State.new(NAMESPACE, "protectorPrimaryA")
local stateProtectorPrimaryB = State.new(NAMESPACE, "protectorPrimaryB")
stateProtectorPrimaryA:clear_callbacks()
stateProtectorPrimaryB:clear_callbacks()

protectorPrimary:onActivate(function(actor)
	if actor:get_data().attack_mode == 1 then
		actor:enter_state(stateProtectorPrimaryA)
	else
		actor:enter_state(stateProtectorPrimaryB)
		actor:sound_play(gm.constants.wDrone1Spawn, 1, 0.9 + math.random() * 0.2)
	end
end)

stateProtectorPrimaryA:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.trx = nil
	data.try = nil
	data.trmoving = 0
	actor:get_data().laser = nil
	actor:get_data().laser2 = nil
	actor:get_data().laser3 = nil
	actor:sound_play(sound_laser_fire, 1, 0.8 + math.random() * 0.2)
end)

stateProtectorPrimaryA:onStep(function(actor, data)
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
				actor:get_data().laser = objLaser:create(data.trx - 300, data.try)
				actor:get_data().laser:get_data().parent = actor
				actor:get_data().laser.speed = data.trmoving
				actor:get_data().laser.timer = 50
				actor:get_data().laser2 = objLaser:create(data.trx, data.try)
				actor:get_data().laser2:get_data().parent = actor
				actor:get_data().laser2.speed = data.trmoving
				actor:get_data().laser2.small = 1
				actor:get_data().laser3 = objLaser:create(data.trx + 300, data.try)
				actor:get_data().laser3:get_data().parent = actor
				actor:get_data().laser3.speed = data.trmoving
				actor:get_data().laser3.timer = 50
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

stateProtectorPrimaryB:onEnter(function(actor, data)
	actor.image_index = 0
	data.trx = nil
	data.try = nil
	data.fired = 0
	
	if gm._mod_net_isHost() and gm._mod_net_isOnline() then
		sync_target(actor.target.parent, actor)
	end
	if actor.target and Instance.exists(actor.target) then
		if actor.target.parent and Instance.exists(actor.target.parent) then
			data.targetvalue = actor.target.parent.value
		end
	end
end)

stateProtectorPrimaryB:onStep(function(actor, data)
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
		
		if data.trx and data.try then
			actor:sound_play(sound_laser_fire2, 0.6, 0.9 + math.random() * 0.2)
			if gm._mod_net_isHost() then
				local xx = actor.x - 35 * actor.image_xscale
				local yy = actor.y + 9
				
				local missileType = Object.find("ror-EfMissileEnemy")
				if actor.team == 1 then
					missileType = Object.find("ror-EfMissile")
				end
				
				local missile = missileType:create(xx, yy)
				missile.parent = actor
				missile.target = target
				missile.targetx = data.trx
				missile.targety = data.try
				missile.team = actor.team
				missile.damage = actor.damage
				missile.firing = true
				
				local x2 = data.trx + target.pHspeed * gm.point_distance(actor.x, actor.y,data.trx, data.try) / 8
				local y2 = data.try + target.pVspeed * 5
				
				local missile = missileType:create(xx, yy)
				missile.parent = actor
				missile.target = target
				missile.targetx = x2
				missile.targety = y2
				missile.team = actor.team
				missile.damage = actor.damage
				missile.firing = true
			end
		end
	elseif actor.image_index >= 15 and data.fired == 1 then
		data.fired = 2
		
		if data.trx and data.try then
			actor:sound_play(sound_laser_fire2, 0.6, 0.9 + math.random() * 0.2)
			if gm._mod_net_isHost() then
				local xx = actor.x + 35 * actor.image_xscale
				local yy = actor.y + 9
				
				local missileType = Object.find("ror-EfMissileEnemy")
				if actor.team == 1 then
					missileType = Object.find("ror-EfMissile")
				end
				
				local missile = missileType:create(xx, yy)
				missile.parent = actor
				missile.target = target
				missile.targetx = data.trx
				missile.targety = data.try
				missile.team = actor.team
				missile.damage = actor.damage
				missile.firing = true
				
				local x2 = data.trx + target.pHspeed * gm.point_distance(actor.x, actor.y,data.trx, data.try) / 8
				local y2 = data.try + target.pVspeed * 5
				
				local missile = missileType:create(xx, yy)
				missile.parent = actor
				missile.target = target
				missile.targetx = x2
				missile.targety = y2
				missile.team = actor.team
				missile.damage = actor.damage
				missile.firing = true
			end
		end
	end
	
	if data.fired < 2 then
		if target and target:exists() then
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

	actor:skill_util_exit_state_on_anim_end()
end)

local protectorSecondary = Skill.new(NAMESPACE, "protectorX")
protectorSecondary.cooldown = 7 * 60
protectorSecondary.is_primary = false
protectorSecondary.is_utility = false
protectorSecondary.does_change_activity_state = true
protectorSecondary:clear_callbacks()

local stateProtectorSecondaryA = State.new(NAMESPACE, "protectorSecondaryA")
local stateProtectorSecondaryB = State.new(NAMESPACE, "protectorSecondaryB")
stateProtectorSecondaryA:clear_callbacks()
stateProtectorSecondaryB:clear_callbacks()

protectorSecondary:onActivate(function(actor)
	if actor:get_data().attack_mode == 1 then
		actor:enter_state(stateProtectorSecondaryA)
	else
		actor:enter_state(stateProtectorSecondaryB)
	end
end)

stateProtectorSecondaryA:onEnter(function(actor, data)
	actor.sprite_idle = sprite_idle2
	actor.image_index = 0
	actor:get_data().attack_mode = 2
	actor:refresh_skill(Skill.SLOT.primary)
	actor:buff_apply(fortified, 9999)
end)

stateProtectorSecondaryA:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2a, 0.15)
	actor:skill_util_exit_state_on_anim_end()
end)

stateProtectorSecondaryB:onEnter(function(actor, data)
	actor.sprite_idle = sprite_idle
	actor.image_index = 0
	actor:get_data().attack_mode = 1
	actor:refresh_skill(Skill.SLOT.primary)
	actor:buff_remove(fortified)
end)

stateProtectorSecondaryB:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2b, 0.15)
	actor:skill_util_exit_state_on_anim_end()
end)

local objArtifactSpawn = Object.new(NAMESPACE, "artifactSpawnBasin")

local objProtectorSpawn = Object.new(NAMESPACE, "protectorSpawnBasin")
objProtectorSpawn:clear_callbacks()

objProtectorSpawn:onStep(function(self)
	if gm._mod_net_isHost() then
		local spawn = true
		for _, button in ipairs(Instance.find_all(gm.constants.oArtifactButton)) do
			if button.activated == 0 then
				spawn = false
				break
			end
		end
		
		if spawn then
			local inst = Instance.find(objArtifactSpawn) 
			protector:create(inst.x, inst.y)
			self:destroy()
		end
	end
end)