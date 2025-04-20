local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Knight")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Knight")


-- assets as per usual
-- icons
local sprite_loadout =        Resources.sprite_load(NAMESPACE, "KnightSelect", path.combine(SPRITE_PATH, "Select.png"), 19, 2, 0)
local sprite_portrait =       Resources.sprite_load(NAMESPACE, "KnightPortrait", path.combine(SPRITE_PATH, "portrait.png"), 2)
local sprite_portrait_small = Resources.sprite_load(NAMESPACE, "KnightPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills =         Resources.sprite_load(NAMESPACE, "KnightSkills", path.combine(SPRITE_PATH, "skills.png"), 6)

-- non-skill sprites
local sprite_idle =           Resources.sprite_load(NAMESPACE, "KnightIdle", path.combine(SPRITE_PATH, "Idle.png"), 1, 8, 12)
local sprite_idle_half =      Resources.sprite_load(NAMESPACE, "KnightIdleHalf", path.combine(SPRITE_PATH, "IdleHalf.png"), 1, 8, 12)
local sprite_walk =           Resources.sprite_load(NAMESPACE, "KnightWalk", path.combine(SPRITE_PATH, "Walk.png"), 8, 8, 12)
local sprite_walk_half =      Resources.sprite_load(NAMESPACE, "KnightWalkHalf", path.combine(SPRITE_PATH, "WalkHalf.png"), 8, 8, 12)
local sprite_jump =           Resources.sprite_load(NAMESPACE, "KnightJump", path.combine(SPRITE_PATH, "Jump.png"), 1, 8, 12)
local sprite_jump_half =      Resources.sprite_load(NAMESPACE, "KnightJumpHalf", path.combine(SPRITE_PATH, "JumpHalf.png"), 1, 8, 12)
local sprite_climb =          Resources.sprite_load(NAMESPACE, "KnightClimb", path.combine(SPRITE_PATH, "Climb.png"), 2, 4, 8)
local sprite_death =          Resources.sprite_load(NAMESPACE, "KnightDeath", path.combine(SPRITE_PATH, "Death.png"), 9, 9, 11)
local sprite_decoy =          Resources.sprite_load(NAMESPACE, "KnightDecoy", path.combine(SPRITE_PATH, "Decoy.png"), 1, 9, 18)

-- skill sprites
local sprite_shoot1_1 =       Resources.sprite_load(NAMESPACE, "KnightShoot1_1", path.combine(SPRITE_PATH, "Shoot1_1.png"), 4, 8, 14)
local sprite_shoot1_1_half =  Resources.sprite_load(NAMESPACE, "KnightShoot1_1Half", path.combine(SPRITE_PATH, "Shoot1_1Half.png"), 4, 8, 14)
local sprite_shoot1_2 =       Resources.sprite_load(NAMESPACE, "KnightShoot1_2", path.combine(SPRITE_PATH, "Shoot1_2.png"),4, 8 ,16)
local sprite_shoot1_2_half =  Resources.sprite_load(NAMESPACE, "KnightShoot1_2Half", path.combine(SPRITE_PATH, "Shoot1_2Half.png"), 4, 8, 16)
local sprite_shoot1_3 =       Resources.sprite_load(NAMESPACE, "KnightShoot1_3", path.combine(SPRITE_PATH, "Shoot1_3.png"), 6, 8, 12)
local sprite_shoot2 =         Resources.sprite_load(NAMESPACE, "KnightShoot2", path.combine(SPRITE_PATH, "Shoot2.png"), 5, 8, 12)
local sprite_shoot2_half =    Resources.sprite_load(NAMESPACE, "KnightShoot2_Half", path.combine(SPRITE_PATH, "Shoot2_Half.png"), 5, 8, 12)
local sprite_shoot3 =         Resources.sprite_load(NAMESPACE, "KnightShoot3", path.combine(SPRITE_PATH, "Shoot3.png"), 7, 10, 22)
local sprite_shoot4 =         Resources.sprite_load(NAMESPACE, "KnightShoot4", path.combine(SPRITE_PATH, "Shoot4.png"), 18, 17, 19)

-- effect sprites
local sprite_sparks1 =        Resources.sprite_load(NAMESPACE, "KnightSparks1", path.combine(SPRITE_PATH, "Sparks1.png"), 4, 7, 7)
local sprite_sparks2 =		  Resources.sprite_load(NAMESPACE, "KnightSparks2", path.combine(SPRITE_PATH, "Sparks2.png"), 4, 10, 10)
local sprite_sparks3 =        Resources.sprite_load(NAMESPACE, "KnightSparks3", path.combine(SPRITE_PATH, "Shoot4Ef.png"), 5, 76, 19)

-- sounds
local sound_shoot1a =         Resources.sfx_load(NAMESPACE, "KnightShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b =         Resources.sfx_load(NAMESPACE, "KnightShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c =         Resources.sfx_load(NAMESPACE, "KnightShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot1d =         Resources.sfx_load(NAMESPACE, "KnightShoot1d", path.combine(SOUND_PATH, "skill1d.ogg"))
local sound_shoot2 =          Resources.sfx_load(NAMESPACE, "KnightShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot2_impact =   Resources.sfx_load(NAMESPACE, "Knightshoot2Impact", path.combine(SOUND_PATH, "skill2impact.ogg"))
local sound_shoot2_block =    Resources.sfx_load(NAMESPACE, "KnightShoot2Block", path.combine(SOUND_PATH, "skill2deflect.ogg"))
local sound_shoot3a =         Resources.sfx_load(NAMESPACE, "KnightShoot3a", path.combine(SOUND_PATH, "skill3a.ogg"))
local sound_shoot3b =         Resources.sfx_load(NAMESPACE, "KnightShoot3b", path.combine(SOUND_PATH, "skill3b.ogg"))
local sound_shoot4 =          Resources.sfx_load(NAMESPACE, "KnightShoot4", path.combine(SOUND_PATH, "skill4.ogg"))


-------- knight
local knight = Survivor.new(NAMESPACE, "knight")
local knight_id = knight.value


-- stats setup
knight:set_stats_base({
	maxhp = 101,
	damage = 13,
	regen = 0.0095
})

knight:set_stats_level({
	maxhp = 24,
	damage = 4.2,
	regen = 0.0013,
	armor = 3
})

-- animations setup
knight:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy
})

knight:set_cape_offset(0,0,0,0)
knight:set_primary_color(Color.from_rgb(234,183,121))

-- ui sprites setup
knight.sprite_loadout = sprite_loadout
knight.sprite_portrait = sprite_portrait
knight.sprite_portrait_small = sprite_portrait_small
knight.sprite_title = sprite_walk

-- strafing setup
knight:clear_callbacks()
knight:onInit(function( actor )
	local idle_half = Array.new()
	local walk_half = Array.new()
	local jump_half = Array.new()
	idle_half:push(sprite_idle, sprite_idle_half, 0)
	walk_half:push(sprite_walk, sprite_walk_half, 0, sprite_walk)
	jump_half:push(sprite_jump, sprite_jump_half, 0)

	actor.sprite_idle_half = idle_half
	actor.sprite_walk_half = walk_half
	actor.sprite_jump_half = jump_half
	actor.sprite_jump_peak_half = jump_half
	actor.sprite_fall_half = jump_half

	actor:survivor_util_init_half_sprites()
end)

-- skills setup
local knightPrimary =   knight:get_primary()
local knightSecondary = knight:get_secondary()
local knightUtility =   knight:get_utility()
local knightSpecial =   knight:get_special()

local knightSpecialScepter = Skill.new(NAMESPACE, "knightSpecialBoosted")
knightSpecial:set_skill_upgrade(knightSpecialScepter)

local knightShieldBash = Skill.new(NAMESPACE, "knightShieldBash")


-------- cling clash claanngg shrrrrrr shingg!
local combo = 0
local combo_window = 0.5
local combo_time = 0
local shoot1_sounds = {sound_shoot1a, sound_shoot1b, sound_shoot1c, sound_shoot1d}

knightPrimary.sprite = sprite_skills
knightPrimary.subimage = 0
knightPrimary.cooldown = 12
knightPrimary.damage = 1.5
knightPrimary.require_key_press = false
knightPrimary.is_primary = true
knightPrimary.does_change_activity_state = true
knightPrimary.hold_facing_direction = true
knightPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

knightShieldBash.sprite = sprite_skills
knightShieldBash.subimage = 5
knightShieldBash.damage = 3.0
knightShieldBash.cooldown = 0
knightShieldBash.require_key_press = true

local stateKnightPrimary = State.new(NAMESPACE, "knightPrimary")
local stateKnightShieldBash = State.new(NAMESPACE, "knightShieldBash")

knightPrimary:clear_callbacks()
knightPrimary:onActivate(function( actor )
	actor:enter_state(stateKnightPrimary)
end)

stateKnightPrimary:clear_callbacks()
stateKnightPrimary:onEnter(function( actor, data )
	actor.image_index2 = 0
	data.fired = 0

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

stateKnightPrimary:onStep(function( actor, data )
	if os.clock() - combo_time > combo_window then
		combo = 0
	end

	if combo == 0 then
		actor.sprite_index2 = sprite_shoot1_1_half
	else
		actor.sprite_index2 = sprite_shoot1_2_half
	end
	combo_time = os.clock()

	actor:skill_util_strafe_update(.15 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if data.fired == 0 then
		data.fired = 1
		
		actor:sound_play(shoot1_sounds[math.ceil(math.random() * 3 + 1)], .5, 0.9 + math.random() * 0.8)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightPrimary)
			local dir = gm.cos(gm.degtorad(actor:skill_util_facing_direction()))
			local sparks = combo == 0 and sprite_sparks1 or sprite_sparks2

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage, nil, sparks, true)
				end
			end
		end
	end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		if combo >= 1 then
			combo = 0
		else
			combo = combo + 1
		end
		actor:skill_util_reset_activity_state()
	end
end)

knightShieldBash:clear_callbacks()
knightShieldBash:onActivate(function( actor )
	actor:enter_state(stateKnightShieldBash)
end)

stateKnightShieldBash:clear_callbacks()
stateKnightShieldBash:onEnter(function( actor, data )
	data.fired = 0
	actor.image_index = 0
end)

stateKnightShieldBash:onStep(function( actor, data )
	actor.sprite_index = sprite_shoot1_3
	actor.image_speed = .25

	actor:skill_util_exit_state_on_anim_end()
end)

stateKnightShieldBash:onExit(function( actor, data )
	GM._mod_ActorSkillSlot_removeOverride(actor:actor_get_skill_slot(Skill.SLOT.primary), knightShieldBash, Skill.OVERRIDE_PRIORITY.cancel)
end)


-------- block. parry. DODGE!
knightSecondary.sprite = sprite_skills
knightSecondary.subimage = 1
knightSecondary.cooldown = 3 * 60
knightSecondary.require_key_press = false
knightSecondary.does_change_activity_state = true
knightSecondary.hold_facing_direction = true
knightSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateKnightSecondary = State.new(NAMESPACE, "knightSecondary")

local knightArmorBuff = Buff.new(NAMESPACE, "knightArmorBuff")
knightArmorBuff.show_icon = true
knightArmorBuff.is_timed = false

knightArmorBuff:clear_callbacks()
knightArmorBuff:onStatRecalc(function( actor )
	actor.armor = actor.armor + 100
end)

knightSecondary:clear_callbacks()
knightSecondary:onActivate(function( actor )
	actor:enter_state(stateKnightSecondary)
end)

stateKnightSecondary:clear_callbacks()
stateKnightSecondary:onEnter(function( actor, data )
	actor.image_index2 = 0
	data.exit = 0

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
	actor:buff_apply(knightArmorBuff)
	GM._mod_ActorSkillSlot_addOverride(actor:actor_get_skill_slot(Skill.SLOT.primary), knightShieldBash, Skill.OVERRIDE_PRIORITY.cancel)
end)

stateKnightSecondary:onStep(function( actor, data )
	actor.sprite_index2 = sprite_shoot2_half

	actor:skill_util_strafe_update(.25, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if data.exit == 1 then
		actor:skill_util_reset_activity_state()
	end

	if actor.image_index2 > 3 then
		actor.image_index2 = 3.1
	end

	local holding = gm.bool(actor.x_skill)
	if not holding then
		actor.image_index2 = 4
		data.exit = 1
	end
end)

stateKnightSecondary:onExit(function( actor, data )
	actor:buff_remove(knightArmorBuff)
end)