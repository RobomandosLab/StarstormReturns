local nemtress = Survivor.new("nemesisHuntress")

nemtress:set_stats_base({
	health = 90,
	damage = 12,
	regen = 0.006,
})

nemtress:set_stats_level({
	health = 32,
	damage = 3,
	regen = 0.0012,
	armor = 2,
})

Callback.add(nemtress.on_init, function(actor) 
	actor.sprite_idle = gm.constants.sHuntressIdle
	actor.sprite_walk = gm.constants.sHuntressWalk
	actor.sprite_jump = gm.constants.sHuntressJump
	actor.sprite_jump_peak = gm.constants.sHuntressJumpPeak
	actor.sprite_fall = gm.constants.sHuntressFall
	actor.sprite_climb = gm.constants.sHuntressClimb
	actor.sprite_death = gm.constants.sHuntressDeath
	actor.sprite_decoy = gm.constants.sHuntressDecoy
	actor.sprite_drone_idle = gm.constants.sDronePlayerHuntressIdle
	actor.sprite_drone_shoot = gm.constants.sDronePlayerHuntressShoot

    actor.sprite_idle_half = Array.new({gm.constants.sHuntressIdle, gm.constants.sHuntressIdleHalf, 0})
	actor.sprite_walk_half = Array.new({gm.constants.sHuntressWalk, gm.constants.sHuntressWalkHalf, 0})
	actor.sprite_jump_half = Array.new({gm.constants.sHuntressJump, gm.constants.sHuntressJumpHalf, 0})
	actor.sprite_jump_peak_half = Array.new({gm.constants.sHuntressJumpPeak, gm.constants.sHuntressJumpPeakHalf, 0})
	actor.sprite_fall_half = Array.new({gm.constants.sHuntressFall, gm.constants.sHuntressFallHalf, 0})

    actor:survivor_util_init_half_sprites()
end)

local primary = nemtress:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = nemtress:get_skills(Skill.Slot.SECONDARY)[1]
local utility = nemtress:get_skills(Skill.Slot.UTILITY)[1]
local special = nemtress:get_skills(Skill.Slot.SPECIAL)[1]



-- Bolt Axe
local primaryCharge = 0
local CHARGE_CAP = 100

primary.damage = 5
primary.require_key_press = false
primary.hold_facing_direction = true
primary.required_interrupt_priority = ActorState.InterruptPriority.ANY

local statePrimaryCharge = ActorState.new("nemtressPrimaryCharge")
local statePrimaryRelease = ActorState.new("nemtressPrimaryFire")

Callback.add(primary.on_activate, function(actor) 
    actor:set_state(statePrimaryCharge)
end)

Callback.add(statePrimaryCharge.on_enter, function(actor, data)
    actor:skill_util_strafe_init()
    primaryCharge = 0
end)

Callback.add(statePrimaryCharge.on_step, function(actor, data)
	actor:skill_util_strafe_update(0.22 * actor.attack_speed, 1)
	actor:skill_util_step_strafe_sprites()

     -- when this gets sprites have a point in the animation where it can go into a swipe and make it wait until that point to fire
    if actor:is_authority() and (not actor:control("skill1", 0) and primaryCharge > 15) then
		actor:set_state(statePrimaryRelease)
	end

    print(primaryCharge)
    if primaryCharge < CHARGE_CAP then
        primaryCharge = primaryCharge + 1
    end
end)

Callback.add(statePrimaryRelease.on_enter, function(actor, data)
    data.fired = 0

    data.damage = primary.damage * (primaryCharge/CHARGE_CAP)
    if primaryCharge == CHARGE_CAP then
        data.damage = data.damage * 1.5
    end
end)

Callback.add(statePrimaryRelease.on_step, function(actor, data)
    if data.fired == 0 then
        data.fired = 1

        if primaryCharge == CHARGE_CAP then
            actor:fire_explosion(actor.x + actor.image_xscale * 60, actor.y, 180, 65, data.damage)
            actor.x = actor.x + actor.image_xscale * 120
        else
            actor:fire_explosion(actor.x + actor.image_xscale * 25, actor.y, 80, 65, data.damage)
        end
    end

    GM.actor_set_state_networked(actor, -1) -- temp exits until this state plays an anim
end)

