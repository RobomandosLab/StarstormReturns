local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Nucleator")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Nucleator")

-- sprites
local sprite_loadout			= Resources.sprite_load(NAMESPACE, "NukeSelect", path.combine(SPRITE_PATH, "select.png"), 16, 2, 0)
local sprite_portrait			= Resources.sprite_load(NAMESPACE, "NukePortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small		= Resources.sprite_load(NAMESPACE, "NukePortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills				= Resources.sprite_load(NAMESPACE, "NukeSkills", path.combine(SPRITE_PATH, "skills.png"), 5)

local sprite_idle				= Resources.sprite_load(NAMESPACE, "NukeIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 17, 18)
local sprite_idle_half			= Resources.sprite_load(NAMESPACE, "NukeIdleHalf", path.combine(SPRITE_PATH, "idle_half.png"), 1, 8, 9)
local sprite_walk				= Resources.sprite_load(NAMESPACE, "NukeWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 18, 19)
local sprite_walk_half			= Resources.sprite_load(NAMESPACE, "NukeWalkHalf", path.combine(SPRITE_PATH, "walk_half.png"), 8, 18, 19)
local sprite_jump_start			= Resources.sprite_load(NAMESPACE, "NukeJumpStart", path.combine(SPRITE_PATH, "jump_start.png"), 1, 19, 17)
local sprite_jump_start_half	= Resources.sprite_load(NAMESPACE, "NukeJumpStartHalf", path.combine(SPRITE_PATH, "jump_start_half.png"), 1, 19, 17)
local sprite_jump_peak			= Resources.sprite_load(NAMESPACE, "NukeJumpPeak", path.combine(SPRITE_PATH, "jump_peak.png"), 1, 19, 17)
local sprite_jump_peak_half		= Resources.sprite_load(NAMESPACE, "NukeJumpPeakHalf", path.combine(SPRITE_PATH, "jump_peak_half.png"), 1, 19, 17)
local sprite_jump_fall			= Resources.sprite_load(NAMESPACE, "NukeJumpFall", path.combine(SPRITE_PATH, "jump_fall.png"), 1, 19, 17)
local sprite_jump_fall_half		= Resources.sprite_load(NAMESPACE, "NukeJumpFallHalf", path.combine(SPRITE_PATH, "jump_fall_half.png"), 1, 19, 17)
local sprite_climb				= Resources.sprite_load(NAMESPACE, "NukeClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 16, 25)
local sprite_death				= Resources.sprite_load(NAMESPACE, "NukeDeath", path.combine(SPRITE_PATH, "death.png"), 5, 5, 9)
local sprite_decoy				= Resources.sprite_load(NAMESPACE, "NukeDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 9, 10)

local sprite_shoot1				= Resources.sprite_load(NAMESPACE, "NukeShoot1", path.combine(SPRITE_PATH, "shoot1.png"), 19, 10, 26)
local sprite_shoot1_half		= Resources.sprite_load(NAMESPACE, "NukeShoot1Half", path.combine(SPRITE_PATH, "shoot1_half.png"), 19, 10, 26)
local sprite_shoot2				= Resources.sprite_load(NAMESPACE, "NukeShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 23, 10, 12)
local sprite_shoot2_half		= Resources.sprite_load(NAMESPACE, "NukeShoot2Half", path.combine(SPRITE_PATH, "shoot2_half.png"), 23, 10, 12)
local sprite_shoot3				= Resources.sprite_load(NAMESPACE, "NukeShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 16, 15, 24)
local sprite_shoot4				= Resources.sprite_load(NAMESPACE, "NukeShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 6, 11, 12)
local sprite_shoot4S			= Resources.sprite_load(NAMESPACE, "NukeShoot4S", path.combine(SPRITE_PATH, "shoot4S.png"), 6, 11, 12)

local sprite_bar				= Resources.sprite_load(NAMESPACE, "NukeBar", path.combine(SPRITE_PATH, "bar.png"), 1, 19, 9)
local sprite_sparks				= Resources.sprite_load(NAMESPACE, "NukeSparks", path.combine(SPRITE_PATH, "sparks.png"), 3, 13, 8)
local sprite_bullet				= Resources.sprite_load(NAMESPACE, "NukeBullet", path.combine(SPRITE_PATH, "bullet.png"), 4, 10, 5)
local sprite_explosion			= Resources.sprite_load(NAMESPACE, "NukeBulletExplosion", path.combine(SPRITE_PATH, "bulletExplosion.png"), 6, 11, 10)
local sprite_push				= Resources.sprite_load(NAMESPACE, "NukePush", path.combine(SPRITE_PATH, "push.png"), 4, 22, 15)
local sprite_push_blast			= Resources.sprite_load(NAMESPACE, "NukePushBlast", path.combine(SPRITE_PATH, "push_blast.png"), 6, 10, 12)


-- sounds
local sound_alarm				= Resources.sfx_load(NAMESPACE, "NukeShoot1a", path.combine(SOUND_PATH, "alarm.ogg"))
local sound_shoot1a				= Resources.sfx_load(NAMESPACE, "NukeShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b				= Resources.sfx_load(NAMESPACE, "NukeShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c				= Resources.sfx_load(NAMESPACE, "NukeShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot2				= Resources.sfx_load(NAMESPACE, "NukeShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3a				= Resources.sfx_load(NAMESPACE, "NukeShoot3a", path.combine(SOUND_PATH, "skill3a.ogg"))
local sound_shoot3b				= Resources.sfx_load(NAMESPACE, "NukeShoot3b", path.combine(SOUND_PATH, "skill3b.ogg"))
local sound_shoot3c				= Resources.sfx_load(NAMESPACE, "NukeShoot3c", path.combine(SOUND_PATH, "skill3c.ogg"))
local sound_shoot4a				= Resources.sfx_load(NAMESPACE, "NukeShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b				= Resources.sfx_load(NAMESPACE, "NukeShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))
local sound_shoot4c				= Resources.sfx_load(NAMESPACE, "NukeShoot4c", path.combine(SOUND_PATH, "skill4c.ogg"))


-------- THE NUCLEATORRRRRR!!!!
local nuke = Survivor.new(NAMESPACE, "nucleator")
local nuke_id = nuke.value

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

nuke:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump_start,
	jump_peak = sprite_jump_peak,
	jump_fall = sprite_jump_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy
})

nuke:set_cape_offset(0,0,0,0)
nuke:set_primary_color(Color.from_rgb(255,250,0)) -- god hes so gross

nuke.sprite_loadout = sprite_loadout
nuke.sprite_portrait = sprite_portrait
nuke.sprite_portrait_small = sprite_portrait_small
nuke.sprite_title = sprite_walk

nuke:clear_callbacks()
nuke:onInit(function(actor)
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


local nukePrimary    = nuke:get_primary()
local nukeSecondary  = nuke:get_secondary()
local nukeUtility    = nuke:get_utility()
local nukeSpecial    = nuke:get_special()
local nukeSpecialScepter = Skill.new(NAMESPACE, "nukeSpecialBoosted")
nukeSpecial:set_skill_upgrade(nukeSpecialScepter)


-- buffs
local selfRadiation = Buff.new(NAMESPACE, "NukeSelfRad")
selfRadiation.icon_sprite = gm.constants.sBuffs
selfRadiation.icon_subimage = 9

selfRadiation:clear_callbacks()

local enemyRadiation = Buff.new(NAMESPACE, "NukeEnemyRad")
enemyRadiation.show_icon = false

enemyRadiation:clear_callbacks()


-- charging stuff dont mind me
local charge_rate = 5
local charge_limit = 60
local overcharge_limit = charge_limit * 1.5

local function NukeChargeStart( actor )
	local data = actor:get_data()

	if actor:buff_stack_count(selfRadiation) > 0 then
		data.charge = charge_limit
	else
		data.charge = 0
	end
end

local function NukeChargeStep(actor)
	local data = actor:get_data()
	if not Instance.exists(data.charge_bar) then return end

	data.charge_tick = data.charge_tick + 1

	if data.charge_tick >= charge_rate then
		data.charge = data.charge + charge_rate
		data.charge_tick = 0

		if data.charge > charge_limit and actor:buff_stack_count(selfRadiation) == 0 then
			local dmg = actor.hp * 0.1
			gm.damage_inflict(actor.id, dmg, 10, -25, actor.x, actor.y, dmg, 1, nuke.primary_color)
		end
	end

	if data.charge >= overcharge_limit then return 1 else return 0 end
end

local function NukeChargeRelease(actor)
	local data = actor:get_data()
	if not Instance.exists(data.charge_bar) then return end

	local ratio = data.charge/overcharge_limit
	data.charge = 0
	data.charge_tick = 0
	return ratio
end

local objChargeBar = Object.new(NAMESPACE, "NukeChargeBar")
objChargeBar.obj_depth = -1000

nuke:onStep(function( actor )
	data = actor:get_data()

	if not Instance.exists(data.charge_bar) then
		data.charge_bar = objChargeBar:create()
		data.charge_bar.parent = actor
		data.charge = 0
		data.charge_tick = 0
	end
end)

objChargeBar:clear_callbacks()
objChargeBar:onCreate(function( inst )
	inst.parent = -4
	inst.persistent = true
end)
objChargeBar:onStep(function( inst )
	if not GM.actor_is_alive(inst.parent) then
		inst:destroy()
	end
end)

objChargeBar:onDraw(function( inst )
	if not Instance.exists(inst.parent) then return end
	if inst.parent:get_data().charge <= 0 and inst.parent:get_data().charge_tick == 0 then return end

	local actor = inst.parent
	local data = actor:get_data()

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

	gm.draw_sprite(sprite_bar, 0, x, y)
end)


-------- IRRADIATE
local objNukeBullet = Object.new(NAMESPACE, "NucleatorBullet")
objNukeBullet:set_sprite(sprite_bullet)

objNukeBullet:clear_callbacks()
objNukeBullet:onCreate(function( inst )
	inst.parent = -4
	inst.initial_speed = 5
	inst.speed = inst.initial_speed
	inst.image_speed = 0.2
	inst.lifetime = 3 * 60
	inst.life = inst.lifetime
	inst.ratio = 0
end)

objNukeBullet:onStep(function( inst )
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

objNukeBullet:onDestroy(function( inst )
	if not Instance.exists(inst.parent) then return end
	
	local damage = inst.ratio <= charge_limit/overcharge_limit and math.max(1.0, inst.parent:skill_get_damage(nukePrimary) * (inst.ratio/(charge_limit/overcharge_limit))) or 10.0 * inst.ratio

	if inst.parent:is_authority() then
		local buff_shadow_clone = Buff.find("ror", "shadowClone")
		for i=0, inst.parent:buff_stack_count(buff_shadow_clone) do
			inst.parent:fire_explosion(inst.x, inst.y, 50, 50, damage, sprite_explosion)
		end
	end

	if inst.ratio >= charge_limit/overcharge_limit then
		local t = gm.instance_create(inst.x, inst.y, gm.constants.oChainLightning)
		local overcharge = (inst.ratio - (charge_limit/overcharge_limit)) * 2 / (charge_limit/overcharge_limit)

		t.parent = inst.parent.value
		t.team = inst.parent.team
		t.damage = inst.parent.damage * damage
		t.blend = nuke.primary_color
		t.bounce = 3
		t.range = math.max(100, math.ceil(300 * overcharge))
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
nukePrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateNukePrimary = State.new(NAMESPACE, "nukePrimary")
local stateNukePrimaryFire = State.new(NAMESPACE, "nukeFirePrimary")

nukePrimary:clear_callbacks()
nukePrimary:onActivate(function( actor )
	actor:enter_state(stateNukePrimary)
end)

stateNukePrimary:onEnter(function( actor, data )
	actor.image_index2 = 0

	data.exit_index = 15

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()

	NukeChargeStart(actor)
end)

stateNukePrimary:onStep(function( actor, data )
	actor.sprite_index2 = sprite_shoot1_half
	actor:skill_util_strafe_update(data.exit_index/overcharge_limit, 0.2)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if actor:is_authority() and ((not actor:control("skill1", 0) and actor:get_data().charge > 0) or NukeChargeStep(actor) == 1) then
		GM.actor_set_state_networked(actor, stateNukePrimaryFire)
	end
end)


stateNukePrimaryFire:onEnter(function( actor, data )
	actor.image_index = 15
	actor.sprite_index = sprite_shoot1

	data.ratio = NukeChargeRelease(actor)
	data.fired = 0
end)

stateNukePrimaryFire:onStep(function( actor, data )
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
	end
end)


-------- QUARANTINE
local objNukePush = Object.new(NAMESPACE, "NucleatorPush")
objNukePush:set_sprite(sprite_push)

objNukePush:clear_callbacks()
objNukePush:onCreate(function( inst )
	inst.parent = -4
	inst.ratio = 0
	inst.image_speed = 0.2

	inst.speed = 3
	inst.lifetime = 3 * 60
	inst.life = inst.lifetime

	inst.hit_delay = 15
	data = inst:get_data()
	data.hit_list = {}
end)

objNukePush:onStep(function( inst )
	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end

	inst.life = inst.life - 1
	if inst.life <= 0 then
		inst:destroy()
	end

	local data = inst:get_data()
	local collisions = inst:get_collisions(gm.constants.pActorCollisionBase)
	local overcharge = (inst.ratio - (charge_limit/overcharge_limit)) * 2 / (charge_limit/overcharge_limit)
	local damage = math.max(0.5, 2 * overcharge)

	for _, actor in ipairs(collisions) do
		if actor.team ~= inst.parent.team then
			if data.hit_list[actor.id] == nil then
				if gm._mod_net_isHost() then
					local attack = inst.parent:fire_direct(actor, damage, inst.direction, inst.x, inst.y, nil, true).attack_info
					attack.knockback_direction = inst.image_xscale
					attack.knockback = 5
					attack.knockup = 2
				end

				inst:sound_play(gm.constants.wMercenaryShoot1_3, 0.5, 0.9)
				data.hit_list[actor.id] = Global._current_frame

			elseif Global._current_frame - data.hit_list[actor.id] >= inst.hit_delay then
				if gm._mod_net_isHost() then
					local attack = inst.parent:fire_direct(actor, damage, inst.direction, inst.x, inst.y, nil, true).attack_info
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
nukeSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateNukeSecondary = State.new(NAMESPACE, "nukeSecondary")
local stateNukeSecondaryFire = State.new(NAMESPACE, "nukeFireSecondary")

nukeSecondary:clear_callbacks()
nukeSecondary:onActivate(function( actor )
	actor:enter_state(stateNukeSecondary)
end)

stateNukeSecondary:onEnter(function( actor, data )
	actor.image_index2 = 0

	data.exit_index = 16

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()

	NukeChargeStart(actor)
end)

stateNukeSecondary:onStep(function( actor, data )
	actor.sprite_index2 = sprite_shoot2_half
	actor:skill_util_strafe_update(data.exit_index/overcharge_limit, 0.2)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if actor:is_authority() and ((not actor:control("skill2", 0) and actor:get_data().charge > 0) or NukeChargeStep(actor) == 1) then
		GM.actor_set_state_networked(actor, stateNukeSecondaryFire)
	end
end)


stateNukeSecondaryFire:onEnter(function( actor, data )
	actor.image_index = 16
	actor.sprite_index = sprite_shoot2

	data.ratio = NukeChargeRelease(actor)
	data.fired = 0
end)

stateNukeSecondaryFire:onStep(function( actor, data )
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

				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
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
nukeUtility.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateNukeUtility = State.new(NAMESPACE, "nukeUtility")
local stateNukeUtilityFire = State.new(NAMESPACE, "nukeFireUtility")

nukeUtility:clear_callbacks()
nukeUtility:onActivate(function( actor )
	actor:enter_state(stateNukeUtility)
end)

stateNukeUtility:onEnter(function( actor, data )
	data.exit_index = 14

	actor.image_index = 0
	actor.sprite_index = sprite_shoot3
	actor.image_speed = data.exit_index/overcharge_limit

	data.fired = 0

	NukeChargeStart(actor)
end)

stateNukeUtility:onStep(function( actor, data )
	actor:skill_util_fix_hspeed()

	if actor:is_authority() and ((not actor:control("skill3", 0) and actor:get_data().charge > 0) or NukeChargeStep(actor) == 1) then
		GM.actor_set_state_networked(actor, stateNukeUtilityFire)
	end
end)


stateNukeUtilityFire:onEnter(function( actor, data )
	actor.image_index = 14
	actor.sprite_index = sprite_shoot3

	data.ratio = NukeChargeRelease(actor)
	data.fired = 0
end)

stateNukeUtilityFire:onStep(function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:actor_animation_set(actor.sprite_index, 0.15)
	actor:set_immune(3)

	local down = gm.bool(actor.ropeDown) and 1 or 0
	local up = gm.bool(actor.ropeUp) and 1 or 0
	local left = gm.bool(actor.moveLeft) and 1 or 0
	local right = gm.bool(actor.moveRight) and 1 or 0

	local vertical = down - up
	local horizontal = right - left

	local speed_factor_h = math.max(1, 5 * data.ratio)
	local speed_factor_v = math.max(0.1, 3 * data.ratio)

	actor.pVspeed = vertical * speed_factor_v * actor.pVmax
	actor.pHspeed = horizontal * speed_factor_h * actor.pHmax
	actor.y = actor.y - 10

	if vertical == 0 and horizontal == 0 then
		actor.pVspeed = -speed_factor_v * actor.pVmax
	end
end)


-------- RADIONUCLIDE SURGE
nukeSpecial.sprite = sprite_skills
nukeSpecial.subimage = 3
nukeSpecial.cooldown = 13 * 60
nukeSpecial.damage = 3.0
nukeSpecial.require_key_press = true
nukeSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

nukeSpecialScepter.sprite = sprite_skills
nukeSpecialScepter.subimage = 4
nukeSpecialScepter.cooldown = 13 * 60
nukeSpecialScepter.damage = 3.0
nukeSpecialScepter.require_key_press = true
nukeSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateNukeSpecial = State.new(NAMESPACE, "nukeSpecial")

nukeSpecial:clear_callbacks()
nukeSpecial:onActivate(function( actor )
	actor:enter_state(stateNukeSpecial)
end)

nukeSpecialScepter:clear_callbacks()
nukeSpecialScepter:onActivate(function( actor )
	actor:enter_state(stateNukeSpecial)
end)

stateNukeSpecial:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 and sprite_shoot4S or sprite_shoot4
	actor.image_speed = 0.2

	data.fired = 0

	NukeChargeRelease(actor)
end)

stateNukeSpecial:onStep(function( actor, data )
	actor:set_immune(3)
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
end)

stateNukeSpecial:onExit(function( actor, data )
	actor:buff_apply(selfRadiation, 1.2 * 60, 1)
end)