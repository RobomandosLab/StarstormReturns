local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisCommando")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisCommando")

local sprite_idle			= Resources.sprite_load(NAMESPACE, "NemCommandoIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 15, 12)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "NemCommandoIdle2", path.combine(SPRITE_PATH, "idle2.png"), 1, 15, 12)
local sprite_idle_half		= Resources.sprite_load(NAMESPACE, "NemCommandoIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 15, 12)
-- walk sprites have a sprite speed of 0.8, the slower animation looks better
local sprite_walk			= Resources.sprite_load(NAMESPACE, "NemCommandoWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 17, 13, 0.8)
local sprite_walk2			= Resources.sprite_load(NAMESPACE, "NemCommandoWalk2", path.combine(SPRITE_PATH, "walk2.png"), 8, 15, 18, 0.8)
local sprite_walk_half		= Resources.sprite_load(NAMESPACE, "NemCommandoWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 17, 13, 0.8)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "NemCommandoWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 20, 25, 0.8)
local sprite_walk_back2		= Resources.sprite_load(NAMESPACE, "NemCommandoWalkBack2", path.combine(SPRITE_PATH, "walkBack2.png"), 8, 20, 25, 0.8)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "NemCommandoJump", path.combine(SPRITE_PATH, "jump.png"), 1, 18, 17)
local sprite_jump2			= Resources.sprite_load(NAMESPACE, "NemCommandoJump2", path.combine(SPRITE_PATH, "jump2.png"), 1, 18, 18)
local sprite_jump_half		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 18, 16)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 18, 17)
local sprite_jump_peak2		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeak2", path.combine(SPRITE_PATH, "jumpPeak2.png"), 1, 18, 18)
local sprite_jump_peak_half	= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 18, 16)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "NemCommandoFall", path.combine(SPRITE_PATH, "fall.png"), 1, 18, 17)
local sprite_fall2			= Resources.sprite_load(NAMESPACE, "NemCommandoFall2", path.combine(SPRITE_PATH, "fall2.png"), 1, 18, 18)
local sprite_fall_half		= Resources.sprite_load(NAMESPACE, "NemCommandoFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 18, 16)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "NemCommandoClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 20, 18)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 28, 62)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 28, 62)
local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 5, 15, 26)
local sprite_shoot2_half	= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2Half", path.combine(SPRITE_PATH, "shoot2Half.png"), 5, 15, 26)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot33", path.combine(SPRITE_PATH, "shoot3.png"), 6, 14, 13)

local sprite_dust			= Resources.sprite_load(NAMESPACE, "NemCommandoDust", path.combine(SPRITE_PATH, "dust.png"), 3, 21, 12)
local sprite_rocket_mask	= Resources.sprite_load(NAMESPACE, "NemCommandoRocketMask", path.combine(SPRITE_PATH, "rocketMask.png"), 1, 0, 2)

-- grenade fx
local particleRubble2 = Particle.find("ror", "Rubble2")
-- rocket fx
local particleRocketTrail = Particle.find("ror", "MissileTrail")
local particleRubble1 = Particle.find("ror", "Rubble1")
local particleSpark = Particle.find("ror", "Spark")

local nemCommando = Survivor.new(NAMESPACE, "nemesisCommando")
local nemCommando_id = nemesisCommando

local GRENADE_FUSE_TIMER = 2 * 60
local GRENADE_TICK_INTERVAL = 30
local GRENADE_THROW_XSPEED = 4
local GRENADE_THROW_YSPEED = -6
local GRENADE_TOSS_XSPEED = 3
local GRENADE_TOSS_YSPEED = -3
local GRENADE_VELOCITY_INHERIT_MULT = 1
local GRENADE_AUTOTHROW_THRESHOLD = 1
local GRENADE_SELFSTUN_THRESHOLD = 15
local GRENADE_END_LAG = 16

nemCommando:set_stats_base({
	maxhp = 115,
	damage = 11,
	regen = 0.011,
})
nemCommando:set_stats_level({
	maxhp = 36,
	damage = 3,
	regen = 0.001,
	armor = 2,
})

nemCommando:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump_peak,
	fall = sprite_fall,
	climb = sprite_climb,
	--death = sprite_death,
	--decoy = sprite_decoy,
})

nemCommando:set_cape_offset(0, -8, 0, -8)
nemCommando:set_primary_color(Color.from_rgb(250, 40, 40))

nemCommando.sprite_title = sprite_walk

-- utility function for updating his basic sprites depending on if his last skill was the gun
local function nemmando_update_sprites(actor, has_gun)
	if has_gun then
		actor.sprite_idle = sprite_idle2
		actor.sprite_walk = sprite_walk2
		actor.sprite_walk_half[4] = sprite_walk_back2
		actor.sprite_jump = sprite_jump2
		actor.sprite_jump_peak = sprite_jump_peak2
		actor.sprite_fall = sprite_fall2
	else
		actor.sprite_idle = sprite_idle
		actor.sprite_walk = sprite_walk
		actor.sprite_walk_half[4] = sprite_walk_back
		actor.sprite_jump = sprite_jump
		actor.sprite_jump_peak = sprite_jump_peak
		actor.sprite_fall = sprite_fall
	end
	actor.sprite_idle_half[1] = actor.sprite_idle
	actor.sprite_walk_half[1] = actor.sprite_walk
	actor.sprite_jump_half[1] = actor.sprite_jump
	actor.sprite_jump_peak_half[1] = actor.sprite_jump_peak
	actor.sprite_fall_half[1] = actor.sprite_fall
	actor.sprite_walk_last = actor.sprite_walk -- dunno what this is but setting it was required
end

nemCommando:clear_callbacks()
nemCommando:onInit(function(actor)
	actor.sprite_idle_half = Array.new({sprite_idle, sprite_idle_half, 0})
	actor.sprite_walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk_back})
	actor.sprite_jump_half = Array.new({sprite_jump, sprite_jump_half, 0})
	actor.sprite_jump_peak_half = Array.new({sprite_jump_peak, sprite_jump_peak_half, 0})
	actor.sprite_fall_half = Array.new({sprite_fall, sprite_fall_half, 0})

	actor:survivor_util_init_half_sprites()
end)

local nemCommandoPrimary = nemCommando:get_primary()
local nemCommandoSecondary = nemCommando:get_secondary()
local nemCommandoUtility = nemCommando:get_utility()
local nemCommandoSpecial = nemCommando:get_special()

-- Blade of Cessation
nemCommandoPrimary.cooldown = 10
nemCommandoPrimary.damage = 1.2
nemCommandoPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateNemCommandoPrimary = State.new(NAMESPACE, "nemCommandoPrimary")

nemCommandoPrimary:clear_callbacks()
nemCommandoPrimary:onActivate(function(actor)
	actor:enter_state(stateNemCommandoPrimary)
end)

stateNemCommandoPrimary:clear_callbacks()
stateNemCommandoPrimary:onEnter(function(actor, data)
	actor.image_index = 0

	nemmando_update_sprites(actor, false)

	data.fired = 0
	-- variable used to keep track of which attack anim to use
	if not data.attack_side then
		data.attack_side = 0
	end

	actor.sprite_index = sprite_shoot1_1
	if data.attack_side == 1 then
		actor.sprite_index = sprite_shoot1_2
	end
end)
stateNemCommandoPrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if actor.image_index >= 1 and data.fired == 0 then
		data.fired = 1
		data.attack_side = (data.attack_side + 1) % 2

		actor:sound_play(gm.constants.wMercenaryShoot1_1, 1, 0.75 + math.random() * 0.05)

		actor:skill_util_nudge_forward(2 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(nemCommandoPrimary)

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack_info = actor:fire_explosion(actor.x + actor.image_xscale * 30, actor.y, 80, 58, damage, nil, gm.constants.sSparks9r).attack_info
					attack_info.climb = i * 8
					attack_info.__ssr_nemmando_wound = 1
				end
			end
		end
	end

	if actor.image_index + actor.image_speed >= actor.image_number then
		actor:skill_util_reset_activity_state()
	end
end)
stateNemCommandoPrimary:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 4 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

local wound = Buff.find("ror", "commandoWound")

Callback.add(Callback.TYPE.onAttackHit, "SSNemmandoOnHit", function(hit_info)
	if hit_info.attack_info.__ssr_nemmando_wound == 1 then
		victim = hit_info.target
		if victim:buff_stack_count(wound) == 0 then
			--victim:buff_apply(wound, 4 * 60)
			GM.apply_buff(victim, wound, 6 * 60, 1)
		else
			GM.set_buff_time(victim, wound, 6 * 60)
		end
	end
end)

-- Single Tap
nemCommandoSecondary.cooldown = 2.5 * 60
nemCommandoSecondary.damage = 1.5
nemCommandoSecondary.max_stock = 4
-- is_primary makes the skill's cooldown reduced by attack speed, but also removes cooldown timer on HUD, and causes other unintuitive issues. is it worth?
--nemCommandoSecondary.is_primary = true
nemCommandoSecondary.hold_facing_direction = true

local tracer_particle = Particle.find("ror", "WispGTracer")
local tracer_color = Color.from_rgb(252, 118, 98)
local tracer, tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	y1 = y1 - 8
	y2 = y2 - 8

	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	-- tracer
	local t = GM.instance_create(x1, y1, gm.constants.oEfProjectileTracer)
	t.direction = dir
	t.speed = 60
	t.length = 80
	t.blend_1 = tracer_color
	t.blend_2 = tracer_color
	t:alarm_set(0, math.max(1, dist / t.speed))

	-- particles
	tracer_particle:set_direction(dir, dir, 0, 0)

	local px = x1
	local py = y1
	local i = 0
	while i < dist do
		tracer_particle:create_colour(px, py, tracer_color, 1)
		px = px + gm.lengthdir_x(15, dir)
		py = py + gm.lengthdir_y(15, dir)
		i = i + 15
	end
end)
tracer_info.sparks_offset_y = -8

local stateNemCommandoSecondary = State.new(NAMESPACE, "nemCommandoSecondary")

nemCommandoSecondary:clear_callbacks()
nemCommandoSecondary:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSecondary)
end)

stateNemCommandoSecondary:clear_callbacks()
stateNemCommandoSecondary:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.fired = 0

	nemmando_update_sprites(actor, true)

	actor:skill_util_strafe_init()
	--actor:skill_util_strafe_turn_init() -- this and skill_util_strafe_turn_update only works for skills in the Z/primary slot ....
end)
stateNemCommandoSecondary:onStep(function(actor, data)
	actor.sprite_index2 = sprite_shoot2_half

	actor:skill_util_strafe_update(0.25 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	--actor:skill_util_strafe_turn_update()

	-- adjust vertical offset so the upper body bobs up and down depending on the leg animation
	if actor.sprite_index == actor.sprite_walk_half[2] then
		local walk_offset = 0
		local leg_frame = math.floor(actor.image_index)
		if leg_frame == 0 or leg_frame == 4 then
			walk_offset = 2
		elseif leg_frame == 2 or leg_frame == 6 then
			walk_offset = -1
		end
		actor.ydisp = walk_offset -- ydisp controls upper body offset
	end

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wBullet2, 1, 1.4 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(nemCommandoSecondary)
			local dir = actor:skill_util_facing_direction()

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y, 1400, dir + gm.random_range(-1, 1), damage, nil, gm.constants.sSparks23r, tracer).attack_info
				attack_info.climb = i * 8
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)
stateNemCommandoSecondary:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)
stateNemCommandoSecondary:onGetInterruptPriority(function(actor, data)
	if actor.image_index2 + 0.25 * actor.attack_speed >= 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

nemCommandoUtility.cooldown = 3 * 60
nemCommandoUtility.max_stock = 2
nemCommandoUtility.override_strafe_direction = true
nemCommandoUtility.ignore_aim_direction = true
nemCommandoUtility.is_utility = true

local stateNemCommandoUtility = State.new(NAMESPACE, "nemCommandoUtility")
stateNemCommandoUtility.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

nemCommandoUtility:clear_callbacks()
nemCommandoUtility:onActivate(function(actor)
	actor:enter_state(stateNemCommandoUtility)
end)
nemCommandoUtility:onCanActivate(function(actor)
	if actor.actor_state_current_id == State.find(NAMESPACE, "nemCommandoSpecial").value then
		return true
	end
end)

stateNemCommandoUtility:clear_callbacks()
stateNemCommandoUtility:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)
stateNemCommandoUtility:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.25, false)

	actor.pHspeed = 2.5 * actor.pHmax * actor.image_xscale
	actor:set_immune(3)

	if data.fired == 0 then
		data.fired = 1

		local secondary = actor:get_active_skill(Skill.SLOT.secondary)

		if secondary.skill_id == nemCommandoSecondary.value then
			if secondary.stock < secondary.max_stock then
				actor:sound_play(gm.constants.wSniperReload, 0.8, 1.5)
			end

			GM.actor_skill_add_stock(actor, Skill.SLOT.secondary)
			GM.actor_skill_add_stock(actor, Skill.SLOT.secondary)
		end

		actor:sound_play(gm.constants.wCommandoRoll, 0.9, 1.2)

		local dust = GM.instance_create(actor.x, actor.y + 12, gm.constants.oEfExplosion)
		dust.sprite_index = sprite_dust
		dust.image_xscale = actor.image_xscale
		dust.image_speed = 0.15
	end

	actor:skill_util_exit_state_on_anim_end()
end)

-- Flush Out

local objGrenade = Object.new(NAMESPACE, "NemmandoGrenade")
objGrenade.obj_sprite = gm.constants.sEfGrenadeEnemy

nemCommandoSpecial.cooldown = 6 * 60

local stateNemCommandoSpecial = State.new(NAMESPACE, "nemCommandoSpecial")

nemCommandoSpecial:clear_callbacks()
nemCommandoSpecial:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSpecial)
end)

stateNemCommandoSpecial:clear_callbacks()
stateNemCommandoSpecial:onEnter(function(actor, data)
	actor.activity_type = 4 -- locks facing direction while allowing free movement and animation

	data.timer = GRENADE_FUSE_TIMER
	data.fired = 0
end)
stateNemCommandoSpecial:onStep(function(actor, data)
	actor.pHspeed = actor.pHspeed * 0.75

	if data.fired == 0 and data.timer % GRENADE_TICK_INTERVAL == 0 then
		actor:sound_play(gm.constants.wPickupOLD, 0.7, 4)

		local flash = GM.instance_create(actor.x, actor.y, gm.constants.oEfFlash)
		flash.parent = actor
		flash.rate = 0.1
		flash.image_alpha = 0.5
	end

	data.timer = data.timer - 1

	local release = not gm.bool(actor.v_skill)
	local low_toss = gm.bool(actor.ropeDown)
	local auto_toss = data.timer <= GRENADE_AUTOTHROW_THRESHOLD

	if (release or low_toss or auto_toss) and data.fired == 0 then
		local nade = objGrenade:create(actor.x, actor.y - 5)

		if low_toss then
			nade.hspeed = GRENADE_TOSS_XSPEED * actor.image_xscale
			nade.vspeed = GRENADE_TOSS_YSPEED
		else
			nade.hspeed = GRENADE_THROW_XSPEED * actor.image_xscale
			nade.vspeed = GRENADE_THROW_YSPEED
		end

		nade.hspeed = nade.hspeed + actor.pHspeed * GRENADE_VELOCITY_INHERIT_MULT
		nade.vspeed = nade.vspeed + actor.pVspeed * GRENADE_VELOCITY_INHERIT_MULT

		nade.parent = actor
		nade.timer = data.timer
		if nade.timer <= GRENADE_SELFSTUN_THRESHOLD then
			nade.stun_parent = 1
		end

		data.timer = GRENADE_END_LAG
		data.fired = 1
	end

	if data.fired == 1 and data.timer <= 0 then
		actor:skill_util_reset_activity_state()
	end
end)
stateNemCommandoSpecial:onExit(function(actor, data)
	if data.timer > 0 and data.fired == 0 then
		local nade = objGrenade:create(actor.x, actor.y - 5)

		--nade.hspeed = GRENADE_TOSS_XSPEED * actor.image_xscale
		nade.vspeed = GRENADE_TOSS_YSPEED

		nade.hspeed = nade.hspeed + actor.pHspeed * GRENADE_VELOCITY_INHERIT_MULT
		nade.vspeed = nade.vspeed + actor.pVspeed * GRENADE_VELOCITY_INHERIT_MULT

		nade.parent = actor
		nade.timer = data.timer
		if nade.timer <= GRENADE_SELFSTUN_THRESHOLD then
			nade.stun_parent = 1
		end
	end
end)

local particleTrail = Particle.find("ror", "PixelDust")

objGrenade:clear_callbacks()
objGrenade:onCreate(function(inst)
	inst.gravity = 0.4
	inst.bounces = 3

	inst.parent = -4
	inst.timer = GRENADE_FUSE_TIMER
	inst.stun_parent = 0
end)
objGrenade:onStep(function(inst)
	if inst.bounces > 0 then
		local bounced = false

		-- extrapolate where the grenade will be next frame for collision detection
		-- a half pixel margin is added to mitigate a bug where the grenade bounces incorrectly
		local speedx = inst.hspeed + gm.sign(inst.hspeed) * 0.5
		local speedy = inst.vspeed + gm.sign(inst.vspeed) * 0.5

		local bounce_h = inst:is_colliding(gm.constants.pBlock, inst.x + speedx, inst.y)
		local bounce_v = inst:is_colliding(gm.constants.pBlock, inst.x, inst.y + speedy)
		if bounce_h then
			inst.hspeed = inst.hspeed * -0.5
			bounced = true
		end
		if bounce_v then
			if inst.vspeed > 0 then
				inst.bounces = inst.bounces - 1
			end

			inst.vspeed = inst.vspeed * -0.5
			inst.hspeed = inst.hspeed * 0.75

			bounced = true
		end

		if bounced and inst.speed > 1 then
			inst:sound_play(gm.constants.wGuardHit, 1, 1 + 1 / (inst.speed))

			if bounce_h and bounce_v then
				inst:sound_play(gm.constants.wReflect, 1, 2)
			end
		end

		if inst.bounces <= 0 then
			inst.gravity = 0
			inst:move_contact_solid(270, inst.speed)
			inst.speed = 0
		end
	end

	particleTrail:create_color(inst.x, inst.y, Color.RED, 1, Particle.SYSTEM.below)

	if inst.timer % GRENADE_TICK_INTERVAL == 0 then
		inst:sound_play(gm.constants.wPickupOLD, 0.7, 4)
	end

	inst.timer = inst.timer - 1

	if inst.timer <= 0 then
		inst:destroy()
	end
end)

objGrenade:onDestroy(function(inst)
	inst:sound_play(gm.constants.wExplosiveShot, 1, 2)
	inst:screen_shake(4)

	particleRubble2:create(inst.x, inst.y, 15)

	if Instance.exists(inst.parent) and gm._mod_net_isHost() then
		inst.parent:fire_explosion(inst.x, inst.y, 192, 160, 7.0, gm.constants.sEfBombExplodeEnemy)

		if inst.stun_parent == 1 then
			GM.actor_knockback_inflict(inst.parent, 1, -inst.parent.image_xscale, 60)
		end
	end
end)

-- Devastator
local objRocket = Object.new(NAMESPACE, "NemmandoRocket")
objRocket.obj_sprite = gm.constants.sEfMissile

nemCommandoSpecial2 = Skill.new(NAMESPACE, "nemesisCommandoV2")
nemCommando:add_special(nemCommandoSpecial2)

nemCommandoSpecial2.cooldown = 6 * 60

local stateNemCommandoSpecial2 = State.new(NAMESPACE, "nemCommandoSpecial2")

nemCommandoSpecial2:clear_callbacks()
nemCommandoSpecial2:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSpecial2)
end)

stateNemCommandoSpecial2:clear_callbacks()
stateNemCommandoSpecial2:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)
stateNemCommandoSpecial2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()

	actor:actor_animation_set(sprite_shoot2, 0.2)

	if data.fired == 0 then
		data.fired = 1

		actor:sound_play(gm.constants.wEnforcerShoot1, 1, 0.5 + math.random() * 0.1)
		actor:screen_shake(3)

		local rocket = objRocket:create(actor.x + 8 * actor.image_xscale, actor.y - 8)

		rocket.parent = actor
		rocket.direction = actor:skill_util_facing_direction()

		actor.pHspeed = actor.pHmax * -2 * actor.image_xscale
		if gm.bool(actor.free) then
			rocket.direction = 270 + actor.image_xscale * 45

			actor.pVspeed = actor.pVmax * -1.2
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

objRocket:clear_callbacks()
objRocket:onCreate(function(inst)
	inst.speed = 2
	inst.mask_index = sprite_rocket_mask

	inst.team = 1
	inst.parent = -4
	inst.victim = -4

	inst.lifetime = 3 * 60
	inst.woosh_sound = -1
end)
objRocket:onStep(function(inst)
	inst.image_angle = inst.direction

	if inst.woosh_sound == -1 then
		inst.woosh_sound = gm.sound_play_at(gm.constants.wFwoosh, 1, 0.1 + math.random() * 0.1, inst.x + inst.hspeed * 120, inst.y)
	end

	particleRocketTrail:set_orientation(inst.direction, inst.direction, 0, 0, 0)
	-- always create enough trail particles to cover the rocket's travel
	for i = 0, math.floor(inst.speed / 4) do
		local xoff = (inst.hspeed * i) / 4
		local yoff = (inst.vspeed * i) / 4
		particleRocketTrail:create(inst.x - xoff, inst.y - yoff, 1)
	end

	inst.speed = math.min(24, inst.speed + 0.5)

	local detonate = inst:is_colliding(gm.constants.pBlock)

	if not detonate then
		local actors = inst:get_collisions(gm.constants.pActorCollisionBase)

		for _, actor in ipairs(actors) do
			if inst:attack_collision_canhit(actor) then
				detonate = true
				inst.victim = actor
				break
			end
		end
	end

	inst.lifetime = inst.lifetime - 1
	if inst.lifetime < 0 then
		detonate = true
	end

	if detonate then
		inst:destroy()
	end
end)
objRocket:onDestroy(function(inst)
	inst:sound_play(gm.constants.wTurtleExplosion, 1, 0.4 + math.random() * 0.2)
	inst:sound_play(gm.constants.wWormExplosion, 1, 0.6 + math.random() * 0.2)
	inst:screen_shake(25)

	if gm.audio_is_playing(inst.woosh_sound) then
		gm.audio_stop_sound(inst.woosh_sound)
	end

	particleRubble1:create(inst.x, inst.y, 15)

	if Instance.exists(inst.parent) and gm._mod_net_isHost() then
		-- sweet spot aoe
		--inst.parent:fire_explosion(inst.x, inst.y, 30, 30, 5)

		-- direct hit
		if inst.victim ~= -4 then
			inst.parent:fire_direct(inst.victim, 10, inst.direction, inst.x, inst.y)
		end

		-- large stunning aoe
		local attack = inst.parent:fire_explosion(inst.x, inst.y, 260, 260, 0.5, gm.constants.sEfSuperMissileExplosion).attack_info
		attack.stun = 1.66
		attack.knockback = 5
		attack.knockup = 5
		attack.climb = 8 * 1.35
	end
end)
