local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Executioner")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Executioner")

-- assets.
local sprite_loadout = Resources.sprite_load(NAMESPACE, "ExecutionerSelect", path.combine(SPRITE_PATH, "select.png"), 1, 28, 0)
local sprite_portrait = Resources.sprite_load(NAMESPACE, "ExecutionerPortrait", path.combine(SPRITE_PATH, "portrait.png"))
local sprite_portrait_small = Resources.sprite_load(NAMESPACE, "ExecutionerPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills = Resources.sprite_load(NAMESPACE, "ExecutionerSkills", path.combine(SPRITE_PATH, "skills.png"), 9)

local sprite_idle = Resources.sprite_load(NAMESPACE, "ExecutionerIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 12, 17)
local sprite_idle_half = Resources.sprite_load(NAMESPACE, "ExecutionerIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 12, 17)
local sprite_walk = Resources.sprite_load(NAMESPACE, "ExecutionerWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 14, 18)
local sprite_walk_half = Resources.sprite_load(NAMESPACE, "ExecutionerWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 14, 18)
local sprite_jump = Resources.sprite_load(NAMESPACE, "ExecutionerJump", path.combine(SPRITE_PATH, "jump.png"), 1, 6, 13)
local sprite_jump_peak = sprite_jump -- placeholder
local sprite_fall = sprite_jump -- placeholder
local sprite_climb = Resources.sprite_load(NAMESPACE, "ExecutionerClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 18)
local sprite_death = Resources.sprite_load(NAMESPACE, "ExecutionerDeath", path.combine(SPRITE_PATH, "death.png"), 5, 14, 8)
local sprite_decoy = Resources.sprite_load(NAMESPACE, "ExecutionerDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 17, 16)

local sprite_shoot1 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot1", path.combine(SPRITE_PATH, "shoot1.png"), 5, 10, 17)
local sprite_shoot1_half = Resources.sprite_load(NAMESPACE, "ExecutionerShoot1Half", path.combine(SPRITE_PATH, "shoot1Half.png"), 5, 10, 17)
local sprite_shoot2a = Resources.sprite_load(NAMESPACE, "ExecutionerShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 6, 12, 25)
local sprite_shoot2b = Resources.sprite_load(NAMESPACE, "ExecutionerShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 6, 12, 25)
local sprite_shoot3 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 8, 44, 40)
local sprite_shoot4 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 14, 32, 69)
local sprite_shoot5 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot5", path.combine(SPRITE_PATH, "shoot5.png"), 14, 32, 69)

local sprite_sparks2 = Resources.sprite_load(NAMESPACE, "ExecutionerSparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 14, 11)

local sound_shoot1 = Resources.sfx_load(NAMESPACE, "ExecutionerShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2 = Resources.sfx_load(NAMESPACE, "ExecutionerShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3 = Resources.sfx_load(NAMESPACE, "ExecutionerShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a = Resources.sfx_load(NAMESPACE, "ExecutionerShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b = Resources.sfx_load(NAMESPACE, "ExecutionerShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))

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
})

executioner:set_cape_offset(0, -8, 0, -12)
executioner:set_primary_color(Color.from_rgb(175, 113, 126))

executioner.sprite_loadout = sprite_loadout
executioner.sprite_portrait = sprite_portrait
executioner.sprite_portrait_small = sprite_portrait_small
executioner.sprite_title = sprite_walk

executioner:clear_callbacks()
executioner:onInit(function(actor)
	-- setup half-sprite nonsense
	local idle_half = Array.new()
	local walk_half = Array.new()
	local jump_half = Array.new()
	local jump_peak_half = Array.new()
	local fall_half = Array.new()
	idle_half:push(sprite_idle, sprite_idle_half, 0)
	walk_half:push(sprite_walk, sprite_walk_half, 0)
	jump_half:push(sprite_jump, sprite_idle_half, 0)
	jump_peak_half:push(sprite_jump_peak, sprite_idle_half, 0)
	fall_half:push(sprite_fall, sprite_idle_half, 0)

	actor.sprite_idle_half = idle_half.value
	actor.sprite_walk_half = walk_half.value
	actor.sprite_jump_half = jump_half.value
	actor.sprite_jump_peak_half = jump_peak_half.value
	actor.sprite_fall_half = fall_half.value

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
executionerPrimary.is_primary = true
executionerPrimary.does_change_activity_state = true
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

	-- manually update half sprite offset because we cant do it how rorr does it sobs
	local walk_half_array = actor.sprite_walk_half
	local walk_offset = 0
	local leg_frame = math.floor(actor.image_index)

	-- upper body bobs up and down depending on the leg animation
	if leg_frame == 1 or leg_frame == 5 then
		walk_offset = 1
	elseif leg_frame == 3 or leg_frame == 7 then
		walk_offset = -1
	end
	walk_half_array[3] = walk_offset -- 3 is the vertical offset

	actor:skill_util_strafe_update(0.33 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if data.fired == 0 then
		data.fired = 1

		actor:sound_play(sound_shoot1, 1, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(executionerPrimary)
			local dir = actor:skill_util_facing_direction()

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks1, 8)
					attack.climb = i * 8
				end
			end
		end
	end

	if actor.image_index2 >= 5 then
		actor:skill_util_reset_activity_state()
	end
	--actor:skill_util_exit_state_on_anim_end() -- do not use in strafing states with half-sprites
end)
stateExecutionerPrimary:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)
stateExecutionerPrimary:onGetInterruptPriority(function(actor, data)
	-- enables extremely high attack rates -- allow interrupting if the next frame is calculated to reach the end of the anim
	-- FIXME: breaks strafe turn updating
	if actor.image_index2 + 0.33 * actor.attack_speed >= 5 then
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
executionerSecondary.does_change_activity_state = true
executionerSecondary.use_delay = 30
executionerSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateExecutionerSecondary = State.new(NAMESPACE, "executionerSecondary")

executionerSecondary:clear_callbacks()
executionerSecondary:onActivate(function(actor, skill)
	actor:enter_state(stateExecutionerSecondary)
end)
stateExecutionerSecondary:clear_callbacks()
stateExecutionerSecondary:onEnter(function(actor, data)
	actor.image_index = 0
	data.ion_rounds = actor.skills[2].active_skill.stock + 1 -- compensate for first stock being decremented already
	data.should_fire = 1
	data.is_first_shot = 1
	data.sprite = sprite_shoot2a
end)
stateExecutionerSecondary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(data.sprite, 0.33)

	if data.ion_rounds > 0 and actor.image_index + 0.33 * actor.attack_speed > 2 then
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
				local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks13, 9)
				attack:set_stun(1.0)
				attack.climb = i * 8
			end
		end

		if data.is_first_shot == 0 then
			local skill = actor.skills[2].active_skill
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

Callback.add("onKillProc", "SSIonCharge", function(self, other, result, args)
	local killer = Instance.wrap(args[3].value)
	if killer.object_index == gm.constants.oP and killer.class == executioner_id then
		GM.actor_skill_add_stock_networked(killer, 1)
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

	if data.feared == 0 then
		data.feared = 1

		actor:sound_play(sound_shoot3, 1.0, 1.0)

		-- buff application is host-side
		if not GM._mod_net_isClient() then
			-- fear rectangle gets expanded in the direction that exe is dashing
			local left, right = actor.x - 100, actor.x + 100
			local bias = 1.1 * actor.pHspeed * 30 -- extrapolate distance in 0.5 sec, 1.1x multiplier to account for momentum
			left = math.min(left, left + bias)
			right = math.max(right, right + bias)

			local fear = Buff.find("ror", "fear")
			local victims = List.new()
			actor:collision_rectangle_list(left, actor.y - 48, right, actor.y + 48, gm.constants.pActor, false, true, victims, false)

			for _, victim in ipairs(victims) do
				if victim.team ~= actor.team then
					victim:buff_apply(fear, 2 * 60)
				end
			end

			victims:destroy()
		end
	end

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

local stateExecutionerSpecial = State.new(NAMESPACE, "executionerSpecial")

executionerSpecial:clear_callbacks()
executionerSpecial:onActivate(function(actor)
	actor:enter_state(stateExecutionerSpecial)
end)
executionerSpecialScepter:clear_callbacks()
executionerSpecialScepter:onActivate(function(actor)
	actor:enter_state(stateExecutionerSpecial)
end)

stateExecutionerSpecial:clear_callbacks()
stateExecutionerSpecial:onEnter(function(actor, data)
	actor.image_index = 0
	actor.activity_type = 2 -- changes physics for the state. gravity is disabled and vertical velocity is uncapped.

	data.substate = 0
	data.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
	data.aoe_height = 0
	data.recovery_attempts = 0
end)
stateExecutionerSpecial:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	local animation = sprite_shoot4
	if data.scepter > 0 then
		animation = sprite_shoot5
	end
	actor:actor_animation_set(animation, 0.25)

	if data.substate == 0 then -- leaping into the air
		actor.pVspeed = (actor.pVmax * -2) * actor.attack_speed
		data.substate = 1
		actor:sound_play(sound_shoot4a, 1.0, 1.0)
	elseif data.substate == 1 then -- decelerating, hanging in the air
		local deceleration = 0.5 * actor.attack_speed * actor.attack_speed -- squaring attack speed seems to prevent height gain from attack speed, i dont know math lmao
		actor.pVspeed = math.min(actor.pVspeed + deceleration, 0)

		if actor.image_index >= 7 then
			if actor.pVspeed >= 0 then
				data.substate = 2
				actor.pVspeed = (actor.pVmax * -1.5) * actor.attack_speed
			else
				actor.image_index = 7
			end
		end
	elseif data.substate == 2 then -- winding up
		if actor.image_index >= 9 then
			actor.pVspeed = 30 * actor.attack_speed
			data.substate = 3
			data.aoe_height = 0
		end
	elseif data.substate == 3 then -- coming down
		data.aoe_height = data.aoe_height + actor.pVspeed
		actor.image_index = 10

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
			actor.pVspeed = 30 * actor.attack_speed -- water slows exe down and without gravity he's left stuck, so always force to max speed'

			-- ugly check for having landed -- gamemaker bools suck
			if (actor.free == 0.0 or actor.free == false) then
				data.substate = 4
				actor.activity_type = 1 -- return to standard state physics

				actor:sound_play(sound_shoot4b, 1.0, 1.0)
				actor:screen_shake(15)

				-- this makes me sad, but execution's damage has to be host-side in order for the cdr to work
				-- because onAttackHandleEnd and its related callbacks only run host-side, and the host confirms kills
				if not GM._mod_net_isClient() then
					local ax = actor.x + 32 * actor.image_xscale
					local ay = actor.y + 24 - data.aoe_height * 0.5

					local damage = actor:skill_get_damage(executionerSpecial)
					if data.scepter > 0 then
						damage = actor:skill_get_damage(executionerSpecialScepter)
					end

					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, actor:buff_stack_count(buff_shadow_clone) do
						local attack = actor:fire_explosion(ax, ay, 160, 32 + data.aoe_height, damage)
						attack.climb = i * 8
						attack.y = actor.y
						attack.execution = 1
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

Callback.add("onAttackHandleEnd", "SSExecutionCDR", function(self, other, result, args)
	local attack = args[2].value
	if attack.execution == 1 then
		local kill_count = attack.kill_number
		GM.actor_skill_reset_cooldowns(attack.parent, -60 * kill_count, true, false, true)
	end
end)
