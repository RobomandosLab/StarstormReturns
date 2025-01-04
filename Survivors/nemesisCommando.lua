local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisCommando")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisCommando")

local sprite_idle			= Resources.sprite_load(NAMESPACE, "NemCommandoIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 15, 12)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "NemCommandoWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 17, 13, 0.8)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "NemCommandoJump", path.combine(SPRITE_PATH, "jump.png"), 1, 18, 17)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 18, 17)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "NemCommandoFall", path.combine(SPRITE_PATH, "fall.png"), 1, 18, 17)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "NemCommandoClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 20, 18)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 28, 62)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 28, 62)
local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 5, 15, 26)
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

nemCommando:set_primary_color(Color.from_rgb(250, 40, 40))

nemCommando.sprite_title = sprite_walk

local nemCommandoPrimary = nemCommando:get_primary()
local nemCommandoSecondary = nemCommando:get_secondary()
local nemCommandoUtility = nemCommando:get_utility()
local nemCommandoSpecial = nemCommando:get_special()

nemCommandoPrimary.cooldown = 10
nemCommandoPrimary.damage = 1

local stateNemCommandoPrimary = State.new(NAMESPACE, "nemCommandoPrimary")

nemCommandoPrimary:clear_callbacks()
nemCommandoPrimary:onActivate(function(actor)
	actor:enter_state(stateNemCommandoPrimary)
end)

stateNemCommandoPrimary:clear_callbacks()
stateNemCommandoPrimary:onEnter(function(actor, data)
	actor.image_index = 0

	data.fired = 0
	if not data.side then
		data.side = 0
	else
		data.side = 1 - data.side
	end

	actor.sprite_index = sprite_shoot1_1
	if data.side == 1 then
		actor.sprite_index = sprite_shoot1_2
	end
end)
stateNemCommandoPrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(actor.sprite_index, 0.18)

	if actor.image_index >= 1 and data.fired == 0 then
		data.fired = 1

		actor:sound_play(gm.constants.wMercenaryShoot1_1, 1, 0.75 + math.random() * 0.05)

		actor:skill_util_nudge_forward(2 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(nemCommandoPrimary)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_explosion(actor.x + actor.image_xscale * 30, actor.y, 80, 58, damage, nil, gm.constants.sSparks9r).attack_info
				attack_info:set_attack_flags(Attack_Info.ATTACK_FLAG.commando_wound, true)
				attack_info.climb = i * 8
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

nemCommandoSecondary.cooldown = 2 * 60
nemCommandoSecondary.damage = 2
nemCommandoSecondary.max_stock = 4
nemCommandoSecondary.is_primary = true

local tracer_particle = Particle.find("ror", "WispGTracer")
local tracer_color = Color.from_rgb(252, 118, 98)
local tracer, tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	y1 = y1 - 8
	y2 = y2 - 8

	-- particles
	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

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
	actor.image_index = 0
	data.fired = 0
end)
stateNemCommandoSecondary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2, 0.25)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wBullet2, 1, 1.4 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(nemCommandoSecondary)
			local dir = actor:skill_util_facing_direction() + gm.random_range(-3, 3)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks23r, tracer).attack_info
				attack_info.climb = i * 8
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)
stateNemCommandoSecondary:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

nemCommandoUtility.cooldown = 3 * 60
nemCommandoUtility.max_stock = 2
nemCommandoUtility.override_strafe_direction = true
nemCommandoUtility.ignore_aim_direction = true

local stateNemCommandoUtility = State.new(NAMESPACE, "nemCommandoUtility")
stateNemCommandoUtility.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

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
	actor:set_immune(5)

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
stateNemCommandoUtility:onExit(function(actor, data)
	if actor.invincible <= 5 then
		actor.invincible = 0
	end
end)
