local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Chirr")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Chirr")


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
	decoy = sprite_decoy,
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


-- her movement control stuff
local player = Instance.find(gm.constants.pActor)
local flying = false
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
			wings.image_xscale = gm.cos(gm.degtorad(actor:skill_util_facing_direction()))
		else
			wings.x = actor.x
			wings.y = actor.y
			wings.image_xscale = gm.cos(gm.degtorad(actor:skill_util_facing_direction()))
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

	if #tamed < 1 + actor:item_stack_count(Item.find("ror", "ancientScepter")) then
		print("im sooo hungry...")
	else
		print("im full now!")
	end
end)


-------- get this girl her thorns
-- this is all basic skill info
chirrPrimary.sprite = sprite_skills
chirrPrimary.subimage = 0
chirrPrimary.cooldown = 5
chirrPrimary.damage = 0.9
chirrPrimary.require_key_press = false
chirrPrimary.is_primary = true
chirrPrimary.does_change_activity_state = true
chirrPrimary.hold_facing_direction = true
chirrPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local tracer_particle = Particle.find("ror", "WispGTracer") 
local tracer_color = Color.from_rgb(129,167,98)
local thorn_tracer, thorn_tracer_info = CustomTracer.new(function(x1, y1, x2, y2) -- i just kinda copied this tracer code and tweaked it for some fun visuals
	if x1 < x2 then x1 = x1 + 16 else x1 = x1 - 16 end

	y1 = y1 - 5
	y2 = y2 - 5

	local tracer = gm.instance_create(x1, y1, gm.constants.oEfLineTracer)

	tracer.xend = x2
	tracer.yend = y2
	tracer.sprite_index = sprite_tracer
	tracer.image_speed = 1
	tracer.rate = 1
	tracer.blend_1 = Color.from_rgb(129,167,98)
	tracer.blend_2 = tracer_color
	tracer.blend_rate = 0.2
	tracer.image_alpha = 1.5
	tracer.bm = 1
	tracer.width = 1

	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	tracer_particle:set_direction(dir, dir, 0, 0)

	local px = x1
	local i = 0
	while i < dist do
		tracer_particle:create_colour(px, y1 + gm.random_range(-8, 8), tracer_color, 1)
		px = px + gm.lengthdir_x(20, dir)
		i = i + 20
	end
end)
thorn_tracer_info.sparks_offset_y = 0

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

		actor:sound_play(sound_shoot1, .5, 0.9 + math.random() * 0.4)
		
		if actor:is_authority() then -- if local player
			local damage = actor:skill_get_damage(chirrPrimary)
			local dir = actor:skill_util_facing_direction()
			
			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then -- if not using heaven cracker
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do -- stuff for shattered mirror
					local attack = actor:fire_bullet(actor.x, actor.y, 400, dir, damage, nil, sprite_sparks, thorn_tracer, true)
					attack.climb = i * 8
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


-------- headbutt
-- just skill info
chirrSecondary.sprite = sprite_skills
chirrSecondary.subimage = 1
chirrSecondary.cooldown = 3*60
chirrSecondary.damage = 3.0
chirrSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrSecondary = State.new(NAMESPACE, "chirrSecondary") -- setting up states again

chirrSecondary:clear_callbacks()
chirrSecondary:onActivate(function( actor )
	actor:enter_state(stateChirrSecondary)
end)

stateChirrSecondary:clear_callbacks()
stateChirrSecondary:onEnter(function( actor, data ) -- skill setup again
	actor.image_index = 0
	data.fired = 0
end)

stateChirrSecondary:onStep(function( actor, data ) -- using the skill
	actor.sprite_index = sprite_shoot2
	actor.image_speed = 0.25

	actor:skill_util_fix_hspeed()

	for _, friend in ipairs(tamed) do
		gm.teleport_nearby(friend.value, player_actor.x, player_actor.y)
	end

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot2, .8, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(chirrSecondary)
			local dir = gm.cos(gm.degtorad(actor:skill_util_facing_direction())) -- explosions dont use directions, this is just used to make the x offset

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then -- if not using heaven cracker
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do -- stuff for shattered mirror
					attack = actor:fire_explosion(actor.x + dir * 40, actor.y, 100, 50, damage, nil, nil, true)
					attack.attack_info:allow_stun()
					attack.attack_info:set_stun(3, dir, standard)
				end
			end
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)


-------- heal pulse
-- more info yayyyyyyy
chirrUtility.sprite = sprite_skills
chirrUtility.subimage = 2
chirrUtility.cooldown = 15 * 60
chirrUtility.is_utility = true
chirrUtility.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrUtility = State.new(NAMESPACE, "chirrUtility") -- guess what this is, you get three tries

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

	if actor.image_index == 12 then -- when the animation reaches the final frame
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


-------- taming
-- getting a tame
chirrSpecial.sprite = sprite_skills
chirrSpecial.subimage = 3
chirrSpecial.cooldown = 4 * 60
chirrSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- getting a SUUUUUPPPERRR tame
local chirrSpecialScepter = Skill.new(NAMESPACE, "chirrSpecialBoosted")
chirrSpecial:set_skill_upgrade(chirrSpecialScepter)

chirrSpecialScepter.sprite = sprite_skills
chirrSpecialScepter.subimage = 5
chirrSpecialScepter.cooldown = 4 * 60
chirrSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- girl and her tether
local chirrTether = Skill.new(NAMESPACE, "chirrTether")
chirrTether.sprite = sprite_skills
chirrTether.subimage = 4
chirrTether.cooldown = 2 * 60
chirrTether.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrSpecial = State.new(NAMESPACE, "chirrSpecial")

chirrSpecial:clear_callbacks()
chirrSpecial:onActivate(function( actor, data )
	actor:enter_state(stateChirrSpecial)
end)
chirrSpecialScepter:clear_callbacks()
chirrSpecialScepter:onActivate(function( actor, data )
	actor:enter_state(stateChirrSpecial)
end)

local obj_tame_heart = Object.new(NAMESPACE, "chirrTameHeart") -- making the little heart object
obj_tame_heart.obj_sprite = sprite_shoot4
obj_tame_heart.obj_depth = 1

local function tameHeartStep( inst ) -- heart animation and lifetime stuff
	inst.image_speed = 0.25
	if inst.image_index == 9 then
		inst:destroy()
	end
end

obj_tame_heart:onStep(tameHeartStep)

local elite = Elite.new(NAMESPACE, "tamed") -- setup for the elite type
local elite_id = gm.elite_type_find("tamed")
elite:set_healthbar_icon(sprite_tamed_icon)
elite.palette = sprite_palette
gm._mod_elite_generate_palette_all()

 -- list of your friends!

Callback.add(Callback.TYPE.onGameStart, "chirrResetTameTable", function(  )
	tamed = {}
end)

Callback.add(Callback.TYPE.onDeath, "chirrTameUpdate", function( victim, fell_out_of_bounds )
	for index, friend in ipairs(tamed) do
		if friend.value == victim.value then
			table.remove(tamed, index)
		end
	end
end)

Callback.add(Callback.TYPE.onPickupCollected, "chirrFriendItemSync", function( pickup, player )
	if pickup.equipment_id == -1 then
		for _, friend in ipairs(tamed) do
			friend:item_give(pickup.item_id, 1, pickup.item_stack_kind)	
		end
	end
end)

Callback.add(Callback.TYPE.onStageStart, "chirrFriendGroupup", function(  )
	for _, friend in ipairs(tamed) do
		gm.teleport_nearby(friend.value, player_actor.x, player_actor.y)
	end
end)

stateChirrSpecial:clear_callbacks()
stateChirrSpecial:onEnter(function( actor, data )
	actor:sound_play(sound_shoot4, 1, 1)

	obj_tame_heart:create(actor.x + 14 * gm.cos(gm.degtorad(actor:skill_util_facing_direction())), actor.y - 10) -- make the little heart

	local potential_tames = List.new()
	actor:collision_circle_list(actor.x, actor.y, 120, gm.constants.pActor, true, false, potential_tames, false) -- grab all nearby actors like the util

	for _, tame_option in ipairs(potential_tames) do
		if tame_option.team ~= actor.team and not tame_option.enemy_party and tame_option.hp <= tame_option.maxhp * 0.5 then -- makes sure they arent on our team, arent a boss, and have half health or less
			if #tamed < 1 + actor:item_stack_count(Item.find("ror", "ancientScepter")) then -- sets the limit based off our scepter count
				actor:actor_team_set(tame_option, 1) -- setting the enemies team to our team (1 is player team, 2 is enemy)
				tame_option.persistent = true -- this stops our friends from going away each stage
				GM.elite_set(tame_option, elite) -- sets the elite type of your friend
				table.insert(tamed, tame_option) -- adds them to our list of friends
				tame_option.hp = tame_option.maxhp -- heals them for their troubles
				actor:inventory_items_copy(actor, tame_option, 0) -- gives our friend our items
				tame_option.y_range = 175
			end
		end
	end

	potential_tames:destroy()
	actor:skill_util_reset_activity_state()
end)
