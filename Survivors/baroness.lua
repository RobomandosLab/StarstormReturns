local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Baroness")

local sprite_idle = Resources.sprite_load(NAMESPACE, "BaronessIdle", path.combine(SPRITE_PATH, "BaronessIdle.png"), 1, 15, 12)
local sprite_walk = Resources.sprite_load(NAMESPACE, "BaronessWalk", path.combine(SPRITE_PATH, "BaronessWalk.png"), 8, 17, 13, 0.8)
local sprite_jump = Resources.sprite_load(NAMESPACE, "BaronessJump", path.combine(SPRITE_PATH, "BaronessIdle.png"), 1, 18, 17)
local sprite_shoot = Resources.sprite_load(NAMESPACE, "BaronessShoot", path.combine(SPRITE_PATH, "BaronessShoot.png"), 1, 18, 17)


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
baronessShootPrimary.cooldown = 2 * 60
baronessShootPrimary.damage = 2
baronessShootPrimary.max_stock = 4
baronessShootPrimary.is_primary = true

local stateBaronessShoot = State.new(NAMESPACE, "baronessShootPrimary")

baronessShootPrimary:clear_callbacks()
baronessShootPrimary:onActivate(function(actor)
	actor:enter_state(stateBaronessShoot)
end)

stateBaronessShoot:clear_callbacks()
stateBaronessShoot:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

stateBaronessShoot:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot, 0.25)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wBullet2, 1, 1.4 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(stateBaronessShoot)
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

stateBaronessShoot:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)