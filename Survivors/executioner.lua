local SPRITE_PATH = path.combine(PATH, "Sprites/Executioner")
local SOUND_PATH = path.combine(PATH, "Sounds/Executioner")

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
local sprite_shoot2 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 4, 10, 20)
local sprite_shoot3 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 8, 44, 40)
local sprite_shoot4 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 14, 32, 69)
local sprite_shoot5 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot5", path.combine(SPRITE_PATH, "shoot5.png"), 14, 32, 69)

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

local executionerZ = executioner:get_primary()
local executionerX = executioner:get_secondary()
local executionerC = executioner:get_utility()
local executionerV = executioner:get_special()

-- service pistol
executionerZ.sprite = sprite_skills
executionerZ.subimage = 0

executionerZ.cooldown = 5
executionerZ.damage = 1.0
executionerZ.require_key_press = false
executionerZ.is_primary = true
executionerZ.does_change_activity_state = true
executionerZ.hold_facing_direction = true

local stateZ = State.new(NAMESPACE, "executionerZ")

executionerZ:clear_callbacks()
executionerZ:onActivate(function(actor)
	actor:enter_state(stateZ)
end)

stateZ:clear_callbacks()
stateZ:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.fired = 0 -- gamemaker bools are a pain to deal with in lua, so just use numbers instead

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)
stateZ:onStep(function(actor, data)
	--actor:actor_animation_set(sprite_shoot1, 0.25)
	actor.sprite_index2 = sprite_shoot1_half

	actor:skill_util_strafe_update(0.33 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	-- manually update half sprite offset because we cant do it how rorr does it sobs
	local walk_half = actor.sprite_walk_half
	local walk_offset = 0
	local leg_frame = math.floor(actor.image_index)

	if leg_frame == 1 or leg_frame == 5 then
		walk_offset = 1
	elseif leg_frame == 3 or leg_frame == 7 then
		walk_offset = -1
	end
	walk_half[3] = walk_offset

	if data.fired == 0 then
		data.fired = 1

		GM.sound_play_at(sound_shoot1, 1, 0.9 + math.random() * 0.2, actor.x, actor.y)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(executionerZ)
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
stateZ:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)

-- bang bang bang bang

executionerX.sprite = sprite_skills
executionerX.subimage = 2
executionerX.cooldown = -1
executionerX.damage = 3.2
executionerX.max_stock = 10
executionerX.auto_restock = false
executionerX.start_with_stock = false
executionerX.does_change_activity_state = true
executionerX.use_delay = 30

local stateX = State.new(NAMESPACE, "executionerX")

executionerX:clear_callbacks()
executionerX:onActivate(function(actor, skill)
	actor:enter_state(stateX)
end)
stateX:clear_callbacks()
stateX:onEnter(function(actor, data)
	actor.image_index = 0
	data.ion_rounds = actor.skills[2].active_skill.stock + 1 -- how many to fire. compensates for first stock being decremented already
	data.shoot = 1 -- tracks if a shot should be fired
	data.first = 1 -- if it was the first -- subsequent shots manually decrement skill stocks
end)
stateX:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2, 0.33)

	if data.ion_rounds > 0 and actor.image_index >= 2 then
		actor.image_index = 0
		data.shoot = 1
	end
	if data.shoot == 1 then
		data.ion_rounds = data.ion_rounds - 1
		data.shoot = 0

		GM.sound_play_at(sound_shoot2, 1.0, 0.9 + (data.ion_rounds * 0.02) + math.random() * 0.2, actor.x, actor.y)
		GM._mod_game_shakeScreen_global(2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(executionerX)
			local dir = actor:skill_util_facing_direction()

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks2, 9)
				attack:set_stun(1.0)
				attack.climb = i * 8
			end
		end

		if data.first == 0 then
			local skill = actor.skills[2].active_skill
			skill.stock = skill.stock - 1
		else
			data.first = 0
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add("onKillProc", "SSIonCharge", function(self, other, result, args)
	local killer = Instance.wrap(args[3].value)
	if killer.object_index == gm.constants.oP and killer.class == executioner_id then
		GM.actor_skill_add_stock(killer, 1)
	end
end)

-- scary
executionerC.sprite = sprite_skills
executionerC.subimage = 6
executionerC.cooldown = 7 * 60
executionerC.is_utility = true
executionerC.override_strafe_direction = true
executionerC.ignore_aim_direction = true

local stateC = State.new(NAMESPACE, "executionerC")
stateC.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

executionerC:clear_callbacks()
executionerC:onActivate(function(actor)
	actor:enter_state(stateC)
end)
stateC:clear_callbacks()
stateC:onEnter(function(actor, data)
	actor.image_index = 0
	data.scary = 0
end)
stateC:onStep(function(actor, data)
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.25

	actor.pHspeed = actor.pHmax * 2.2 * actor.image_xscale
	actor:set_immune(8)

	if data.scary == 0 then
		data.scary = 1

		GM.sound_play_at(sound_shoot3, 1.0, 1.0, actor.x, actor.y)

		if actor:is_authority() then
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

-- die die die
executionerV.sprite = sprite_skills
executionerV.subimage = 7
executionerV.cooldown = 8 * 60
executionerV.damage = 10

-- scepter'd version
local executionerVBoosted = Skill.new(NAMESPACE, "executionerVBoosted")
executionerV:set_skill_upgrade(executionerVBoosted)

executionerVBoosted.sprite = sprite_skills
executionerVBoosted.subimage = 8
executionerVBoosted.cooldown = 8 * 60
executionerVBoosted.damage = 15

local stateV = State.new(NAMESPACE, "executionerV")

executionerV:clear_callbacks()
executionerV:onActivate(function(actor)
	actor:enter_state(stateV)
end)
executionerVBoosted:clear_callbacks()
executionerVBoosted:onActivate(function(actor)
	actor:enter_state(stateV)
end)

stateV:clear_callbacks()
stateV:onEnter(function(actor, data)
	actor.image_index = 0
	actor.activity_type = 2 -- changes physics for the state. gravity is disabled and vertical velocity is uncapped.
	data.con = 0 -- keeps track of which part of the state we're in
	data.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter")) -- easier to do this rather than making a whole new state that does almost the same thing
	data.exheight = 0 -- how much to expand the aoe upwards
	data.recoveries = 0 -- how many times exe has retried to slam after being interrupted -- gives up after 3
end)
stateV:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	local animation = sprite_shoot4
	if data.scepter > 0 then
		animation = sprite_shoot5
	end
	actor:actor_animation_set(animation, 0.25)

	if data.con == 0 then -- leaping into the air
		actor.pVspeed = (actor.pVmax * -2) * actor.attack_speed
		data.con = 1
		GM.sound_play_at(sound_shoot4a, 1.0, 1.0, actor.x, actor.y)
	elseif data.con == 1 then -- decelerating, hanging in the air
		local deceleration = 0.5 * actor.attack_speed * actor.attack_speed -- squaring attack speed seems to prevent height gain from attack speed, i dont know math lmao
		actor.pVspeed = math.min(actor.pVspeed + deceleration, 0)

		if actor.image_index >= 7 then
			if actor.pVspeed >= 0 then
				data.con = 2
				actor.pVspeed = (actor.pVmax * -1.5) * actor.attack_speed
			else
				actor.image_index = 7
			end
		end
	elseif data.con == 2 then -- winding up
		if actor.image_index >= 9 then
			actor.pVspeed = 30 * actor.attack_speed
			data.con = 3
			data.exheight = 0
		end
	elseif data.con == 3 then -- coming down
		data.exheight = data.exheight + actor.pVspeed
		actor.image_index = 10

		if actor.pVspeed < 0 then -- something launched us -- go back and retry slam
			data.recoveries = data.recoveries + 1
			if data.recoveries > 3 then
				actor:skill_util_reset_activity_state() -- too many interruptions -- give up so we're not perma immune lmao
			else
				actor.image_index = 0
				data.con = 1
			end
		else
			actor.pVspeed = 30 * actor.attack_speed -- water slows exe down and without gravity he's left stuck, so always force to max speed'

			-- ugly check for having landed -- gamemaker bools suck
			if (actor.free == 0.0 or actor.free == false) then
				data.con = 4
				actor.activity_type = 1 -- return to standard state physics

				GM.sound_play_at(sound_shoot4b, 1.0, 1.0, actor.x, actor.y)
				GM._mod_game_shakeScreen_global(15)

				if actor:is_authority() then
					local ax = actor.x + 32 * actor.image_xscale
					local ay = actor.y + 24 - data.exheight * 0.5

					local damage = actor:skill_get_damage(executionerV)
					if data.scepter > 0 then
						damage = actor:skill_get_damage(executionerVBoosted)
					end

					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, actor:buff_stack_count(buff_shadow_clone) do
						local attack = actor:fire_explosion(ax, ay, 160, 32 + data.exheight, damage)
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

	if data.con < 4 then
		actor:set_immune(8)
	end
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add("onAttackHandleEnd", "SSExecutionCDR", function(self, other, result, args)
	local attack = args[2].value
	if attack.execution == 1 then
		local kill_count = attack.kill_number
		GM.actor_skill_reset_cooldowns(attack.parent, -60 * kill_count, true)
	end
end)
