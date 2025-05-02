local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisCommando")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisCommando")

local sprite_idle			= Resources.sprite_load(NAMESPACE, "NemCommandoIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 15, 12)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "NemCommandoIdle2", path.combine(SPRITE_PATH, "idle2.png"), 1, 15, 12)

local sprite_walk			= Resources.sprite_load(NAMESPACE, "NemCommandoWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 17, 6, 0.8)
local sprite_walk2			= Resources.sprite_load(NAMESPACE, "NemCommandoWalk2", path.combine(SPRITE_PATH, "walk2.png"), 8, 15, 18, 0.8)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "NemCommandoJump", path.combine(SPRITE_PATH, "jump.png"), 1, 18, 17)
local sprite_jump2			= Resources.sprite_load(NAMESPACE, "NemCommandoJump2", path.combine(SPRITE_PATH, "jump2.png"), 1, 18, 18)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 18, 17)
local sprite_jump_peak2		= Resources.sprite_load(NAMESPACE, "NemCommandoJumpPeak2", path.combine(SPRITE_PATH, "jumpPeak2.png"), 1, 18, 18)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "NemCommandoFall", path.combine(SPRITE_PATH, "fall.png"), 1, 18, 17)
local sprite_fall2			= Resources.sprite_load(NAMESPACE, "NemCommandoFall2", path.combine(SPRITE_PATH, "fall2.png"), 1, 18, 18)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "NemCommandoClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 20, 18)
local sprite_death			= Resources.sprite_load(NAMESPACE, "NemCommandoDeath", path.combine(SPRITE_PATH, "death.png"), 13, 31, 9)
local sprite_aura 			= Resources.sprite_load(NAMESPACE, "NemCommandoAura", path.combine(SPRITE_PATH, "aura.png"), 1, 50, 50)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 28, 62)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 28, 62)
local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 5, 15, 26)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot2B", path.combine(SPRITE_PATH, "shoot2b.png"), 10, 36, 39)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "NemCommandoShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 6, 14, 13)
local sprite_shoot4_1		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4_1_Full", path.combine(SPRITE_PATH, "shoot4_1_full.png"), 10, 23, 30)
local sprite_shoot4_2a		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4_2A_Full", path.combine(SPRITE_PATH, "shoot4_2a_full.png"), 6, 17, 24)
local sprite_shoot4_2b		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4_2B_Full", path.combine(SPRITE_PATH, "shoot4_2b_full.png"), 6, 19, 17)
local sprite_shoot4b		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4B", path.combine(SPRITE_PATH, "shoot4b.png"), 9, 47, 33)
local sprite_shoot4b_a		= Resources.sprite_load(NAMESPACE, "NemCommandoShoot4B_A", path.combine(SPRITE_PATH, "shoot4b_a.png"), 8, 34, 27)

local sprite_gash			= Resources.sprite_load(NAMESPACE, "NemCommandoGash", path.combine(SPRITE_PATH, "gash.png"), 4, 25, 25)
local sprite_dust			= Resources.sprite_load(NAMESPACE, "NemCommandoDust", path.combine(SPRITE_PATH, "dust.png"), 3, 21, 12)
local sprite_grenade		= Resources.sprite_load(NAMESPACE, "NemCommandoGrenade", path.combine(SPRITE_PATH, "grenade.png"), 8, 9, 9)

gm.sprite_set_bbox_mode(sprite_grenade, 2)
gm.sprite_set_bbox(sprite_grenade, 1, 1, 16, 16)

local sprite_explosion		= Resources.sprite_load(NAMESPACE, "NemCommandoExplosion", path.combine(SPRITE_PATH, "grenade_explosion.png"), 5, 117, 102)
local sprite_rocket			= Resources.sprite_load(NAMESPACE, "NemCommandoRocket", path.combine(SPRITE_PATH, "rocket.png"), 3, 33, 10)
local sprite_rocket_mask	= Resources.sprite_load(NAMESPACE, "NemCommandoRocketMask", path.combine(SPRITE_PATH, "rocketMask.png"), 1, 0, 2)

local canticum_vitae_cope	= Resources.sfx_load(NAMESPACE, "NemCommandoMusic", path.combine(PATH.."/Sounds/Music", "musicVoidBoss.ogg"))
local sound_slash			= Resources.sfx_load(NAMESPACE, "NemCommandoGash", path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_grenade_prime	= Resources.sfx_load(NAMESPACE, "NemCommandoGrenadePrimeA", path.combine(SOUND_PATH, "grenade_prime.ogg"))
local sound_grenade_throw	= Resources.sfx_load(NAMESPACE, "NemCommandoGrenadeThrowA", path.combine(SOUND_PATH, "grenade_throw.ogg"))
local sound_grenade_bounce	= Resources.sfx_load(NAMESPACE, "NemCommandoGrenadeBounceA", path.combine(SOUND_PATH, "grenade_bounce.ogg"))

local particleTracer = Particle.find("ror", "WispGTracer")
local particleRubble2 = Particle.find("ror", "Rubble2")
local particleTrail = Particle.find("ror", "PixelDust")

local particleRocketTrail = Particle.find("ror", "MissileTrailSuper")
local particleRubble1 = Particle.find("ror", "Rubble1")
local particleSpark = Particle.find("ror", "Spark")

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

local nemmando = Object.new(NAMESPACE, "nemmandoEnemy", Object.PARENT.bossClassic)
nemmando.obj_sprite = sprite_idle

local function nemmando_update_sprites(actor, has_gun)
	if has_gun then
		actor.sprite_idle = sprite_idle2
		actor.sprite_walk = sprite_walk2
		actor.sprite_jump = sprite_jump2
		actor.sprite_jump_peak = sprite_jump_peak2
		actor.sprite_fall = sprite_fall2
	else
		actor.sprite_idle = sprite_idle
		actor.sprite_walk = sprite_walk
		actor.sprite_jump = sprite_jump
		actor.sprite_jump_peak = sprite_jump_peak
		actor.sprite_fall = sprite_fall
	end
	actor.sprite_walk_last = actor.sprite_walk
end

local nemmando_id = nemmando.value
nemmando:clear_callbacks()

local nemmandoAura = Object.new(NAMESPACE, "nemmandoAura")
nemmandoAura.obj_depth = 0
nemmandoAura:clear_callbacks()

nemmandoAura:onDraw(function(self)
	if self.parent.visible == 1 and self.parent.image_alpha > 0 then
		local alpha = 0.35 + math.sin(Global._current_frame * 0.03) * 0.15
		gm.draw_sprite_ext(sprite_aura, 0, self.parent.x, self.parent.y, 1, 1, 0, self.parent.image_blend, alpha)
	end
end)

local z_skill = Skill.new(NAMESPACE, "nemmandoEnemyZ")
z_skill.is_primary = true
z_skill.does_change_activity_state = true
z_skill.cooldown = 10
z_skill.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
z_skill:clear_callbacks()

local x_skill = Skill.new(NAMESPACE, "nemmandoEnemyX")
x_skill.cooldown = 2 * 60
x_skill.max_stock = 4
x_skill:clear_callbacks()

local x_skill2 = Skill.new(NAMESPACE, "nemmandoEnemyX2")
x_skill2.cooldown = 3 * 60
x_skill2:clear_callbacks()

local c_skill = Skill.new(NAMESPACE, "nemmandoEnemyC")
c_skill.cooldown = 3 * 60
c_skill.max_stock = 2
c_skill.override_strafe_direction = true
c_skill.ignore_aim_direction = true
c_skill.is_utility = true
c_skill:clear_callbacks()

local v_skill = Skill.new(NAMESPACE, "nemmandoEnemyV")
v_skill.cooldown = 6 * 60
v_skill:clear_callbacks()

local v_skill2 = Skill.new(NAMESPACE, "nemmandoEnemyV2")
local v_skill2b = Skill.new(NAMESPACE, "nemmandoEnemyV2Boosted")
v_skill2:set_skill_upgrade(v_skill2b)
v_skill2.cooldown = 6 * 60
v_skill2.disable_aim_stall = true
v_skill2b:set_skill_icon(sprite_skills, 7)
v_skill2b.cooldown = 6 * 60
v_skill2b.max_stock = 2
v_skill2b.disable_aim_stall = true

nemmando:onCreate(function(actor)
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death
	actor.sprite_climb = sprite_climb
	actor.sprite_climb_hurt = sprite_death

	actor.can_jump = true
	actor.can_rope = true
	
	actor.mask_index = sprite_walk

	actor:enemy_stats_init(14, 500, 0, 116)
	actor.hp_regen = 0.01
	actor.pHmax_base = 2.8
	actor.knockback_cap_base = actor.maxhp
	actor.fallImmunity = true
	
	actor.z_range = 100
	actor.y_range = 64
	actor.x_range = 800
	actor.c_range = 2000
	actor.v_range = 350

	actor:set_default_skill(Skill.SLOT.primary, z_skill)
	
	if Helper.chance(0.5) then
		actor:set_default_skill(Skill.SLOT.secondary, x_skill)
	else
		actor:set_default_skill(Skill.SLOT.secondary, x_skill2)
	end
	
	actor:set_default_skill(Skill.SLOT.utility, c_skill)
	
	if Helper.chance(0.5) then
		actor:set_default_skill(Skill.SLOT.special, v_skill)
	else
		actor:set_default_skill(Skill.SLOT.special, v_skill2)
	end
	
	local arr = Array.new({actor})
	local party = GM.actor_create_enemy_party_from_ids(arr)
	local director = GM._mod_game_getDirector()
	director:register_boss_party_gml_Object_oDirectorControl_Create_0(party)
	
	local aura = nemmandoAura:create(actor.x, actor.y)
	aura.parent = actor
	
	actor.music_id = Global.music_name
	Global.music_name = canticum_vitae_cope
	
	actor:init_actor_late()
end)

nemmando:onDestroy(function(actor)
	Global.music_name = actor.music_id
end)

local z = State.new(NAMESPACE, "nemCommandoEnemyPrimary")

z_skill:onActivate(function(actor)
	actor:enter_state(z)
end)
z:clear_callbacks()

z:onEnter(function(actor, data)
	actor.image_index = 0

	nemmando_update_sprites(actor, false)

	data.fired = 0
	if not data.attack_side then
		data.attack_side = 0
	end

	actor.sprite_index = sprite_shoot1_1
	if data.attack_side == 1 then
		actor.sprite_index = sprite_shoot1_2
	end
end)

z:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if actor.image_index >= 1 and data.fired == 0 then
		data.fired = 1
		data.attack_side = (data.attack_side + 1) % 2
		actor:sound_play(gm.constants.wMercenaryShoot1_1, 1, 0.75 + math.random() * 0.05)
		actor:skill_util_nudge_forward(2 * actor.image_xscale)

		local attack = actor:fire_explosion_local(actor.x + actor.image_xscale * 30, actor.y, 100, 64, 1.2, nil, gm.constants.sSparks9r)
		attack.attack_info.__ssr_nemmando_wound = ATTACK_TAG_APPLY_WOUND
	end

	actor:skill_util_exit_state_on_anim_end()
end)

z:onGetInterruptPriority(function(actor, data)
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
				GM.apply_buff(victim, wound, 6 * 60, 1)
			else
				GM.set_buff_time(victim, wound, WOUND_DEBUFF_DURATION)
			end
		elseif attack_tag == ATTACK_TAG_EXTEND_WOUND then
			if victim:buff_stack_count(wound) > 0 then
				GM.set_buff_time(victim, wound, WOUND_DEBUFF_DURATION)
			end
		end
	end
end)

local tracer_color = Color.from_rgb(252, 118, 98)
local tracer, tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	y1 = y1 - 8
	y2 = y2 - 8

	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	local t = GM.instance_create(x1, y1, gm.constants.oEfProjectileTracer)
	t.direction = dir
	t.speed = 60
	t.length = 80
	t.blend_1 = tracer_color
	t.blend_2 = tracer_color
	t:alarm_set(0, math.max(1, dist / t.speed))

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

local x = State.new(NAMESPACE, "nemCommandoEnemySecondary")

x_skill:onActivate(function(actor)
	actor:enter_state(x)
end)
x:clear_callbacks()

x:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0

	nemmando_update_sprites(actor, true)
end)

x:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2, 0.25)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wBullet2, 1, 1.4 + math.random() * 0.2)

		if gm._mod_net_isHost() then
			actor:fire_bullet(actor.x, actor.y, 1400, actor:skill_util_facing_direction(), 2, nil, gm.constants.sSparks23r, tracer)
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

x:onGetInterruptPriority(function(actor, data)
	if actor.image_index + 0.25 * actor.attack_speed >= 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

local objSlash = Object.new(NAMESPACE, "NemmandoEnemySlash")
objSlash.obj_sprite = sprite_gash
objSlash:clear_callbacks()

local x2 = State.new(NAMESPACE, "nemCommandoEnemySecondary2")
x2:clear_callbacks()

x_skill2:onActivate(function(actor)
	actor:enter_state(x2)
end)

x2:clear_callbacks()
x2:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0

	nemmando_update_sprites(actor, false)

	actor:sound_play(gm.constants.wMercenary_Parry_Deflection, 0.8, 1.1)
end)
x2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2b, 0.25)

	if actor.image_index >= 4 and data.fired == 0 then
		data.fired = 1

		local slash = objSlash:create(actor.x, actor.y)
		slash.parent = actor
		slash.team = actor.team
		slash.direction = actor:skill_util_facing_direction()
		slash.image_xscale = actor.image_xscale

		actor:screen_shake(2)
		actor:sound_play(sound_slash, 1, 0.9 + math.random() * 0.1)
		actor:sound_play(gm.constants.wMercenaryShoot1_2, 0.7, 0.6 + math.random() * 0.1)
	end

	actor:skill_util_exit_state_on_anim_end()
end)

x2:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 8 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

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

local c = State.new(NAMESPACE, "nemCommandoEnemyUtility")
c.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

c_skill:onActivate(function(actor)
	actor:enter_state(c)
end)
c:clear_callbacks()

c:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

c:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.25, false)

	actor.pHspeed = 2.5 * actor.pHmax * actor.image_xscale
	actor:set_immune(3)

	if data.fired == 0 then
		data.fired = 1

		local secondary = actor:get_active_skill(Skill.SLOT.secondary)

		if secondary.skill_id == x_skill.value then
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

local v = State.new(NAMESPACE, "nemCommandoEnemySpecial")

v_skill:onActivate(function(actor)
	actor:enter_state(v)
end)
v:clear_callbacks()

local objGrenade = Object.new(NAMESPACE, "NemmandoEnemyGrenade")
objGrenade.obj_sprite = sprite_grenade

v:onEnter(function(actor, data)
	actor.image_index = 0
	actor.sprite_index = sprite_shoot4_1

	data.fuse_timer = GRENADE_FUSE_TIMER
	data.primed = 0
	data.tossed = 0
	data.low_toss = 0
	data.blip = 0
	if actor.target and Instance.exists(actor.target) then
		if actor.target.parent and Instance.exists(actor.target.parent) then
			data.targetvalue = actor.target.parent.value
		end
	end
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
		log.warning("sync_target (Nemesis Commando) called on client!")
		return
	end

	local msg = targetSync:message_begin()
	msg:write_instance(target)
	msg:write_instance(actor)
	msg:send_to_all()
end

v:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor.image_speed = 0.25 * actor.attack_speed
	
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
	
	if target and actor.x - target.x < 0 then
		actor.image_xscale = 1
	elseif target and actor.x - target.x > 0 then
		actor.image_xscale = -1
	end

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
		if data.primed == 0 and actor.image_index >= 2 then
			data.primed = 1
			actor:sound_play(sound_grenade_prime, 1, 1)
		end
		if actor.image_index >= 5 and (data.fuse_timer - 4) % GRENADE_TICK_INTERVAL == 0 then
			data.blip = 1
		end

		if data.blip == 0 and actor.image_index >= 6 then
			actor.image_index = 5
		elseif data.blip == 1 and actor.image_index >= 9 then
			actor.image_index = 5
			data.blip = 0
		end
	
		if actor.image_index >= 4 then
		
			local release = false
			if data.fuse_timer < GRENADE_FUSE_TIMER - 80 and target and gm.point_distance(target.x, target.y, actor.x, actor.y) <= 250 then
				release = true
			elseif data.fuse_timer < GRENADE_FUSE_TIMER - 40 and target and gm.point_distance(target.x, target.y, actor.x, actor.y) > 250 then
				actor.pVspeed = -actor.pVmax * 0.5
				actor.pHspeed = actor.pHmax * actor.image_xscale
				release = true
			end
			
			local low_toss = false
			if data.fuse_timer < GRENADE_FUSE_TIMER - 60 and target and gm.point_distance(target.x, target.y, actor.x, actor.y) <= 100 then
				low_toss = true
			end
			
			local auto_toss = data.fuse_timer == GRENADE_AUTOTHROW_THRESHOLD

			if (release or low_toss or auto_toss) and data.tossed == 0 then

				actor.image_index = 0
				if low_toss then
					actor.sprite_index = sprite_shoot4_2b
				else
					actor.sprite_index = sprite_shoot4_2a
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
		if actor.image_index >= 5 then
			actor:skill_util_reset_activity_state()
		end
	end
end)

v:onExit(function(actor, data)
	if data.tossed == 0 then
		local nade = objGrenade:create(actor.x, actor.y - 5)

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

	local attack = parent:fire_explosion(inst.x, inst.y, 192, 160, inst.damage)

	if boosted then
		attack.attack_info.stun = 1
	end

	if inst.stun_parent == 1 then
		GM.actor_knockback_inflict(parent, 1, -parent.image_xscale, 60)
	end

	if boosted then
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

local objRocket = Object.new(NAMESPACE, "NemmandoEnemyRocket")
objRocket.obj_sprite = sprite_rocket

local v2 = State.new(NAMESPACE, "nemCommandoEnemySpecial2")
v2:clear_callbacks()

v_skill2:onActivate(function(actor)
	actor:enter_state(v2)
end)

v_skill2b:onActivate(function(actor)
	actor:enter_state(v2)
end)

v2:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0

	if gm.bool(data.airborne) then
		actor.sprite_index = sprite_shoot4b_a
	else
		actor.sprite_index = sprite_shoot4b
	end
	actor:sound_play(gm.constants.wHANDShoot2_1, 1, 0.5)
end)
v2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()

	actor:actor_animation_set(actor.sprite_index, 0.2)

	local should_fire = actor.image_index >= 3 or (actor.image_index >= 2 and airborne)

	if should_fire and data.fired == 0 then
		data.fired = 1

		actor:sound_play(gm.constants.wEnforcerShoot1, 1, 0.5 + math.random() * 0.1)
		actor:sound_play(gm.constants.wEnforcerGrenadeShoot, 1, 0.9 + math.random() * 0.2)
		actor:screen_shake(3)

		local backblast = actor:fire_explosion_local(actor.x - 50 * actor.image_xscale, actor.y - 12, 100, 60, 1.0)
		backblast.attack_info.knockback = 4
		backblast.attack_info.knockback_direction = -actor.image_xscale

		local rocket = objRocket:create(actor.x + 8 * actor.image_xscale, actor.y - 8)
		rocket.parent = actor
		rocket.team = actor.team
		rocket.direction = actor:skill_util_facing_direction()
		rocket.image_xscale = actor.image_xscale
		rocket.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))

		actor.pHspeed = actor.pHspeed + actor.pHmax * -2 * actor.image_xscale 

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

	inst.team = 2
	inst.parent = -4
	inst.victim = -4
	inst.scepter = 0

	inst.lifetime = 3 * 60
	inst.woosh_sound = -1
end)
objRocket:onStep(function(inst)
	if inst.woosh_sound == -1 then
		inst.woosh_sound = gm.sound_play_at(gm.constants.wFwoosh, 1, 0.1 + math.random() * 0.1, inst.x + inst.hspeed * 120, inst.y)
	end

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

	if gm.audio_is_playing(inst.woosh_sound) then
		gm.audio_stop_sound(inst.woosh_sound)
	end

	particleRubble1:create(inst.x, inst.y, 15)
	particleSpark:create(inst.x, inst.y, 6)

	if Instance.exists(inst.parent) then
		local boosted = inst.scepter > 0

		if inst.victim ~= -4 then
			local direct = inst.parent:fire_direct(inst.victim, 10, inst.direction, inst.x, inst.y)
		end

		local attack = inst.parent:fire_explosion(inst.x, inst.y, 260, 260, 0.5)
		attack.attack_info.stun = 1.66
		attack.attack_info.knockback = 5
		attack.attack_info.knockup = 5

		if boosted then
			attack.attack_info.stun = attack.stun * 1.5
			attack.attack_info.knockback = attack.knockback * 2
			attack.attack_info.knockup = attack.knockup * 3
		end
	end
end)

local function spawnNemmando()
	if Helper.chance(0.1) and GM._mod_game_getDirector().stages_passed > 0 and not GM._mod_game_getDirector().nemmandoSpawned then
		local player = Instance.find(gm.constants.oP)
		local blockList = List.new()
		player:collision_ellipse_list(player.x - 1000, player.y - 1000, player.x + 1000, player.x + 1000, gm.constants.oB, false, true, blockList, true)
		if blockList[#blockList] then
			local flash = Object.find("ror-WhiteFlash"):create(player.x, player.y)
			flash.image_blend = Color.PURPLE
			flash.rate = 0.01
			flash.image_alpha = 0.5
			gm.audio_play_sound(gm.constants.wImpPortal1, 1, false)
			gm.audio_play_sound(gm.constants.wTeleporter_Complete, 1, false)
			nemmando:create(blockList[#blockList].x, blockList[#blockList].y - 16)
			GM._mod_game_getDirector().nemmandoSpawned = true
		end
		blockList:destroy()
	end
end

Callback.add(Callback.TYPE.onStageStart, "nemmandoAppear", function()
	Alarm.create(spawnNemmando, 3.4 * 60, nil)
end)

gm.pre_script_hook(gm.constants.actor_phy_on_landed, function(self, other, result, args)
    local real_self = Instance.wrap(self)
    if not gm.bool(self.invincible) and real_self.fallImmunity then
        self.invincible = 1
        guarded = true
    end
end)

gm.post_script_hook(gm.constants.actor_phy_on_landed, function(self, other, result, args)
    if guarded then
        self.invincible = 0
        guarded = false
    end
end)