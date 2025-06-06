local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisCommando")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisCommando")

local sprite_select			= Resources.sprite_load(NAMESPACE, "NemCommandoSelect", path.combine(SPRITE_PATH, "select.png"), 34, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "NemCommandoPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "NemCommandoPortraitSmall", path.combine(SPRITE_PATH, "portraitTiny.png"))
local sprite_credits		= Resources.sprite_load(NAMESPACE, "CreditsSurvivorNemCommando", path.combine(SPRITE_PATH, "credits.png"), 1, 7, 11)

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
local sprite_death			= Resources.sprite_load(NAMESPACE, "NemCommandoDeath", path.combine(SPRITE_PATH, "death.png"), 13, 31, 9)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 28, 62)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 28, 62)
--local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 5, 15, 26)
local sprite_shoot2_half	= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2Half", path.combine(SPRITE_PATH, "shoot2Half.png"), 5, 15, 26)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2B", path.combine(SPRITE_PATH, "shoot2b.png"), 10, 36, 39)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 6, 14, 13)
local sprite_shoot4_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4_1", path.combine(SPRITE_PATH, "shoot4_1.png"), 10, 23, 30)
local sprite_shoot4_2a		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4_2A", path.combine(SPRITE_PATH, "shoot4_2a.png"), 6, 17, 24)
local sprite_shoot4_2b		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4_2B", path.combine(SPRITE_PATH, "shoot4_2b.png"), 6, 19, 17)
local sprite_shoot4b		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4B", path.combine(SPRITE_PATH, "shoot4b.png"), 9, 47, 33)
local sprite_shoot4b_a		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4B_A", path.combine(SPRITE_PATH, "shoot4b_a.png"), 8, 34, 27)

local sprite_decoy			= Resources.sprite_load(NAMESPACE, "NemCommandoDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 22, 18)
local sprite_drone_idle		= Resources.sprite_load(NAMESPACE, "DronePlayerNemCommandoIdle", path.combine(SPRITE_PATH, "drone_idle.png"), 5, 15, 13)
local sprite_drone_shoot	= Resources.sprite_load(NAMESPACE, "DronePlayerNemCommandoShoot", path.combine(SPRITE_PATH, "drone_shoot.png"), 5, 33, 13)

local sprite_skills			= Resources.sprite_load(NAMESPACE, "NemCommandoSkills", path.combine(SPRITE_PATH, "skills.png"), 8, 0, 0)
local sprite_gash			= Resources.sprite_load(NAMESPACE, "NemCommandoGash", path.combine(SPRITE_PATH, "gash.png"), 4, 25, 25)
local sprite_dust			= Resources.sprite_load(NAMESPACE, "NemCommandoDust", path.combine(SPRITE_PATH, "dust.png"), 3, 21, 12)
local sprite_grenade		= Resources.sprite_load(NAMESPACE, "NemCommandoGrenade", path.combine(SPRITE_PATH, "grenade.png"), 8, 9, 9)
gm.sprite_set_bbox_mode(sprite_grenade, 2) -- manual
gm.sprite_set_bbox(sprite_grenade, 1, 1, 16, 16) -- reduce hitbox by 1px on each side
local sprite_explosion		= Resources.sprite_load(NAMESPACE, "NemCommandoExplosion", path.combine(SPRITE_PATH, "grenade_explosion.png"), 5, 117, 102)
local sprite_rocket			= Resources.sprite_load(NAMESPACE, "NemCommandoRocket", path.combine(SPRITE_PATH, "rocket.png"), 3, 33, 10)
local sprite_rocket_mask	= Resources.sprite_load(NAMESPACE, "NemCommandoRocketMask", path.combine(SPRITE_PATH, "rocketMask.png"), 1, 0, 2)

local sprite_log			= Resources.sprite_load(NAMESPACE, "NemCommandoLog", path.combine(SPRITE_PATH, "log.png"))

local sound_select			= Resources.sfx_load(NAMESPACE, "UISurvivorsNemCommando", path.combine(SOUND_PATH, "select.ogg"))
local sound_slash			= Resources.sfx_load(NAMESPACE, "NemCommandoGash", path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_grenade_prime	= Resources.sfx_load(NAMESPACE, "NemCommandoGrenadePrime", path.combine(SOUND_PATH, "grenade_prime.ogg"))
local sound_grenade_throw	= Resources.sfx_load(NAMESPACE, "NemCommandoGrenadeThrow", path.combine(SOUND_PATH, "grenade_throw.ogg"))
local sound_grenade_bounce	= Resources.sfx_load(NAMESPACE, "NemCommandoGrenadeBounce", path.combine(SOUND_PATH, "grenade_bounce.ogg"))
local sound_rocket_fire		= Resources.sfx_load(NAMESPACE, "NemCommandoRocketFire", path.combine(SOUND_PATH, "rocket_fire.ogg"))

-- secondary skill tracer
local particleTracer = Particle.find("ror", "WispGTracer")
-- grenade fx
local particleRubble2 = Particle.find("ror", "Rubble2")
local particleTrail = Particle.find("ror", "PixelDust")
-- rocket fx
local particleRocketTrail = Particle.find("ror", "MissileTrailSuper")
local particleRubble1 = Particle.find("ror", "Rubble1")
local particleSpark = Particle.find("ror", "Spark")

local nemCommando = Survivor.new(NAMESPACE, "nemesisCommando")
local nemCommando_id = nemesisCommando

nemCommando.sprite_portrait = sprite_portrait
nemCommando.sprite_portrait_small = sprite_portrait_small
nemCommando.select_sound_id = sound_select

local ATTACK_TAG_APPLY_WOUND = 1
local ATTACK_TAG_EXTEND_WOUND = 2
local WOUND_DEBUFF_DURATION = 6 * 60

local GRENADE_FUSE_TIMER = 2 * 60
local GRENADE_TICK_INTERVAL = 30
local GRENADE_THROW_XSPEED = 4
local GRENADE_THROW_YSPEED = -6
local GRENADE_TOSS_XSPEED = 3
local GRENADE_TOSS_YSPEED = -3
local GRENADE_VELOCITY_INHERIT_MULT = 1
local GRENADE_AUTOTHROW_THRESHOLD = 1
local GRENADE_SELFSTUN_THRESHOLD = 15

local ROCKET_SPEED_START = 0
local ROCKET_SPEED_MAX = 24
local ROCKET_ACCELERATION = 0.35

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
	death = sprite_death,
	decoy = sprite_decoy,

	drone_idle = sprite_drone_idle,
	drone_shoot = sprite_drone_shoot,
})

nemCommando:set_cape_offset(0, -8, 0, -8)
nemCommando:set_primary_color(Color.from_rgb(250, 40, 40))

nemCommando.sprite_loadout = sprite_select
nemCommando.sprite_idle = sprite_idle
nemCommando.sprite_title = sprite_walk
nemCommando.sprite_credits = sprite_credits

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

local function nemmando_update_strafe(actor)
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
nemCommandoPrimary:set_skill_icon(sprite_skills, 0)
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

		actor.z_count = actor.z_count + 1 -- this is part of heaven cracker and has to be run shared for reasons

		-- has to be host-side instead of authority-side because of the wounding thing uughhhhhhhhhhhh
		if gm._mod_net_isHost() then
			local damage = actor:skill_get_damage(nemCommandoPrimary)
			local direction = actor:skill_util_facing_direction()

			-- skill_util_update_heaven_cracker runs is_authority internally
			-- and so we have to manually recreate it to fire the drill host-side, to make it inflict wound, because otherwise it wont work for clients
			-- ohhhhh the misery
			local heaven_cracker_count = actor:item_stack_count(Item.find("ror", "heavenCracker"))
			local cracker_shot = false

			if heaven_cracker_count > 0 and actor.z_count >= 5 - heaven_cracker_count then
				cracker_shot = true
				actor.z_count = 0
			end

			for i=0, actor:buff_stack_count(Buff.find("ror", "shadowClone")) do
				local attack_info
				if cracker_shot then
					attack_info = actor:fire_bullet(actor.x, actor.y, 700, direction, damage, 1, gm.constants.sSparks1, Attack_Info.TRACER.drill).attack_info
				else
					attack_info = actor:fire_explosion(actor.x + actor.image_xscale * 30, actor.y, 100, 65, damage, nil, gm.constants.sSparks9r).attack_info
				end
				attack_info.climb = i * 8 * 1.35
				attack_info.__ssr_nemmando_wound = ATTACK_TAG_APPLY_WOUND
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
	local attack_tag = hit_info.attack_info.__ssr_nemmando_wound
	if attack_tag then
		local victim = hit_info.target

		if attack_tag == ATTACK_TAG_APPLY_WOUND then
			if victim:buff_stack_count(wound) == 0 then
				--victim:buff_apply(wound, 6 * 60) -- doesn't work correctly (????????)
				GM.apply_buff(victim, wound, 6 * 60, 1)
			else
				GM.set_buff_time(victim, wound, WOUND_DEBUFF_DURATION)
			end
		elseif attack_tag == ATTACK_TAG_EXTEND_WOUND then
			if victim:buff_stack_count(wound) > 0 then
				--GM.apply_buff(victim, wound, 6 * 60, 1)
				GM.set_buff_time(victim, wound, WOUND_DEBUFF_DURATION)
			end
		end
	end
end)

-- Single Tap
nemCommandoSecondary:set_skill_icon(sprite_skills, 1)
nemCommandoSecondary.cooldown = 2 * 60
nemCommandoSecondary.damage = 2.0
nemCommandoSecondary.max_stock = 4
-- is_primary makes the skill's cooldown reduced by attack speed, but also removes cooldown timer on HUD, and causes other unintuitive issues. is it worth?
--nemCommandoSecondary.is_primary = true
nemCommandoSecondary.hold_facing_direction = true

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
	particleTracer:set_direction(dir, dir, 0, 0)

	local px = x1
	local py = y1
	local i = 0
	while i < dist do
		particleTracer:create_colour(px, py, tracer_color, 1)
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
	nemmando_update_strafe(actor)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wBullet2, 1, 1.4 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(nemCommandoSecondary)
			local dir = actor:skill_util_facing_direction()

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y, 1400, dir, damage, nil, gm.constants.sSparks23r, tracer).attack_info
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

-- Distant Gash
local objSlash = Object.new(NAMESPACE, "NemmandoSlash")
objSlash.obj_sprite = sprite_gash

nemCommandoSecondary2 = Skill.new(NAMESPACE, "nemesisCommandoX2")
nemCommando:add_secondary(nemCommandoSecondary2)

nemCommandoSecondary2:set_skill_icon(sprite_skills, 2)
nemCommandoSecondary2.cooldown = 3 * 60

local stateNemCommandoSecondary2 = State.new(NAMESPACE, "nemCommandoSecondary2")

nemCommandoSecondary2:clear_callbacks()
nemCommandoSecondary2:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSecondary2)
end)

stateNemCommandoSecondary2:clear_callbacks()
stateNemCommandoSecondary2:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0

	nemmando_update_sprites(actor, false)

	actor:sound_play(gm.constants.wMercenary_Parry_Deflection, 0.8, 1.1)
end)
stateNemCommandoSecondary2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2b, 0.25)

	if actor.image_index >= 4 and data.fired == 0 then
		data.fired = 1

		local buff_shadow_clone = Buff.find("ror", "shadowClone")
		for i=0, actor:buff_stack_count(buff_shadow_clone) do
			local slash = objSlash:create(actor.x - i * 12 * actor.image_xscale, actor.y)
			slash.parent = actor
			slash.team = actor.team
			slash.direction = actor:skill_util_facing_direction()
			slash.image_xscale = actor.image_xscale
			slash.depth = slash.depth + i

			if i > 0 then
				slash.image_blend = Color.DKGRAY
			end
		end

		actor:screen_shake(2)
		actor:sound_play(sound_slash, 1, 0.9 + math.random() * 0.1)
		actor:sound_play(gm.constants.wMercenaryShoot1_2, 0.7, 0.6 + math.random() * 0.1)
	end

	actor:skill_util_exit_state_on_anim_end()
end)
stateNemCommandoSecondary2:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 8 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

objSlash:clear_callbacks()
objSlash:onCreate(function(inst)
	inst.image_speed = 0.25
	inst.speed = 10
	inst.parent = -4

	local data = inst:get_data()
	data.hit_list = {}
	data.lifetime = 80
end)
objSlash:onStep(function(inst)
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end

	local data = inst:get_data()

	data.lifetime = data.lifetime - 1
	if data.lifetime < 0 then
		inst:destroy()
		return
	end

	if data.lifetime % 8 == 0 then
		local trail = GM.instance_create(inst.x, inst.y, gm.constants.oEfTrail)
		trail.sprite_index = inst.sprite_index
		trail.image_index = inst.image_index
		trail.image_blend = gm.merge_colour(inst.image_blend, Color.BLACK, 0.5)
		trail.image_xscale = inst.image_xscale
		trail.image_yscale = inst.image_yscale
		trail.depth = inst.depth + 1
	end

	local scale = math.min(1, data.lifetime / 40)

	inst.image_yscale = scale

	if math.random() < 0.5 and data.lifetime > 10 then
		particleTracer:set_direction(inst.direction, inst.direction, 0, 0)
		particleTracer:create_colour(inst.x, inst.y + gm.random_range(-20, 20) * scale, tracer_color, 1)
	end

	local actors = inst:get_collisions(gm.constants.pActorCollisionBase)

	for _, actor in ipairs(actors) do
		if inst:attack_collision_canhit(actor) and not data.hit_list[actor.id] then
			if gm._mod_net_isHost() then
				local attack = inst.parent:fire_direct(actor, 0.9, inst.direction, inst.x, inst.y, gm.constants.sBite3).attack_info
				attack.__ssr_nemmando_wound = ATTACK_TAG_APPLY_WOUND
			end

			inst:sound_play(gm.constants.wMercenaryShoot1_3, 0.5, 0.9)
			data.hit_list[actor.id] = true
		end
	end
end)

nemCommandoUtility:set_skill_icon(sprite_skills, 3)
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
	local special_id = State.find(NAMESPACE, "nemCommandoSpecial").value
	local data = actor.actor_state_current_data_table
	if actor.actor_state_current_id == special_id and (data.primed == 1 or data.tossed == 1) then
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
objGrenade.obj_sprite = sprite_grenade

local nemCommandoSpecialBoosted = Skill.new(NAMESPACE, "nemesisCommandoVBoosted")

nemCommandoSpecial:set_skill_icon(sprite_skills, 4)
nemCommandoSpecial:set_skill_upgrade(nemCommandoSpecialBoosted)
nemCommandoSpecial.cooldown = 6 * 60
nemCommandoSpecial.require_key_press = true

nemCommandoSpecialBoosted:set_skill_icon(sprite_skills, 5)
nemCommandoSpecialBoosted.cooldown = 6 * 60
nemCommandoSpecialBoosted.require_key_press = true

local stateNemCommandoSpecial = State.new(NAMESPACE, "nemCommandoSpecial")

nemCommandoSpecial:clear_callbacks()
nemCommandoSpecial:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSpecial)
end)
nemCommandoSpecialBoosted:clear_callbacks()
nemCommandoSpecialBoosted:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSpecial)
end)

stateNemCommandoSpecial:clear_callbacks()
stateNemCommandoSpecial:onEnter(function(actor, data)
	actor:skill_util_strafe_init()

	actor.image_index2 = 0
	actor.sprite_index2 = sprite_shoot4_1

	data.fuse_timer = GRENADE_FUSE_TIMER
	data.primed = 0
	data.tossed = 0
	data.low_toss = 0
	data.blip = 0
end)
stateNemCommandoSpecial:onStep(function(actor, data)
	local animation_speed = 0.25 * actor.attack_speed

	actor:skill_util_strafe_update(animation_speed, 0.75)
	actor:skill_util_step_strafe_sprites()

	nemmando_update_strafe(actor)

	if data.primed == 1 then
		if data.fuse_timer % GRENADE_TICK_INTERVAL == 0 then
			actor:sound_play(gm.constants.wPickupOLD, 0.7, 4)

			local flash = GM.instance_create(actor.x, actor.y, gm.constants.oEfFlash)
			flash.parent = actor
			flash.rate = 0.1
			flash.image_alpha = 0.5
		end
		data.fuse_timer = data.fuse_timer - 1
	end

	if data.tossed == 0 then
		if data.primed == 0 and actor.image_index2 >= 2 then
			data.primed = 1
			actor:sound_play(sound_grenade_prime, 1, 1)
		end

		if actor.image_index2 >= 5 and (data.fuse_timer - 4) % GRENADE_TICK_INTERVAL == 0 then
			data.blip = 1
		end

		if data.blip == 0 and actor.image_index2 >= 6 then
			actor.image_index2 = 5
		elseif data.blip == 1 and actor.image_index2 >= 10 then
			actor.image_index2 = 5
			data.blip = 0
		end

		if actor.image_index2 >= 4 then
			local release = not actor:control("skill4", 0)
			if not actor:is_authority() then
				-- for online purposes -- see below on wtf this means
				release = gm.bool(actor.activity_var2)
			end
			local low_toss = gm.bool(actor.ropeDown)
			local auto_toss = data.fuse_timer <= GRENADE_AUTOTHROW_THRESHOLD

			if (release or low_toss or auto_toss) and data.tossed == 0 then
				if gm._mod_net_isOnline() then
					-- magical bullshit to sync grenade releasing
					-- so the thing is, there's no way to tell if another player is holding down their skill input.
					-- so to actually sync this, i use the game's own message system to send a vanilla packet -- id 43: "set_activity_var2"
					-- this packet sets the activity_var2 variable on the actor when received. so this way we can inform the host/other clients that a nemmando released his grenade.
					-- it also sets the actor's xscale i guess
					if gm._mod_net_isHost() then
						-- args: [not sure], packet id, object index, net id, value to write to activity_var2, actor xscale
						gm.server_message_send(0, 43, actor:get_object_index_self(), actor.m_id, 1, gm.sign(actor.image_xscale))
					else
						-- args: packet id, value to write to activity_var2, actor xscale
						gm.client_message_send(43, 1, gm.sign(actor.image_xscale))
					end
				end

				actor.image_index2 = 0
				if low_toss then
					actor.sprite_index2 = sprite_shoot4_2b
				else
					actor.sprite_index2 = sprite_shoot4_2a
				end
				actor:sound_play(sound_grenade_throw, 1, 1.0 + math.random() * 0.2)

				data.tossed = 1
				data.primed = 0

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
				nade.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
				nade.timer = data.fuse_timer
				if nade.timer <= GRENADE_SELFSTUN_THRESHOLD then
					nade.stun_parent = 1
				end
			end
		end
	else
		if actor.image_index2 >= 6 then
			actor:skill_util_reset_activity_state()
		end
	end
end)
stateNemCommandoSpecial:onExit(function(actor, data)
	-- release the grenade if the state was exited for any reason prior to release
	if data.tossed == 0 then
		local nade = objGrenade:create(actor.x, actor.y - 5)

		--nade.hspeed = GRENADE_TOSS_XSPEED * actor.image_xscale
		nade.vspeed = GRENADE_TOSS_YSPEED

		nade.hspeed = nade.hspeed + actor.pHspeed * GRENADE_VELOCITY_INHERIT_MULT
		nade.vspeed = nade.vspeed + actor.pVspeed * GRENADE_VELOCITY_INHERIT_MULT

		nade.parent = actor
		nade.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
		nade.timer = data.fuse_timer
		if nade.timer <= GRENADE_SELFSTUN_THRESHOLD then
			nade.stun_parent = 1
		end
	end
	actor:skill_util_strafe_exit()
end)

objGrenade:clear_callbacks()
objGrenade:onCreate(function(inst)
	inst.image_speed = 1
	inst.gravity = 0.4
	inst.bounces = 3

	inst.parent = -4
	inst.damage = 7
	inst.timer = GRENADE_FUSE_TIMER
	inst.stun_parent = 0
	inst.scepter = 0
end)
objGrenade:onStep(function(inst)
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end
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
			inst:sound_play(sound_grenade_bounce, 0.8, 1 + 1 / (inst.speed))
			inst.image_speed = inst.image_speed * 0.6

			if bounce_h and bounce_v then
				inst:sound_play(gm.constants.wReflect, 1, 2)
			end
		end

		if inst.bounces <= 0 then
			inst.gravity = 0
			inst:move_contact_solid(270, inst.speed)
			inst.speed = 0
			inst.image_speed = 0
		end
	end

	if math.random() < 0.5 then
		particleTrail:create_color(inst.x, inst.y, 0x454efc, 1, Particle.SYSTEM.below)
	end

	if inst.timer % GRENADE_TICK_INTERVAL == 0 then
		inst:sound_play(gm.constants.wPickupOLD, 0.7, 4)

		local ef = GM.instance_create(0, 0, gm.constants.oEfFlash)
		ef.parent = inst
		ef.image_blend = 0x454efc
		ef.rate = 0.2
	end

	inst.timer = inst.timer - 1

	if inst.timer <= 0 then
		inst:destroy()
	end
end)

objGrenade:onDestroy(function(inst)
	local parent = inst.parent
	if not Instance.exists(parent) then return end

	particleRubble2:create(inst.x, inst.y, 15)
	local ef = gm.instance_create(inst.x, inst.y, gm.constants.oEfExplosion)
	ef.sprite_index = sprite_explosion

	inst:sound_play(gm.constants.wBanditShoot2Explo, 1, 1 + math.random() * 0.2)
	inst:screen_shake(4)

	local boosted = inst.scepter > 0

	if parent:is_authority() then
		local buff_shadow_clone = Buff.find("ror", "shadowClone")
		for i=0, parent:buff_stack_count(buff_shadow_clone) do
			local attack = parent:fire_explosion(inst.x, inst.y, 192, 160, inst.damage).attack_info
			attack.climb = i * 8 * 1.35

			if boosted then
				attack.stun = 1
			end
		end
	end

	if inst.stun_parent == 1 then
		-- this occurs host-side
		GM.actor_knockback_inflict(parent, 1, -parent.image_xscale, 60)
	end

	if boosted then
		-- this doesn't sync, but it doesn't matter because the client that threw them is the one that fires the attacks, and it'll feel fine for them
		for i=-1, 1 do
			local nade = objGrenade:create(inst.x, inst.y)
			nade.timer = GRENADE_FUSE_TIMER * (0.4 + math.random() * 0.1 - i * 0.05)
			nade.parent = parent
			nade.damage = 1.5
			nade.direction = 90 + i * 45
			nade.speed = 5 + math.random(2)

			nade.hspeed = nade.hspeed + inst.hspeed
			nade.vspeed = nade.vspeed + inst.vspeed
		end
	end
end)

-- Devastator
local objRocket = Object.new(NAMESPACE, "NemmandoRocket")
objRocket.obj_sprite = sprite_rocket

local nemCommandoSpecial2 = Skill.new(NAMESPACE, "nemesisCommandoV2")
local nemCommandoSpecial2Boosted = Skill.new(NAMESPACE, "nemesisCommandoV2Boosted")

nemCommando:add_special(nemCommandoSpecial2)

nemCommandoSpecial2:set_skill_icon(sprite_skills, 6)
nemCommandoSpecial2:set_skill_upgrade(nemCommandoSpecial2Boosted)
nemCommandoSpecial2.cooldown = 6 * 60
nemCommandoSpecial2.disable_aim_stall = true
nemCommandoSpecial2Boosted:set_skill_icon(sprite_skills, 7)
nemCommandoSpecial2Boosted.cooldown = 6 * 60
nemCommandoSpecial2Boosted.max_stock = 2
nemCommandoSpecial2Boosted.disable_aim_stall = true

local stateNemCommandoSpecial2 = State.new(NAMESPACE, "nemCommandoSpecial2")

nemCommandoSpecial2:clear_callbacks()
nemCommandoSpecial2:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSpecial2)
end)
nemCommandoSpecial2Boosted:clear_callbacks()
nemCommandoSpecial2Boosted:onActivate(function(actor)
	actor:enter_state(stateNemCommandoSpecial2)
end)

stateNemCommandoSpecial2:clear_callbacks()
stateNemCommandoSpecial2:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.airborne = actor.free

	if gm.bool(data.airborne) then
		actor.sprite_index = sprite_shoot4b_a
	else
		actor.sprite_index = sprite_shoot4b
	end
	actor:sound_play(sound_rocket_fire, 1, 1)
end)
stateNemCommandoSpecial2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()

	actor:actor_animation_set(actor.sprite_index, 0.2)

	local airborne = gm.bool(data.airborne)
	local should_fire = actor.image_index >= 3 or (actor.image_index >= 2 and airborne)

	if should_fire and data.fired == 0 then
		data.fired = 1

		actor:sound_play(gm.constants.wEnforcerShoot1, 1, 0.5 + math.random() * 0.1)
		actor:sound_play(gm.constants.wEnforcerGrenadeShoot, 1, 0.9 + math.random() * 0.2)
		actor:screen_shake(3)

		if actor:is_authority() then
			-- fire backblast. there's zero reason for this to exist, but it's funny!
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local backblast = actor:fire_explosion(actor.x - 50 * actor.image_xscale, actor.y-12, 100, 60, 1.0)
				if airborne then
					-- rotate explosion attack ... cursed, but funny
					backblast.image_angle = actor.image_xscale * -45
					backblast.y = backblast.y - 50
				end
				backblast.attack_info.climb = i * 8 * 1.35
				backblast.attack_info.knockback = 4
				backblast.attack_info.knockback_direction = -actor.image_xscale
			end
		end

		local rocket = objRocket:create(actor.x + 8 * actor.image_xscale, actor.y - 8)
		rocket.parent = actor
		rocket.direction = actor:skill_util_facing_direction()
		rocket.image_xscale = actor.image_xscale
		rocket.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))

		actor.pHspeed = actor.pHspeed + actor.pHmax * -2 * actor.image_xscale
		if airborne then
			rocket.direction = 270 + actor.image_xscale * 45

			actor.pVspeed = actor.pVmax * -1.2
			actor.force_jump_held = true
		end

		rocket.image_angle = rocket.direction
		if actor.image_xscale < 0 then
			rocket.image_angle = rocket.image_angle - 180
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

objRocket:clear_callbacks()
objRocket:onCreate(function(inst)
	inst.speed = ROCKET_SPEED_START
	inst.mask_index = sprite_rocket_mask

	inst.team = 1
	inst.parent = -4
	inst.victim = -4
	inst.scepter = 0

	inst.lifetime = 3 * 60
end)

objRocket:onStep(function(inst)
	local dir = inst.direction
	local xoff = gm.lengthdir_x(16, dir)
	local yoff = gm.lengthdir_y(16, dir)
	particleRocketTrail:set_orientation(dir, dir, 0, 0, 0)
	particleRocketTrail:create(inst.x - xoff, inst.y - yoff, 1, Particle.SYSTEM.above)

	inst.speed = math.min(ROCKET_SPEED_MAX, inst.speed + ROCKET_ACCELERATION)

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
	local ef = gm.instance_create(inst.x, inst.y, gm.constants.oEfExplosion)
	ef.sprite_index = gm.constants.sEfSuperMissileExplosion

	inst:sound_play(gm.constants.wTurtleExplosion, 1, 0.8 + math.random() * 0.1)
	inst:sound_play(gm.constants.wWormExplosion, 1, 0.6 + math.random() * 0.2)
	inst:sound_play(gm.constants.wExplosiveShot, 1, 1.25 + math.random() * 0.1)
	inst:screen_shake(10)

	particleRubble1:create(inst.x, inst.y, 15)
	particleSpark:create(inst.x, inst.y, 6)

	if Instance.exists(inst.parent) and inst.parent:is_authority() then
		local boosted = inst.scepter > 0

		local buff_shadow_clone = Buff.find("ror", "shadowClone")
		for i=0, inst.parent:buff_stack_count(buff_shadow_clone) do
			-- direct hit
			if inst.victim ~= -4 then
				local direct = inst.parent:fire_direct(inst.victim, 10, inst.direction, inst.x, inst.y).attack_info
				direct.climb = 8 * 1.35 * (i * 2)
			end

			-- large stunning aoe
			-- i wish i could turn off procs on this but it makes knockback not work. ughhh
			local attack = inst.parent:fire_explosion(inst.x, inst.y, 260, 260, 0.5).attack_info
			attack.stun = 1.66
			attack.knockback = 5
			attack.knockup = 5
			attack.climb = 8 * 1.35 * (i * 2 + 1)

			if boosted then
				attack.stun = attack.stun * 1.5
				attack.knockback = attack.knockback * 2
				attack.knockup = attack.knockup * 3
			end
		end
	end
end)

local nemCommandoLog = Survivor_Log.new(nemCommando, sprite_log)
