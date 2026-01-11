local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Brawler")


local sprite_loadout =        Sprite.new("BrawlerSelect", path.combine(SPRITE_PATH, "Select.png"), 13, 2, 0)
local sprite_portrait =       Sprite.new("BrawlerPortrait", path.combine(SPRITE_PATH, "portrait.png"), 2)
local sprite_portrait_small = Sprite.new("BrawlerPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills =         Sprite.new("BrawlerSkills", path.combine(SPRITE_PATH, "skills.png"), 9)

local sprite_idle =           Sprite.new("BrawlerIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 9, 10)
local sprite_idle2 =          Sprite.new("BrawlerIdle2", path.combine(SPRITE_PATH, "idle_2.png"), 1, 9, 15)
local sprite_walk =           Sprite.new("BrawlerWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 11, 13)
local sprite_walk2 =          Sprite.new("BrawlerWalk2", path.combine(SPRITE_PATH, "walk_2.png"), 8, 11, 20)
local sprite_jump =           Sprite.new("BrawlerJump", path.combine(SPRITE_PATH, "jump.png"), 1, 9, 12)
local sprite_jump2 =          Sprite.new("BrawlerJump2", path.combine(SPRITE_PATH, "jump_2.png"), 1, 9, 15)
local sprite_climb =          Sprite.new("BrawlerClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 6, 10)
local sprite_death =          Sprite.new("BrawlerDeath", path.combine(SPRITE_PATH, "death.png"), 9, 12, 12)
local sprite_decoy =          Sprite.new("BrawlerDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 8, 10)

local sprite_shoot1_1 =       Sprite.new("BrawlerShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 13, 20)
local sprite_shoot1_2 =       Sprite.new("BrawlerShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 13, 20)
local sprite_shoot1_3 =       Sprite.new("BrawlerShoot1_3", path.combine(SPRITE_PATH, "shoot1_3.png"), 9, 13, 20)
local sprite_shoot1_4 =       Sprite.new("BrawlerShoot1_4", path.combine(SPRITE_PATH, "shoot1_4.png"), 6, 11, 27)
local sprite_shoot2_1 =       Sprite.new("BrawlerShoot2_1", path.combine(SPRITE_PATH, "shoot2_1.png"), 6, 12, 24)
local sprite_shoot2_2 =       Sprite.new("BrawlerShoot2_2", path.combine(SPRITE_PATH, "shoot2_2.png"), 4, 14, 22)
local sprite_shoot3_1 =       Sprite.new("BrawlerShoot3_1", path.combine(SPRITE_PATH, "shoot3_1.png"), 7, 33, 19)
local sprite_shoot3_2 =       Sprite.new("BrawlerShoot3_2", path.combine(SPRITE_PATH, "shoot3_2.png"), 7, 11, 24)
local sprite_shoot4_1 =       Sprite.new("BrawlerShoot4_1", path.combine(SPRITE_PATH, "shoot4_1.png"), 11, 29, 12)
local sprite_shoot4_2 =       Sprite.new("BrawlerShoot4_2", path.combine(SPRITE_PATH, "shoot4_2.png"), 10, 15, 21)
local sprite_shoot4_3 =       Sprite.new("BrawlerShoot4_3", path.combine(SPRITE_PATH, "shoot4_3.png"), 5, 10, 10)

local sprite_slam =           Sprite.new("BrawlerSlam", path.combine(SPRITE_PATH, "sBrawlerSlam.png"), 6, 61, 37)


-------- the brawlah
local brawler = Survivor.new("brawler")
local player_actor = nil
local grabbed = nil

brawler:set_stats_base({
	maxhp = 140,
	damage = 13,
	regen = 1.2/60
})

brawler:set_stats_level({
	maxhp = 30,
	damage = 3,
	regen = 0.15/60,
	armor = 3
})

brawler.cape_offset = {0,0,0,0}
brawler.primary_color = Color.from_rgb(236,180,124)

brawler.sprite_loadout = sprite_loadout
brawler.sprite_portrait = sprite_portrait
brawler.sprite_portrait_small = sprite_portrait_small
brawler.sprite_title = sprite_walk

Callback.add(brawler.on_init, function( actor )
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump
	actor.sprite_climb = sprite_climb
	actor.sprite_death = sprite_death
	actor.sprite_decoy = sprite_decoy
end)


local brawlerSelfGrabBuff = Buff.new("brawlerSelfGrabBuff")
brawlerSelfGrabBuff.show_icon = false
brawlerSelfGrabBuff.is_timed = false

RecalculateStats.add(function( actor, api )
	if actor:buff_count(brawlerSelfGrabBuff) > 0 then
		api.armor_add(100)
	end
end)

local brawlerVictimGrabBuff = Buff.new("brawlerVictimGrabBuff")
brawlerVictimGrabBuff.show_icon = false
brawlerVictimGrabBuff.is_timed = false

RecalculateStats.add(-1, function( actor, api )
	if actor:buff_count(brawlerVictimGrabBuff) > 0 then
		api.armor_add(-100)
		api.pGravity1_add(actor.pGravity1 * -1)
	end
end)

local function setGrab( actor, state, victim )
	if state == 1 then
		if victim then
			grabbed = victim
			grabbed:buff_apply(brawlerVictimGrabBuff, 1, 1)
		end

		actor.sprite_idle = sprite_idle2
		actor.sprite_walk = sprite_walk2
		actor.sprite_jump = sprite_jump2
		actor.sprite_jump_peak = sprite_jump2
		actor.sprite_fall = sprite_jump2

		actor.can_rope = false
		actor:buff_apply(brawlerSelfGrabBuff, 1, 1)
	else
		if Instance.exists(grabbed) then
			grabbed:buff_remove(brawlerVictimGrabBuff, 1)

			if grabbed.hp <= 0 then
				grabbed.pVspeed = 0
				grabbed.pHspeed = 0
				grabbed:move_contact_solid(270, -1)
				print(grabbed.hp)
			end

			grabbed = nil
		end

		actor.sprite_idle = sprite_idle
		actor.sprite_walk = sprite_walk
		actor.sprite_jump = sprite_jump
		actor.sprite_jump_peak = sprite_jump
		actor.sprite_fall = sprite_jump

		actor.can_rope = true
		actor:buff_remove(brawlerSelfGrabBuff, 1)
	end
end

Callback.add(Callback.ON_DEATH, function(victim, fell_out_of_bounds)
	if Instance.exists(grabbed) then
		if grabbed.value == victim.value then
			setGrab(player_actor, 0)
		end
	end
end)

Callback.add(brawler.on_step, function( actor )
	if Instance.exists(grabbed) then
		grabbed.x = actor.x + 10 * actor.image_xscale
		grabbed.y = actor.y - 20
	end

	if not player_actor then
		player_actor = actor
	end
end)

local brawlerPrimary =   brawler:get_skills(Skill.Slot.PRIMARY)[1]
local brawlerSecondary = brawler:get_skills(Skill.Slot.SECONDARY)[1]
local brawlerUtility =   brawler:get_skills(Skill.Slot.UTILITY)[1]
local brawlerSpecial =   brawler:get_skills(Skill.Slot.SPECIAL)[1]


-------- WAVE PUMMEL!
local combo = 0
local combo_window = 20
local combo_time = Global._current_frame

brawlerPrimary.sprite = sprite_skills
brawlerPrimary.subimage = 0
brawlerPrimary.cooldown = 12
brawlerPrimary.damage = 1
brawlerPrimary.require_key_press = false
brawlerPrimary.is_primary = true
brawlerPrimary.does_change_activity_state = true
brawlerPrimary.hold_facing_direction = true
brawlerPrimary.required_interrupt_priority = ActorState.InterruptPriority.ANY

local stateBrawlerPrimary1 = ActorState.new("brawlerPrimary1")
local stateBrawlerPrimary2 = ActorState.new("brawlerPrimary2")
local stateBrawlerPrimary3 = ActorState.new("brawlerPrimary3")

Callback.add(brawlerPrimary.on_activate, function( actor )
	if Global._current_frame - combo_time <= combo_window then
		combo = combo + 1
	else
		combo = 0
	end

	if combo == 0 then
		actor:set_state(stateBrawlerPrimary1)
	elseif combo == 1 then
		actor:set_state(stateBrawlerPrimary2)
	else
		actor:set_state(stateBrawlerPrimary3)
	end

	combo_time = Global._current_frame
end)

Callback.add(stateBrawlerPrimary1.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot1_1
	data.fired = 0
end)

Callback.add(stateBrawlerPrimary1.on_step, function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1
		actor:skill_util_nudge_forward(6 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(brawlerPrimary)
			local dir = actor.image_xscale

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage)
				end
			end
		end
	end

	if actor:is_authority() and not actor:control("skill1", 0) and actor.image_index > 1 then
		GM.actor_set_state_networked(actor, -1)
	end
end)

Callback.add(stateBrawlerPrimary2.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot1_2
	data.fired = 0
end)

Callback.add(stateBrawlerPrimary2.on_step, function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:actor_animation_set(actor.sprite_index, 0.2)

	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1
		actor:skill_util_nudge_forward(6 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(brawlerPrimary)
			local dir = actor.image_xscale

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage)
				end
			end
		end
	end

	if actor:is_authority() and not actor:control("skill1", 0) and actor.image_index > 3 then
		GM.actor_set_state_networked(actor, -1)
	end
end)

Callback.add(stateBrawlerPrimary3.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot1_3
	data.fired = 0
end)

Callback.add(stateBrawlerPrimary3.on_step, function( actor, data )
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
	actor:actor_animation_set(actor.sprite_index, 0.25)

		if data.fired == 0 and actor.image_index >= 2 then
		data.fired = 1
		actor:skill_util_nudge_forward(6 * actor.image_xscale)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(brawlerPrimary)
			local dir = actor.image_xscale

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					attack = actor:fire_explosion(actor.x + dir * 30, actor.y, 100, 50, damage * 1.25)
					attack.attack_info.knockup = 4
				end
			end
		end
	end
end)



-------- BLAZING UPPERCUT!
brawlerSecondary.sprite = sprite_skills
brawlerSecondary.subimage = 1
brawlerSecondary.cooldown = 3 * 60
brawlerSecondary.damage = 2.5
brawlerSecondary.require_key_press = true
brawlerSecondary.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateBrawlerSecondary = ActorState.new("brawlerSecondary")

Callback.add(brawlerSecondary.on_activate, function( actor )
	actor:set_state(stateBrawlerSecondary)
end)

Callback.add(stateBrawlerSecondary.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot2_1
	actor.image_speed = 0.25

	data.fired = 0
end)

Callback.add(stateBrawlerSecondary.on_step, function( actor, data )
	if data.fired == 0 then
		data.fired = 1
		actor.pVspeed = -1.5 * actor.pVmax

		if actor:is_authority() then
			local damage = actor:skill_get_damage(brawlerSecondary)
			local dir = actor.image_xscale


			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					attack = actor:fire_explosion(actor.x + 20 * dir, actor.y - 20, 60, 100, damage)
					attack.attack_info.knockup = 8
				end
			end
		end
	end

	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
end)



-------- EARTHSHATTER DIVE!
brawlerUtility.sprite = sprite_skills
brawlerUtility.subimage = 2
brawlerUtility.cooldown = 5 * 60
brawlerUtility.damage = 15
brawlerUtility.require_key_press = true
brawlerUtility.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateBrawlerUtility = ActorState.new("brawlerUtility")

Callback.add(brawlerUtility.on_activate, function( actor )
	actor:set_state(stateBrawlerUtility)
end)

Callback.add(stateBrawlerUtility.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot3_1
	actor.image_speed = 0.25

	data.step = 0
	data.substate = 0
	data.final_speed = 0
end)

Callback.add(stateBrawlerUtility.on_step, function( actor, data )
	if data.substate == 0 then
		actor.pVspeed = -1/(1 + data.step/3) * actor.pVmax

		if actor.image_index >= 3 then
			data.substate = 1
			data.step = 0
		end
	elseif data.substate == 1 then
		if actor.image_index >= 4 then
			actor.image_index = 3.9
		end
		
		actor.pVspeed = actor.pVspeed + actor.pVmax * 0.075
		actor.invincible = math.max(8, actor.invincible)

		if not gm.bool(actor.free) then
			data.substate = 2

			if actor:is_authority() then
				local base_damage = actor:skill_get_damage(brawlerUtility)
				local dir = actor.image_xscale

				local damage = base_damage * (data.final_speed/(actor.pVmax * 4))
				if damage > base_damage then
					damage = base_damage
				end
				print(damage)

				if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then 
					local buff_shadow_clone = Buff.find("shadowClone")
					for i=0, actor:buff_count(buff_shadow_clone) do
						attack = actor:fire_explosion(actor.x, actor.y, 120, 100, damage, sprite_slam)
						attack.attack_info.stun = 1.5
						attack.attack_info.knockback = 3
						attack.attack_info.knockup = 5
					end
				end
			end
		end

		data.final_speed = actor.pVspeed
	end

	data.step = data.step + 1
	actor:skill_util_fix_hspeed()
	actor:skill_util_exit_state_on_anim_end()
end)



-------- GRAB!
brawlerSpecial.sprite = sprite_skills
brawlerSpecial.subimage = 3
brawlerSpecial.cooldown = 5 * 60
brawlerSpecial.damage = 0
brawlerSpecial.require_key_press = true
brawlerSpecial.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateBrawlerSpecial = ActorState.new("brawlerSpecial")

Callback.add(brawlerSpecial.on_activate, function( actor )
	actor:set_state(stateBrawlerSpecial)
end)

Callback.add(stateBrawlerSpecial.on_enter, function( actor, data )
	actor.image_index = 0
	actor.sprite_index = sprite_shoot4_1
	actor.image_speed = 0.35
end)

Callback.add(stateBrawlerSpecial.on_step, function( actor, data )
	actor.pHspeed = actor.pHmax * 3 * actor.image_xscale

		local targets = List.new()
		local x_size = 50
		local y_size = 25

		actor:collision_rectangle_list(actor.x - x_size, actor.y + y_size, actor.x + x_size, actor.y - y_size, gm.constants.pActor, false, true, targets, false)

		for _, target in ipairs(targets) do
			if target.team ~= actor.team then
				setGrab(actor, 1, target)
				GM.actor_set_state_networked(actor, -1)
				targets:destroy()
				return
			end
		end
		targets:destroy()

	actor:skill_util_exit_state_on_anim_end()
end)