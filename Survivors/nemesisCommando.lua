local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisCommando")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisCommando")

local sprite_select			= Sprite.new("NemCommandoSelect", path.combine(SPRITE_PATH, "select.png"), 34, 28, 0)
local sprite_portrait		= Sprite.new("NemCommandoPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small	= Sprite.new("NemCommandoPortraitSmall", path.combine(SPRITE_PATH, "portraitTiny.png"))
local sprite_credits		= Sprite.new("CreditsSurvivorNemCommando", path.combine(SPRITE_PATH, "credits.png"), 1, 7, 11)
local sprite_palette 		= Sprite.new("NemCommandoPalette", path.combine(SPRITE_PATH, "palette.png"))

local sprite_idle			= Sprite.new("NemCommandoIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 15, 12)
local sprite_idle2			= Sprite.new("NemCommandoIdle2", path.combine(SPRITE_PATH, "idle2.png"), 1, 15, 12)
local sprite_idle_half		= Sprite.new("NemCommandoIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 15, 12)
-- walk sprites have a sprite speed of 0.8, the slower animation looks better
local sprite_walk			= Sprite.new("NemCommandoWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 17, 13, 0.8)
local sprite_walk2			= Sprite.new("NemCommandoWalk2", path.combine(SPRITE_PATH, "walk2.png"), 8, 15, 18, 0.8)
local sprite_walk_half		= Sprite.new("NemCommandoWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 17, 13, 0.8)
local sprite_walk_back		= Sprite.new("NemCommandoWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 20, 25, 0.8)
local sprite_walk_back2		= Sprite.new("NemCommandoWalkBack2", path.combine(SPRITE_PATH, "walkBack2.png"), 8, 20, 25, 0.8)
local sprite_jump			= Sprite.new("NemCommandoJump", path.combine(SPRITE_PATH, "jump.png"), 1, 18, 17)
local sprite_jump2			= Sprite.new("NemCommandoJump2", path.combine(SPRITE_PATH, "jump2.png"), 1, 18, 18)
local sprite_jump_half		= Sprite.new("NemCommandoJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 18, 16)
local sprite_jump_peak		= Sprite.new("NemCommandoJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 18, 17)
local sprite_jump_peak2		= Sprite.new("NemCommandoJumpPeak2", path.combine(SPRITE_PATH, "jumpPeak2.png"), 1, 18, 18)
local sprite_jump_peak_half	= Sprite.new("NemCommandoJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 18, 16)
local sprite_fall			= Sprite.new("NemCommandoFall", path.combine(SPRITE_PATH, "fall.png"), 1, 18, 17)
local sprite_fall2			= Sprite.new("NemCommandoFall2", path.combine(SPRITE_PATH, "fall2.png"), 1, 18, 18)
local sprite_fall_half		= Sprite.new("NemCommandoFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 18, 16)
local sprite_climb			= Sprite.new("NemCommandoClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 20, 18)
local sprite_death			= Sprite.new("NemCommandoDeath", path.combine(SPRITE_PATH, "death.png"), 13, 31, 9)

local sprite_shoot1_1		= Sprite.new("NemCommandoShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 28, 62)
local sprite_shoot1_2		= Sprite.new("NemCommandoShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 28, 62)
local sprite_shoot2_half	= Sprite.new("NemCommandoShoot2Half", path.combine(SPRITE_PATH, "shoot2Half.png"), 5, 15, 26)
local sprite_shoot2b		= Sprite.new("NemCommandoShoot2B", path.combine(SPRITE_PATH, "shoot2b.png"), 10, 36, 39)
local sprite_shoot3			= Sprite.new("NemCommandoShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 6, 14, 13)
local sprite_shoot4_1		= Sprite.new("NemCommandoShoot4_1", path.combine(SPRITE_PATH, "shoot4_1.png"), 10, 23, 30)
local sprite_shoot4_2a		= Sprite.new("NemCommandoShoot4_2A", path.combine(SPRITE_PATH, "shoot4_2a.png"), 6, 17, 24)
local sprite_shoot4_2b		= Sprite.new("NemCommandoShoot4_2B", path.combine(SPRITE_PATH, "shoot4_2b.png"), 6, 19, 17)
local sprite_shoot4b		= Sprite.new("NemCommandoShoot4B", path.combine(SPRITE_PATH, "shoot4b.png"), 9, 47, 33)
local sprite_shoot4b_a		= Sprite.new("NemCommandoShoot4B_A", path.combine(SPRITE_PATH, "shoot4b_a.png"), 8, 34, 27)

local sprite_decoy			= Sprite.new("NemCommandoDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 22, 18)
local sprite_drone_idle		= Sprite.new("DronePlayerNemCommandoIdle", path.combine(SPRITE_PATH, "drone_idle.png"), 5, 15, 13)
local sprite_drone_shoot	= Sprite.new("DronePlayerNemCommandoShoot", path.combine(SPRITE_PATH, "drone_shoot.png"), 5, 33, 13)

local sprite_skills			= Sprite.new("NemCommandoSkills", path.combine(SPRITE_PATH, "skills.png"), 8, 0, 0)
local sprite_gash			= Sprite.new("NemCommandoGash", path.combine(SPRITE_PATH, "gash.png"), 4, 25, 25)
local sprite_dust			= Sprite.new("NemCommandoDust", path.combine(SPRITE_PATH, "dust.png"), 3, 21, 12)
local sprite_grenade		= Sprite.new("NemCommandoGrenade", path.combine(SPRITE_PATH, "grenade.png"), 8, 9, 9)

gm.sprite_set_bbox_mode(sprite_grenade.value, 2) -- manual
gm.sprite_set_bbox(sprite_grenade.value, 1, 1, 16, 16) -- reduce hitbox by 1px on each side

local sprite_explosion		= Sprite.new("NemCommandoExplosion", path.combine(SPRITE_PATH, "grenade_explosion.png"), 5, 117, 102)
local sprite_rocket			= Sprite.new("NemCommandoRocket", path.combine(SPRITE_PATH, "rocket.png"), 3, 33, 10)
local sprite_rocket_mask	= Sprite.new("NemCommandoRocketMask", path.combine(SPRITE_PATH, "rocketMask.png"), 1, 0, 2)

local sprite_log			= Sprite.new("NemCommandoLog", path.combine(SPRITE_PATH, "log.png"))

local sound_select			= Sound.new("UISurvivorsNemCommando", path.combine(SOUND_PATH, "select.ogg"))
local sound_slash			= Sound.new("NemCommandoGash", path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_grenade_prime	= Sound.new("NemCommandoGrenadePrime", path.combine(SOUND_PATH, "grenade_prime.ogg"))
local sound_grenade_throw	= Sound.new("NemCommandoGrenadeThrow", path.combine(SOUND_PATH, "grenade_throw.ogg"))
local sound_grenade_bounce	= Sound.new("NemCommandoGrenadeBounce", path.combine(SOUND_PATH, "grenade_bounce.ogg"))
local sound_rocket_fire		= Sound.new("NemCommandoRocketFire", path.combine(SOUND_PATH, "rocket_fire.ogg"))

-- secondary skill tracer
local particleTracer = Particle.find("WispGTracer")

-- grenade fx
local particleRubble2 = Particle.find("Rubble2")
local particleTrail = Particle.find("PixelDust")

-- rocket fx
local particleRocketTrail = Particle.find("MissileTrailSuper")
local particleRubble1 = Particle.find("Rubble1")
local particleSpark = Particle.find("Spark")

local nemmando = Survivor.new("nemesisCommando")

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

nemmando:set_stats_base({
	health = 115,
	damage = 11,
	regen = 0.011,
})
nemmando:set_stats_level({
	health = 36,
	damage = 3,
	regen = 0.001,
	armor = 2,
})

local nemmando_log = SurvivorLog.new_from_survivor(nemmando)
nemmando_log.portrait_id = sprite_log

nemmando.primary_color = Color.from_rgb(250, 40, 40)

nemmando.sprite_portrait = sprite_portrait
nemmando.sprite_portrait_small = sprite_portrait_small
nemmando.sprite_loadout = sprite_select

nemmando.sprite_idle = sprite_idle
nemmando.sprite_title = sprite_walk
nemmando.sprite_credits = sprite_credits

nemmando.sprite_palette = sprite_palette
nemmando.sprite_portrait_palette = sprite_palette
nemmando.sprite_loadout_palette = sprite_palette

nemmando.select_sound_id = sound_select
nemmando.cape_offset = Array.new({0, -8, 0, -5})

--skins
nemmando:add_skin("Mk. II", 1, Sprite.new("NemCommandoSelect2", path.combine(SPRITE_PATH, "select2.png"), 34, 28, 0),
Sprite.new("NemCommandoPortrait2", path.combine(SPRITE_PATH, "portrait2.png"), 3),
Sprite.new("NemCommandoPortraitSmall2", path.combine(SPRITE_PATH, "portraitTiny2.png")))

nemmando:add_skin("Ice Blade", 2, Sprite.new("NemCommandoSelect3", path.combine(SPRITE_PATH, "select3.png"), 34, 28, 0),
Sprite.new("NemCommandoPortrait3", path.combine(SPRITE_PATH, "portrait3.png"), 3),
Sprite.new("NemCommandoPortraitSmall3", path.combine(SPRITE_PATH, "portraitTiny3.png")))

nemmando:add_skin("Nature's Gift", 3, Sprite.new("NemCommandoSelect4", path.combine(SPRITE_PATH, "select4.png"), 34, 28, 0),
Sprite.new("NemCommandoPortrait4", path.combine(SPRITE_PATH, "portrait4.png"), 3),
Sprite.new("NemCommandoPortraitSmall4", path.combine(SPRITE_PATH, "portraitTiny4.png")))

nemmando:add_skin("Callback", 4, Sprite.new("NemCommandoSelect5", path.combine(SPRITE_PATH, "select5.png"), 34, 28, 0),
Sprite.new("NemCommandoPortrait5", path.combine(SPRITE_PATH, "portrait5.png"), 3),
Sprite.new("NemCommandoPortraitSmall5", path.combine(SPRITE_PATH, "portraitTiny5.png")))

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

Callback.add(nemmando.on_init, function(actor)
	actor.sprite_idle_half = Array.new({sprite_idle, sprite_idle_half, 0})
	actor.sprite_walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk_back})
	actor.sprite_jump_half = Array.new({sprite_jump, sprite_jump_half, 0})
	actor.sprite_jump_peak_half = Array.new({sprite_jump_peak, sprite_jump_peak_half, 0})
	actor.sprite_fall_half = Array.new({sprite_fall, sprite_fall_half, 0})
	
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_climb = sprite_climb
	actor.sprite_death = sprite_death
	actor.sprite_decoy = sprite_decoy
	actor.sprite_drone_idle = sprite_drone_idle
	actor.sprite_drone_shoot = sprite_drone_shoot

	actor:survivor_util_init_half_sprites()
end)

-- default skills
local primary = nemmando:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = nemmando:get_skills(Skill.Slot.SECONDARY)[1]
local utility = nemmando:get_skills(Skill.Slot.UTILITY)[1]
local special = nemmando:get_skills(Skill.Slot.SPECIAL)[1]
local specialS = Skill.new("nemesisCommandoVBoosted")

-- alt secondary
local secondary2 = Skill.new("nemesisCommandoX2")
nemmando:add_skill(Skill.Slot.SECONDARY, secondary2)

-- alt special 
local special2 = Skill.new("nemesisCommandoV2")
local special2S = Skill.new("nemesisCommandoV2Boosted")
nemmando:add_skill(Skill.Slot.SPECIAL, special2)

-- Blade of Cessation
primary.sprite = sprite_skills
primary.subimage = 0
primary.cooldown = 10
primary.damage = 1.2
primary.required_interrupt_priority = ActorState.InterruptPriority.ANY

local statePrimary = ActorState.new("nemCommandoPrimary")

Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary)
end)

Callback.add(statePrimary.on_enter, function(actor, data)
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

Callback.add(statePrimary.on_step, function(actor, data)
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
			local damage = actor:skill_get_damage(primary)
			local direction = actor:skill_util_facing_direction()

			-- skill_util_update_heaven_cracker runs is_authority internally
			-- and so we have to manually recreate it to fire the drill host-side, to make it inflict wound, because otherwise it wont work for clients
			-- ohhhhh the misery
			local heaven_cracker_count = actor:item_count(Item.find("heavenCracker"))
			local cracker_shot = false

			if heaven_cracker_count > 0 and actor.z_count >= 5 - heaven_cracker_count then
				cracker_shot = true
				actor.z_count = 0
			end

			for i=0, actor:buff_count(Buff.find("shadowClone")) do
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

Callback.add(statePrimary.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 4 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	end
end)

local wound = Buff.find("commandoWound")

Callback.add(Callback.ON_ATTACK_HIT, function(hit_info)
	local attack_tag = hit_info.attack_info.__ssr_nemmando_wound
	if attack_tag then
		local victim = hit_info.target

		if attack_tag == ATTACK_TAG_APPLY_WOUND then
			if victim:buff_count(wound) == 0 then
				GM.apply_buff(victim, wound, 6 * 60, 1)
			else
				GM.set_buff_time(victim, wound, WOUND_DEBUFF_DURATION)
			end
		elseif attack_tag == ATTACK_TAG_EXTEND_WOUND then
			if victim:buff_count(wound) > 0 then
				GM.set_buff_time(victim, wound, WOUND_DEBUFF_DURATION)
			end
		end
	end
end)

-- Single Tap
secondary.sprite = sprite_skills
secondary.subimage = 1
secondary.cooldown = 2 * 60
secondary.damage = 2.0
secondary.max_stock = 4
secondary.hold_facing_direction = true

local tracer = Tracer.new("nemCommandoSingleTap")
tracer.sparks_offset_y = -8

tracer:set_callback(function(x1, y1, x2, y2, color)
	y1 = y1 - 8
	y2 = y2 - 8

	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	-- tracer
	local t = GM.instance_create(x1, y1, gm.constants.oEfProjectileTracer)
	t.direction = dir
	t.speed = 60
	t.length = 80
	t.blend_1 = Color.from_rgb(252, 118, 98)
	t.blend_2 = Color.from_rgb(252, 118, 98)
	t:alarm_set(0, math.max(1, dist / t.speed))

	-- particles
	particleTracer:set_direction(dir, dir, 0, 0)

	local px = x1
	local py = y1
	local i = 0
	while i < dist do
		particleTracer:create_colour(px, py, Color.from_rgb(252, 118, 98), 1)
		px = px + gm.lengthdir_x(15, dir)
		py = py + gm.lengthdir_y(15, dir)
		i = i + 15
	end
end)

local stateSecondary = ActorState.new("nemCommandoSecondary")

Callback.add(secondary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary)
end)

Callback.add(stateSecondary.on_enter, function(actor, data)
	actor.image_index2 = 0
	data.fired = 0

	nemmando_update_sprites(actor, true)

	actor:skill_util_strafe_init()
	--actor:skill_util_strafe_turn_init() -- this and skill_util_strafe_turn_update only works for skills in the Z/primary slot ....
end)

Callback.add(stateSecondary.on_step, function(actor, data)
	actor.sprite_index2 = sprite_shoot2_half

	actor:skill_util_strafe_update(0.25 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	--actor:skill_util_strafe_turn_update()
	nemmando_update_strafe(actor)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wBullet2, 1, 1.4 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(secondary)
			local dir = actor:skill_util_facing_direction()

			local buff_shadow_clone = Buff.find("shadowClone")
			for i=0, actor:buff_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y, 1400, dir, damage, nil, gm.constants.sSparks23r, tracer).attack_info
				attack_info.climb = i * 8
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(stateSecondary.on_exit, function(actor, data)
	actor:skill_util_strafe_exit()
end)

Callback.add(stateSecondary.on_get_interrupt_priority, function(actor, data)
	if actor.image_index2 + 0.25 * actor.attack_speed >= 3 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	end
end)

-- Distant Gash
local objSlash = Object.new("NemmandoSlash")
objSlash:set_sprite(sprite_gash)

secondary2.sprite = sprite_skills
secondary2.subimage = 2
secondary2.cooldown = 3 * 60

local stateSecondary2 = ActorState.new("nemCommandoSecondary2")

Callback.add(secondary2.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary2)
end)

Callback.add(stateSecondary2.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0

	nemmando_update_sprites(actor, false)

	actor:sound_play(gm.constants.wMercenary_Parry_Deflection, 0.8, 1.1)
end)

Callback.add(stateSecondary2.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2b, 0.25)

	if actor.image_index >= 4 and data.fired == 0 then
		data.fired = 1

		local buff_shadow_clone = Buff.find("shadowClone")
		for i=0, actor:buff_count(buff_shadow_clone) do
			local slash = objSlash:create(actor.x - i * 12 * actor.image_xscale, actor.y)
			slash.parent = actor
			slash.team = actor.team
			slash.direction = actor:skill_util_facing_direction()
			slash.image_xscale = actor.image_xscale
			slash.depth = slash.depth + i
			slash:actor_skin_skinnable_set_skin(actor)

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

Callback.add(stateSecondary2.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 8 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	end
end)

Callback.add(objSlash.on_create, function(inst)
	inst.image_speed = 0.25
	inst.speed = 10
	inst.parent = -4

	local data = Instance.get_data(inst)
	data.hit_list = {}
	data.lifetime = 80
	
	inst:actor_skin_skinnable_init()
end)

Callback.add(objSlash.on_step, function(inst)
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end

	local data = Instance.get_data(inst)

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
		trail:actor_skin_skinnable_set_skin(inst.parent)
	end

	local scale = math.min(1, data.lifetime / 40)

	inst.image_yscale = scale

	if math.random() < 0.5 and data.lifetime > 10 then
		particleTracer:set_direction(inst.direction, inst.direction, 0, 0)
		particleTracer:create_colour(inst.x, inst.y + gm.random_range(-20, 20) * scale, Color.from_rgb(252, 118, 98), 1)
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

Callback.add(objSlash.on_draw, function(inst)
	inst:actor_skin_skinnable_draw_self()
end)

-- Tactical Roll
utility.sprite = sprite_skills
utility.subimage = 3
utility.cooldown = 3 * 60
utility.max_stock = 2
utility.override_strafe_direction = true
utility.ignore_aim_direction = true
utility.is_utility = true

local stateUtility = ActorState.new("nemCommandoUtility")
stateUtility.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL

Callback.add(utility.on_activate, function(actor, skill, slot)
	actor:set_state(stateUtility)
end)

Callback.add(utility.on_can_activate, function(actor, skill, slot)
	local special_id = ActorState.find("nemCommandoSpecial").value
	local data = actor.actor_state_current_data_table
	if actor.actor_state_current_id == special_id and (data.primed == 1 or data.tossed == 1) then
		return true
	end
end)

Callback.add(stateUtility.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(stateUtility.on_step, function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.25, false)

	actor.pHspeed = 2.5 * actor.pHmax * actor.image_xscale
	actor.invincible = math.max(3, actor.invincible)

	if data.fired == 0 then
		data.fired = 1

		local current_secondary = actor:get_active_skill(Skill.Slot.SECONDARY)

		if current_secondary.skill_id == secondary.value then
			if current_secondary.stock < secondary.max_stock then
				actor:sound_play(gm.constants.wSniperReload, 0.8, 1.5)
			end

			GM.actor_skill_add_stock(actor, Skill.Slot.SECONDARY)
			GM.actor_skill_add_stock(actor, Skill.Slot.SECONDARY)
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

local objGrenade = Object.new("NemmandoGrenade")
objGrenade:set_sprite(sprite_grenade)

special.sprite = sprite_skills
special.subimage = 4
special.upgrade_skill = specialS
special.cooldown = 6 * 60

specialS.sprite = sprite_skills
specialS.subimage = 5
specialS.cooldown = 6 * 60

local stateSpecial = ActorState.new("nemCommandoSpecial")

Callback.add(special.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)

Callback.add(specialS.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)

Callback.add(stateSpecial.on_enter, function(actor, data)
	actor:skill_util_strafe_init()

	actor.image_index2 = 0
	actor.sprite_index2 = sprite_shoot4_1

	data.fuse_timer = GRENADE_FUSE_TIMER
	data.primed = 0
	data.tossed = 0
	data.low_toss = 0
	data.blip = 0
end)

Callback.add(stateSpecial.on_step, function(actor, data)
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
			local release = not Util.bool(actor.v_skill)
			if not actor:is_authority() then
				-- for online purposes -- see below on wtf this means
				release = Util.bool(actor.activity_var2)
			end
			local low_toss = Util.bool(actor.ropeDown)
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
				Instance.get_data(nade).scepter = actor:item_count(Item.find("ancientScepter"))
				Instance.get_data(nade).timer = data.fuse_timer
				if Instance.get_data(nade).timer <= GRENADE_SELFSTUN_THRESHOLD then
					Instance.get_data(nade).stun_parent = 1
				end
			end
		end
	else
		if actor.image_index2 >= 6 then
			actor:skill_util_reset_activity_state()
		end
	end
end)

Callback.add(stateSpecial.on_exit, function(actor, data)
	-- release the grenade if the state was exited for any reason prior to release
	if data.tossed == 0 then
		local nade = objGrenade:create(actor.x, actor.y - 5)

		--nade.hspeed = GRENADE_TOSS_XSPEED * actor.image_xscale
		nade.vspeed = GRENADE_TOSS_YSPEED

		nade.hspeed = nade.hspeed + actor.pHspeed * GRENADE_VELOCITY_INHERIT_MULT
		nade.vspeed = nade.vspeed + actor.pVspeed * GRENADE_VELOCITY_INHERIT_MULT

		nade.parent = actor
		Instance.get_data(nade).scepter = actor:item_count(Item.find("ancientScepter"))
		Instance.get_data(nade).timer = data.fuse_timer
		if Instance.get_data(nade).timer <= GRENADE_SELFSTUN_THRESHOLD then
			Instance.get_data(nade).stun_parent = 1
		end
	end
	actor:skill_util_strafe_exit()
end)

Callback.add(objGrenade.on_create, function(inst)
	inst.image_speed = 1
	inst.gravity = 0.4
	inst.parent = -4
	
	local data = Instance.get_data(inst)
	
	data.bounces = 3
	data.damage = 7
	data.stun_parent = 0
	data.timer = GRENADE_FUSE_TIMER
	data.scepter = 0
end)

Callback.add(objGrenade.on_step, function(inst)
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end
	
	local data = Instance.get_data(inst)
	
	if data.bounces > 0 then
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
				data.bounces = data.bounces - 1
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

		if data.bounces <= 0 then
			inst.gravity = 0
			inst:move_contact_solid(270, inst.speed)
			inst.speed = 0
			inst.image_speed = 0
		end
	end

	if math.random() < 0.5 then
		particleTrail:create_color(inst.x, inst.y, Color.from_hex(0x454EFC), 1, Particle.System.BELOW)
	end

	if data.timer % GRENADE_TICK_INTERVAL == 0 then
		inst:sound_play(gm.constants.wPickupOLD, 0.7, 4)

		local ef = GM.instance_create(0, 0, gm.constants.oEfFlash)
		ef.parent = inst
		ef.image_blend = Color.from_hex(0x454EFC)
		ef.rate = 0.2
	end

	data.timer = data.timer - 1

	if data.timer <= 0 then
		inst:destroy()
	end
end)

Callback.add(objGrenade.on_destroy, function(inst)
	local parent = inst.parent
	if not Instance.exists(parent) then return end
	
	local data = Instance.get_data(inst)

	particleRubble2:create(inst.x, inst.y, 15)
	
	local ef = Object.find("EfExplosion"):create(inst.x, inst.y)
	ef.sprite_index = sprite_explosion

	inst:sound_play(gm.constants.wBanditShoot2Explo, 1, 1 + math.random() * 0.2)
	inst:screen_shake(4)

	local boosted = data.scepter > 0

	if parent:is_authority() then
		local buff_shadow_clone = Buff.find("shadowClone")
		for i=0, parent:buff_count(buff_shadow_clone) do
			local attack = parent:fire_explosion(inst.x, inst.y, 192, 160, data.damage).attack_info
			attack.climb = i * 8 * 1.35

			if boosted then
				attack.stun = 1
			end
		end
	end

	if data.stun_parent == 1 then
		-- this occurs host-side
		if gm._mod_net_isHost() then
			parent:apply_knockback(-parent.image_xscale, 60)
		end
	end

	if boosted then
		-- this doesn't sync, but it doesn't matter because the client that threw them is the one that fires the attacks, and it'll feel fine for them
		for i=-1, 1 do
			local nade = objGrenade:create(inst.x, inst.y)
			Instance.get_data(nade).timer = GRENADE_FUSE_TIMER * (0.4 + math.random() * 0.1 - i * 0.05)
			Instance.get_data(nade).damage = 1.5
			
			nade.parent = parent
			nade.direction = 90 + i * 45
			nade.speed = 5 + math.random(2)

			nade.hspeed = nade.hspeed + inst.hspeed
			nade.vspeed = nade.vspeed + inst.vspeed
		end
	end
end)

-- Devastator
local objRocket = Object.new("NemmandoRocket")
objRocket:set_sprite(sprite_rocket)

special2.sprite = sprite_skills
special2.subimage = 6
special2.upgrade_skill = special2S
special2.cooldown = 6 * 60
special2.disable_aim_stall = true
special2S.sprite = sprite_skills
special2S.subimage = 7
special2S.cooldown = 6 * 60
special2S.max_stock = 2
special2S.disable_aim_stall = true

local stateSpecial2 = ActorState.new("nemCommandoSpecial2")

Callback.add(special2.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial2)
end)

Callback.add(special2S.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial2)
end)

Callback.add(stateSpecial2.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.airborne = actor.free

	if Util.bool(data.airborne) then
		actor.sprite_index = sprite_shoot4b_a
	else
		actor.sprite_index = sprite_shoot4b
	end
	actor:sound_play(sound_rocket_fire, 1, 1)
end)

Callback.add(stateSpecial2.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()

	actor:actor_animation_set(actor.sprite_index, 0.2)

	local airborne = Util.bool(data.airborne)
	local should_fire = actor.image_index >= 3 or (actor.image_index >= 2 and airborne)

	if should_fire and data.fired == 0 then
		data.fired = 1

		actor:sound_play(gm.constants.wEnforcerShoot1, 1, 0.5 + math.random() * 0.1)
		actor:sound_play(gm.constants.wEnforcerGrenadeShoot, 1, 0.9 + math.random() * 0.2)
		actor:screen_shake(3)

		if actor:is_authority() then
			-- fire backblast. there's zero reason for this to exist, but it's funny!
			local buff_shadow_clone = Buff.find("shadowClone")
			for i=0, actor:buff_count(buff_shadow_clone) do
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
		rocket.scepter = actor:item_count(Item.find("ancientScepter"))

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

Callback.add(objRocket.on_create, function(inst)
	inst.speed = ROCKET_SPEED_START
	inst.mask_index = sprite_rocket_mask

	inst.team = 1
	inst.parent = -4
	inst.victim = -4
	inst.scepter = 0

	inst.lifetime = 3 * 60
end)

Callback.add(objRocket.on_step, function(inst)
	local dir = inst.direction
	local xoff = gm.lengthdir_x(16, dir)
	local yoff = gm.lengthdir_y(16, dir)
	
	particleRocketTrail:set_orientation(dir, dir, 0, 0, 0)
	particleRocketTrail:create(inst.x - xoff, inst.y - yoff, 1)

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

Callback.add(objRocket.on_destroy, function(inst)
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

		local buff_shadow_clone = Buff.find("shadowClone")
		for i=0, inst.parent:buff_count(buff_shadow_clone) do
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

