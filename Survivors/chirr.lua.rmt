--[[
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
local taming_target
local has_full_party = 0
local apply_tame_tag = 1


local tethered
local time_since_tether_override

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

local chirrTether = Skill.new(NAMESPACE, "chirrTether")


-- her movement control stuff and other on step stuff
local tameHealthbarBuff = Buff.new(NAMESPACE, "chirrShowAllyHPBuff") -- draws the health bars for your friends!
tameHealthbarBuff.show_icon = false
tameHealthbarBuff.is_timed = false

tameHealthbarBuff:clear_callbacks()
tameHealthbarBuff:onPreDraw(function( actor )
	actor:draw_hp_bar_ally()
end)

local tameOptionDisplay = Buff.new(NAMESPACE, "chirrIndicateTameTarget") -- this is her weird little tame indicator
tameOptionDisplay.show_icon = true
tameOptionDisplay.icon_sprite = sprite_portrait_small
tameOptionDisplay.is_timed = false
tameOptionDisplay.is_debuff = true

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

	if player_actor then  -- UNREASONABLE RIDICULOUS TETHER FIX
		if #tamed < 1 + player_actor:item_stack_count(Item.find("ror", "ancientScepter")) and has_full_party == 1 then -- if your party has newly been made empty
			has_full_party = 0
			time_since_tether_override = Global._current_frame
			GM._mod_ActorSkillSlot_removeOverride(player_actor:actor_get_skill_slot(Skill.SLOT.special), chirrTether , Skill.OVERRIDE_PRIORITY.cancel) -- sets the override skill to tether

		elseif #tamed >= 1 + player_actor:item_stack_count(Item.find("ror", "ancientScepter")) and has_full_party == 0 then -- if your party has newly been made full
			has_full_party = 1
			GM._mod_ActorSkillSlot_addOverride(player_actor:actor_get_skill_slot(Skill.SLOT.special), chirrTether, Skill.OVERRIDE_PRIORITY.cancel) -- removes the tether override skill
			time_since_tether_override = Global._current_frame
		end
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
local tracer_color2= Color.from_rgb(204,232,111)
local thorn_tracer, thorn_tracer_info = CustomTracer.new(function(x1, y1, x2, y2) -- i just kinda copied this tracer code and tweaked it for some fun visuals
	y1 = y1 - 8
	y2 = y2 - 8

	local dist = gm.point_distance(x1, y1, x2, y2)
	local dir = gm.point_direction(x1, y1, x2, y2)

	local t = GM.instance_create(x1, y1, gm.constants.oEfProjectileTracer)
	t.direction = dir
	t.speed = 60
	t.length = 80
	t.blend_1 = tracer_color2
	t.blend_2 = tracer_color2
	t:alarm_set(0, math.max(1, dist / t.speed))

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
					attack_info.__ssr_chirr_set_tame_target = apply_tame_tag
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
chirrSecondary.cooldown = 4*60
chirrSecondary.damage = 3.0
chirrSecondary.require_key_press = true
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

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot2, .8, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(chirrSecondary)
			local dir = actor.image_xscale -- explosions dont use directions, this is just used to make the x offset

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
chirrUtility.require_key_press = true
chirrUtility.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrUtility = State.new(NAMESPACE, "chirrUtility") -- guess what this is, you get three tries

local channeling_heal_pulse = 0
local channeling_step = 0

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

	channeling_heal_pulse = 1
	channeling_step = channeling_step + 1

	actor:skill_util_fix_hspeed()

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

stateChirrUtility:onExit(function( ... )
	channeling_heal_pulse = 0
	channeling_step = 0
end)


Callback.add(Callback.TYPE.onDraw, "SSChirrDrawPulseZone", function() -- just a fun visual to help you aim the heal pulse
	if channeling_heal_pulse == 1 then
		if player_actor then
			gm.draw_set_alpha(channeling_step * .0025)

			gm.draw_set_colour(Color.TEXT_GREEN)
			gm.draw_circle(player_actor.x, player_actor.y, 200 + (math.log(channeling_step) * 35), false)
	
			gm.draw_set_alpha(1)
		end
	end
end)




-------- taming
-- getting a tame
chirrSpecial.sprite = sprite_skills
chirrSpecial.subimage = 3
chirrSpecial.cooldown = 4 * 60
chirrSpecial.require_key_press = true
chirrSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- getting a SUUUUUPPPERRR tame
chirrSpecialScepter.sprite = sprite_skills
chirrSpecialScepter.subimage = 5
chirrSpecialScepter.cooldown = 4 * 60
chirrSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- girl and her tether
chirrTether.sprite = sprite_skills
chirrTether.subimage = 4
chirrTether.cooldown = 4 * 60
chirrTether.require_key_press = false
chirrTether.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateChirrSpecial = State.new(NAMESPACE, "chirrSpecial")
local stateChirrTether = State.new(NAMESPACE, "chirrTether")

local allyMaxHPFactor = 0.25
local siphonFactor = 0.75

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

local tamedStatChangeItem = Item.new(NAMESPACE, "tamedEliteItem", true) -- item for your fellas 
tamedStatChangeItem.is_hidden = true

tamedStatChangeItem:onStatRecalc(function( actor, stack )
	actor.maxhp = actor.maxhp * allyMaxHPFactor
	if actor.hp > actor.maxhp then
		actor.hp = actor.maxhp
	end
end)

elite:clear_callbacks()
elite:onApply(function( actor )
	actor:item_give(tamedStatChangeItem)
end)

Callback.add(Callback.TYPE.onGameStart, "SSChirrResetTameTable", function(  ) -- resets the friend list each game
	tamed = {}
	tethered = nil
	taming_target = nil
end)

Callback.add(Callback.TYPE.onDeath, "SSChirrTameUpdate", function( victim, fell_out_of_bounds ) -- removes friends from the list once they die
	for index, friend in ipairs(tamed) do
		if friend.value == victim.value then
			table.remove(tamed, index)
		end
	end

	if tethered then
		if tethered.value == victim.value then
			tethered = nil
		end
	end

	if taming_target then
		if victim.value == taming_target.value then
			taming_target:remove_buff(tameOptionDisplay)
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
	if player_actor then
		for _, friend in ipairs(tamed) do
			gm.teleport_nearby(friend.value, player_actor.x, player_actor.y)
		end
	end
end)

Callback.add(Callback.TYPE.onDamagedProc, "SSChirrTetherSiphon", function( actor, hit_info ) -- soul siphon ACTIVATE!!
	if player_actor then
		if actor.value == player_actor.value and tethered then
			local damage_to_siphon = hit_info.damage * siphonFactor
			player_actor:heal(damage_to_siphon)
			GM.damage_inflict(tethered, damage_to_siphon)
		end
	end
end)

Callback.add(Callback.TYPE.onDraw, "SSChirrDrawTether", function(  ) -- draws the tether graphics when shes tethering to an ally
	if player_actor then
		if tethered then
			gm.draw_set_alpha(0.5)

			gm.draw_set_colour(Color.TEXT_GREEN)
			gm.draw_line_width(player_actor.x, player_actor.y, tethered.x, tethered.y, 5 + math.random() * 2)
			gm.draw_circle(tethered.x, tethered.y, 4 + math.random() * 8, false)
			gm.draw_circle(player_actor.x, player_actor.y, 2 + math.random() * 4, false)

			gm.draw_set_colour(Color.WHITE)
			gm.draw_line_width(player_actor.x, player_actor.y, tethered.x, tethered.y, 2)
			gm.draw_circle(tethered.x, tethered.y, 8, true)
			gm.draw_circle(player_actor.x, player_actor.y, 4, true)

			gm.draw_set_alpha(1)
		end
	end
end)

Callback.add(Callback.TYPE.onAttackHit, "SSChirrSetTameTarget", function( hit_info ) -- sets chirrs tame target from her primary shot
	local tame_tag = hit_info.attack_info.__ssr_chirr_set_tame_target

	if tame_tag then
		if taming_target then
			if taming_target ~= hit_info.target and #tamed < 1 + player_actor:item_stack_count(Item.find("ror", "ancientScepter")) then
				taming_target:buff_remove(tameOptionDisplay)
				taming_target = hit_info.target
				hit_info.target:buff_apply(tameOptionDisplay, 1)
			end
		else
			taming_target = hit_info.target
			hit_info.target:buff_apply(tameOptionDisplay, 1)
		end
	end
end)



stateChirrSpecial:clear_callbacks()
stateChirrSpecial:onEnter(function( actor, data )
	actor:sound_play(sound_shoot4, 1, 1)

	obj_tame_heart:create(actor.x + 14 * actor.image_xscale, actor.y - 10) -- make the little heart

	if taming_target then
		if taming_target.team ~= actor.team and not taming_target.enemy_party and taming_target.hp <= taming_target.maxhp * 0.5 then -- makes sure they arent on our team, arent a boss, and have half health or less
			if #tamed < 1 + actor:item_stack_count(Item.find("ror", "ancientScepter")) then -- sets the limit based off our scepter count
				table.insert(tamed, taming_target) -- adds them to our list of total friends
				taming_target.persistent = true -- this stops our friends from going away each stage
				taming_target.is_character_enemy_targettable = true -- lets enemies actually target the poor fella
				actor:actor_team_set(taming_target, 1) -- setting the enemies team to our team (1 is player team, 2 is enemy)

				taming_target:buff_remove(tameOptionDisplay) -- removes the little tame indicator
				taming_target:buff_apply(tameHealthbarBuff, 1)
				GM.elite_set(taming_target, elite) -- sets the elite type of your friend
				taming_target.hp = taming_target.maxhp * allyMaxHPFactor -- heals them for their troubles
				print(taming_target.hp, taming_target.maxhp)
				actor:inventory_items_copy(actor, taming_target, 0) -- gives our friend our items
				taming_target.y_range = taming_target.y_range + 100 -- lets our friend attack from a bit higher
			end
		end
	end

	actor:skill_util_reset_activity_state()
end)

chirrTether:clear_callbacks()
chirrTether:onActivate(function( actor, state )
	actor:enter_state(stateChirrTether)
end)

stateChirrTether:clear_callbacks()
stateChirrTether:onEnter(function( actor, data )
	data.step = 0
	data.exit = 0
end)

local tether_tp_charge_time = .75*60

stateChirrTether:onStep(function( actor, data ) -- track how long the tether skill is held to see what the skill should do after being let go
	if Global._current_frame - time_since_tether_override > 10 then
		actor:skill_util_fix_hspeed()
	
		data.step = data.step + 1

		local holding = gm.bool(actor.v_skill)
		if not holding or data.step >= tether_tp_charge_time then
			actor:skill_util_reset_activity_state()
		end		local holding = gm.bool(actor.v_skill)
		if not holding or data.step >= tether_tp_charge_time then
			actor:skill_util_reset_activity_state()
		end
	else
		data.exit = 1
		actor:skill_util_reset_activity_state()
	end
end)

stateChirrTether:onExit(function( actor, data )
	if data.exit == 0 then
		if data.step >= tether_tp_charge_time then -- teleport friends nearby if held long enough
			for _, friend in ipairs(tamed) do
				GM.teleport_nearby(friend, actor.x, actor.y + 45 )
			end
		else -- tether the closest fella otherwise
			if not tethered then
				local nearby_friends = {}
				local nearby_allies = List.new()
				actor:collision_circle_list(actor.x, actor.y, 240, gm.constants.pActor, true, false, nearby_allies, false)

				for _,ally in ipairs(nearby_allies) do
					for _,friend in ipairs(tamed) do 
						if ally.value == friend.value then
							table.insert(nearby_friends, ally)
						end
					end
				end

				local shortest_distance
				local closest_friend
				if #nearby_friends > 0 then
					for _,friend in ipairs(nearby_friends) do
						local current_distance = math.sqrt((friend.x - actor.x)^2+(friend.y - actor.y)^2)

						if not shortest_distance or shortest_distance > current_distance then
							shortest_distance = current_distance
							closest_friend = friend
							print(shortest_distance)
						end
					end
				end

				tethered = closest_friend
				nearby_allies:destroy()
			else
				tethered = nil
			end
		end
	end
end)
]]