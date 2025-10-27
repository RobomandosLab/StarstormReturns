local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Chirr")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Chirr")


-- this is a change i have to make to the providence summoning event to account for chirrs tames
local providence_spawn_address = gm.get_object_function_address("gml_Object_oCommand_Step_2")

if providence_spawn_address:is_valid() then
    local stupid_fucker = providence_spawn_address:add(5371) -- I FUCKING HATE THIS FUNCTION CALL IM SO GLAD IM KILLING IT
    for i = 0, 4 do
        stupid_fucker:add(i):patch_byte(0x90):apply() -- this stops the function from destroying all enemy objects
    end

	memory.dynamic_hook_mid("gml_Object_oCommand_Step_2__chirr_compat", {}, {}, 0, stupid_fucker, function( args )
		local actors = Instance.find_all(gm.constants.pActor)

		for i, actor in ipairs(actors) do -- this instead destroys everything on the enemy team
			if actor.team ~= 1 then
				actor:destroy()
			end
		end
	end)
end


-- assets
-- icon sprites and stuff
local sprite_loadout =        Resources.sprite_load(NAMESPACE, "ChirrSelect", path.combine(SPRITE_PATH, "select.png"), 15, 14, 0)
local sprite_portrait =       Resources.sprite_load(NAMESPACE, "ChirrPortrait", path.combine(SPRITE_PATH, "portrait.png"), 2)
local sprite_portrait_small = Resources.sprite_load(NAMESPACE, "ChirrPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills =         Resources.sprite_load(NAMESPACE, "ChirrSkills", path.combine(SPRITE_PATH, "skills.png"), 6)

-- non-skill sprites
local sprite_idle =           Resources.sprite_load(NAMESPACE, "ChirrIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 12, 11)
local sprite_idle_half =      Resources.sprite_load(NAMESPACE, "ChirrIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 12, 11)
local sprite_walk =           Resources.sprite_load(NAMESPACE, "ChirrWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 13, 13)
local sprite_walk_half =      Resources.sprite_load(NAMESPACE, "ChirrWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 13, 13)
local sprite_jump =           Resources.sprite_load(NAMESPACE, "ChirrJump", path.combine(SPRITE_PATH, "jump.png"), 1, 11, 13)
local sprite_jump_half =      Resources.sprite_load(NAMESPACE, "ChirrJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 11, 13)
local sprite_flight =         Resources.sprite_load(NAMESPACE, "ChirrFlight", path.combine(SPRITE_PATH, "flight.png"), 1, 11, 15)
local sprite_wings =          Resources.sprite_load(NAMESPACE, "ChirrWings", path.combine(SPRITE_PATH, "wings.png"), 3, 11, 15)
local sprite_climb =          Resources.sprite_load(NAMESPACE, "ChirrClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 11, 10)
local sprite_death =          Resources.sprite_load(NAMESPACE, "ChirrDeath", path.combine(SPRITE_PATH, "death.png"), 8, 16, 11)
local sprite_decoy =          Resources.sprite_load(NAMESPACE, "ChirrDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 9, 10)

-- skill sprites
local sprite_shoot1 =         Resources.sprite_load(NAMESPACE, "ChirrShoot1", path.combine(SPRITE_PATH, "shoot1.png"), 5, 17, 11)
local sprite_shoot1_half =    Resources.sprite_load(NAMESPACE, "ChirrShoot1Half", path.combine(SPRITE_PATH, "shoot1Half.png"), 5, 17, 12)
local sprite_shoot2 =         Resources.sprite_load(NAMESPACE, "ChirrShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 23, 11)
local sprite_shoot3 =         Resources.sprite_load(NAMESPACE, "ChirrShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 13, 19, 27)
local sprite_shoot4 =         Resources.sprite_load(NAMESPACE, "ChirrShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 10, 3, 4)

-- effect sprites, entirely used for the primary because i was having fun and bc the rest of her kit didnt really use any
local sprite_sparks =         Resources.sprite_load(NAMESPACE, "ChirrSparks", path.combine(SPRITE_PATH, "sparks.png"), 3, 11, 3)
local sprite_tracer =         Resources.sprite_load(NAMESPACE, "ChirrTracer", path.combine(SPRITE_PATH, "tracer.png"), 5, 0, 2)

-- sprites for the elite type given to tamed monsters
local sprite_palette =        Resources.sprite_load(NAMESPACE, "ChirrPalette", path.combine(SPRITE_PATH, "palette.png"))
local sprite_tamed_icon =     Resources.sprite_load(NAMESPACE, "ChirrTameIcon", path.combine(SPRITE_PATH, "tameIcon.png"))

-- sounds
local sound_shoot1 =          Resources.sfx_load(NAMESPACE, "ChirrShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2 =          Resources.sfx_load(NAMESPACE, "ChirrShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3a =         Resources.sfx_load(NAMESPACE, "ChirrShoot3A", path.combine(SOUND_PATH, "skill3A.ogg"))
local sound_shoot3b =         Resources.sfx_load(NAMESPACE, "ChirrShoot3B", path.combine(SOUND_PATH, "skill3B.ogg"))
local sound_shoot4 =          Resources.sfx_load(NAMESPACE, "ChirrShoot4", path.combine(SOUND_PATH, "skill4.ogg"))


-------- the creachirr
local chirr = Survivor.new(NAMESPACE, "chirr")
local chirr_id = chirr.value
local player_actor

local tamed = {}
local taming_target
local has_full_party = 0
local apply_mist_buildup = 1
local apply_tame_tag = 1
local tame_charge_time = .75*60
local tame_teleport_distance = 1100

chirr:set_stats_base({ -- setting base stats
	maxhp = 104,
	damage = 11,
	regen = 0.014
})
chirr:set_stats_level({ -- setting stats for leveling up
	maxhp = 29,
	damage = 3,
	regen = 0.0024, 
	armor = 2
})

local base_physics = { -- chirrs default different physics
	gravity1 = 0.4,
	gravity2 = 0.16
}
chirr:set_physics_base(base_physics)

chirr:set_animations({ -- setting the animations, a lot of this is modeled after executioner
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy
})

chirr:set_cape_offset(0,0,0,0)
chirr:set_primary_color(Color.from_rgb(129,167,98))

-- setting some misc sprites
chirr.sprite_loadout = sprite_loadout
chirr.sprite_portrait = sprite_portrait
chirr.sprite_portrait_small = sprite_portrait_small
chirr.sprite_title = sprite_walk

chirr:clear_callbacks()
chirr:onInit(function(actor) -- setting up the beasts half sprite stuff
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

-- her wing sprites
local obj_wings = Object.new(NAMESPACE, "chirrWings")
obj_wings.obj_sprite = sprite_wings
obj_wings.obj_depth = 1

-- setting up the default skills
local chirrPrimary =   chirr:get_primary()
local chirrSecondary = chirr:get_secondary()
local chirrUtility =   chirr:get_utility()
local chirrSpecial =   chirr:get_special()
local chirrSpecialScepter = Skill.new(NAMESPACE, "chirrSpecialBoosted")
chirrSpecial:set_skill_upgrade(chirrSpecialScepter)

-- alt skills
local chirrUtilityAlt = Skill.new(NAMESPACE, "channelingPulse")
chirr:add_utility(chirrUtilityAlt)

-- her movement control stuff and other on step stuff
local tameHealthbarBuff = Buff.new(NAMESPACE, "chirrShowAllyHPBuff") -- draws the health bars for your friends!
tameHealthbarBuff.show_icon = false
tameHealthbarBuff.is_timed = false

tameHealthbarBuff:clear_callbacks()
tameHealthbarBuff:onPreDraw(function( actor )
	actor:draw_hp_bar_ally()
end)

local tameMark = Buff.new(NAMESPACE, "chirrTameMark") -- this is her weird little tame indicator
tameMark.show_icon = true
tameMark.icon_sprite = sprite_portrait_small
tameMark.is_debuff = true

tameMark:onStatRecalc(function( actor )
	actor.armor = actor.armor - 30
end)

local flying = false -- hover stuff
local wings
chirr:onStep(function( actor )
	if actor.moveUpHold == 1.0 and actor.pVspeed > 0.35 then -- her hover
		flying = true
		actor.pVspeed = 0.35

		if actor.actor_state_current_id == -1 then -- setting her sprite to the flight idle if nothing else is happening
			actor.sprite_index = sprite_flight
		end
		
		if not wings then -- displaying her wings
			wings = obj_wings:create(actor.ghost_x, actor.ghost_y)
			wingsData = wings:get_data()
			wingsData.parent = actor
			wings.image_xscale = actor.image_xscale
		else
			wings.x = actor.x
			wings.y = actor.y
			wings.image_xscale = actor.image_xscale
		end
	else
		flying = false

		if wings then
			wings:destroy()
			wings = nil
		end
	end

	if player_actor ~= actor then -- updating the actor value for my own convenience
		player_actor = actor
	end

	if player_actor then -- party size tracker
		if #tamed < 1 + player_actor:item_stack_count(Item.find("ror", "ancientScepter")) and has_full_party == 1 then -- if your party has newly been made empty
			has_full_party = 0
		elseif #tamed >= 1 + player_actor:item_stack_count(Item.find("ror", "ancientScepter")) and has_full_party == 0 then -- if your party has newly been made full
			has_full_party = 1
		end
	end

	for i, friend in ipairs(tamed) do
		if Instance.exists(friend) then -- sanity check to ensure your friends actually exist
			friend.despawn_time = 99999999

			if gm.point_distance(actor.x, actor.y, friend.x, friend.y) >= tame_teleport_distance then
				gm.teleport_nearby(friend.value, actor.x, actor.y)
			end
		else 
			table.remove(tamed, i)
		end
	end
end)


-------- get this girl her thorns
-- this is all basic skill info
chirrPrimary.sprite = sprite_skills
chirrPrimary.subimage = 0
chirrPrimary.cooldown = 5
chirrPrimary.damage = 0.4
chirrPrimary.require_key_press = false
chirrPrimary.is_primary = true
chirrPrimary.does_change_activity_state = true
chirrPrimary.hold_facing_direction = true
chirrPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

-- tracer for her projectiles
local tracer_particle = Particle.find("ror", "WispGTracer") 
local tracer_color = Color.from_rgb(129,167,98)
local tracer_color2= Color.from_rgb(204,232,111)
local thorn_tracer, thorn_tracer_info = CustomTracer.new(function(x1, y1, x2, y2) -- i just kinda copied this tracer code and tweaked it for some fun visuals
	local offset = -7 + math.random() * 3
	y1 = y1 + offset
	y2 = y2 + offset

	local tr = gm.instance_create(x1, y1, gm.constants.oEfLineTracer)
	tr.xend = x2
	tr.yend = y2
	tr.sprite_index = gm.constants.sPilotShoo1BTracer
	tr.image_speed = 2
	tr.rate = 0.125
	tr.bm = 1 -- additive
	tr.image_blend = tracer_color2

	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	tracer_particle:set_direction(dir, dir, 0, 0)
	local px = x1
	local py = y1
	local i = 0
	while i < dist do
		tracer_particle:create_colour(px, y1 + gm.random_range(-8, 8), tracer_color, 1)
		px = px + gm.lengthdir_x(40, dir)
		i = i + 40
	end

	i = 0
	px = x1
	while i < dist do
		tracer_particle:create_colour(px, py, tracer_color2, 1)
		px = px + gm.lengthdir_x(15, dir)
		py = py + gm.lengthdir_y(15, dir)
		i = i + 15
	end
end)
thorn_tracer_info.sparks_offset_y = -8

-- healing mist spawned by the primary
local objHealingMist = Object.new(NAMESPACE, "chirrHealingMist")
objHealingMist.obj_depth = 1

local partHealingMist = Particle.new(NAMESPACE, "partHealingMist")
partHealingMist:set_shape(Particle.SHAPE.cloud)
partHealingMist:set_life(60)
partHealingMist:set_size(1, 1.2, -0.0167, -0.02)

local partHealingSparks = Particle.new(NAMESPACE, "partHealingSparks")
partHealingSparks:set_shape(Particle.SHAPE.star)
partHealingSparks:set_life(10, 30)
partHealingSparks:set_size(0.09, 0.125, -0.05, -0.1)

objHealingMist:onCreate(function( inst )
	inst.parent = -4
	inst.start = Global._current_frame
	inst.tick = Global._current_frame
end)

objHealingMist:onStep(function( inst )
	if Global._current_frame - inst.start >= 5 * 60 then
		inst:destroy()
	end

	partHealingMist:create_color(inst.x + math.random(-90,90), inst.y + math.random(-90,90), Color.TEXT_GREEN, 1, Particle.SYSTEM.below)

	if Global._current_frame - inst.tick >= 30 then
		partHealingSparks:create_color(inst.x + math.random(-90,90), inst.y + math.random(-90,90), Color.TEXT_GREEN, 1, Particle.SYSTEM.above)

		local friends = List.new() 
		player_actor:collision_circle_list(inst.x, inst.y, 180, gm.constants.pActor, false, false, friends, false) 

		for _, friend in ipairs(friends) do
			if friend.team == 1 then -- checking to see who is actually our friend
				friend:heal(friend.maxhp * .025)
			end
		end
				
		friends:destroy()
		inst.tick = Global._current_frame
	end
end)

-- debuff that her primary inflicts
local healingMistBuildup = Buff.new(NAMESPACE, "healingMistDebuff") -- this is her weird little tame indicator
healingMistBuildup.show_icon = true
healingMistBuildup.icon_sprite = sprite_portrait_small
healingMistBuildup.is_debuff = true
healingMistBuildup.icon_stack_subimage = false
healingMistBuildup.draw_stack_number = true
healingMistBuildup.stack_number_col = Array.new(1, tracer_color2)
healingMistBuildup.max_stack = 9

healingMistBuildup:onApply(function( actor, stack )
	if stack == 5 then
		actor:buff_remove(healingMistBuildup)

		if player_actor then
			player_actor:fire_explosion(actor.x, actor.y, 100, 100, 1)
		end

		local mist = objHealingMist:create(actor.x, actor.y)
		mist.parent = actor

	end
end)

-- actual primary skill
local stateChirrPrimary = State.new(NAMESPACE, "chirrPrimary") -- making a primary state

chirrPrimary:clear_callbacks()
chirrPrimary:onActivate(function( actor ) 
	actor:enter_state(stateChirrPrimary)
end)

stateChirrPrimary:clear_callbacks() -- using the skill, setting up the important data and stuff
stateChirrPrimary:onEnter(function( actor, data )
	actor.image_index2 = 0
	data.fired = 0
	data.count = 3

	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

stateChirrPrimary:onStep(function( actor, data ) -- actually using the skill
	actor.sprite_index2 = sprite_shoot1_half
	
	actor:skill_util_strafe_update(.12 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()
	if data.fired == 0 and data.count > 0 and actor.image_index2 > 1 then -- this if else is to make sure the skill fires at the right time and also does a proper barrage of 3 thorns
		data.fired = 1
		data.count = data.count - 1

		actor:sound_play(sound_shoot1, .5, 0.9 + math.random() * 0.8)
		
		if actor:is_authority() then -- if local player
			local damage = actor:skill_get_damage(chirrPrimary)
			local dir = actor:skill_util_facing_direction()
			
			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then -- if not using heaven cracker
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do -- stuff for shattered mirror
					local attack_info
					attack_info = actor:fire_bullet(actor.x, actor.y + math.random(-8.00,8.00), 400, dir, damage, nil, sprite_sparks, thorn_tracer, true).attack_info
					attack_info.climb = i * 8
					attack_info.__ssr_chirr_mist_buildup_tag = apply_mist_buildup
				end
			end
		end
	else
		data.fired = 0
	end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)



-------- burrow
chirrSecondary.sprite = sprite_skills
chirrSecondary.subimage = 1
chirrSecondary.damage = 5
chirrSecondary.cooldown = 5 * 60
chirrSecondary.require_key_press = false
chirrSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrBurrow = State.new(NAMESPACE, "chirrBurrow") -- the actual dive into the ground part
local stateChirrDigging = State.new(NAMESPACE, "chirrDigging") -- start digging in the earth twin 🤖

chirrSecondary:clear_callbacks()
chirrSecondary:onActivate(function(actor)
	actor:enter_state(stateChirrBurrow)
end)

-- leaping into the ground behavior
stateChirrBurrow:clear_callbacks()
stateChirrBurrow:onEnter(function( actor, data )
	-- anim stuff will go here when its added
	actor.image_index = 0
	actor.pVspeed = -12
	tempVSpeed = -12
end)

stateChirrBurrow:onStep(function( actor, data )
	actor.pVspeed = actor.pVspeed + 0.5
	if actor.pVspeed > actor.pVmax * 6 then
		actor.pVspeed = actor.pVmax * 6
	end

	actor:freeze_active_skill(Skill.SLOT.secondary) 
	actor:set_immune(3) -- prevents instant death from fall damage

	if actor:is_grounded() and actor.pVspeed >= 0 then 
		actor:enter_state(stateChirrDigging)
	end
end)

-- digging around behavior
stateChirrDigging:clear_callbacks()
stateChirrDigging:onEnter(function( actor, data )
	data.yLevel = actor.y
	data.time = 0
end)

stateChirrDigging:onStep(function( actor, data )
	actor.y = data.yLevel
	actor.pVspeed = 0
	data.time = data.time + 1
	actor:set_immune(3)
	actor:freeze_active_skill(Skill.SLOT.secondary)

	-- conditions keeping you in the state
	local holding = gm.bool(actor.x_skill)
	if not holding or data.time > 5 * 60 then
		actor:skill_util_reset_activity_state()
	end

	-- movement controls
	-- this is split up because i need to do separate checks for if you can move left or right, otherwise youd just get stuck
	local collisionL = actor:collision_point(actor.x - 16, actor.y + 32, gm.constants.pBlock, false, true)
	local collisionR = actor:collision_point(actor.x + 16, actor.y + 32, gm.constants.pBlock, false, true)

	if gm.bool(actor.moveLeft) then -- left checks
		if not collisionL or (type(collisionL) == "number" and collisionL < 0) then
			actor.pHspeed = 3
		elseif not (actor.pHspeed < -1 * actor.pHmax * 1.75) then
			actor.pHspeed = actor.pHspeed - 0.2
		end
	end

	if gm.bool(actor.moveRight) then -- right checks
		if not collisionR or (type(collisionR) == "number" and collisionR < 0) then
			actor.pHspeed = -3
		elseif not (actor.pHspeed > actor.pHmax * 1.75) then
			actor.pHspeed = actor.pHspeed + 0.2
		end
	end
end)

stateChirrDigging:onExit(function( actor, data )
	actor.pVspeed = -9

	local damage = actor:skill_get_damage(chirrSecondary)
	local dir = actor.image_xscale

	if actor:is_authority() then
		local buff_shadow_clone = Buff.find("ror", "shadowClone")
		for i=0, actor:buff_stack_count(buff_shadow_clone) do
			local attack_info = actor:fire_explosion(actor.x, actor.y, 150, 150, damage).attack_info
			attack_info:set_stun(3, dir, standard)
		end
	end
end)



-------- heal pulse
-- more info yayyyyyyy
chirrUtility.sprite = sprite_skills
chirrUtility.subimage = 2
chirrUtility.cooldown = 15 * 60
chirrUtility.is_utility = true
chirrUtility.require_key_press = true
chirrUtility.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrUtility = State.new(NAMESPACE, "chirrUtility") -- guess what this is, you get three tries

local charging_heal = 0
local charging_heal_step = 0

chirrUtility:clear_callbacks()
chirrUtility:onActivate(function(actor)
	actor:enter_state(stateChirrUtility)
end)

stateChirrUtility:clear_callbacks()
stateChirrUtility:onEnter(function(actor, data)
	actor.image_index = 0
	actor:sound_play(sound_shoot3a, .8, 1.4)
end)

local utilRegenBuff = Buff.new(NAMESPACE, "chirrRegenBuff")
utilRegenBuff.show_icon = false

utilRegenBuff:clear_callbacks()
utilRegenBuff:onStatRecalc(function( actor )
	actor.hp_regen = actor.hp_regen + actor.maxhp * .002
end)

stateChirrUtility:onStep(function( actor, data )
	actor.sprite_index = sprite_shoot3
	actor.image_speed = .25

	charging_heal = 1
	charging_heal_step = charging_heal_step + 1

	actor:skill_util_fix_hspeed()

	if actor.image_index >= 11.5 then -- when the animation reaches the final frame
		actor:sound_play(sound_shoot3b, 1.2, 0.9 + math.random() * 0.2)

		local healArea = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle) -- cool circle object ty kris
		healArea.radius = 240
		healArea.rate = 60
		healArea.image_blend = Color.from_rgb(179,217,148)

		if actor:is_authority() then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i = 0, actor:buff_stack_count(buff_shadow_clone) do
				local friends = List.new() -- list to hold our friends

				actor:collision_circle_list(actor.x, actor.y, 320, gm.constants.pActor, false, false, friends, false) -- this grabs all the actors in a radius

				for _, friend in ipairs(friends) do
					if friend.team == actor.team then -- checking to see who is actually our friend
						friend:heal(friend.maxhp * .25)
						friend:buff_apply(utilRegenBuff, 6 * 60)
					end
				end
				
				friends:destroy()
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

stateChirrUtility:onExit(function( ... )
	charging_heal = 0
	charging_heal_step = 0
end)


Callback.add(Callback.TYPE.onDraw, "SSChirrDrawPulseZone", function() -- just a fun visual to help you aim the heal pulse
	if charging_heal == 1 then
		if player_actor then
			gm.draw_set_alpha(charging_heal_step * .0025)

			gm.draw_set_colour(Color.TEXT_GREEN)
			gm.draw_circle(player_actor.x, player_actor.y, 200 + (math.log(charging_heal_step) * 35), false)
	
			gm.draw_set_alpha(1)
		end
	end
end)


-------- channeling pulse
chirrUtilityAlt.sprite = sprite_skills
chirrUtilityAlt.subimage = 2
chirrUtilityAlt.cooldown = 15 * 60
chirrUtilityAlt.is_utility = true
chirrUtilityAlt.require_key_press = true
chirrUtilityAlt.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrUtilityAlt = State.new(NAMESPACE, "chirrUtilityAlt") -- guess what this is, you get three tries

local charging_blast = 0
local charging_blast_step = 0

chirrUtilityAlt:clear_callbacks()
chirrUtilityAlt:onActivate(function(actor)
	actor:enter_state(stateChirrUtilityAlt)
end)

stateChirrUtilityAlt:clear_callbacks()
stateChirrUtilityAlt:onEnter(function(actor, data)
	actor.image_index = 0
	actor:sound_play(sound_shoot3a, .6, 1.4)
end)

stateChirrUtilityAlt:onStep(function( actor, data )
	actor.sprite_index = sprite_shoot3
	actor.image_speed = .2

	charging_blast = 1
	charging_blast_step = charging_blast_step + 1

	actor:skill_util_fix_hspeed()

	if actor.image_index >= 11.5 then -- when the animation reaches the final frame
		actor:sound_play(sound_shoot3b, 1.2, 0.9 + math.random() * 0.2)

		local trigger_pulse = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle)
		trigger_pulse.radius = 0
		trigger_pulse.rate = 120
		trigger_pulse.image_blend = Color.from_rgb(179,217,148)

		if actor:is_authority() then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i = 0, actor:buff_stack_count(buff_shadow_clone) do
				for _, friend in ipairs(tamed) do
					local damage = friend.maxhp/40 -- your tames max hp, adjusted to work as a % value
					local attack_info = actor:fire_explosion(friend.x, friend.y, 600, 600, damage).attack_info
					attack_info:set_stun(1, dir, standard)
					GM.damage_inflict(friend, friend.maxhp)

					local detonate_pulse = GM.instance_create(friend.x, friend.y, gm.constants.oEfCircle)
					detonate_pulse.radius = 0
					detonate_pulse.rate = 120
					detonate_pulse.image_blend = Color.from_rgb(179,217,148)
				end
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

stateChirrUtilityAlt:onExit(function( ... )
	charging_blast = 0
	charging_blast_step = 0
end)



-------- taming
-- getting a tame
chirrSpecial.sprite = sprite_skills
chirrSpecial.subimage = 3
chirrSpecial.cooldown = 1.5 * 60
chirrSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- getting a SUUUUUPPPERRR tame
chirrSpecialScepter.sprite = sprite_skills
chirrSpecialScepter.subimage = 5
chirrSpecialScepter.cooldown = 1.5 * 60
chirrSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill


-- making the little heart object
local obj_tame_heart = Object.new(NAMESPACE, "chirrTameHeart")
obj_tame_heart.obj_sprite = sprite_shoot4
obj_tame_heart.obj_depth = 1

local function tameHeartStep( inst ) -- heart animation and lifetime stuff
	inst.image_speed = 0.25
	if inst.image_index == 9 then
		inst:destroy()
	end
end

obj_tame_heart:onStep(tameHeartStep)


 -- elite type for tamed enemies
local elite = Elite.new(NAMESPACE, "tamed")
local elite_id = gm.elite_type_find("tamed")
elite:set_healthbar_icon(sprite_tamed_icon)
elite.palette = sprite_palette
gm._mod_elite_generate_palette_all()

-- stat changes and behaviors for tames
local tamedEliteItem = Item.new(NAMESPACE, "tamedEliteItem", true) -- item for your fellas 
tamedEliteItem.is_hidden = true

tamedEliteItem:onPostStep(function( actor, data )
	actor.hp = actor.hp - actor.maxhp * 0.00075
end)

elite:clear_callbacks()
elite:onApply(function( actor )
	actor:item_give(tamedEliteItem)
end)


-- callbacks that keep this character from fucking shitting itself
Callback.add(Callback.TYPE.onGameStart, "SSChirrResetTameTable", function(  ) -- resets the friend list each game
	tamed = {}
	taming_target = nil
end)

Callback.add(Callback.TYPE.onDeath, "SSChirrTameUpdate", function( victim, fell_out_of_bounds ) -- removes friends from the list once they die
	for index, friend in ipairs(tamed) do
		if friend.value == victim.value then
			table.remove(tamed, index)
		end
	end

	if taming_target then
		if victim.value == taming_target.value then
			taming_target:remove_buff(tameMark)
			taming_target = nil
		end
	end
end)

Callback.add(Callback.TYPE.onPickupCollected, "SSChirrFriendItemSync", function( pickup, player ) -- copies your new items over to your friend
	if pickup.equipment_id == -1 then
		for _, friend in ipairs(tamed) do
			friend:item_give(pickup.item_id, 1, pickup.item_stack_kind)	 
		end
	end
end)

Callback.add(Callback.TYPE.onStageStart, "SSChirrFriendGroupup", function(  ) -- brings your friends to you on each stage
	tamed = {}
end)

Callback.add(Callback.TYPE.onAttackHit, "SSChirrApplyDebuffs", function( hit_info ) -- applies chirrs debuffs where necessary
	-- taming mark
	local tame_tag = hit_info.attack_info.__ssr_chirr_set_tame_target

	if tame_tag then
		if taming_target and Instance.exists(taming_target) then
			if taming_target:buff_stack_count(tameMark) > 0 then
				taming_target:buff_remove(tameMark)
			end
		end

		taming_target = hit_info.target
		hit_info.target:buff_apply(tameMark, 10 * 60)

		for _, tame in ipairs(tamed) do
			tame.target = taming_target
		end
	end

	-- healing mist buildup
	local mist_tag = hit_info.attack_info.__ssr_chirr_mist_buildup_tag

	if mist_tag then
		hit_info.target:buff_apply(healingMistBuildup, 6 * 60)
	end
end)


-- taming skill code
local stateChirrSpecial = State.new(NAMESPACE, "chirrSpecial")

chirrSpecial:clear_callbacks()
chirrSpecial:onActivate(function( actor, data )
	actor:enter_state(stateChirrSpecial)
end)
chirrSpecialScepter:clear_callbacks()
chirrSpecialScepter:onActivate(function( actor, data )
	actor:enter_state(stateChirrSpecial)
end)

stateChirrSpecial:clear_callbacks()
stateChirrSpecial:onEnter(function( actor, data )
	data.step = 0
end)

stateChirrSpecial:onStep(function( actor, data )
	data.step = data.step + 1

	local holding = gm.bool(actor.v_skill)
	if not holding or data.step >= tame_charge_time then
		actor:skill_util_reset_activity_state()
	end
end)

stateChirrSpecial:onExit(function( actor, data )
	if data.step >= tame_charge_time then
		actor:sound_play(sound_shoot4, 1, 1)
		obj_tame_heart:create(actor.x + 14 * actor.image_xscale, actor.y - 10) -- make the little heart

		if has_full_party == 1 then
			for _, friend in ipairs(tamed) do
				friend:actor_teleport(actor.x, actor.y)
			end
		else
			if taming_target then
				if taming_target.team ~= actor.team and not taming_target.enemy_party and taming_target.hp <= taming_target.maxhp * 0.5 then -- makes sure they arent on our team, arent a boss, and have half health or less
					if #tamed < 1 + actor:item_stack_count(Item.find("ror", "ancientScepter")) then -- sets the limit based off our scepter count

						table.insert(tamed, taming_target) -- adds them to our list of total friends
						taming_target.is_character_enemy_targettable = true -- lets enemies actually target the poor fella
						actor:actor_team_set(taming_target, 1) -- setting the enemies team to our team (1 is player team, 2 is enemy)

						taming_target:buff_remove(tameMark) -- removes the little tame indicator
						taming_target:buff_remove(healingMistBuildup) -- theres no reason for this to be there now
						taming_target:buff_apply(tameHealthbarBuff, 1)
						GM.elite_set(taming_target, elite) -- sets the elite type of your friend
						actor:inventory_items_copy(actor, taming_target, 0) -- gives our friend our items
						taming_target.y_range = taming_target.y_range + 100 -- lets our friend attack from a bit higher
					end
				end
			end
		end

	else
		actor:sound_play(sound_shoot1, .5, 0.9 + math.random() * 0.8)
		
		if actor:is_authority() then 
			local damage = actor:skill_get_damage(chirrPrimary)
			local dir = actor:skill_util_facing_direction()

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do -- stuff for shattered mirror
				local attack_info
				attack_info = actor:fire_bullet(actor.x, actor.y, 400, dir, damage, nil, sprite_sparks, thorn_tracer, true).attack_info
				attack_info.climb = i * 8
				attack_info.__ssr_chirr_set_tame_target = apply_tame_tag
			end
		end
	end
end)