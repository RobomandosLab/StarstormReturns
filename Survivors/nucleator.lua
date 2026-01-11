local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Nucleator")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Nucleator")

-- sprites
local sprite_loadout			= Sprite.new("NukeSelect", path.combine(SPRITE_PATH, "select.png"), 16, 2, 0)
local sprite_portrait			= Sprite.new("NukePortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small		= Sprite.new("NukePortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills				= Sprite.new("NukeSkills", path.combine(SPRITE_PATH, "skills.png"), 5)

local sprite_idle				= Sprite.new("NukeIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 17, 18)
local sprite_idle_half			= Sprite.new("NukeIdleHalf", path.combine(SPRITE_PATH, "idle_half.png"), 1, 8, 9)
local sprite_walk				= Sprite.new("NukeWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 18, 19)
local sprite_walk_half			= Sprite.new("NukeWalkHalf", path.combine(SPRITE_PATH, "walk_half.png"), 8, 18, 19)
local sprite_jump_start			= Sprite.new("NukeJumpStart", path.combine(SPRITE_PATH, "jump_start.png"), 1, 19, 17)
local sprite_jump_start_half	= Sprite.new("NukeJumpStartHalf", path.combine(SPRITE_PATH, "jump_start_half.png"), 1, 19, 17)
local sprite_jump_peak			= Sprite.new("NukeJumpPeak", path.combine(SPRITE_PATH, "jump_peak.png"), 1, 19, 17)
local sprite_jump_peak_half		= Sprite.new("NukeJumpPeakHalf", path.combine(SPRITE_PATH, "jump_peak_half.png"), 1, 19, 17)
local sprite_jump_fall			= Sprite.new("NukeJumpFall", path.combine(SPRITE_PATH, "jump_fall.png"), 1, 19, 17)
local sprite_jump_fall_half		= Sprite.new("NukeJumpFallHalf", path.combine(SPRITE_PATH, "jump_fall_half.png"), 1, 19, 17)
local sprite_climb				= Sprite.new("NukeClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 16, 25)
local sprite_death				= Sprite.new("NukeDeath", path.combine(SPRITE_PATH, "death.png"), 5, 5, 9)
local sprite_decoy				= Sprite.new("NukeDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 9, 10)

local sprite_shoot1				= Sprite.new("NukeShoot1", path.combine(SPRITE_PATH, "shoot1.png"), 19, 10, 26)
local sprite_shoot1_half		= Sprite.new("NukeShoot1Half", path.combine(SPRITE_PATH, "shoot1_half.png"), 19, 10, 26)
local sprite_shoot2				= Sprite.new("NukeShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 23, 10, 12)
local sprite_shoot2_half		= Sprite.new("NukeShoot2Half", path.combine(SPRITE_PATH, "shoot2_half.png"), 23, 10, 12)
local sprite_shoot3				= Sprite.new("NukeShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 16, 15, 24)
local sprite_shoot4				= Sprite.new("NukeShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 6, 11, 12)
local sprite_shoot4S			= Sprite.new("NukeShoot4S", path.combine(SPRITE_PATH, "shoot4S.png"), 6, 11, 12)

local sprite_bar				= Sprite.new("NukeBar", path.combine(SPRITE_PATH, "bar.png"), 1, 19, 9)
local sprite_sparks				= Sprite.new("NukeSparks", path.combine(SPRITE_PATH, "sparks.png"), 3, 13, 8)
local sprite_bullet				= Sprite.new("NukeBullet", path.combine(SPRITE_PATH, "bullet.png"), 4, 10, 5)
local sprite_explosion			= Sprite.new("NukeBulletExplosion", path.combine(SPRITE_PATH, "bulletExplosion.png"), 6, 11, 10)
local sprite_push				= Sprite.new("NukePush", path.combine(SPRITE_PATH, "push.png"), 4, 22, 15)
local sprite_push_blast			= Sprite.new("NukePushBlast", path.combine(SPRITE_PATH, "push_blast.png"), 6, 10, 12)


-- sounds
local sound_alarm				= Sound.new("NukeShoot1a", path.combine(SOUND_PATH, "alarm.ogg"))
local sound_shoot1a				= Sound.new("NukeShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b				= Sound.new("NukeShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c				= Sound.new("NukeShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot2				= Sound.new("NukeShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3a				= Sound.new("NukeShoot3a", path.combine(SOUND_PATH, "skill3a.ogg"))
local sound_shoot3b				= Sound.new("NukeShoot3b", path.combine(SOUND_PATH, "skill3b.ogg"))
local sound_shoot3c				= Sound.new("NukeShoot3c", path.combine(SOUND_PATH, "skill3c.ogg"))
local sound_shoot4a				= Sound.new("NukeShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b				= Sound.new("NukeShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))
local sound_shoot4c				= Sound.new("NukeShoot4c", path.combine(SOUND_PATH, "skill4c.ogg"))


-------- THE NUCLEATORRRRRR!!!!
local nuke = Survivor.new("nucleator")

local APPLY_RADIATION_TAG = 1
local RADIATION_TICK_SPEED = 2 * 60
local SELF_RADIATION_DURATION = 1.2 * 60
local ENEMY_RADIATION_DURATION = 30 * 60

local UTIL_HSPEED_MIN = 1.5
local UTIL_HSPEED_FACTOR = 6
local UTIL_VSPEED_MIN = 1
local UTIL_VSPEED_FACTOR = 4

nuke:set_stats_base({
	maxhp = 115,
	damage = 12,
	regen = 0.0095
})

nuke:set_stats_level({
	maxhp = 34,
	damage = 3,
	regen = 0.0002,
	armor = 2
})

nuke.cape_offset = {0,0,0,0}
nuke.primary_color = Color.from_rgb(255,250,0) -- god hes so gross

nuke.sprite_loadout = sprite_loadout
nuke.sprite_portrait = sprite_portrait
nuke.sprite_portrait_small = sprite_portrait_small
nuke.sprite_title = sprite_walk

Callback.add(nuke.on_init, function( actor )
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump_start
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_jump_fall = sprite_jump_fall
	actor.sprite_climb = sprite_climb
	actor.sprite_death = sprite_death
	actor.sprite_decoy = sprite_decoy

	local idle_half = Array.new({sprite_idle, sprite_idle_half, 0})
	local walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk})
	local jump_half = Array.new({sprite_jump_start, sprite_jump_start_half, 0})

	actor.sprite_idle_half = Array.new({sprite_idle, sprite_idle_half, 0})
	actor.sprite_walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk})
	actor.sprite_jump_half = Array.new({sprite_jump_start, sprite_jump_start_half, 0})
	actor.sprite_jump_peak_half = Array.new({sprite_jump_peak, sprite_jump_peak_half, 0})
	actor.sprite_fall_half = Array.new({sprite_jump_fall, sprite_jump_fall_half, 0})

	actor:survivor_util_init_half_sprites()
end)


local nukePrimary    = nuke:get_skills(Skill.Slot.PRIMARY)[1]
local nukeSecondary  = nuke:get_skills(Skill.Slot.SECONDARY)[1]
local nukeUtility    = nuke:get_skills(Skill.Slot.UTILITY)[1]
local nukeSpecial    = nuke:get_skills(Skill.Slot.SPECIAL)[1]
local nukeSpecialS = Skill.new("nukeSpecialBoosted")


-- buffs
local selfRadiation = Buff.new("NukeSelfRad")
selfRadiation.icon_sprite = gm.constants.sBuffs
selfRadiation.icon_subimage = 9
selfRadiation.max_stack = 3
selfRadiation.draw_stack_number = true
selfRadiation.is_timed = false

local enemyRadiation = Buff.new("NukeEnemyRad")
enemyRadiation.is_debuff = true
enemyRadiation.icon_sprite = gm.constants.sBuffs
enemyRadiation.icon_subimage = 9
enemyRadiation.max_stack = 1

Callback.add(enemyRadiation.on_step, function( actor )
	local data = Instance.get_data(actor, "ssr_radiation")
	local tick = data.radiation_tick
	local attacker = data.attacker

	if tick then
		if Global._current_frame - tick >= RADIATION_TICK_SPEED then
			data.radiation_tick = Global._current_frame

			if attacker then 
				local damage = (actor.maxhp * 0.025)/attacker.damage
				attacker:fire_explosion(actor.x, actor.y, 750, 750, 1.0)
			end
		end
	else
		data.radiation_tick = Global._current_frame
	end
end)

Callback.add(Callback.ON_ATTACK_HIT, function( hit_info )
	local radiation_tag = hit_info.attack_info.__ssr_nuke_radiation

	if radiation_tag == APPLY_RADIATION_TAG then
		local victim = hit_info.target

		local data = Instance.get_data(victim, "ssr_radiation")
		data.attacker = hit_info.inflictor

		victim:buff_apply(enemyRadiation, ENEMY_RADIATION_DURATION, 1)
	end
end)


-- charging stuff dont mind me
local charge_rate = 5
local charge_limit = 60
local overcharge_limit = charge_limit * 1.5

local function NukeChargeStart( actor )
	local data = Instance.get_data(actor)

	if actor:buff_count(selfRadiation) > 0 then
		data.charge = charge_limit
	else
		data.charge = 0
	end
end

local function NukeChargeStep(actor)
	local data = Instance.get_data(actor)
	if not Instance.exists(data.charge_bar) then return end

	data.charge_tick = data.charge_tick + 1

	if data.charge_tick >= charge_rate then
		data.charge = data.charge + charge_rate
		data.charge_tick = 0

		if data.charge > charge_limit and actor:buff_count(selfRadiation) == 0 then
			local dmg = actor.hp * 0.1
			gm.damage_inflict(actor.id, dmg, 10, -25, actor.x, actor.y, dmg, 1, nuke.primary_color)
		end
	end

	if data.charge >= overcharge_limit then return 1 else return 0 end
end

local function NukeChargeRelease(actor)
	local data = Instance.get_data(actor)
	if not Instance.exists(data.charge_bar) then return end

	local ratio = data.charge/overcharge_limit
	local undercharge = ratio/(charge_limit/overcharge_limit)
	local overcharge = math.max(0, (ratio - (charge_limit/overcharge_limit)) * 2 / (charge_limit/overcharge_limit))

	data.charge = 0
	data.charge_tick = 0
	if actor:buff_count(selfRadiation) > 0 then
		actor:buff_remove(selfRadiation, 1)
	end

	return ratio, undercharge, overcharge
end

local objChargeBar = Object.new("NukeChargeBar")
objChargeBar.obj_depth = -1000

Callback.add(nuke.on_step, function( actor )
	local data = Instance.get_data(actor)

	if not Instance.exists(data.charge_bar) then
		data.charge_bar = objChargeBar:create()
		data.charge_bar.parent = actor
		data.charge = 0
		data.charge_tick = 0
	end
end)

Callback.add(objChargeBar.on_create, function( inst )
	inst.parent = -4
	inst.persistent = true
end)

Callback.add(objChargeBar.on_step, function( inst )
	if not GM.actor_is_alive(inst.parent) then
		inst:destroy()
	end
end)

Callback.add(objChargeBar.on_draw, function( inst )
	if not Instance.exists(inst.parent) then return end
	if Instance.get_data(inst.parent).charge <= 0 and Instance.get_data(inst.parent).charge_tick == 0 then return end

	local actor = inst.parent
	local data = Instance.get_data(actor)

	local x, y = math.floor(actor.ghost_x+0.5), math.floor(actor.ghost_y+0.5)
	local x = x + 1
	local y = y + 19

	local bar_left		= x - 14
	local bar_right		= x + 15
	local bar_width		= bar_right - bar_left
	local bar_top		= y - 2
	local bar_bottom	= y + 1

	local ratio = data.charge/overcharge_limit

	if data.charge < charge_limit then
		gm.draw_set_colour(nuke.primary_color)
	else
		gm.draw_set_colour(Color.RED)
	end
	gm.draw_rectangle(bar_left, bar_top, bar_left + bar_width * ratio, bar_bottom, false)

	GM.draw_sprite(sprite_bar, 0, x, y)
end)


-------- IRRADIATE
local objNukeBullet = Object.new("NucleatorBullet")
objNukeBullet:set_sprite(sprite_bullet)

Callback.add(objNukeBullet.on_create, function( inst )
	inst.parent = -4
	inst.initial_speed = 5
	inst.speed = inst.initial_speed
	inst.image_speed = 0.2
	inst.lifetime = 3 * 60
	inst.life = inst.lifetime
	inst.ratio = 0
	inst.overcharge = 0
end)

Callback.add(objNukeBullet.on_step, function( inst )
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end

	inst.life = inst.life - 1
	inst.speed = inst.initial_speed * (inst.life / inst.lifetime)

	if inst.life <= 0 then
		inst:destroy()
	end

	local collisions = inst:get_collisions(gm.constants.pActorCollisionBase)

	for _, actor in ipairs(collisions) do 
		if inst.parent:attack_collision_canhit(actor) and inst.parent:is_authority() then
			inst:destroy()
		end
	end

	if inst:is_colliding(gm.constants.pSolidBulletCollision) then
		inst:destroy()
		return
	end
end)

Callback.add(objNukeBullet.on_destroy, function( inst )
	if not Instance.exists(inst.parent) then return end

	local damage = inst.ratio <= charge_limit/overcharge_limit and math.max(1.0, inst.parent:skill_get_damage(nukePrimary) * (inst.ratio/(charge_limit/overcharge_limit))) or 10.0 * inst.ratio

	if inst.parent:is_authority() then
		local buff_shadow_clone = Buff.find("shadowClone")
		for i=0, inst.parent:buff_count(buff_shadow_clone) do
			local attack = inst.parent:fire_explosion(inst.x, inst.y, 50, 50, damage, sprite_explosion).attack_info
			attack.climb = i * 8

			if inst.ratio >= charge_limit/overcharge_limit then
				attack.__ssr_nuke_radiation = APPLY_RADIATION_TAG

				local t = gm.instance_create(inst.x, inst.y, gm.constants.oChainLightning)

				t.parent = inst.parent.value
				t.team = inst.parent.team
				t.damage = inst.parent.damage * damage / 2
				t.blend = nuke.primary_color
				t.bounce = 2
				t.range = math.max(30, math.ceil(150 * inst.overcharge))
			end
		end
	end
end)


nukePrimary.sprite = sprite_skills
nukePrimary.subimage = 0
nukePrimary.cooldown = 12
nukePrimary.damage = 4.0
nukePrimary.require_key_press = false
nukePrimary.is_primary = true
nukePrimary.does_change_activity_state = true
nukePrimary.hold_facing_direction = true
nukePrimary.required_interrupt_priority = ActorState.InterruptPriority.ANY

local stateNukePrimary = ActorState.new("nukePrimary")
local stateNukePrimaryFire = ActorState.new("nukeFirePrimary")

Callback.add(nukePrimary.on_activate, function( actor )
	actor:set_state(stateNukePrimary)
end)

Callback.add(stateNukePrimary.on_enter, function( actor, data )
	actor.image_index2 = 0

	data.exit_index = 15

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()

	NukeChargeStart(actor)
end)

Callback.add(stateNukePrimary.on_step, function( actor, data )
	actor.sprite_index2 = sprite_shoot1_half
	actor:skill_util_strafe_update(data.exit_index/overcharge_limit, 0.2)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if actor:is_authority() and ((not actor:control("skill1", 0) and Instance.get_data(actor).charge > 0) or NukeChargeStep(actor) == 1) then
		actor:set_state(stateNukePrimaryFire)
	end
end)


Callback.add(stateNukePrimaryFire.on_enter, function( actor, data )
	actor.image_index = 15
	actor.sprite_index = sprite_shoot1

	local ratio, undercharge, overcharge = NukeChargeRelease(actor)
	data.ratio = ratio
	data.overcharge = overcharge
	data.fired = 0
end)

Callback.add(stateNukePrimaryFire.on_step, function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if data.fired == 0 then
		data.fired = 1
		actor:skill_util_nudge_forward(-20 * data.ratio * actor.image_xscale)

		local bullet = objNukeBullet:create(actor.x, actor.y)
		bullet.parent = actor
		bullet.direction = actor:skill_util_facing_direction()
		bullet.image_xscale = actor.image_xscale
		bullet.ratio = data.ratio
		bullet.overcharge = data.overcharge
	end
end)



-------- QUARANTINE
local objNukePush = Object.new("NucleatorPush")
objNukePush:set_sprite(sprite_push)

Callback.add(objNukePush.on_create, function( inst )
	inst.parent = -4
	inst.ratio = 0
	inst.overcharge = 0
	inst.image_speed = 0.2

	inst.speed = 3
	inst.lifetime = 0
	inst.life = 0

	inst.hit_delay = 15
	data = Instance.get_data(inst)
	data.hit_list = {}
end)

Callback.add(objNukePush.on_step, function( inst )
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end

	inst.life = inst.life - 1
	if inst.life <= 0 then
		local attack = inst.parent:fire_explosion(inst.x, inst.y, 100, 100, 1.0, sprite_explosion).attack_info
		attack.__ssr_nuke_radiation = APPLY_RADIATION_TAG
		attack.knockback_direction = inst.image_xscale
		attack.knockback = 7
		attack.knockup = 1

		inst:destroy()
	end

	local data = Instance.get_data(inst)
	local collisions = inst:get_collisions(gm.constants.pActorCollisionBase)

	for _, actor in ipairs(collisions) do
		if actor.team ~= inst.parent.team then
			if data.hit_list[actor.id] == nil or Global._current_frame - data.hit_list[actor.id] >= inst.hit_delay then
				if gm._mod_net_isHost() then
					local attack = inst.parent:fire_direct(actor, 0.5, inst.direction, inst.x, inst.y, nil, true).attack_info
					attack.knockback_direction = inst.image_xscale
					attack.knockback = 5
					attack.knockup = 2
				end

				inst:sound_play(gm.constants.wMercenaryShoot1_3, 0.5, 0.9)
				data.hit_list[actor.id] = Global._current_frame
			end
		end
	end
end)


nukeSecondary.sprite = sprite_skills
nukeSecondary.subimage = 1
nukeSecondary.cooldown = 4 * 60
nukeSecondary.damage = 3.0
nukeSecondary.require_key_press = false
nukeSecondary.does_change_activity_state = true
nukeSecondary.hold_facing_direction = true
nukeSecondary.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateNukeSecondary = ActorState.new("nukeSecondary")
local stateNukeSecondaryFire = ActorState.new("nukeFireSecondary")

Callback.add(nukeSecondary.on_activate, function( actor )
	actor:set_state(stateNukeSecondary)
end)

Callback.add(stateNukeSecondary.on_enter, function( actor, data )
	actor.image_index2 = 0

	data.exit_index = 16

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()

	NukeChargeStart(actor)
end)

Callback.add(stateNukeSecondary.on_step, function( actor, data )
	actor.sprite_index2 = sprite_shoot2_half
	actor:skill_util_strafe_update(data.exit_index/overcharge_limit, 0.2)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if actor:is_authority() and ((not actor:control("skill2", 0) and Instance.get_data(actor).charge > 0) or NukeChargeStep(actor) == 1) then
		GM.actor_set_state_networked(actor, stateNukeSecondaryFire)
	end
end)


Callback.add(stateNukeSecondaryFire.on_enter, function( actor, data )
	actor.image_index = 16
	actor.sprite_index = sprite_shoot2

	local ratio, undercharge, overcharge = NukeChargeRelease(actor)
	data.ratio = ratio
	data.overcharge = overcharge
	data.fired = 0
end)

Callback.add(stateNukeSecondaryFire.on_step, function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if data.fired == 0 then
		data.fired = 1
		actor:skill_util_nudge_forward( -10 + -20 * data.ratio * actor.image_xscale)

		if data.ratio < charge_limit/overcharge_limit then
			if actor:is_authority() then
				local undercharge = data.ratio/(charge_limit/overcharge_limit)
				local damage = actor:skill_get_damage(nukeSecondary) * undercharge
				local dir = actor.image_xscale

				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					local info = actor:fire_explosion(actor.x + 50 * dir, actor.y, 100, 50, damage, sprite_push_blast).attack_info
					info.knockback = math.max(5, 12 * undercharge)
					info.knockup = math.max(1, 4 * undercharge)
					info.knockback_direction = dir
				end
			end
		else
			local push = objNukePush:create(actor.x, actor.y)
			push.parent = actor
			push.direction = actor:skill_util_facing_direction()
			push.image_xscale = actor.image_xscale

			push.ratio = data.ratio
			push.overcharge = data.overcharge

			push.lifetime = math.max(1 * 60, 3 * push.overcharge * 60)
			push.life = push.lifetime
		end
	end
end)



-------- FISSION IMPULSE
nukeUtility.sprite = sprite_skills
nukeUtility.subimage = 2
nukeUtility.cooldown = 6 * 60
nukeUtility.damage = 5.5
nukeUtility.require_key_press = false
nukeUtility.does_change_activity_state = true
nukeUtility.hold_facing_direction = true
nukeUtility.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateNukeUtility = ActorState.new("nukeUtility")
local stateNukeUtilityFire = ActorState.new("nukeFireUtility")

Callback.add(nukeUtility.on_activate, function( actor )
	actor:set_state(stateNukeUtility)
end)

Callback.add(stateNukeUtility.on_enter, function( actor, data )
	data.exit_index = 14

	actor.image_index = 0
	actor.sprite_index = sprite_shoot3
	actor.image_speed = data.exit_index/overcharge_limit

	data.fired = 0

	NukeChargeStart(actor)
end)

Callback.add(stateNukeUtility.on_step, function( actor, data )
	actor:skill_util_fix_hspeed()

	if actor:is_authority() and ((not actor:control("skill3", 0) and Instance.get_data(actor).charge > 0) or NukeChargeStep(actor) == 1) then
		GM.actor_set_state_networked(actor, stateNukeUtilityFire)
	end
end)


Callback.add(stateNukeUtilityFire.on_enter, function( actor, data )
	actor.image_index = 14
	actor.sprite_index = sprite_shoot3

	data.ratio = NukeChargeRelease(actor)
	data.fired = 0

	data.down = gm.bool(actor.ropeDown) and 1 or 0
	data.up = gm.bool(actor.ropeUp) and 1 or 0
	data.left = gm.bool(actor.moveLeft) and 1 or 0
	data.right = gm.bool(actor.moveRight) and 1 or 0

	data.vertical = data.down - data.up
	data.horizontal = data.right - data.left

	data.speed_factor_h = math.max(UTIL_HSPEED_MIN, UTIL_HSPEED_FACTOR  * math.log(data.ratio + 1))
	data.speed_factor_v = math.max(UTIL_VSPEED_MIN, UTIL_VSPEED_FACTOR * math.log(data.ratio + 1))

	if data.ratio < charge_limit/overcharge_limit then
		local attack = actor:fire_explosion(actor.x, actor.y, 150, 150, 1.0, sprite_explosion).attack_info
		attack.knockback = 4
		attack.knockup = 1
	else
		local attack = actor:fire_explosion(actor.x, actor.y, 200, 200, 2.0, sprite_explosion).attack_info
		attack.__ssr_nuke_radiation = APPLY_RADIATION_TAG
		attack.knockback = -6
		attack.knockup = 1
	end
end)

Callback.add(stateNukeUtilityFire.on_step, function( actor, data )
	actor.invincible = math.max(8, actor.invincible)
	actor.moveLeft = false
	actor.moveRight = false

	if data.fired == 0 then
		data.fired = 1
		  
		actor.y = actor.y - 10
		actor.pVspeed = data.vertical * data.speed_factor_v * actor.pVmax

		if data.vertical == 0 then
			if data.horizontal == 0 then
				actor.pVspeed = -data.speed_factor_v * actor.pVmax
			else
				actor.pVspeed = -UTIL_VSPEED_MIN * actor.pVmax
			end
		end
	end

	actor.pHspeed = data.horizontal * data.speed_factor_h * actor.pHmax

	if actor.image_index >= 15.8 then
		actor.sprite_index = sprite_jump_peak
	end

	if ssr_is_colliding_stage(actor, actor.x + 1, actor.y + 1) or ssr_is_colliding_stage(actor, actor.x - 1) then
		local attack = actor:fire_explosion(actor.x, actor.y, 150, 150, 90.0, sprite_explosion).attack_info
		attack.stun = 1
		attack.knockback = 2
		attack.knockup = 1

		actor.pVspeed = -0.75 * actor.pVmax
		actor:skill_util_reset_activity_state()
	end
end)



-------- RADIONUCLIDE SURGE
nukeSpecial.sprite = sprite_skills
nukeSpecial.subimage = 3
nukeSpecial.cooldown = 20 * 60
nukeSpecial.damage = 3.0
nukeSpecial.require_key_press = true
nukeSpecial.required_interrupt_priority = ActorState.InterruptPriority.SKILL
nukeSpecial.upgrade_skill = nukeSpecialS

nukeSpecialS.sprite = sprite_skills
nukeSpecialS.subimage = 4
nukeSpecialS.cooldown = 20 * 60
nukeSpecialS.damage = 3.0
nukeSpecialS.require_key_press = true
nukeSpecialS.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateNukeSpecial = ActorState.new("nukeSpecial")

Callback.add(nukeSpecial.on_activate, function( actor )
	actor:set_state(stateNukeSpecial)
end)

Callback.add(nukeSpecialS.on_activate, function( actor )
	actor:set_state(stateNukeSpecial)
end)

Callback.add(stateNukeSpecial.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = actor:item_count(Item.find("ancientScepter")) > 0 and sprite_shoot4S or sprite_shoot4
	actor.image_speed = 0.2

	data.fired = 0

	NukeChargeRelease(actor)
end)

Callback.add(stateNukeSpecial.on_step, function( actor, data )
	actor.invincible = math.max(8, actor.invincible)
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(stateNukeSpecial.on_exit, function( actor, data )
	actor:buff_apply(selfRadiation, SELF_RADIATION_DURATION, actor:item_count(Item.find("ancientScepter")) > 0 and 5 or 3)
end)