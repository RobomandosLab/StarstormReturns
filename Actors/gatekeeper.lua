local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Gatekeeper")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Gatekeeper")

local sprite_mask			= Resources.sprite_load(NAMESPACE, "GatekeeperMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 32, 94)
local sprite_laser_mask		= Resources.sprite_load(NAMESPACE, "GatekeeperLaserMask",	path.combine(SPRITE_PATH, "laserMask.png"), 1, 6, 8)
local sprite_palette		= Resources.sprite_load(NAMESPACE, "GatekeeperPalette",		path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn			= Resources.sprite_load(NAMESPACE, "GatekeeperSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 22, 66, 141)
local sprite_idle			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle",		path.combine(SPRITE_PATH, "idle.png"), 1, 52, 125)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle2",		path.combine(SPRITE_PATH, "idle2.png"), 1, 52, 125)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "GatekeeperWalk",		path.combine(SPRITE_PATH, "walk.png"), 6, 58, 126)
local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 7, 54, 126)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 17, 54, 126)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2a",		path.combine(SPRITE_PATH, "shoot2a.png"), 5, 54, 126)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2b",		path.combine(SPRITE_PATH, "shoot2b.png"), 5, 54, 126)
local sprite_death			= Resources.sprite_load(NAMESPACE, "GatekeeperDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 79, 148)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "GatekeeperPortrait",	path.combine(SPRITE_PATH, "portrait.png"))
local sprite_tracer 		= Resources.sprite_load(NAMESPACE, "GatekeeperTracer",		path.combine(SPRITE_PATH, "tracer.png"))

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
	self.mask = sprite_laser_mask
	self.sprite_index = sprite_laser_mask
	self.image_yscale = 0 -- fuck it
	self:move_contact_solid(270, 200)
	self.direction = 0
	self.speed = 0
	data.parent = -4
	data.target = -4
	data.charge = 0
	data.timer = 30
	data.color = Color.from_hex(0x83CDCD)
end)

objLaser:onStep(function(self)
	local data = self:get_data()
	
	self:move_contact_solid(270, 200)
	
	if data.timer > 0 then
		data.timer = data.timer - 1
	else
		if data.charge < 110 then
			data.charge = data.charge + 1
		else
			self:destroy()
		end
		
		if data.colorCheck == nil and parent and parent:exists() then
			if self.parent.elite_type and self.parent.elite_type ~= -1 then
				data.color = Elite.wrap(self.parent.elite_type.blend_col)
			end
			data.colorCheck = true
		end
		
		if data.parent:exists() then
			if data.charge % 6 == 0 then
				local attack = data.parent:fire_explosion(self.x, self.y - 200, ((data.charge * 0.3) + 8), 400, 1 * data.charge * 0.005)
				attack.attack_info.gk_laser = true
				data.parent:fire_explosion(self.x, self.y, 0, 0, 0)
			end
		end
	end
end)

objLaser:onDraw(function(self)
	local data = self:get_data()
	
	if data.timer > 0 then
		local width = data.timer * 0.4
		
		gm.draw_set_colour(Color.WHITE)
		gm.draw_set_alpha(0.3 + data.timer * 0.01)
		gm.draw_rectangle(self.x - width / 2, 0, self.x + width / 2, self.y - 1, true)
	else
		local color = data.color
		local width = data.charge * 0.4
		local alpha = math.min((110 - data.charge) * 0.08, 1)
		
		gm.draw_set_colour(color)
		gm.draw_set_alpha(0.75 * alpha)
		gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
		gm.draw_set_colour(Color.WHITE)
		gm.draw_set_alpha(0.9 * alpha)
		gm.draw_rectangle(self.x - width / 2, 0, self.x + width / 2, self.y - 1, false)
	end
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
	actor.y_range = 256
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
	local color = Color.from_hex(0x83CDCD)
	
	if actor.elite_type and actor.elite_type ~= -1 then
		color = Elite.wrap(actor.elite_type.blend_col)
	end
	
	-- additive
	
	if stdata.trx and stdata.try then
		if actor.sprite_index == sprite_shoot1b then
			actor:collision_line_advanced(actor.x, actor.y - 38, stdata.trx, stdata.try, gm.constants.pBlock, true, true)
			local xx = gm.variable_global_get("collision_x")
			local yy = gm.variable_global_get("collision_y")
			gm.draw_set_colour(color)
			gm.draw_set_alpha(0.64)
			gm.draw_line_width(actor.x, actor.y - 38, xx, yy, 4)
			if stdata.trx == xx and stdata.try == yy then
				gm.draw_circle(stdata.trx, stdata.try, 6, true)
			end
			gm.draw_set_alpha(1)
		end
	end
end)

Callback.add(Callback.TYPE.onAttackHit, "GatekeeperLaserHit", function(hit_info)
	if hit_info.gk_laser then
		hit_info.target:sound_play(sound_laser_hit, 0.6, 0.9 + math.random() * 0.2)
		hit_info.target:screen_shake(2)
	end
end)

local parTracer = Particle.new(NAMESPACE, "GatekeeperTracer")
parTracer:set_sprite(sprite_tracer, false, true, false)
parTracer:set_life(30, 30)
parTracer:set_orientation(0, 0, 0, 0, true)
parTracer:set_alpha2(0.75, 0)
parTracer:set_blend(true)

local tracer_color = Color.from_hex(0x83CDCD)
local tracer, tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	-- particles
	parTracer:set_direction(dir, dir, 0, 0)

	local px = x1
	local py = y1
	local i = 0
	while i < dist do
		parTracer:create_colour(px, py, tracer_color, 1)
		px = px + gm.lengthdir_x(15, dir)
		py = py + gm.lengthdir_y(15, dir)
		i = i + 15
	end
end)

local stateKeeperPrimaryA = State.new(NAMESPACE, "gatekeeperPrimaryA")
local stateKeeperPrimaryB = State.new(NAMESPACE, "gatekeeperPrimaryB")
stateKeeperPrimaryA:clear_callbacks()
stateKeeperPrimaryB:clear_callbacks()

keeperPrimary:onActivate(function(actor)
	if actor:get_data().attack_mode == 1 then
		actor:enter_state(stateKeeperPrimaryA)
	else
		actor:enter_state(stateKeeperPrimaryB)
	end
end)

stateKeeperPrimaryA:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.trx = nil
	data.try = nil
	data.trmoving = 0
	actor:sound_play(sound_laser_fire, 1, 0.8 + math.random() * 0.2)
end)

stateKeeperPrimaryA:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1a, 0.16)
	
	local target = nil
	if actor.target.parent and actor.target.parent:exists() then
		target = actor.target.parent
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
			local laser = objLaser:create(data.trx, data.try)
			laser:get_data().parent = actor
			laser.speed = data.trmoving
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

stateKeeperPrimaryB:onEnter(function(actor, data)
	actor.image_index = 0
	data.trx = nil
	data.try = nil
	data.fired = 0
	data.tracer = 0
end)

stateKeeperPrimaryB:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1b, 0.16)
	
	local target = nil
	if actor.target.parent and actor.target.parent:exists() then
		target = actor.target.parent
	end
	
	if actor.image_index >= 13 and data.fired == 0 then
		data.fired = 1
		
		if data.trx and data.try then
			local xx = actor.x - 35 * actor.image_xscale
			local yy = actor.y - 29
			local angle = gm.point_direction(xx, yy, data.trx, data.try)
			local attack = actor:fire_bullet(xx, yy, 5000, angle, 1, 1, gm.constants.sSparks2, tracer,  true)
			actor:sound_play(sound_laser_fire2, 0.6, 0.9 + math.random() * 0.2)
		end
	elseif actor.image_index >= 15 and data.fired == 1 then
		data.fired = 2
		
		if data.trx and data.try then
			local xx = actor.x + 35 * actor.image_xscale
			local yy = actor.y - 29
			local angle = gm.point_direction(xx, yy, data.trx, data.try)
			local attack = actor:fire_bullet(xx, yy, 5000, angle, 1, 1, gm.constants.sSparks2, tracer, true)
			actor:sound_play(sound_laser_fire2, 0.6, 0.9 + math.random() * 0.2)
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

keeperSecondary:onActivate(function(actor)
	if actor:get_data().attack_mode == 1 then
		actor:enter_state(stateKeeperSecondaryA)
	else
		actor:enter_state(stateKeeperSecondaryB)
	end
end)

stateKeeperSecondaryA:onEnter(function(actor, data)
	actor.sprite_idle = sprite_idle2
	actor.image_index = 0
	actor:get_data().attack_mode = 2
	actor:refresh_skill(Skill.SLOT.primary)
	actor:buff_apply(fortified, 9999)
end)

stateKeeperSecondaryA:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2a, 0.15)
	actor:skill_util_exit_state_on_anim_end()
end)

stateKeeperSecondaryB:onEnter(function(actor, data)
	actor.sprite_idle = sprite_idle
	actor.image_index = 0
	actor:get_data().attack_mode = 1
	actor:refresh_skill(Skill.SLOT.primary)
	actor:buff_remove(fortified)
end)

stateKeeperSecondaryB:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2b, 0.15)
	actor:skill_util_exit_state_on_anim_end()
end)