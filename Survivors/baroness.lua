local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Baroness")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Baroness")


local sprite_idle = Resources.sprite_load(NAMESPACE, "BaronessIdle", path.combine(SPRITE_PATH, "BaronessIdle.png"), 1, 15, 12)
local sprite_walk = Resources.sprite_load(NAMESPACE, "BaronessWalk", path.combine(SPRITE_PATH, "BaronessWalk.png"), 8, 17, 13, 0.8)
local sprite_jump = Resources.sprite_load(NAMESPACE, "BaronessJump", path.combine(SPRITE_PATH, "BaronessIdle.png"), 1, 18, 17)
local sprite_shoot = Resources.sprite_load(NAMESPACE, "BaronessShoot", path.combine(SPRITE_PATH, "BaronessShoot.png"), 1, 18, 17)


-- Sounds
local sound_shoot1 = Resources.sfx_load(NAMESPACE, "BaronessShoot1", path.combine(SOUND_PATH, "skill1a.ogg"))


-- Survivor Info
local baroness = Survivor.new(NAMESPACE, "baroness")
local baroness_id = baroness

baroness:set_stats_base({
	maxhp = 115,
	damage = 11,
	regen = 0.011,
})
baroness:set_stats_level({
	maxhp = 36,
	damage = 3,
	regen = 0.001,
	armor = 2,
})

baroness:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_idle,
	fall = sprite_idle,
	climb = sprite_idle,
	--death = sprite_death,
	--decoy = sprite_decoy,
})

baroness:set_primary_color(Color.from_rgb(250, 40, 40))

baroness.sprite_title = sprite_walk

-- Init states
local baronessShootPrimary = baroness:get_primary()

-- Baroness Primary
baronessShootPrimary.cooldown = 5
baronessShootPrimary.damage = 1.0
baronessShootPrimary.is_primary = true
baronessShootPrimary.require_key_press = false
baronessShootPrimary.does_change_activity_state = true
baronessShootPrimary.hold_facing_direction = true
baronessShootPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateBaronessShoot = State.new(NAMESPACE, "baronessShootPrimary")

baronessShootPrimary:clear_callbacks()
baronessShootPrimary:onActivate(function(actor)
	actor:enter_state(stateBaronessShoot)
end)

stateBaronessShoot:clear_callbacks()
stateBaronessShoot:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()

end)

stateBaronessShoot:onStep(function(actor, data)
	actor:skill_util_strafe_update(0.33 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if data.fired == 0 then
		data.fired = 1

		actor:sound_play(sound_shoot1, 1, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(baronessShootPrimary)
			local dir = actor:skill_util_facing_direction()

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks1, Attack_Info.TRACER.commando1)
					attack.climb = i * 8
				end
			end
		end
	end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)

stateBaronessShoot:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)