local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Executioner")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Executioner")

-- sprites.
local sprite_loadout		= Resources.sprite_load(NAMESPACE, "ExecutionerSelect", path.combine(SPRITE_PATH, "select.png"), 22, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "ExecutionerPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "ExecutionerPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "ExecutionerSkills", path.combine(SPRITE_PATH, "skills.png"), 9)
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
--local sprite_palette		= Resources.sprite_load(NAMESPACE, "ExecutionerPalette", path.combine(SPRITE_PATH, "palette.png"))

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

local sprite_drone_idle		= Resources.sprite_load(NAMESPACE, "DronePlayerExecutionerIdle", path.combine(SPRITE_PATH, "droneIdle.png"), 5, 11, 14)
local sprite_drone_shoot	= Resources.sprite_load(NAMESPACE, "DronePlayerExecutionerShoot", path.combine(SPRITE_PATH, "droneShoot.png"), 5, 33, 13)

local sprite_ion_sparks		= Resources.sprite_load(NAMESPACE, "ExecutionerIonSparks", path.combine(SPRITE_PATH, "ionSparks.png"), 4, 24, 14)
local sprite_ion_tracer		= Resources.sprite_load(NAMESPACE, "ExecutionerIonTracer", path.combine(SPRITE_PATH, "ionTracer.png"), 5, 0, 2)
local sprite_ion_particle	= Resources.sprite_load(NAMESPACE, "ExecutionerIonParticle", path.combine(SPRITE_PATH, "ionParticle.png"), 5, 8, 8)
local sprite_ion_particleS	= Resources.sprite_load(NAMESPACE, "ExecutionerIonParticleS", path.combine(SPRITE_PATH, "ionParticleS.png"), 5, 8, 8)

local sprite_log			= Resources.sprite_load(NAMESPACE, "ExecutionerLog", path.combine(SPRITE_PATH, "log.png"))

-- sounds.
local sound_shoot1			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))

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

executioner:set_cape_offset(0, -8, 0, -12)
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
executionerPrimary.sprite = sprite_skills
executionerPrimary.subimage = 0

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

	actor:skill_util_strafe_update(0.33 * actor.attack_speed, 0.5)
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
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
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
executionerSecondary.sprite = sprite_skills
executionerSecondary.subimage = 2
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

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
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

Callback.add(Callback.TYPE.onKillProc, "SSIonCharge", function(victim, killer)
	if killer.object_index == gm.constants.oP and killer.class == executioner_id then
		local charges = 1
		if GM.actor_is_elite(victim) then
			charges = charges * 2
		end
		if GM.actor_is_boss(victim) then
			charges = charges * 5
		end
		for i=1, charges do
			GM.actor_skill_add_stock_networked(killer, 1)
		end
	end
end)

-- Crowd Dispersion
executionerUtility.sprite = sprite_skills
executionerUtility.subimage = 6
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
executionerSpecial.sprite = sprite_skills
executionerSpecial.subimage = 7
executionerSpecial.cooldown = 8 * 60
executionerSpecial.damage = 10
executionerSpecial.require_key_press = true
executionerSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- Crowd Execution
local executionerSpecialScepter = Skill.new(NAMESPACE, "executionerVBoosted")
executionerSpecial:set_skill_upgrade(executionerSpecialScepter)

executionerSpecialScepter.sprite = sprite_skills
executionerSpecialScepter.subimage = 8
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

	data.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
end)
stateExecutionerSpecialPre:onStep(function(actor, data)
	local drifting = math.abs(actor.pHspeed) > actor.pHmax

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

	local true_speed = math.max(1, 2 - (1 / actor.attack_speed) )
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

	local true_speed = math.max(1, 2 - (1 / actor.attack_speed) )

	actor:actor_animation_set(animation, 0.25 * true_speed, false)

	if data.substate == 0 then
		actor.image_index = 0
		actor.activity_type = 2 -- changes physics for the state. gravity is disabled and vertical velocity is uncapped.
		actor.pVspeed = (actor.pVmax * -2) * true_speed
		data.substate = 1
		actor:sound_play(sound_shoot4a, 1.0, 1.0)
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
				actor:sound_play(sound_shoot4a, 1.0, 1.0)
			else
				actor:skill_util_reset_activity_state() -- too many interruptions -- give up so we're not perma immune lmao
			end
		else
			actor.pVspeed = 30 * true_speed -- water slows exe down and without gravity he's left stuck, so always force to max speed'

			if not gm.bool(actor.free) then
				data.substate = 4
				actor.image_index = 11
				actor.activity_type = 1 -- return to standard state physics

				actor:sound_play(sound_shoot4b, 1.0, 1.0)
				actor:screen_shake(15)

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

					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, actor:buff_stack_count(buff_shadow_clone) do
						local attack_info = actor:fire_explosion(ax, ay, 160, 32 + data.aoe_height, damage).attack_info
						attack_info.climb = i * 8 * 1.35
						attack_info.y = actor.y
						attack_info.execution = 1
					end

					if data.scepter > 0 then
						local fear = Buff.find("ror", "fear")
						local victims = List.new()
						actor:collision_rectangle_list(ax - 120, actor.y - 30, ax + 120, actor.y + 30, gm.constants.pActor, false, true, victims, false)

						for _, victim in ipairs(victims) do
							if victim.team ~= actor.team then
								victim:buff_apply(fear, 2 * 60)
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

local executionerLog = Survivor_Log.new(executioner, sprite_log)
