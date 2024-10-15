
local SPRITE_PATH = path.combine(PATH, "Sprites/Executioner")
local SOUND_PATH = path.combine(PATH, "Sounds/Executioner")

local sprite_loadout = Resources.sprite_load(NAMESPACE, "ExecutionerSelect", path.combine(SPRITE_PATH, "select.png"), 17, 28, 5)
local sprite_portrait = Resources.sprite_load(NAMESPACE, "ExecutionerPortrait", path.combine(SPRITE_PATH, "portrait.png"))
local sprite_portrait_small = Resources.sprite_load(NAMESPACE, "ExecutionerPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills = Resources.sprite_load(NAMESPACE, "ExecutionerSkills", path.combine(SPRITE_PATH, "skills.png"), 9)

local sprite_shoot1 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot1", path.combine(SPRITE_PATH, "shoot1.png"), 5, 10, 17)
local sprite_shoot2 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 4, 10, 20)
local sprite_shoot3 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 8, 44, 40)
local sprite_shoot4 = Resources.sprite_load(NAMESPACE, "ExecutionerShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 14, 32, 69)

local sound_shoot1 = Resources.sfx_load(NAMESPACE, "ExecutionerShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2 = Resources.sfx_load(NAMESPACE, "ExecutionerShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3 = Resources.sfx_load(NAMESPACE, "ExecutionerShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a = Resources.sfx_load(NAMESPACE, "ExecutionerShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b = Resources.sfx_load(NAMESPACE, "ExecutionerShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))

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

local anims = {
	idle = Resources.sprite_load(NAMESPACE, "ExecutionerIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 12, 17),
	walk = Resources.sprite_load(NAMESPACE, "ExecutionerWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 14, 18),
	jump = Resources.sprite_load(NAMESPACE, "ExecutionerJump", path.combine(SPRITE_PATH, "jump.png"), 1, 6, 18),
	jump_peak = Resources.sprite_load(NAMESPACE, "ExecutionerJump", path.combine(SPRITE_PATH, "jump.png"), 1, 6, 18),
	fall = Resources.sprite_load(NAMESPACE, "ExecutionerJump", path.combine(SPRITE_PATH, "jump.png"), 1, 6, 18),
	climb = Resources.sprite_load(NAMESPACE, "ExecutionerClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 18),
}

executioner:set_animations(anims)

executioner:set_cape_offset(0, -8, 0, -12)

executioner.sprite_loadout = sprite_loadout
executioner.sprite_portrait = sprite_portrait
executioner.sprite_portrait_small = sprite_portrait_small
executioner.sprite_title = anims.walk

local executionerZ = executioner:get_primary()
local executionerX = executioner:get_secondary()
local executionerC = executioner:get_utility()
local executionerV = executioner:get_special()

executionerZ.sprite = sprite_skills
executionerZ.subimage = 0

executionerZ.cooldown = 5
executionerZ.damage = 1.0
executionerZ.require_key_press = false
executionerZ.is_primary = true
executionerZ.does_change_activity_state = true
executionerZ.hold_facing_direction = true

executionerX.sprite = sprite_skills
executionerX.subimage = 2
executionerX.cooldown = -1
executionerX.damage = 3.2
executionerX.max_stock = 10
executionerX.auto_restock = false
executionerX.start_with_stock = false
executionerX.does_change_activity_state = true

executionerC.sprite = sprite_skills
executionerC.subimage = 6
executionerC.cooldown = 4 * 60
executionerC.is_utility = true
executionerC.override_strafe_direction = true
executionerC.ignore_aim_direction = true

executionerV.sprite = sprite_skills
executionerV.subimage = 7
executionerV.cooldown = 8 * 60
executionerV.damage = 10

-- service pistol
local stateZ = State.new(NAMESPACE, "executionerZ")
executionerZ:clear_callbacks()
executionerZ:onActivate(function(actor)
	actor:enter_state(stateZ)
end)

stateZ:clear_callbacks()
stateZ:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0 -- gamemaker bools are a pain to deal with in lua, so just use numbers instead

	actor:skill_util_strafe_and_slide_init()
end)
stateZ:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot1, 0.25)
	actor:skill_util_strafe_and_slide(0.45)

	if data.fired == 0 then
		data.fired = 1

		GM.sound_play_at(sound_shoot1, 1.0, 1.0, actor.x, actor.y)

		local damage = actor:skill_get_damage(executionerZ)
		local dir = actor:skill_util_facing_direction()

		if actor:is_authority() then
			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks1, 8)
					attack.climb = i * 8
				end
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)
stateZ:onExit(function(actor, data)
	--actor:skill_util_strafe_exit() -- throws up errors, maybe only to be used for regular non-slide strafing?
end)

-- bang bang bang bang
local stateX = State.new(NAMESPACE, "executionerX")

executionerX:clear_callbacks()
executionerX:onActivate(function(actor)
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

		GM.sound_play_at(sound_shoot2, 1.0, 1.0, actor.x, actor.y)
		GM._mod_game_shakeScreen_global(2)

		local damage = actor:skill_get_damage(executionerX)
		local dir = actor:skill_util_facing_direction()

		if actor:is_authority() then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks2, 9)
				attack:set_stun(0.5)
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
local stateC = State.new(NAMESPACE, "executionerC")
stateC.activity_flags = 1

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

	if data.scary == 0 then
		data.scary = 1

		GM.sound_play_at(sound_shoot3, 1.0, 1.0, actor.x, actor.y)
		actor:set_immune(30)

		local cx, cy = actor.x, actor.y
		local fear = Buff.find("ror", "fear")
		local victims = List.new()
		actor:collision_rectangle_list(cx - 100, cy - 50, cx + 100, cy + 50, gm.constants.pActor, false, true, victims, false)

		for _, victim in ipairs(victims) do
			if victim.team ~= actor.team then
				victim:buff_apply(fear, 2 * 60)
			end
		end

		victims:destroy()
	end

	actor:skill_util_exit_state_on_anim_end()
end)

-- die die die
local stateV = State.new(NAMESPACE, "executionerV")

executionerV:clear_callbacks()
executionerV:onActivate(function(actor)
	actor:enter_state(stateV)
end)
stateV:clear_callbacks()
stateV:onEnter(function(actor, data)
	actor.image_index = 0
	data.yeet = 0 -- have we launched up?
	data.smited = 0 -- have we landed?
end)
stateV:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot4, 0.25)

	-- this is all a bit of a mess
	-- experimenting with having exe actually take time to land rather than teleporting instantly like in ss1
	if data.yeet == 0 then
		actor.pVspeed = (actor.pVmax * -2) * actor.attack_speed
		data.yeet = 1
		GM.sound_play_at(sound_shoot4a, 1.0, 1.0, actor.x, actor.y)
	end
	actor:set_immune(8)
	if actor.image_index >= 7 then
		actor.pVspeed = math.min(actor.pVspeed + 5.0 * actor.attack_speed, 80)
	else
		actor.pVspeed = math.min(actor.pVspeed + 0.1 * actor.attack_speed, -actor.pGravity1)
	end

	if actor.image_index >= 7 and (actor.free == 0.0 or actor.free == false) and data.smited == 0 then
		data.smited = 1
		GM.sound_play_at(sound_shoot4b, 1.0, 1.0, actor.x, actor.y)
		GM._mod_game_shakeScreen_global(15)

		if actor:is_authority() then
		local damage = actor:skill_get_damage(executionerV)
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack = actor:fire_explosion(actor.x, actor.y, 200, 100, damage)
				attack.climb = i * 8
			end
		end
	end

	if data.smited == 0 and actor.image_index >= 10 then
		actor.image_index = 10
	end
	actor:skill_util_exit_state_on_anim_end()
end)
