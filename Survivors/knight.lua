local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Knight")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Knight")


-- assets as per usual
-- icons
local sprite_loadout =        Sprite.new("KnightSelect", path.combine(SPRITE_PATH, "Select.png"), 19, 2, 0)
local sprite_portrait =       Sprite.new("KnightPortrait", path.combine(SPRITE_PATH, "portrait.png"), 2)
local sprite_portrait_small = Sprite.new("KnightPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills =         Sprite.new("KnightSkills", path.combine(SPRITE_PATH, "skills.png"), 6)

-- non-skill sprites
local sprite_idle =           Sprite.new("KnightIdle", path.combine(SPRITE_PATH, "Idle.png"), 1, 8, 12)
local sprite_idle_half =      Sprite.new("KnightIdleHalf", path.combine(SPRITE_PATH, "IdleHalf.png"), 1, 8, 12)
local sprite_walk =           Sprite.new("KnightWalk", path.combine(SPRITE_PATH, "Walk.png"), 8, 8, 12)
local sprite_walk_half =      Sprite.new("KnightWalkHalf", path.combine(SPRITE_PATH, "WalkHalf.png"), 8, 8, 12)
local sprite_jump =           Sprite.new("KnightJump", path.combine(SPRITE_PATH, "Jump.png"), 1, 8, 12)
local sprite_jump_half =      Sprite.new("KnightJumpHalf", path.combine(SPRITE_PATH, "JumpHalf.png"), 1, 8, 12)
local sprite_climb =          Sprite.new("KnightClimb", path.combine(SPRITE_PATH, "Climb.png"), 2, 4, 8)
local sprite_death =          Sprite.new("KnightDeath", path.combine(SPRITE_PATH, "Death.png"), 9, 9, 11)
local sprite_decoy =          Sprite.new("KnightDecoy", path.combine(SPRITE_PATH, "Decoy.png"), 1, 9, 18)

-- skill sprites
local sprite_shoot1_1 =       Sprite.new("KnightShoot1_1", path.combine(SPRITE_PATH, "Shoot1_1.png"), 4, 8, 14)
local sprite_shoot1_1_half =  Sprite.new("KnightShoot1_1Half", path.combine(SPRITE_PATH, "Shoot1_1Half.png"), 4, 8, 14)
local sprite_shoot1_2 =       Sprite.new("KnightShoot1_2", path.combine(SPRITE_PATH, "Shoot1_2.png"),4, 8 ,16)
local sprite_shoot1_2_half =  Sprite.new("KnightShoot1_2Half", path.combine(SPRITE_PATH, "Shoot1_2Half.png"), 4, 8, 16)
local sprite_shoot1_3 =       Sprite.new("KnightShoot1_3", path.combine(SPRITE_PATH, "Shoot1_3.png"), 6, 8, 12)
local sprite_shoot2 =         Sprite.new("KnightShoot2", path.combine(SPRITE_PATH, "Shoot2.png"), 5, 8, 12)
local sprite_shoot2_half =    Sprite.new("KnightShoot2_Half", path.combine(SPRITE_PATH, "Shoot2_Half.png"), 5, 8, 12)
local sprite_shoot3 =         Sprite.new("KnightShoot3", path.combine(SPRITE_PATH, "Shoot3.png"), 7, 10, 22)
local sprite_shoot4 =         Sprite.new("KnightShoot4", path.combine(SPRITE_PATH, "Shoot4.png"), 18, 17, 19)

-- effect sprites
local sprite_sparks1 =        Sprite.new("KnightSparks1", path.combine(SPRITE_PATH, "Sparks1.png"), 4, 7, 7)
local sprite_sparks2 =		  Sprite.new("KnightSparks2", path.combine(SPRITE_PATH, "Sparks2.png"), 4, 10, 10)
local sprite_sparks3 =        Sprite.new("KnightSparks3", path.combine(SPRITE_PATH, "Shoot4Ef.png"), 5, 76, 19)
local sprite_invigorate =     Sprite.new("KnightInvigorateBuff", path.combine(SPRITE_PATH, "buff.png"), 1, 9, 9)

-- sounds
local sound_shoot1a =         Sound.new("KnightShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b =         Sound.new("KnightShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c =         Sound.new("KnightShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot1d =         Sound.new("KnightShoot1d", path.combine(SOUND_PATH, "skill1d.ogg"))
local sound_shoot2 =          Sound.new("KnightShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot2_impact =   Sound.new("Knightshoot2Impact", path.combine(SOUND_PATH, "skill2impact.ogg"))
local sound_shoot2_deflect =  Sound.new("KnightShoot2Block", path.combine(SOUND_PATH, "skill2deflect.ogg"))
local sound_shoot3a =         Sound.new("KnightShoot3a", path.combine(SOUND_PATH, "skill3a.ogg"))
local sound_shoot3b =         Sound.new("KnightShoot3b", path.combine(SOUND_PATH, "skill3b.ogg"))
local sound_shoot4 =          Sound.new("KnightShoot4", path.combine(SOUND_PATH, "skill4.ogg"))


-------- knight
local knight = Survivor.new("knight")
local __quality = 3

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

knight:onInit(function(actor) -- setting up the beasts half sprite stuff
	-- shoutouts to kris for the awesome code i can entirely copy!!
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

local knightPrimaryAlt = Skill.new(NAMESPACE, "knightGreatsword")
knight:add_primary(knightPrimaryAlt)

local knightSecondaryAlt = Skill.new(NAMESPACE, "knightGuard")
knight:add_secondary(knightSecondaryAlt)

local knightSpecialAlt = Skill.new(NAMESPACE, "knightBanner")
knight:add_special(knightSpecialAlt)
local knightSpecialAltScepter = Skill.new(NAMESPACE, "knightBannerScepter")
knightSpecialAlt:set_skill_upgrade(knightSpecialAltScepter)


-- parry enhanced skills
local knightShieldBash = Skill.new(NAMESPACE, "knightShieldBash")
local knightShockwave = Skill.new(NAMESPACE, "knightShockwave")
local knightBeyblade = Skill.new(NAMESPACE, "knightBeyblade")
local knightShieldOrbit = Skill.new(NAMESPACE, "knightShieldOrbit")
local knightShieldOrbitScepter = Skill.new(NAMESPACE, "knightShieldOrbitScepter")
local knightConsecrate = Skill.new(NAMESPACE, "knightConsecrate")
local knightConsecrateScepter = Skill.new(NAMESPACE, "knightConsecrateScepter")

local knightRetaliate = Skill.new(NAMESPACE, "knightRetaliate")


-------- DUEL!
local combo = 0
local combo_window = 0.5 * 60
local combo_time = 0
local shoot1_sounds = {sound_shoot1a, sound_shoot1b, sound_shoot1c, sound_shoot1d}

knightPrimary.sprite = sprite_skills
knightPrimary.subimage = 0
knightPrimary.cooldown = 12
knightPrimary.damage = 1.1
knightPrimary.require_key_press = false
knightPrimary.is_primary = true
knightPrimary.does_change_activity_state = true
knightPrimary.hold_facing_direction = true
knightPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateKnightPrimary = State.new(NAMESPACE, "knightPrimary")

-- actual skill
knightPrimary:onActivate(function( actor )
	actor:enter_state(stateKnightPrimary)
end)

stateKnightPrimary:onEnter(function( actor, data )
	actor.image_index = 0
	data.fired = 0
end)

stateKnightPrimary:onStep(function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(actor.sprite_index, 0.15)

	if Global._current_frame - combo_time > combo_window then
		combo = 0
	end

	if combo == 0 then
		actor.sprite_index = sprite_shoot1_1
	else
		actor.sprite_index = sprite_shoot1_2
	end

	combo_time = Global._current_frame

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(shoot1_sounds[math.ceil(math.random() * 3 + 1)], .5, 0.9 + math.random() * 0.8)
		actor:skill_util_nudge_forward(5 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightPrimary)
			local dir = actor.image_xscale
			local sparks = combo == 0 and sprite_sparks1 or sprite_sparks2

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage, nil, sparks)
				end
			end
		end
	end

	if actor.image_index + actor.image_speed >= actor.image_number then
		if combo >= 1 then
			combo = 0
		else
			combo = combo + 1
		end
		actor:skill_util_reset_activity_state()
	end
end)


-------- CLASH!
local hit_enemies_shieldbash

knightShieldBash.sprite = sprite_skills
knightShieldBash.subimage = 5
knightShieldBash.damage = 3
knightShieldBash.cooldown = 0
knightShieldBash.require_key_press = true
knightShieldBash.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightShieldBash = State.new(NAMESPACE, "knightShieldBash")

-- actual skill
knightShieldBash:onActivate(function( actor )
	actor:enter_state(stateKnightShieldBash)
end)

stateKnightShieldBash:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot1_3
	actor.image_speed = .25

	data.fired = 0
	data.previous_index = 0

	hit_enemies_shieldbash = List.new()
end)

stateKnightShieldBash:onStep(function( actor, data )
	actor.pHspeed = (2 * actor.pHmax * actor.image_xscale) - (0.75 * actor.image_index * actor.image_xscale)
	actor:set_immune(3)

	if data.fired == 0 then
		data.fired = 1
		actor.pHspeed = 2.5 * actor.pHmax * actor.image_xscale
		actor:sound_play(sound_shoot2_impact, 0.5, 0.8)
	end

	if data.previous_index < math.floor(actor.image_index) then
		data.previous_index = data.previous_index + 1

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightShieldBash)
			local dir = actor.image_xscale
			local targets = List.new()

			local x_size = 25
			local y_size = 25

			actor:collision_rectangle_list(actor.x - x_size, actor.y + y_size, actor.x + x_size, actor.y - y_size, gm.constants.pActor, false, true, targets, false)

			for _, target in ipairs(targets) do
				if target.team ~= actor.team then
					local cannot_be_hit = 0
					for _, previous in ipairs(hit_enemies_shieldbash) do
						if target.value == previous.value then 
							cannot_be_hit = 1
						end
					end

					if cannot_be_hit == 0 then
						local buff_shadow_clone = Buff.find("ror", "shadowClone")
						for i=0, actor:buff_stack_count(buff_shadow_clone) do
							attack = actor:fire_direct(target, damage, dir, actor.x, actor.y, sprite_sparks2, true)
							attack.attack_info:allow_stun()
							attack.attack_info:set_stun(3, dir, standard)
						end

						table.insert(hit_enemies_shieldbash, target)
					end
				end
			end

			targets:destroy()
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

stateKnightShieldBash:onExit(function( actor, data )
	hit_enemies_shieldbash:destroy()
end)


-------- VANQUISH!
local alt_combo = 0
local alt_combo_window = 0.5 * 60
local alt_combo_time = 0

knightPrimaryAlt.sprite = sprite_skills
knightPrimaryAlt.subimage = 0
knightPrimaryAlt.damage = 2
knightPrimaryAlt.require_key_press = false
knightPrimaryAlt.is_primary = true
knightPrimaryAlt.does_change_activity_state = true
knightPrimaryAlt.hold_facing_direction = true
knightPrimaryAlt.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateKnightGreatsword = State.new(NAMESPACE, "knightGreatsword")

knightPrimaryAlt:onActivate(function( actor )
	actor:enter_state(stateKnightGreatsword)
end)

stateKnightGreatsword:onEnter(function( actor, data )
	actor.image_index = 0
	data.fired = 0
end)

stateKnightGreatsword:onStep(function( actor, data )
	actor:skill_util_fix_hspeed()
	
	if Global._current_frame - alt_combo_time > alt_combo_window then
		alt_combo = 0
	end

	if alt_combo == 0 then
		actor.sprite_index = sprite_shoot1_1
		actor:actor_animation_set(actor.sprite_index, 0.1)
	elseif alt_combo == 1 then
		actor.sprite_index = sprite_shoot1_2
		actor:actor_animation_set(actor.sprite_index, 0.11)
	else
		actor.sprite_index = sprite_shoot1_2
		actor:actor_animation_set(actor.sprite_index, 0.07)
	end

	alt_combo_time = Global._current_frame

	if data.fired == 0 then
		if alt_combo == 2 then
			data.fired = 1
			actor:sound_play(gm.constants.wTurtleExplosion, 1, 0.5 + math.random() * 0.8)
			actor:skill_util_nudge_forward(12 * actor.image_xscale)

			if actor:is_authority() then
				local damage = actor:skill_get_damage(knightPrimaryAlt)
				local dir = actor.image_xscale

				if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, actor:buff_stack_count(buff_shadow_clone) do
						attack = actor:fire_explosion(actor.x + dir * 80, actor.y + 10, 180, 150, damage * 2, gm.constants.sEnforcerGrenadeExplosion, sprite_sparks1)
						attack.attack_info.knockback = 8
						attack.attack_info.knockback_direction = dir
						attack.attack_info:allow_stun()
						attack.attack_info:set_stun(1, dir, standard)
					end
				end
			end
		else
			data.fired = 1
			actor:sound_play(shoot1_sounds[math.ceil(math.random() * 3 + 1)], .5, 0.5 + math.random() * 0.8)
			actor:skill_util_nudge_forward(8 * actor.image_xscale)

			if actor:is_authority() then
				local damage = actor:skill_get_damage(knightPrimaryAlt)
				local dir = actor.image_xscale

				if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, actor:buff_stack_count(buff_shadow_clone) do
						attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 60, damage, nil, sprite_sparks1)
						attack.attack_info.knockback = 4
						attack.attack_info.knockback_direction = dir
					end
				end
			end
		end
	end

	if actor.image_index + actor.image_speed >= actor.image_number then
		if alt_combo >= 2 then
			alt_combo = 0
		else
			alt_combo = alt_combo + 1
		end
		actor:skill_util_reset_activity_state()
	end
end)


-------- ERADICATE!
objShockwaveSpawner = Object.new(NAMESPACE, "knightShockwaveSpawner")

objShockwaveSpawner:onCreate(function( inst )
	inst.parent = -4
	inst.dir = 1
	inst.offset = 60

	inst.start = Global._current_frame
	inst.length = 10
end)

objShockwaveSpawner:onStep(function( inst )
	if Global._current_frame - inst.start >= 5 then
		inst.start = Global._current_frame

		inst.parent:fire_explosion(inst.x + inst.offset * inst.dir, inst.y + 10, 31, 116, 2.0, gm.constants.sGeyser)
		inst.offset = inst.offset + 50

		inst.length = inst.length - 1
	end

	if inst.length <= 0 then
		inst:destroy()
	end
end)

knightShockwave.sprite = sprite_skills
knightShockwave.subimage = 4
knightShockwave.damage = 3
knightShockwave.cooldown = 0 
knightShockwave.require_key_press = true
knightShockwave.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightShockwave = State.new(NAMESPACE, "knightShockwave")

knightShockwave:onActivate(function( actor )
	actor:enter_state(stateKnightShockwave)
end)

stateKnightShockwave:onEnter(function( actor, data )
	actor.image_index = 0
	data.fired = 0
end)

stateKnightShockwave:onStep(function( actor, data )
	actor.sprite_index = sprite_shoot1_2
	actor:actor_animation_set(actor.sprite_index, 0.06)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wTurtleExplosion, 1, 0.5 + math.random() * 0.8)
		actor:skill_util_nudge_forward(12 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightShockwave)
			local dir = actor.image_xscale

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x + dir * 60, actor.y + 10, 120, 100, damage * 1.5, gm.constants.sEnforcerGrenadeExplosion, sprite_sparks1)
				attack.attack_info.knockback = 6
				attack.attack_info.knockback_direction = dir
			end
		end

		local shockwave = objShockwaveSpawner:create(actor.x, actor.y)
		shockwave.parent = actor
		shockwave.dir = actor.image_xscale
	end

	actor:skill_util_exit_state_on_anim_end()
end)


-------- CONTEND!
local blocking = 0
local parry_window = 0.5 * 60
local parry_start
local react_window = 1.5 * 60
local react_start 

knightSecondary.sprite = sprite_skills
knightSecondary.subimage = 1
knightSecondary.damage = 1.0
knightSecondary.cooldown = 3 * 60
knightSecondary.require_key_press = false
knightSecondary.does_change_activity_state = true
knightSecondary.hold_facing_direction = true
knightSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill

local stateKnightSecondary = State.new(NAMESPACE, "knightSecondary")
local stateKnightParry = State.new(NAMESPACE, "knightParry")

-- extra armor when guarding
local knightArmorBuff = Buff.new(NAMESPACE, "knightArmorBuff")
knightArmorBuff.show_icon = false
knightArmorBuff.is_timed = false

knightArmorBuff:onStatRecalc(function( actor )
	actor.armor = actor.armor + 100
end)

-- actual skill
knightSecondary:onActivate(function( actor )
	actor:enter_state(stateKnightSecondary)
end)

stateKnightSecondary:onEnter(function( actor, data )
	actor.image_index2 = 0
	actor.deflect = 1

	data.exit = 0
	data.primed = 0

	blocking = 1
	parry_start = Global._current_frame

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
	actor:buff_apply(knightArmorBuff, 1, 1)
	actor:freeze_active_skill(Skill.SLOT.secondary)
end)


stateKnightSecondary:onStep(function( actor, data ) -- ok ill break this state down because its a bunch of stuff
	-- set up strafing
	actor.sprite_index2 = sprite_shoot2_half
	actor:skill_util_strafe_update(.25, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	-- freezes the animation while being held
	if actor.image_index2 > 3 then
		actor.image_index2 = 3.1
	end

	-- plays the sound when the skill is first used
	if data.primed == 0 then
		data.primed = 1
		actor:sound_play(sound_shoot2, .5, 1.2)
	end

	-- puts you in the parry state so you can choose a powered up ability
	if actor.deflect == 2 then
		actor:sound_play(sound_shoot2_deflect, .6, 1)

		local damage = actor:skill_get_damage(knightSecondary)

		local invigorateArea = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle)
		invigorateArea.radius = 80
		invigorateArea.rate = 5
		invigorateArea.image_blend = Color.from_rgb(220,228,164)

		if actor:is_authority() then -- just a fun little parry blast yayyyy
			local damage = actor:skill_get_damage(knightSecondary)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x, actor.y, 150, 150, damage, sprite_sparks3, nil, true)
				attack.attack_info:allow_stun()
				attack.attack_info:set_stun(1, actor.image_xscale, standard)
			end
		end

		actor:enter_state(stateKnightParry) -- this is your decision state where you can pick an empowered skill
	end

	-- turns off the parry window once its been a set amount of time
	if Global._current_frame - parry_start > parry_window then
		actor.deflect = 0
	end

	actor:freeze_active_skill(Skill.SLOT.secondary)

	-- turns off the skill once you let go of the key
	if actor:is_authority() and not actor:control("skill2", 0) then
		GM.actor_set_state_networked(actor, -1)
	end
end)

stateKnightSecondary:onExit(function( actor, data )
	actor:sound_play(sound_shoot2, .5, 0.8)
	actor:buff_remove(knightArmorBuff, 1)

	blocking = 0
	actor.deflect = 0
end)

stateKnightParry:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_decoy

	react_start = Global._current_frame

	
	if actor:get_default_skill(Skill.SLOT.primary).skill_id == knightPrimary.value then
		actor:add_skill_override(Skill.SLOT.primary, knightShieldBash, 1)
	elseif actor:get_default_skill(Skill.SLOT.primary).skill_id == knightPrimaryAlt.value then
		actor:add_skill_override(Skill.SLOT.primary, knightShockwave, 1)
	end

	actor:add_skill_override(Skill.SLOT.utility, knightBeyblade, 1)

	if actor:get_default_skill(Skill.SLOT.special).skill_id == knightSpecial.value then
		if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
			actor:add_skill_override(Skill.SLOT.special, knightShieldOrbitScepter, 1)
		else
			actor:add_skill_override(Skill.SLOT.special, knightShieldOrbit, 1)
		end
	elseif actor:get_default_skill(Skill.SLOT.special).skill_id == knightSpecialAlt.value then
		if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
			actor:add_skill_override(Skill.SLOT.special, knightConsecrateScepter, 1)
		else
			actor:add_skill_override(Skill.SLOT.special, knightConsecrate, 1)
		end
	end
end)

stateKnightParry:onStep(function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:set_immune(3)

	if Global._current_frame - react_start >= react_window then
		actor:skill_util_reset_activity_state()
	end
end)

stateKnightParry:onExit(function( actor, data )
	if actor:get_default_skill(Skill.SLOT.primary).skill_id == knightPrimary.value then
		actor:remove_skill_override(Skill.SLOT.primary, knightShieldBash, 1)
	elseif actor:get_default_skill(Skill.SLOT.primary).skill_id == knightPrimaryAlt.value then
		actor:remove_skill_override(Skill.SLOT.primary, knightShockwave, 1)
	end

	actor:remove_skill_override(Skill.SLOT.utility, knightBeyblade, 1)

	if actor:get_default_skill(Skill.SLOT.special).skill_id == knightSpecial.value then
		if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
			actor:remove_skill_override(Skill.SLOT.special, knightShieldOrbitScepter, 1)
		else
			actor:remove_skill_override(Skill.SLOT.special, knightShieldOrbit, 1)
		end
	elseif actor:get_default_skill(Skill.SLOT.special).skill_id == knightSpecialAlt.value then
		if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
			actor:remove_skill_override(Skill.SLOT.special, knightConsecrateScepter, 1)
		else
			actor:remove_skill_override(Skill.SLOT.special, knightConsecrate, 1)
		end
	end
end)


-------- PREVAIL!
local tanking = 0
local parried_hits = 0
local tanked_damage = 0

knightSecondaryAlt.sprite = sprite_skills
knightSecondaryAlt.subimage = 1
knightSecondaryAlt.damage = 1.0
knightSecondaryAlt.cooldown = 5 * 60
knightSecondaryAlt.require_key_press = false
knightSecondaryAlt.does_change_activity_state = true
knightSecondaryAlt.hold_facing_direction = true
knightSecondaryAlt.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill

local stateKnightSecondaryAlt = State.new(NAMESPACE, "knightSecondaryAlt")

knightSecondaryAlt:onActivate(function( actor )
	actor:enter_state(stateKnightSecondaryAlt)
	actor:add_skill_override(Skill.SLOT.secondary, knightRetaliate, 1)
end)

stateKnightSecondaryAlt:onEnter(function( actor, data )
	actor.image_index2 = 0
	actor.deflect = 1

	data.exit = 0
	data.primed = 0

	tanking = 1
	parry_start = Global._current_frame

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
	actor:buff_apply(knightArmorBuff, 1, 1)
	actor:freeze_active_skill(Skill.SLOT.secondary)
end)

stateKnightSecondaryAlt:onStep(function( actor, data )
	actor.sprite_index2 = sprite_shoot2_half
	actor:skill_util_strafe_update(.75, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	if actor.image_index2 > 3 then
		actor.image_index2 = 3.1
	end

	if data.primed == 0 then
		data.primed = 1
		actor:sound_play(sound_shoot2, .5, 1.2)
	end

	if actor.deflect == 2 then
		actor:sound_play(sound_shoot2_deflect, .6, 1)
		parried_hits = parried_hits + 1
		actor.deflect = 1
	end

	if Global._current_frame - parry_start > parry_window then
		actor.deflect = 0
	end

	actor:freeze_active_skill(Skill.SLOT.secondary)

	if actor:is_authority() and not actor:control("skill2", 0) then
		GM.actor_set_state_networked(actor, -1)
	end
end)

stateKnightSecondaryAlt:onExit(function( actor, data )
	actor:sound_play(sound_shoot2, .5, 0.8)
	actor:buff_remove(knightArmorBuff, 1)

	tanking = 0
	actor.deflect = 0
end)


-- handling what to do when hit while guarding
Callback.add(Callback.TYPE.onDamagedProc, "SSKnightHandleBlocking", function( actor, hit_info )
	if actor.object_index == gm.constants.oP and actor.class == knight.value then
		if blocking == 1 then
			actor:sound_play(sound_shoot2_impact, .5, 0.9 + math.random() * 0.8)
		elseif tanking == 1 then
			actor:sound_play(sound_shoot2_impact, .5, 0.9 + math.random() * 0.8)
			tanked_damage = tanked_damage + hit_info.damage
		end
	end
end)


-------- RETALIATE!
knightRetaliate.sprite = sprite_skills
knightRetaliate.subimage = 5
knightRetaliate.damage = 1
knightRetaliate.cooldown = 0
knightRetaliate.require_key_press = true
knightRetaliate.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightRetaliate = State.new(NAMESPACE, "knightRetaliate")

knightRetaliate:onActivate(function( actor )
	actor:enter_state(stateKnightRetaliate)
	actor:remove_skill_override(Skill.SLOT.secondary, knightRetaliate, 1)
end)

stateKnightRetaliate:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot1_3
	actor.image_speed = 0.35

	data.fired = 0
end)

stateKnightRetaliate:onStep(function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:refresh_skill(Skill.SLOT.secondary)

	if data.fired == 0 then
		data.fired = 1
		local base_damage = actor:skill_get_damage(knightSecondaryAlt)
		local parry_factor = 1 + parried_hits
		local tank_factor = tanked_damage/10
		local damage = (base_damage + tank_factor) * parry_factor 

		local buff_shadow_clone = Buff.find("ror", "shadowClone")
		for i=0, actor:buff_stack_count(buff_shadow_clone) do
			attack = actor:fire_explosion(actor.x, actor.y, 150, 150, base_damage, sprite_sparks3, nil, true)
			attack.attack_info:allow_stun()
			attack.attack_info:set_stun(1, actor.image_xscale, standard)
		end
	end

	local skill = actor:get_default_skill(Skill.SLOT.secondary)
	skill.remove_stock(skill, skill, 1)
end)

stateKnightRetaliate:onExit(function( actor, data )
	parried_hits = 0
	tanked_damage = 0
end)


-------- STRIKE!
local hit_enemies_strike

knightUtility.sprite = sprite_skills
knightUtility.subimage = 2
knightUtility.cooldown = 5 * 60
knightUtility.damage = 3
knightUtility.require_key_press = true
knightUtility.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightUtility = State.new(NAMESPACE, "knightUtility")

local shoot3_sounds = {sound_shoot3a, sound_shoot3b}

-- actual skill
knightUtility:onActivate(function( actor )
	actor:enter_state(stateKnightUtility)
end)

stateKnightUtility:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.5

	data.fired = 0
	data.previous_index = 0

	hit_enemies_strike = List.new()
end)

stateKnightUtility:onStep(function( actor, data )
	if data.fired == 0 then
		data.fired = 1
		actor.pHspeed = 3.5 * actor.pHmax * actor.image_xscale
		actor:sound_play(shoot3_sounds[math.ceil(math.random() + 1)], .5, 0.9 + math.random() * 0.8)
	end

	if data.previous_index < math.floor(actor.image_index) then
		data.previous_index = data.previous_index + 1

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightUtility)
			local dir = actor.image_xscale
			local targets = List.new()

			local x_size = 50
			local y_size = 25

			actor:collision_rectangle_list(actor.x - x_size, actor.y + y_size, actor.x + x_size, actor.y - y_size, gm.constants.pActor, false, true, targets, false)

			for _, target in ipairs(targets) do
				if target.team ~= actor.team then
					local cannot_be_hit = 0
					for _, previous in ipairs(hit_enemies_strike) do
						if target.value == previous.value then 
							cannot_be_hit = 1
						end
					end

					if cannot_be_hit == 0 then
						local buff_shadow_clone = Buff.find("ror", "shadowClone")
						for i=0, actor:buff_stack_count(buff_shadow_clone) do
							attack = actor:fire_direct(target, damage, dir, actor.x, actor.y, sprite_sparks2, true)
							attack.attack_info.knockback = 2
							attack.attack_info.knockback_direction = actor.image_xscale
						end

						table.insert(hit_enemies_strike, target)
					end
				end
			end

			targets:destroy()
		end
	end

	actor:set_immune(3)

	actor:skill_util_exit_state_on_anim_end()
end)

stateKnightUtility:onExit(function( actor, data )
	hit_enemies_strike:destroy()
end)


-------- FLURRY!
knightBeyblade.sprite = sprite_skills
knightBeyblade.subimage = 5
knightBeyblade.cooldown = 5 * 60
knightBeyblade.damage = 0.8
knightBeyblade.require_key_press = true
knightBeyblade.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightBeyblade = State.new(NAMESPACE, "knightBeyblade")

-- actual skill
knightBeyblade:onActivate(function( actor )
	actor:enter_state(stateKnightBeyblade)
end)

stateKnightBeyblade:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.25

	data.previous_index = 0

	hit_enemies_strike = List.new()
end)

stateKnightBeyblade:onStep(function( actor, data )
	actor.pHspeed = 2 * actor.pHmax * actor.image_xscale
	actor:set_immune(3)

	if data.previous_index < math.floor(actor.image_index) then
		data.previous_index = data.previous_index + 1
		actor:sound_play(shoot3_sounds[math.ceil(math.random() + 1)], .5, 0.9 + math.random() * 0.8)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightBeyblade)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x, actor.y, 100, 50, damage, sprite_sparks2, sprite_sparks1, true)
				attack.attack_info.knockback = 4
				attack.attack_info.knockback_direction = actor.image_xscale
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

stateKnightBeyblade:onExit(function( actor, data )
	local skill = actor:get_default_skill(Skill.SLOT.utility)
	skill.remove_stock(skill, skill, 1)
end)


-------- invigorate is such a funny word
knightSpecial.sprite = sprite_skills
knightSpecial.subimage = 3
knightSpecial.cooldown = 12 * 60
knightSpecial.damage = 3
knightSpecial.require_key_press = true
knightSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

knightSpecialScepter.sprite = sprite_skills
knightSpecialScepter.subimage = 4
knightSpecialScepter.cooldown = 12 * 60
knightSpecialScepter.damage = 3
knightSpecialScepter.require_key_press = true
knightSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local knightInvigorateBuff = Buff.new(NAMESPACE, "knightInvigorateBuff")
knightInvigorateBuff.icon_sprite = sprite_invigorate

knightInvigorateBuff:onStatRecalc(function( actor )
	actor.attack_speed = actor.attack_speed * 1.4
end)

local stateKnightSpecial = State.new(NAMESPACE, "knightSpecial")

knightSpecial:onActivate(function( actor )
	actor:enter_state(stateKnightSpecial)
end)

knightSpecialScepter:onActivate(function( actor )
	actor:enter_state(stateKnightSpecial)
end)

-- actual skill
stateKnightSpecial:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot4
	actor.image_speed = 0.2

	data.fired = 0
end)

stateKnightSpecial:onStep(function( actor, data )
	if (data.fired == 0 and math.floor(actor.image_index) == 2) or (data.fired == 1 and math.floor(actor.image_index) == 5) then
		data.fired = data.fired + 1

		actor:sound_play(shoot1_sounds[math.ceil(math.random() * 3 + 1)], .5, 0.9 + math.random() * 0.8)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightSpecial)
			local dir = actor.image_xscale
			local sparks = data.fired == 1 and sprite_sparks1 or sprite_sparks2

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage, nil, sparks)
			end
		end
	end

	if (data.fired == 2 and math.floor(actor.image_index) == 11) then
		data.fired = data.fired + 1

		actor:sound_play(sound_shoot4, .7, 0.9 + math.random() * 0.8)

		local invigorateArea = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle)
		invigorateArea.radius = 240
		invigorateArea.rate = 60
		invigorateArea.image_blend = Color.from_rgb(220,228,164)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightSpecial)
			local sparks = data.fired == 1 and sprite_sparks1 or sprite_sparks2

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x, actor.y, 300, 300, damage, sprite_sparks3, sparks, true)
			end
		end

		local allies = List.new() -- list to hold our friends

		actor:collision_circle_list(actor.x, actor.y, 320, gm.constants.pActor, false, false, allies, false) -- this grabs all the actors in a radius

		for _, ally in ipairs(allies) do
			if ally.team == actor.team then -- checking to see who is actually our friend
				if actor:item_stack_count(Item.find("ror", "ancientScepter")) >= 1 then 
					ally:buff_apply(knightInvigorateBuff, 8 * 60, 1)
				else
					ally:buff_apply(knightInvigorateBuff, 4 * 60, 1)
				end
			end
		end

		allies:destroy()
	end

	actor:set_immune(3)
	actor:skill_util_fix_hspeed()

	actor:skill_util_exit_state_on_anim_end()
end)


-------- WARD!
objFloatingShield = Object.new(NAMESPACE, "knightFloatingShield")
objFloatingShield:set_sprite(sprite_invigorate)

objFloatingShield:onCreate(function( inst )
	inst.parent = -4
	inst.speed = 2
	inst.lifetime = 6 * 60
	inst.offset = 0
	inst.initial_radians = 0
	inst.hit_delay = 15

	local data = inst:get_data()
	data.hit_list = {}
end)

objFloatingShield:onStep(function( inst )
	local data = inst:get_data()

	if not Instance.exists(inst.parent) then
		inst:destroy()
		return
	end

	inst.lifetime = inst.lifetime - 1
	if inst.lifetime < 0 then
		inst:destroy()
		return
	end
	
	inst.x = inst.parent.x + math.cos(inst.lifetime/10 * inst.speed + inst.initial_radians) * inst.offset
	inst.y = inst.parent.y + math.sin(inst.lifetime/10 * inst.speed + inst.initial_radians) * inst.offset

	if inst.offset < 100 then
		inst.offset = inst.offset + 5
	end

	for _, actor in ipairs(inst:get_collisions(gm.constants.pActorCollisionBase)) do
		if actor.team ~= inst.parent.team then
			if data.hit_list[actor.id] == nil then
				if gm._mod_net_isHost() then
					local attack = inst.parent:fire_direct(actor, 0.5, inst.direction, inst.x, inst.y, gm.constants.sBite3).attack_info
				end

				inst:sound_play(gm.constants.wMercenaryShoot1_3, 0.5, 0.9)
				data.hit_list[actor.id] = Global._current_frame

			elseif Global._current_frame - data.hit_list[actor.id] >= inst.hit_delay then
				if gm._mod_net_isHost() then
					local attack = inst.parent:fire_direct(actor, 0.5, inst.direction, inst.x, inst.y, gm.constants.sBite3).attack_info
				end

				inst:sound_play(gm.constants.wMercenaryShoot1_3, 0.5, 0.9)
				data.hit_list[actor.id] = Global._current_frame
			end
		end
	end

	local projectiles = Instance.find_all(Instance.projectiles)
    for _, proj in ipairs(projectiles) do
	local dist = gm.point_distance(inst.x, inst.y, proj.x, proj.y)
		if dist <= 20 then
            proj:destroy()
        end
    end
end)


knightShieldOrbit.sprite = sprite_skills
knightShieldOrbit.subimage = 5
knightShieldOrbit.cooldown = 12 * 60
knightShieldOrbit.damage = 3
knightShieldOrbit.require_key_press = true
knightShieldOrbit.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

knightShieldOrbitScepter.sprite = sprite_skills
knightShieldOrbitScepter.subimage = 4
knightShieldOrbitScepter.cooldown = 12 * 60
knightShieldOrbitScepter.damage = 3
knightShieldOrbitScepter.require_key_press = true
knightShieldOrbitScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightShieldOrbit = State.new(NAMESPACE, "knightShieldOrbit")

knightShieldOrbit:onActivate(function( actor )
	actor:enter_state(stateKnightShieldOrbit)
end)

knightShieldOrbitScepter:onActivate(function( actor )
	actor:enter_state(stateKnightShieldOrbit)
end)

-- actual skill
stateKnightShieldOrbit:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot4
	actor.image_speed = 0.2

	data.fired = 0
end)

stateKnightShieldOrbit:onStep(function( actor, data )
	if (data.fired == 0 and math.floor(actor.image_index) == 2) or (data.fired == 1 and math.floor(actor.image_index) == 5) then
		data.fired = data.fired + 1

		actor:sound_play(shoot1_sounds[math.ceil(math.random() * 3 + 1)], .5, 0.9 + math.random() * 0.8)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightSpecial)
			local dir = actor.image_xscale
			local sparks = data.fired == 1 and sprite_sparks1 or sprite_sparks2

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage, nil, sparks)
			end
		end
	end

	if (data.fired == 2 and math.floor(actor.image_index) == 11) then
		data.fired = data.fired + 1

		actor:sound_play(sound_shoot4, .7, 0.9 + math.random() * 0.8)

		local invigorateArea = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle)
		invigorateArea.radius = 240
		invigorateArea.rate = 60
		invigorateArea.image_blend = Color.from_rgb(220,228,164)

		local shield_count = 2 + actor:item_stack_count(Item.find("ror", "ancientScepter"))
		for i = 1, shield_count do 
			local shield = objFloatingShield:create(actor.x, actor.y)
			shield.parent = actor
			shield.initial_radians = (2 * math.pi)/shield_count * i
		end


		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightSpecial)
			local sparks = data.fired == 1 and sprite_sparks1 or sprite_sparks2

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x, actor.y, 300, 300, damage, sprite_sparks3, sparks, true)
			end
		end

		local allies = List.new() -- list to hold our friends

		actor:collision_circle_list(actor.x, actor.y, 320, gm.constants.pActor, false, false, allies, false) -- this grabs all the actors in a radius

		for _, ally in ipairs(allies) do
			if ally.team == actor.team then -- checking to see who is actually our friend
				if actor:item_stack_count(Item.find("ror", "ancientScepter")) >= 1 then 
					ally:buff_apply(knightInvigorateBuff, 8 * 60, 1)
				else
					ally:buff_apply(knightInvigorateBuff, 4 * 60, 1)
				end
			end
		end

		allies:destroy()
	end

	actor:set_immune(3)
	actor:skill_util_fix_hspeed()

	actor:skill_util_exit_state_on_anim_end()
end) 

stateKnightShieldOrbit:onExit(function( actor, data )
	local skill = actor:get_default_skill(Skill.SLOT.special)
	skill.remove_stock(skill, skill, 1)
end)


-------- RALLY!
local objBanner = Object.new(NAMESPACE, "knightBanner")
objBanner:set_sprite(gm.constants.sEfWarbanner)

local knightBannerBuff = Buff.new(NAMESPACE, "knightBannerBuff")
knightBannerBuff.icon_sprite = sprite_invigorate

knightBannerBuff:onStatRecalc(function( actor )
	local secondary = actor:get_active_skill(Skill.SLOT.secondary)
	local utility = actor:get_active_skill(Skill.SLOT.utility)
	local special = actor:get_active_skill(Skill.SLOT.special)

	secondary.cooldown = math.ceil(secondary.cooldown * 0.6)
	utility.cooldown = math.ceil(utility.cooldown * 0.6)
	special.cooldown = math.ceil(special.cooldown * 0.6)

	actor.armor = actor.armor + 20
	actor.hp_regen = actor.hp_regen + actor.maxhp * .0005
	actor.pHmax = actor.pHmax + 0.8
	actor.vHmax = actor.pHmax + 1.2
end)

objBanner:onCreate(function( inst )
	inst:move_contact_solid(270, -1)

	inst.life = 12 * 60
	inst.radius = 360
	inst.update_rate = 5
	inst.parent = -4
	inst.scepter = 0

	inst.image_speed = 0.2
end)

objBanner:onStep(function( inst )
	if inst.image_index >= 5 then
		inst.image_index = 5
	end

	if inst.life % inst.update_rate == 0 then
		local actors = List.wrap(inst:find_characters_circle(inst.x, inst.y, inst.radius, false, 3))

		for _, target in ipairs(actors) do
			if target.team ~= inst.parent.team and inst.scepter > 0 and gm._mod_net_isHost() then
				inst.parent:fire_direct(target, 0.5, inst.parent.image_xscale, inst.x, inst.y, nil, false)
			elseif target.team == inst.parent.team then
				if gm.actor_is_classic(target.id) then
					target:buff_apply(knightBannerBuff, inst.update_rate + 1)
				else
					GM.set_buff_time_nosync(target, knightBannerBuff, inst.update_rate + 1)
				end
			end
		end
	end

	inst.life = inst.life - 1
	inst.image_alpha = inst.life / 15
	if inst.life < 0 then
		inst:destroy()
	end
end)

objBanner:onDraw(function( inst )
	local a = 0.1 + math.sin(Global._current_frame * 0.02) * 0.05
	a = a * math.min(1, inst.life / 15)

	local r1 = inst.radius
	local pulse = (inst.life % 60) / 60
	local r2 = r1 * (1 - pulse)

	gm.draw_set_alpha(a*10)
	gm.draw_set_colour(knight.primary_color)
	gm.draw_circle(inst.x, inst.y, r1, true)

	gm.draw_set_alpha(a)
	gm.draw_circle(inst.x, inst.y, r1, false)

	gm.draw_set_alpha(1)
end)


knightSpecialAlt.sprite = sprite_skills
knightSpecialAlt.subimage = 3
knightSpecialAlt.cooldown = 12 * 60
knightSpecialAlt.damage = 2
knightSpecialAlt.require_key_press = true
knightSpecialAlt.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

knightSpecialAltScepter.sprite = sprite_skills
knightSpecialAltScepter.subimage = 4
knightSpecialAltScepter.cooldown = 12 * 60
knightSpecialAltScepter.damage = 2
knightSpecialAltScepter.require_key_press = true
knightSpecialAltScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightBanner = State.new(NAMESPACE, "knightBanner")

knightSpecialAlt:onActivate(function( actor )
	actor:enter_state(stateKnightBanner)
end)

knightSpecialAltScepter:onActivate(function( actor )
	actor:enter_state(stateKnightBanner)
end)

stateKnightBanner:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.5
	data.fired = 0
end)

stateKnightBanner:onStep(function( actor, data )
	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot4, .7, 0.9 + math.random() * 0.8)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightSpecialAlt)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x, actor.y + 10, 50, 150, damage, gm.constants.sBanditShoot2Explosion, nil, true)
			end
		end

		local banner = objBanner:create(actor.x, actor.y)
		banner.parent = actor
		banner.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
	end

	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
end)


-------- CONSECRATE!
local objConsecratedBanner = Object.new(NAMESPACE, "knightConsecratedBanner")
objConsecratedBanner:set_sprite(gm.constants.sEfWarbanner)

local objEfConsecrate = Object.new(NAMESPACE, "knightEfConsecrate")
objEfConsecrate:set_sprite(gm.constants.sEfArtiStarIdle)

local partConsecrate = Particle.new(NAMESPACE, "knightConsecrate")
partConsecrate:set_shape(Particle.SHAPE.star)
partConsecrate:set_life(15, 25)
partConsecrate:set_size(0.08, 0.12, -0.005, 0)

objConsecratedBanner:onCreate(function( inst )
	inst:move_contact_solid(270, -1)

	inst.life = 12 * 60
	inst.radius = 360
	inst.update_rate = 5
	inst.consecrate_rate = 90
	inst.parent = -4
	inst.scepter = 0

	inst.image_speed = 0.2

	inst:get_data().stars = {}
end)

objConsecratedBanner:onStep(function( inst )
	if inst.image_index >= 5 then
		inst.image_index = 5
	end

	if inst.life % inst.update_rate == 0 then
		local actors = List.wrap(inst:find_characters_circle(inst.x, inst.y, inst.radius, false, 3))

		for _, target in ipairs(actors) do
			if target.team ~= inst.parent.team and inst.scepter > 0 and gm._mod_net_isHost() then
				inst.parent:fire_direct(target, 0.5, inst.parent.image_xscale, inst.x, inst.y, nil, false)
			elseif target.team == inst.parent.team then
				if gm.actor_is_classic(target.id) then
					target:buff_apply(knightBannerBuff, inst.update_rate + 1)
				else
					GM.set_buff_time_nosync(target, knightBannerBuff, inst.update_rate + 1)
				end
			end
		end

		local allies = List.wrap(gm.find_characters_circle(inst.x, inst.y, inst.radius, true, inst.parent.team, true))
		local stars = inst:get_data().stars
		if #allies > 0 then
			for i, star in ipairs(stars) do 
				star.target = allies[math.random(1, #allies)]
				table.remove(stars, i)
			end
		end

	end

	if inst.life % inst.consecrate_rate == 0 then
		local stars = inst:get_data().stars
		local star = objEfConsecrate:create(inst.x, inst.y - 50)
		table.insert(stars, star)
		star.parent = inst.parent
	end

	inst.life = inst.life - 1
	inst.image_alpha = inst.life / 15
	if inst.life < 0 then
		local actors = Instance.find_all(gm.constants.pActor)
		local allies = {}

		for _, actor in ipairs(actors) do
			if actor.team == inst.parent.team then
				table.insert(allies, actor)
			end
		end

		local stars = inst:get_data().stars
		print(#stars)
		for i, star in ipairs(stars) do 
			star.target = allies[math.random(1, #allies)]
			stars[i] = nil
		end

		inst:destroy()
	end
end)

objConsecratedBanner:onDraw(function( inst )
	local a = 0.1 + math.sin(Global._current_frame * 0.02) * 0.025
	a = a * math.min(1, inst.life / 15)

	local r1 = inst.radius
	local pulse = (inst.life % 90) / 90
	local r2 = r1 * (1 - pulse)

	gm.draw_set_alpha(a*10)
	gm.draw_set_colour(knight.primary_color)
	gm.draw_circle(inst.x, inst.y, r1, true)

	gm.draw_set_alpha(a)
	gm.draw_circle(inst.x, inst.y, r1, false)

	gm.draw_set_alpha(a * pulse)
	gm.draw_circle(inst.x, inst.y, r2, false)

	gm.draw_set_alpha(1)
end)

objEfConsecrate:onCreate(function( inst ) -- stolen from the malice formula i am NOT remaking all that man
	inst.parent = -4
	inst.target = -4

	inst.orbitx = inst.x
	inst.orbity = inst.y
	inst.orbit_duration = 0

	inst.fract = 0
	inst.direction = math.random(360)

	__quality = Global.__pref_graphics_quality
end)

objEfConsecrate:onStep(function( inst )
	if not Instance.exists(inst.parent) then self:destroy() return end

	if not Instance.exists(inst.target) then 
		inst.fract = 0
		inst.orbit_duration = inst.orbit_duration + 1

		local offset = inst.orbit_duration > 60 and 60 or inst.orbit_duration

		inst.x = inst.orbitx + math.cos((Global._current_frame + inst.direction) /25) * (offset + (inst.direction/20))
		inst.y = inst.orbity - math.sin((Global._current_frame + inst.direction) /25) * (offset + (inst.direction/20)) / 6
		inst.xstart = inst.x
		inst.ystart = inst.y
	else
		inst.fract = inst.fract + 0.025

		local target, parent = inst.target, inst.parent
		local tx, ty = target.x, target.y

		local coff = math.sin(inst.fract * math.pi)
		inst.x = gm.lerp(inst.xstart, tx, inst.fract) + gm.lengthdir_x(16, inst.direction) * coff
		inst.y = gm.lerp(inst.ystart, ty, inst.fract) + gm.lengthdir_y(16, inst.direction) * coff
		
		if inst.fract + 0.05 > 1 then
			inst.target:heal(inst.target.maxhp * .05)
			inst.target:add_barrier(inst.target.maxhp * .1)
			inst:destroy()
		end
	end

	local dx, dy = inst.x - inst.xprevious, inst.y - inst.yprevious

	for i = 0, __quality - 1 do 
		local f = (i - 1) / (__quality * 1.5) 
		partConsecrate:create(inst.x - dx * f * math.cos(Global._current_frame/5), inst.y - dx * f * math.sin(Global._current_frame/5), 1, Particle.SYSTEM.above)
	end
end)


knightConsecrate.sprite = sprite_skills
knightConsecrate.subimage = 5
knightConsecrate.cooldown = 12 * 60
knightConsecrate.damage = 2
knightConsecrate.require_key_press = true
knightConsecrate.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

knightConsecrateScepter.sprite = sprite_skills
knightConsecrateScepter.subimage = 5
knightConsecrateScepter.cooldown = 12 * 60
knightConsecrateScepter.damage = 2
knightConsecrateScepter.require_key_press = true
knightConsecrateScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateKnightConsecrate = State.new(NAMESPACE, "knightConsecratedBanner")

knightConsecrate:onActivate(function( actor )
	actor:enter_state(stateKnightConsecrate)
end)

knightConsecrateScepter:onActivate(function( actor )
	actor:enter_state(stateKnightConsecrate)
end)

stateKnightConsecrate:onEnter(function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.5
	data.fired = 0
end)

stateKnightConsecrate:onStep(function( actor, data )
	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot4, .7, 0.9 + math.random() * 0.8)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(knightConsecrate)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				attack = actor:fire_explosion(actor.x, actor.y + 10, 50, 150, damage, gm.constants.sBanditShoot2Explosion, nil, true)
			end
		end

		local consecrated_banner = objConsecratedBanner:create(actor.x, actor.y)
		consecrated_banner.parent = actor
		consecrated_banner.scepter = actor:item_stack_count(Item.find("ror", "ancientScepter"))
	end

	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
end) 

stateKnightConsecrate:onExit(function( actor, data )
	local skill = actor:get_default_skill(Skill.SLOT.special)
	skill.remove_stock(skill, skill, 1)
end)