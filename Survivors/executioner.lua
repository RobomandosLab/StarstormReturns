local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Executioner")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Executioner")

-- sprites.
local sprite_loadout		= Resources.sprite_load(NAMESPACE, "ExecutionerSelect", path.combine(SPRITE_PATH, "select.png"), 22, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "ExecutionerPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "ExecutionerPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "ExecutionerSkills", path.combine(SPRITE_PATH, "skills.png"), 11)
local sprite_credits		= Resources.sprite_load(NAMESPACE, "CreditsSurvivorExecutioner", path.combine(SPRITE_PATH, "credits.png"), 1, 6, 12)

local sprite_idle			= Resources.sprite_load(NAMESPACE, "ExecutionerIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 12, 17)
local sprite_idle_half		= Resources.sprite_load(NAMESPACE, "ExecutionerIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 12, 17)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "ExecutionerWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 14, 18)
local sprite_walk_half		= Resources.sprite_load(NAMESPACE, "ExecutionerWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 14, 18)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "ExecutionerWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 9, 16)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "ExecutionerJump", path.combine(SPRITE_PATH, "jump.png"), 1, 12, 15)
local sprite_jump_half		= Resources.sprite_load(NAMESPACE, "ExecutionerJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 12, 15)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "ExecutionerJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 12, 14)
local sprite_jump_peak_half	= Resources.sprite_load(NAMESPACE, "ExecutionerJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 12, 14)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "ExecutionerFall", path.combine(SPRITE_PATH, "fall.png"), 1, 12, 13)
local sprite_fall_half		= Resources.sprite_load(NAMESPACE, "ExecutionerFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 12, 13)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "ExecutionerClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 12, 18)
local sprite_death			= Resources.sprite_load(NAMESPACE, "ExecutionerDeath", path.combine(SPRITE_PATH, "death.png"), 11, 38, 17)
local sprite_decoy			= Resources.sprite_load(NAMESPACE, "ExecutionerDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 16, 18)
local sprite_palette		= Resources.sprite_load(NAMESPACE, "ExecutionerPalette", path.combine(SPRITE_PATH, "palette.png"))
local sprite_palette_select	= Resources.sprite_load(NAMESPACE, "ExecutionerPaletteSelect", path.combine(SPRITE_PATH, "paletteSelect.png"))

local sprite_shoot1			= Resources.sprite_load(NAMESPACE, "ExecutionerShoot1", path.combine(SPRITE_PATH, "shoot1.png"), 5, 10, 17)
local sprite_shoot1_half	= Resources.sprite_load(NAMESPACE, "ExecutionerShoot1Half", path.combine(SPRITE_PATH, "shoot1Half.png"), 5, 10, 17)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "ExecutionerShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 6, 12, 25)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "ExecutionerShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 6, 12, 25)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "ExecutionerShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 10, 68, 82)

local sprite_shoot4PreGround= Resources.sprite_load(NAMESPACE, "ExecutionerShoot4PreGround", path.combine(SPRITE_PATH, "shoot4PreGround.png"), 5, 39, 63)
local sprite_shoot4PreAir	= Resources.sprite_load(NAMESPACE, "ExecutionerShoot4PreAir", path.combine(SPRITE_PATH, "shoot4PreAir.png"), 5, 39, 63)
local sprite_shoot4PreSlide	= Resources.sprite_load(NAMESPACE, "ExecutionerShoot4PreSlide", path.combine(SPRITE_PATH, "shoot4PreSlide.png"), 5, 39, 63)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "ExecutionerShoot4",	path.combine(SPRITE_PATH, "shoot4.png"), 18, 70, 82)

local sprite_shoot5PreGround= Resources.sprite_load(NAMESPACE, "ExecutionerShoot5PreGround", path.combine(SPRITE_PATH, "shoot5PreGround.png"), 5, 39, 63)
local sprite_shoot5PreAir	= Resources.sprite_load(NAMESPACE, "ExecutionerShoot5PreAir", path.combine(SPRITE_PATH, "shoot5PreAir.png"), 5, 39, 63)
local sprite_shoot5PreSlide	= Resources.sprite_load(NAMESPACE, "ExecutionerShoot5PreSlide", path.combine(SPRITE_PATH, "shoot5PreSlide.png"), 5, 39, 63)
local sprite_shoot5			= Resources.sprite_load(NAMESPACE, "ExecutionerShoot5", path.combine(SPRITE_PATH, "shoot5.png"), 18, 70, 82)

local sprite_shoot4b		= Resources.sprite_load(NAMESPACE, "ExecutionerShoot4B", path.combine(SPRITE_PATH, "shoot4b.png"), 9, 36, 33)
local sprite_shoot5b		= Resources.sprite_load(NAMESPACE, "ExecutionerShoot5B", path.combine(SPRITE_PATH, "shoot5b.png"), 9, 36, 33)
local sprite_axe_projectile	= Resources.sprite_load(NAMESPACE, "ExecutionerAxeProjectile", path.combine(SPRITE_PATH, "axeProjectile.png"), 4, 56, 51)
local sprite_axe_projectileS= Resources.sprite_load(NAMESPACE, "ExecutionerAxeProjectileS", path.combine(SPRITE_PATH, "axeProjectileS.png"), 4, 56, 51)

local sprite_drone_idle		= Resources.sprite_load(NAMESPACE, "DronePlayerExecutionerIdle", path.combine(SPRITE_PATH, "droneIdle.png"), 5, 11, 14)
local sprite_drone_shoot	= Resources.sprite_load(NAMESPACE, "DronePlayerExecutionerShoot", path.combine(SPRITE_PATH, "droneShoot.png"), 5, 33, 13)

local sprite_ion_sparks		= Resources.sprite_load(NAMESPACE, "ExecutionerIonSparks", path.combine(SPRITE_PATH, "ionSparks.png"), 4, 24, 14)
local sprite_ion_sparks2	= Resources.sprite_load(NAMESPACE, "ExecutionerIonSparks2s", path.combine(SPRITE_PATH, "ionSparks2.png"), 4, 21, 21)
local sprite_ion_tracer		= Resources.sprite_load(NAMESPACE, "ExecutionerIonTracer", path.combine(SPRITE_PATH, "ionTracer.png"), 5, 0, 2)
local sprite_ion_particle	= Resources.sprite_load(NAMESPACE, "ExecutionerIonParticle", path.combine(SPRITE_PATH, "ionParticle.png"), 5, 8, 8)
local sprite_ion_particleS	= Resources.sprite_load(NAMESPACE, "ExecutionerIonParticleS", path.combine(SPRITE_PATH, "ionParticleS.png"), 5, 8, 8)

local sprite_log			= Resources.sprite_load(NAMESPACE, "ExecutionerLog", path.combine(SPRITE_PATH, "log.png"))

-- sounds.
local sound_shoot1			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4_1		= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4_1", path.combine(SOUND_PATH, "skill4_1.ogg"))
local sound_shoot4_2		= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4_2", path.combine(SOUND_PATH, "skill4_2.ogg"))
local sound_shoot4_3		= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4_3", path.combine(SOUND_PATH, "skill4_3.ogg"))
local sound_shoot4b_1		= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4B_1", path.combine(SOUND_PATH, "skill4b_1.ogg"))
local sound_shoot4b_2		= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4B_2", path.combine(SOUND_PATH, "skill4b_2.ogg"))

-- particles.
-- used for ion burst tracer
local particleWispGTracer = Particle.find("ror", "WispGTracer")

-- used for crowd dispersion and execution
local ionParticle = Particle.new(NAMESPACE, "ion")
ionParticle:set_sprite(sprite_ion_particle, true, true, false)
ionParticle:set_life(15, 60)
ionParticle:set_orientation(0, 360, 0, 0, false)
ionParticle:set_speed(0.2, 0.5, -0.02, 0)
ionParticle:set_size(0.6, 1, 0, 0.01)
ionParticle:set_direction(0, 360, 0, 0)

-- used for scepter-boosted execution
local ionParticleS = Particle.new(NAMESPACE, "ionS")
ionParticleS:set_sprite(sprite_ion_particleS, true, true, false)
ionParticleS:set_life(15, 60)
ionParticleS:set_orientation(0, 360, 0, 0, false)
ionParticleS:set_speed(0.2, 0.5, -0.02, 0)
ionParticleS:set_size(0.6, 1, 0, 0.01)
ionParticleS:set_direction(0, 360, 0, 0)

local buffFear = Buff.find("ror", "fear")
local buffShadowClone = Buff.find("ror", "shadowClone")

-- Okay, let's start Executing, some Monsters ..
local executioner = Survivor.new(NAMESPACE, "executioner")
local executioner_id = executioner.value

executioner:set_stats_base({
	maxhp = 95,
	damage = 14,
	regen = 0.008,
})
executioner:set_stats_level({
	maxhp = 24,
	damage = 3,
	regen = 0.0012,
	armor = 2,
})

executioner:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump_peak,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy,
	drone_idle = sprite_drone_idle,
	drone_shoot = sprite_drone_shoot,
})

executioner:set_palettes(sprite_palette, sprite_pallete_select, sprite_pallete_select)

local sprite_loadout_PAL1			= Resources.sprite_load(NAMESPACE, "ExecutionerSelect_PAL1", path.combine(SPRITE_PATH, "select_PAL1.png"), 22, 28, 0)
local sprite_portrait_PAL1			= Resources.sprite_load(NAMESPACE, "ExecutionerPortrait_PAL1", path.combine(SPRITE_PATH, "portrait_PAL1.png"), 3)
local sprite_portrait_small_PAL1	= Resources.sprite_load(NAMESPACE, "ExecutionerPortraitSmall_PAL1", path.combine(SPRITE_PATH, "portraitSmall_PAL1.png"))
executioner:add_skin("executionerGreen", 1, sprite_loadout_PAL1, sprite_portrait_PAL1, sprite_portrait_small_PAL1)

executioner:add_skin("executionerRed", 2, sprite_loadout, sprite_portrait, sprite_portrait_small)
executioner:add_skin("executionerPurple", 3, sprite_loadout, sprite_portrait, sprite_portrait_small)

executioner:set_cape_offset(0, -8, 0, -5)
executioner:set_primary_color(Color.from_rgb(175, 113, 126))

executioner.sprite_loadout = sprite_loadout
executioner.sprite_portrait = sprite_portrait
executioner.sprite_portrait_small = sprite_portrait_small
executioner.sprite_idle = sprite_idle -- used by skin systen for idle sprite
executioner.sprite_title = sprite_walk -- also used by skin system for walk sprite
executioner.sprite_credits = sprite_credits

executioner:clear_callbacks()
executioner:onInit(function(actor)
	-- setup half-sprite nonsense
	actor.sprite_idle_half		= Array.new({sprite_idle,		sprite_idle_half, 0})
	actor.sprite_walk_half		= Array.new({sprite_walk,		sprite_walk_half, 0, sprite_walk_back})
	actor.sprite_jump_half		= Array.new({sprite_jump,		sprite_jump_half, 0})
	actor.sprite_jump_peak_half	= Array.new({sprite_jump_peak,	sprite_jump_peak_half, 0})
	actor.sprite_fall_half		= Array.new({sprite_fall,		sprite_fall_half, 0})

	actor:survivor_util_init_half_sprites()
end)

local executionerPrimary = executioner:get_primary()
local executionerSecondary = executioner:get_secondary()
local executionerUtility = executioner:get_utility()
local executionerSpecial = executioner:get_special()

-- Service Pistol
executionerPrimary:set_skill_icon(sprite_skills, 0)
executionerPrimary.cooldown = 5
executionerPrimary.damage = 1.0
executionerPrimary.require_key_press = false
executionerPrimary.hold_facing_direction = true
executionerPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateExecutionerPrimary = State.new(NAMESPACE, "executionerPrimary")

executionerPrimary:clear_callbacks()
executionerPrimary:onActivate(function(actor)
	actor:enter_state(stateExecutionerPrimary)
end)

stateExecutionerPrimary:clear_callbacks()
stateExecutionerPrimary:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.fired = 0 -- gamemaker bools are a pain to deal with in lua, so just use numbers instead

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

stateExecutionerPrimary:onStep(function(actor, data)
	actor.sprite_index2 = sprite_shoot1_half

	-- first arg: speed for attack animation, in sprite frames per game frame
	-- second arg: multiplier for movement speed while strafing
	actor:skill_util_strafe_update(0.22 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	-- adjust vertical offset so the upper body bobs up and down depending on the leg animation
	if actor.sprite_index == actor.sprite_walk_half[2] then
		local walk_offset = 0
		local leg_frame = math.floor(actor.image_index)
		if leg_frame == 1 or leg_frame == 5 then
			walk_offset = 1
		elseif leg_frame == 3 or leg_frame == 7 then
			walk_offset = -1
		end
		actor.ydisp = walk_offset -- ydisp controls upper body offset
	end

	if data.fired == 0 then
		data.fired = 1

		actor:sound_play(sound_shoot1, 1, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(executionerPrimary)
			local dir = actor:skill_util_facing_direction()

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				for i=0, actor:buff_stack_count(buffShadowClone) do
					local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks1, Attack_Info.TRACER.commando1)
					attack.climb = i * 8 * 1.35
				end
			end
		end
	end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)
stateExecutionerPrimary:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)
stateExecutionerPrimary:onGetInterruptPriority(function(actor, data)
	-- enables extremely high attack rates -- allow interrupting if the next frame is calculated to reach the end of the anim
	-- FIXME: breaks strafe turn queuing
	if actor.image_index2 + 0.33 * actor.attack_speed >= gm.sprite_get_number(actor.sprite_index2)+1 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	end
	if actor.image_index2 > 2 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	else
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill
	end
end)

-- Ion Burst
executionerSecondary:set_skill_icon(sprite_skills, 2)
executionerSecondary.cooldown = -1
executionerSecondary.damage = 3.2
executionerSecondary.max_stock = 10
executionerSecondary.auto_restock = false
executionerSecondary.start_with_stock = false
executionerSecondary.use_delay = 30
executionerSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local ION_TRACER_COLOR = Color.from_rgb(110, 129, 195)

local ion_tracer, ion_tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	if x1 < x2 then x1 = x1 + 16 else x1 = x1 - 16 end

	y1 = y1 - 5
	y2 = y2 - 5

	-- line tracer
	local tracer = gm.instance_create(x1, y1, gm.constants.oEfLineTracer)

	tracer.xend = x2
	tracer.yend = y2
	tracer.sprite_index = sprite_ion_tracer
	tracer.image_speed = 1
	tracer.rate = 0.1
	tracer.blend_1 = Color.from_rgb(255, 255, 255)
	tracer.blend_2 = ION_TRACER_COLOR
	tracer.blend_rate = 0.2
	tracer.image_alpha = 1.5
	tracer.bm = 1
	tracer.width = 3

	-- particles
	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	particleWispGTracer:set_direction(dir, dir, 0, 0)

	local px = x1
	local i = 0
	while i < dist do
		particleWispGTracer:create_colour(px, y1 + gm.random_range(-8, 8), ION_TRACER_COLOR, 1)
		px = px + gm.lengthdir_x(20, dir)
		i = i + 20
	end
end)
ion_tracer_info.sparks_offset_y = -5

local stateExecutionerSecondary = State.new(NAMESPACE, "executionerSecondary")

executionerSecondary:clear_callbacks()
executionerSecondary:onActivate(function(actor, skill)
	actor:enter_state(stateExecutionerSecondary)
end)
executionerSecondary:onStep(function(actor, skill)
	-- update ion burst's skill icon depending on how many rounds it has
	local ion_rounds = skill.stock
	local frame = 1

	if ion_rounds == 0 then
		frame = 1
	elseif ion_rounds < 4 then
		frame = 2
	elseif ion_rounds < 7 then
		frame = 3
	elseif ion_rounds < 10 then
		frame = 4
	else
		frame = 5
	end

	skill.subimage = frame
end)
stateExecutionerSecondary:clear_callbacks()
stateExecutionerSecondary:onEnter(function(actor, data)
	actor.image_index = 0
	data.ion_rounds = actor:get_active_skill(Skill.SLOT.secondary).stock + 1 -- compensate for first stock being decremented already
	data.should_fire = 1
	data.is_first_shot = 1
	data.sprite = sprite_shoot2a
end)
stateExecutionerSecondary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(data.sprite, 0.33)

	if data.ion_rounds > 0 and actor.image_index >= 2 then
		actor.image_index = 0
		data.should_fire = 1

		if data.sprite == sprite_shoot2a then
			data.sprite = sprite_shoot2b
		else
			data.sprite = sprite_shoot2a
		end
	end
	if data.should_fire == 1 then
		data.ion_rounds = data.ion_rounds - 1
		data.should_fire = 0

		actor:sound_play(sound_shoot2, 1.0, 0.9 + (data.ion_rounds * 0.02) + math.random() * 0.2)
		actor:screen_shake(2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(executionerSecondary)
			local dir = actor:skill_util_facing_direction()

			for i=0, actor:buff_stack_count(buffShadowClone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, sprite_ion_sparks, ion_tracer).attack_info
				attack_info:set_stun(1.0)
				attack_info.climb = i * 8 * 1.35
			end
		end

		if data.is_first_shot == 0 then
			local skill = actor:get_active_skill(Skill.SLOT.secondary)
			skill.stock = skill.stock - 1
		else
			data.is_first_shot = 0
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)
stateExecutionerSecondary:onGetInterruptPriority(function(actor, data)
	if actor.image_index > 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	else
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill
	end
end)

local objIonOrb = Object.new(NAMESPACE, "ExecutionerOrb")
objIonOrb.obj_depth = -280

objIonOrb:clear_callbacks()
objIonOrb:onCreate(function(self)
	self.target = -4
	self.counter = 30
	self.vspeed = -6 + math.random() * 3

	self.charges = 1

	self:instance_sync()
end)
objIonOrb:onStep(function(self)
	if not Instance.exists(self.target) then
		self:destroy()
		return
	end
	if self.counter > 0 then
		self.speed = math.max(0, self.speed - 0.2)
		self.counter = self.counter - 1
	else
		local target = self.target

		self.direction = gm.point_direction(self.x, self.y, target.x, target.y)
		self.speed = math.min(12, self.speed + 0.4)

		if self:distance_to_object(target) < 8 then
			if gm._mod_net_isHost() then
				for i=1, self.charges do
					GM.actor_skill_add_stock_networked(target, Skill.SLOT.secondary)
				end
			end

			local flash = GM.instance_create(0, 0, gm.constants.oEfFlash)
			flash.parent = target
			flash.rate = 0.08

			self:destroy()
		end
	end
end)
objIonOrb:onDraw(function(self)
	local radius = 6 + self.charges * 4
	radius = radius + math.sin(Global._current_frame * 0.2) * 0.5

	gm.gpu_set_blendmode(1)
	gm.draw_set_colour(ION_TRACER_COLOR)
	gm.draw_set_alpha(0.6)
	gm.draw_circle(self.x, self.y, radius, false)
	--gm.draw_circle(self.x, self.y, radius-2, true)
	gm.draw_set_alpha(1)
	gm.draw_set_colour(Color.WHITE)
	for i=1, self.charges do
		gm.draw_circle(self.x, self.y, radius + 3 - (i * 3), true)
	end
	gm.draw_circle(self.x, self.y, radius * 0.33, false)
	gm.gpu_set_blendmode(0)
end)
objIonOrb:onSerialize(function(self, buffer)
	buffer:write_instance(self.target)
	buffer:write_float(self.vspeed)
	buffer:write_byte(self.charges)
end)
objIonOrb:onDeserialize(function(self, buffer)
	self.target = buffer:read_instance()
	self.vspeed = buffer:read_float()
	self.charges = buffer:read_byte()
end)

Callback.add(Callback.TYPE.onKillProc, "SSIonCharge", function(victim, killer)
	if killer.object_index == gm.constants.oP and killer.class == executioner_id then
		local charges = 1
		if GM.actor_is_elite(victim) then
			charges = charges * 2
		end
		if GM.actor_is_boss(victim) then
			charges = charges * 5
		end
		local orb = objIonOrb:create(victim.x, victim.y)
		orb.target = killer
		orb.charges = charges
	end
end)

-- Crowd Dispersion
executionerUtility:set_skill_icon(sprite_skills, 6)
executionerUtility.cooldown = 7 * 60
executionerUtility.is_utility = true
executionerUtility.override_strafe_direction = true
executionerUtility.ignore_aim_direction = true

local stateExecutionerUtility = State.new(NAMESPACE, "executionerUtility")
stateExecutionerUtility.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

executionerUtility:clear_callbacks()
executionerUtility:onActivate(function(actor)
	actor:enter_state(stateExecutionerUtility)
end)
stateExecutionerUtility:clear_callbacks()
stateExecutionerUtility:onEnter(function(actor, data)
	actor.image_index = 0
	data.feared = 0
end)
stateExecutionerUtility:onStep(function(actor, data)
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.25

	actor.pHspeed = actor.pHmax * 2.2 * actor.image_xscale
	actor:set_immune(8)

	if math.random() < 0.5 then
		ionParticle:create(actor.x - 20 + math.random() * 40, actor.y - 10 + math.random() * 20, 1, Particle.SYSTEM.below)
	end

	if data.feared == 0 then
		data.feared = 1
		actor:sound_play(sound_shoot3, 1.0, 1.0)
	end

	local fear = Buff.find("ror", "fear")
	local victims = List.new()
	actor:collision_rectangle_list(actor.x - 100, actor.y - 48, actor.x + 100, actor.y + 48, gm.constants.pActor, false, true, victims, false)

	for _, victim in ipairs(victims) do
		if victim.team ~= actor.team then
			-- buff application is host-only.
			if victim:buff_stack_count(fear) == 0 then
				victim:buff_apply(fear, 2 * 60)
			else
				-- when buffs are re-applied, their duration is extended, which gets networked
				-- avoid clobbering the network with this special bit of code.
				GM.set_buff_time_nosync(victim, fear, 2 * 60)
			end
		end
	end

	victims:destroy()

	actor:skill_util_exit_state_on_anim_end()
end)

-- Execution
executionerSpecial:set_skill_icon(sprite_skills, 7)
executionerSpecial.cooldown = 8 * 60
executionerSpecial.damage = 10
executionerSpecial.require_key_press = true
executionerSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- Crowd Execution
local executionerSpecialScepter = Skill.new(NAMESPACE, "executionerVBoosted")
executionerSpecial:set_skill_upgrade(executionerSpecialScepter)

executionerSpecialScepter:set_skill_icon(sprite_skills, 8)
executionerSpecialScepter.cooldown = 8 * 60
executionerSpecialScepter.damage = 15
executionerSpecialScepter.require_key_press = true
executionerSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateExecutionerSpecialPre = State.new(NAMESPACE, "executionerSpecialPre")
local stateExecutionerSpecial = State.new(NAMESPACE, "executionerSpecial")

executionerSpecial:clear_callbacks()
executionerSpecial:onActivate(function(actor)
	actor:enter_state(stateExecutionerSpecialPre)
end)
executionerSpecialScepter:clear_callbacks()
executionerSpecialScepter:onActivate(function(actor)
	actor:enter_state(stateExecutionerSpecialPre)
end)

stateExecutionerSpecialPre:clear_callbacks()
stateExecutionerSpecialPre:onEnter(function(actor, data)
	actor.image_index = 0
	data.previous_frame = 0
	data.fired = 0

	data.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
end)
stateExecutionerSpecialPre:onStep(function(actor, data)
	local drifting = math.abs(actor.pHspeed) > actor.pHmax
	local true_speed = math.max(1, 2 - (1 / actor.attack_speed) ) -- see stateExecutionerSpecial:onStep for why this is

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot4_1, 1.0, true_speed)
	end

	if not drifting then
		actor:skill_util_fix_hspeed()
	end

	local animation = {
		ground = sprite_shoot4PreGround,
		air = sprite_shoot4PreAir,
		slide = sprite_shoot4PreSlide,
	}

	if data.scepter > 0 then
		animation.ground = sprite_shoot5PreGround
		animation.air = sprite_shoot5PreAir
		animation.slide = sprite_shoot5PreSlide
	end

	local sprite = animation.ground

	-- when `free` is true, we are in the air
	if gm.bool(actor.free) then
		sprite = animation.air
	else
		if drifting then
			sprite = animation.slide
		else
			sprite = animation.ground
		end
	end

	actor:actor_animation_set(sprite, 0.25 * true_speed, false)
	actor:set_immune(8)

	if actor.image_index + 0.25 * true_speed >= actor.image_number then
		actor:enter_state(stateExecutionerSpecial)
	end
end)

stateExecutionerSpecial:clear_callbacks()
stateExecutionerSpecial:onEnter(function(actor, data)
	data.substate = 0
	data.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
	data.aoe_height = 0
	data.recovery_attempts = 0
	actor.activity_free = 1
end)
stateExecutionerSpecial:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()

	local animation = sprite_shoot4
	local particle = ionParticle
	if data.scepter > 0 then
		animation = sprite_shoot5
		particle = ionParticleS
	end

	-- make the atk speed non-linear and never go beyond 200% speed
	-- makes it so the player can still do momemtum tech while having alot of atk speed
	local true_speed = math.max(1, 2 - (1 / actor.attack_speed) )

	actor:actor_animation_set(animation, 0.25 * true_speed, false)

	if data.substate == 0 then
		actor.image_index = 0
		actor.activity_type = 2 -- changes physics for the state. gravity is disabled and vertical velocity is uncapped.
		actor.pVspeed = (actor.pVmax * -2) * true_speed
		data.substate = 1
		actor:sound_play(sound_shoot4_2, 1.0, true_speed)
	elseif data.substate == 1 then -- decelerating, hanging in the air
		local deceleration = 0.5 * true_speed * true_speed -- squaring attack speed seems to prevent height gain from attack speed, i dont know math lmao
		actor.pVspeed = math.min(actor.pVspeed + deceleration, 0)

		if math.random() < 0.25 then
			particle:create(actor.x - 16 + math.random() * 32, actor.y - math.random() * 32, 1, Particle.SYSTEM.below)
		end

		if actor.image_index >= 5 then
			data.substate = 2
			actor.pVspeed = (actor.pVmax * -1.5) * true_speed
		end
	elseif data.substate == 2 then -- winding up
		if actor.image_index >= 7 then
			actor.pVspeed = 30 * true_speed
			data.substate = 3
			data.aoe_height = 0
		end
	elseif data.substate == 3 then -- coming down
		data.aoe_height = data.aoe_height + actor.pVspeed
		if actor.image_index >= 11 then
			actor.image_index = actor.image_index - 4
		end

		particle:create(actor.x - 16 + math.random() * 32, actor.y + math.random() * 32, 1, Particle.SYSTEM.below)

		if actor.pVspeed < 0 then -- something launched us up, handle this interruption
			data.recovery_attempts = data.recovery_attempts + 1
			if data.recovery_attempts <= 3 then
				actor.image_index = 0
				data.substate = 1 -- go back and try again
				actor:sound_play(sound_shoot4_2, 1.0, 1.0)
			else
				actor:skill_util_reset_activity_state() -- too many interruptions -- give up so we're not perma immune lmao
			end
		else
			actor.pVspeed = 30 * true_speed -- water slows exe down and without gravity he's left stuck, so always force to max speed'

			if not gm.bool(actor.free) then
				data.substate = 4
				actor.image_index = 11
				actor.activity_type = 1 -- return to standard state physics

				actor:sound_play(sound_shoot4_3, 1.0, 1.0)
				actor:screen_shake(15)

				if data.scepter > 0 then
					actor:sound_play(gm.constants.wChainLightning2, 1.0, 0.8)
					actor:sound_play(gm.constants.wLightning, 1.0, 1.0)
				end

				for i=1, 9 do
					particle:create(actor.x - 80 + math.random() * 160, actor.y - 60 + math.random() * 80, 1, Particle.SYSTEM.below)
				end

				-- usually attacks use is_authority, but in this case we have to always run it host-side
				-- this is because onAttackHandleEnd only runs on the host, in which we check for the execution variable
				if not GM._mod_net_isClient() then
					local ax = actor.x + 32 * actor.image_xscale
					local ay = actor.y + 24 - data.aoe_height * 0.5

					local damage = actor:skill_get_damage(executionerSpecial)
					if data.scepter > 0 then
						damage = actor:skill_get_damage(executionerSpecialScepter)
					end

					for i=0, actor:buff_stack_count(buffShadowClone) do
						local attack_info = actor:fire_explosion(ax, ay, 160, 32 + data.aoe_height, damage, nil, sprite_ion_sparks2).attack_info
						attack_info.climb = i * 8 * 1.35
						attack_info.y = actor.y
						attack_info.execution = 1
					end

					if data.scepter > 0 then
						local victims = List.new()
						actor:collision_rectangle_list(ax - 120, actor.y - 30, ax + 120, actor.y + 30, gm.constants.pActor, false, true, victims, false)

						for _, victim in ipairs(victims) do
							if victim.team ~= actor.team then
								victim:buff_apply(buffFear, 2 * 60)
							end
						end

						victims:destroy()
					end
				end
			end
		end
	end

	if data.substate < 4 then
		actor:set_immune(8)
	end
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(Callback.TYPE.onAttackHandleEnd, "SSExecutionCDR", function(attack_info)
	if attack_info.execution == 1 then
		local kill_count = attack_info.kill_number
		GM.actor_skill_reset_cooldowns(attack_info.parent, -60 * kill_count, true, false, true)
	end
end)

local executionerSpecial2 = Skill.new(NAMESPACE, "executionerV2")
executionerSpecial2:set_skill_icon(sprite_skills, 9)
executionerSpecial2.cooldown = 8 * 60
executionerSpecial2.damage = 2.5
executionerSpecial2.override_strafe_direction = true
executionerSpecial2.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

executioner:add_special(executionerSpecial2)

local executionerSpecial2Scepter = Skill.new(NAMESPACE, "executionerV2Boosted")
executionerSpecial2Scepter:set_skill_icon(sprite_skills, 10)
executionerSpecial2Scepter.cooldown = 8 * 60
executionerSpecial2Scepter.damage = 2.5
executionerSpecial2Scepter.override_strafe_direction = true
executionerSpecial2Scepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

executionerSpecial2:set_skill_upgrade(executionerSpecial2Scepter)

local stateExecutionerSpecial2 = State.new(NAMESPACE, "executionerSpecial2")

local objExecutionerAxe = Object.new(NAMESPACE, "ExecutionerAxe")
objExecutionerAxe.obj_sprite = sprite_axe_projectile
objExecutionerAxe.obj_depth = -500

local objEfAxeAfterImage = Object.new(NAMESPACE, "EfAxeAfterImage")

executionerSpecial2:clear_callbacks()
executionerSpecial2:onActivate(function(actor)
	actor:enter_state(stateExecutionerSpecial2)
end)
executionerSpecial2Scepter:clear_callbacks()
executionerSpecial2Scepter:onActivate(function(actor)
	actor:enter_state(stateExecutionerSpecial2)
end)

stateExecutionerSpecial2:clear_callbacks()
stateExecutionerSpecial2:onEnter(function(actor, data)
	data.fired = 0
	data.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
	actor.image_index = 0
	actor:sound_play(sound_shoot4b_1, 1, 1)

	if data.scepter > 0 then
		actor.sprite_index = sprite_shoot5b
	else
		actor.sprite_index = sprite_shoot4b
	end
end)
stateExecutionerSpecial2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if data.fired == 0 and actor.image_index >= 4 then
		data.fired = 1

		local damage = actor:skill_get_damage(executionerSpecial2)
		if data.scepter > 0 then
			damage = actor:skill_get_damage(executionerSpecial2Scepter)
		end

		for i=0, actor:buff_stack_count(buffShadowClone) do
			local projectile = objExecutionerAxe:create(actor.x + 30 * actor.image_xscale, actor.y - 30)
			projectile.parent = actor
			projectile.team = actor.team
			projectile.direction = 90 - actor.image_xscale * 90
			projectile.image_xscale = actor.image_xscale
			projectile.damage_coeff = damage

			projectile.tX = actor.x + 270 * actor.image_xscale
			projectile.tY = actor.y

			if data.scepter > 0 then
				projectile.sprite_index = sprite_axe_projectileS

				projectile = objExecutionerAxe:create(actor.x + 30 * actor.image_xscale, actor.y - 30)
				projectile.parent = actor
				projectile.team = actor.team
				projectile.direction = 90 - actor.image_xscale * 90
				projectile.image_xscale = actor.image_xscale
				projectile.image_yscale = -1
				projectile.sprite_index = sprite_axe_projectileS
				projectile.damage_coeff = damage

				projectile.tX = actor.x + 270 * actor.image_xscale
				projectile.tY = actor.y
			end
		end

		actor:screen_shake(5)
		actor:sound_play(sound_shoot4b_2, 1, 1)
		actor:sound_play(gm.constants.wLizardR_Spear_2, 0.8, 0.9)
		actor:sound_play(gm.constants.wSawmerang, 0.6, 0.6)
	end

	actor:skill_util_exit_state_on_anim_end()
end)

objExecutionerAxe:clear_callbacks()
objExecutionerAxe:onCreate(function(self)
	self.parent = -4
	self.team = 1
	self.damage_coeff = 1
	self.image_speed = 0.75

	self.tX = self.x
	self.tY = self.y
	self.hitstop = 0

	self.time = 0.0

	self:get_data().already_hit = {}
end)
objExecutionerAxe:onStep(function(self)
	if not Instance.exists(self.parent) then
		self:destroy()
		return
	end

	local attack_rate = math.ceil(10 / self.parent.attack_speed)

	if self.hitstop == 0 then
		local actors = self:get_collisions(gm.constants.pActorCollisionBase)
		local did_hit = false
		local already_hit = self:get_data().already_hit
		for _, hit in ipairs(actors) do
			if self:attack_collision_canhit(hit) then
				did_hit = true
				if gm._mod_net_isHost() then
					local dmg = self.damage_coeff
					local proc = not already_hit[hit.id] -- only proc once per hit enemy

					local actor = GM.attack_collision_resolve(hit)
					if actor:buff_stack_count(buffFear) > 0 then
						dmg = dmg * 2
					end

					local attack_info = self.parent:fire_direct(hit, dmg, self.direction, hit.x, hit.y, sprite_ion_sparks2, proc).attack_info
					attack_info.execution = 1
					attack_info.stun = 0.5

					-- always direct knockback inwards -- effectively sucks victims into the grinder while hitting them
					if hit.x > self.x then
						attack_info.knockback_direction = -1
					else
						attack_info.knockback_direction = 1
					end

					already_hit[hit.id] = true
				end

				self:sound_play(gm.constants.wLizardR_Spear_2, 0.8, 0.8 + math.random() * 0.2)
				self:sound_play(gm.constants.wCrit, 0.8, 0.4 + math.random() * 0.2)
				self:screen_shake(5)
			end
		end

		if did_hit then
			self.hitstop = attack_rate
		end
	end

	if Global._current_frame % 3 == 0 then
		local ef = gm.instance_create(self.x, self.y, gm.constants.oEfTrail)
		ef.sprite_index = self.sprite_index
		ef.image_index = self.image_index
		ef.image_xscale = self.image_xscale
		ef.image_blend = ION_TRACER_COLOR
		ef.rate = 0.08
		ef.depth = self.depth + 1
	end

	if math.random() < 0.5 then
		local particle = ionParticle
		if self.sprite_index == sprite_axe_projectileS then
			particle = ionParticleS
		end
		particle:create(self.x + math.random(-48, 48), self.y + math.random(-48, 48), 1, Particle.SYSTEM.below)
	end

	if self.hitstop > 0 then
		-- handle hitstop
		self.hitstop = self.hitstop - 1

		if self.hitstop == 0 then
			-- jump forward a bit to compensate for hitstop
			-- 0.75x multiplier effectively slows it by 25% while hitting stuff
			self.time = self.time + 0.02 * attack_rate * 0.75
		end
	else
		-- move forward normally
		self.time = self.time + 0.02
	end

	local yscale = self.image_yscale

	if self.time < 1 then
		-- first half of lifetime -- arcing towards the sweetspot
		local x1, y1 = self.xstart, self.ystart -- start point
		local x4, y4 = self.tX, self.tY -- end point

		local lx = (x1 + x4) / 2

		-- 2 points inbetween that form the actual curve
		local x2, y2 = lx, y1 - 160 * yscale
		local x3, y3 = x4, y1 - 80 * yscale

		local b = gm.Bezier_Point(self.time, x1, y1, x2, y2, x3, y3, x4, y4)
		self.x = b[1]
		self.y = b[2]
	else
		-- second half of lifetime -- returning to owner
		local x1, y1 = self.tX, self.tY -- start point
		local x4, y4 = self.parent.x, self.parent.y -- end point

		local lx = (x1 + x4) / 2

		-- 2 points inbetween that form the actual curve
		local x2, y2 = x1, y1 + 80 * yscale
		local x3, y3 = lx, y1 + 160 * yscale

		local b = gm.Bezier_Point(self.time - 1, x1, y1, x2, y2, x3, y3, x4, y4)
		self.x = b[1]
		self.y = b[2]

		if self.time > 2 or gm.point_distance(self.parent.x, self.parent.y, self.x, self.y) < 40 then
			self:sound_play(gm.constants.wLizardR_Spear_2, 0.8, 1.3)
			self:destroy()
			return
		end
	end

	-- make projectile vibrate subtly during hitstop
	if self.hitstop > 0 then
		self.x = self.x + math.random(-4, 4)
		self.y = self.y + math.random(-4, 4)
	end
end)

local executionerLog = Survivor_Log.new(executioner, sprite_log)
