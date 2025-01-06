local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisCommando")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisCommando")

local sprite_idle			= Resources.sprite_load(NAMESPACE, "NemCommandoIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 15, 12)
local sprite_idle_half		= Resources.sprite_load(NAMESPACE, "NemCommandoIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 15, 12)
-- walk sprites have a sprite speed of 0.8 so they animate a bit slower
local sprite_walk			= Resources.sprite_load(NAMESPACE, "NemCommandoWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 17, 13, 0.8)
local sprite_walk_half		= Resources.sprite_load(NAMESPACE, "NemCommandoWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 17, 13, 0.8)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "NemCommandoWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 20, 25, 0.8)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "NemCommandoJump", path.combine(SPRITE_PATH, "jump.png"), 1, 18, 17)
local sprite_jump_half		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 18, 16)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 18, 17)
local sprite_jump_peak_half	= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 18, 16)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "NemCommandoFall", path.combine(SPRITE_PATH, "fall.png"), 1, 18, 17)
local sprite_fall_half		= Resources.sprite_load(NAMESPACE, "NemCommandoFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 18, 16)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "NemCommandoClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 20, 18)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 28, 62)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 28, 62)
local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 5, 15, 26)
local sprite_shoot2_half	= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2Half", path.combine(SPRITE_PATH, "shoot2Half.png"), 5, 15, 26)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot33", path.combine(SPRITE_PATH, "shoot3.png"), 6, 14, 13)

local sprite_dust			= Resources.sprite_load(NAMESPACE, "NemCommandoDust", path.combine(SPRITE_PATH, "dust.png"), 3, 21, 12)

local nemCommando = Survivor.new(NAMESPACE, "nemesisCommando")
local nemCommando_id = nemesisCommando

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

nemCommando:clear_callbacks()
nemCommando:onInit(function(actor)
	local idle_half = Array.new()
	local walk_half = Array.new()
	local jump_half = Array.new()
	local jump_peak_half = Array.new()
	local fall_half = Array.new()
	idle_half:push(sprite_idle, sprite_idle_half, 0)
	walk_half:push(sprite_walk, sprite_walk_half, 0, sprite_walk_back)
	jump_half:push(sprite_jump, sprite_jump_half, 0)
	jump_peak_half:push(sprite_jump_peak, sprite_jump_peak_half, 0)
	fall_half:push(sprite_fall, sprite_fall_half, 0)

	actor.sprite_idle_half = idle_half
	actor.sprite_walk_half = walk_half
	actor.sprite_jump_half = jump_half
	actor.sprite_jump_peak_half = jump_peak_half
	actor.sprite_fall_half = fall_half

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

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_explosion(actor.x + actor.image_xscale * 30, actor.y, 80, 58, damage, nil, gm.constants.sSparks9r).attack_info
				attack_info.climb = i * 8
				attack_info.__ssr_nemmando_wound = 1
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
nemCommandoSecondary.cooldown = 2 * 60
nemCommandoSecondary.damage = 1.5
nemCommandoSecondary.max_stock = 4
-- is_primary makes the skill's cooldown reduced by attack speed, but also removes cooldown timer on HUD, and causes other unintuitive issues. is it worth?
nemCommandoSecondary.is_primary = true
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

	data.timer = 2 * 60
	data.fired = 0
end)
stateNemCommandoSpecial:onStep(function(actor, data)
	actor.pHspeed = actor.pHspeed * 0.75

	if data.fired == 0 and data.timer % 30 == 0 then
		actor:sound_play(gm.constants.wPickupOLD, 0.7, 4)
	end

	data.timer = data.timer - 1

	if (not gm.bool(actor.v_skill) or gm.bool(actor.ropeDown) or data.timer < 5) and data.fired == 0 then
		local nade = objGrenade:create(actor.x, actor.y - 5)
		nade.hspeed = actor.pHspeed
		nade.vspeed = actor.pVspeed
		if not gm.bool(actor.ropeDown) then
			nade.hspeed = nade.hspeed + 4 * actor.image_xscale
			nade.vspeed = nade.vspeed - 6
		end
		nade.parent = actor
		nade.timer = data.timer

		data.timer = 16
		data.fired = 1
	end

	if data.fired == 1 and data.timer <= 0 then
		actor:skill_util_reset_activity_state()
	end
end)

local particleTrail = Particle.find("ror", "PixelDust")

objGrenade:clear_callbacks()
objGrenade:onCreate(function(inst)
	inst.gravity = 0.4
	inst.parent = -4
	inst.bounces = 3
end)
objGrenade:onStep(function(inst)
	if inst.bounces > 0 then
		local bounced = false
		local bounce_h = inst:is_colliding(gm.constants.pBlock, inst.x + inst.hspeed, inst.y)
		local bounce_v = inst:is_colliding(gm.constants.pBlock, inst.x, inst.y + inst.vspeed)
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
		end

		if inst.bounces <= 0 then
			inst.gravity = 0
			inst:move_contact_solid(270, inst.speed)
			inst.speed = 0
		end
	end

	particleTrail:create_color(inst.x, inst.y, Color.RED, 1, Particle.SYSTEM.below)

	if inst.timer % 30 == 0 then
		inst:sound_play(gm.constants.wPickupOLD, 0.7, 4)
	end

	inst.timer = inst.timer - 1

	if inst.timer <= 0 then
		inst:destroy()
	end
end)
objGrenade:onDestroy(function(inst)
	inst:sound_play(gm.constants.wExplosiveShot, 1, 2)

	if Instance.exists(inst.parent) and inst.parent:is_authority() then
		inst.parent:fire_explosion(inst.x, inst.y, 160, 100, 5.0, gm.constants.sEfBombExplodeEnemy)
	end
end)
