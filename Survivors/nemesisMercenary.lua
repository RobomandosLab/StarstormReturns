local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisMercenary")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisMercenary")

local sprite_loadout		= Sprite.new("NemesisMercenarySelect", path.combine(SPRITE_PATH, "select.png"), 19, 28, 0)
local sprite_portrait		= Sprite.new("NemesisMercenaryPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small	= Sprite.new("NemesisMercenaryPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Sprite.new("NemesisMercenarySkills", path.combine(SPRITE_PATH, "skills.png"), 5)
local sprite_credits		= Sprite.new("CreditsSurvivorNemesisMercenary", path.combine(SPRITE_PATH, "credits.png"), 1, 8, 10)

local sprite_idle			= Sprite.new("NemesisMercenaryIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 11, 15)
local sprite_idle2			= Sprite.new("NemesisMercenaryIdle2", path.combine(SPRITE_PATH, "idle2.png"), 3, 19, 14)
local sprite_idle2l			= Sprite.new("NemesisMercenaryIdle2l", path.combine(SPRITE_PATH, "idle2l.png"), 3, 19, 7)
local sprite_walk			= Sprite.new("NemesisMercenaryWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 12, 17)
local sprite_walk_back		= Sprite.new("NemesisMercenaryWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 12, 17)
local sprite_jump			= Sprite.new("NemesisMercenaryJump", path.combine(SPRITE_PATH, "jump.png"), 1, 10, 16)
local sprite_jump_peak		= Sprite.new("NemesisMercenaryJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 13, 15)
local sprite_fall			= Sprite.new("NemesisMercenaryFall", path.combine(SPRITE_PATH, "fall.png"), 1, 15, 14)
local sprite_climb			= Sprite.new("NemesisMercenaryClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 13, 23)
local sprite_death			= Sprite.new("NemesisMercenaryDeath", path.combine(SPRITE_PATH, "death.png"), 15, 50, 17)
local sprite_decoy			= Sprite.new("NemesisMercenaryDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 22, 18)
local sprite_drone_idle		= Sprite.new("DronePlayerNemesisMercenaryIdle", path.combine(SPRITE_PATH, "drone_idle.png"), 5, 22, 13)
local sprite_drone_shoot	= Sprite.new("DronePlayerNemesisMercenaryShoot", path.combine(SPRITE_PATH, "drone_shoot.png"), 5, 30, 12)
local sprite_palette		= Sprite.new("NemesisMercenaryPalette", path.combine(SPRITE_PATH, "palette.png"))

local sprite_shoot1_1a		= Sprite.new("NemesisMercenaryShoot1_1a", path.combine(SPRITE_PATH, "shoot1_1a.png"), 5, 17, 37)
local sprite_shoot1_2a		= Sprite.new("NemesisMercenaryShoot1_2a", path.combine(SPRITE_PATH, "shoot1_2a.png"), 5, 21, 16)
local sprite_shoot1_3a		= Sprite.new("NemesisMercenaryShoot1_3a", path.combine(SPRITE_PATH, "shoot1_3a.png"), 5, 19, 42)
local sprite_shoot1_4a		= Sprite.new("NemesisMercenaryShoot1_4a", path.combine(SPRITE_PATH, "shoot1_4a.png"), 5, 31, 25)
local sprite_shoot1b		= Sprite.new("NemesisMercenaryShoot1b", path.combine(SPRITE_PATH, "shoot1b.png"), 5, 20, 31)
local sprite_shoot1lb		= Sprite.new("NemesisMercenaryShoot1lb", path.combine(SPRITE_PATH, "shoot1lb.png"), 5, 64, 13)

local sprite_shoot2a		= Sprite.new("NemesisMercenaryShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 5, 17, 60)
local sprite_shoot2b		= Sprite.new("NemesisMercenaryShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 5, 21, 53)
local sprite_shoot2lb		= Sprite.new("NemesisMercenaryShoot2lb", path.combine(SPRITE_PATH, "shoot2lb.png"), 5, 84, 60)

local sprite_shoot3			= Sprite.new("NemesisMercenaryShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 9, 21, 16)

local sprite_shoot4_1		= Sprite.new("NemesisMercenaryShoot4_1", path.combine(SPRITE_PATH, "shoot4_1.png"), 8, 28, 29)
local sprite_shoot4_2		= Sprite.new("NemesisMercenaryShoot4_2a", path.combine(SPRITE_PATH, "shoot4_2a.png"), 11, 47, 130)
local sprite_shoot4_2b		= Sprite.new("NemesisMercenaryShoot4_2b", path.combine(SPRITE_PATH, "shoot4_2b.png"), 11, 77, 77)
local sprite_shoot4_2c		= Sprite.new("NemesisMercenaryShoot4_2c", path.combine(SPRITE_PATH, "shoot4_2c.png"), 11, 82, 85)
local sprite_shoot4_3		= Sprite.new("NemesisMercenaryShoot4_3", path.combine(SPRITE_PATH, "shoot4_3.png"), 5, 24, 15)

local sprite_sparks			= Sprite.new("NemesisMercenarySparks", path.combine(SPRITE_PATH, "sparks.png"), 5, 13, 17)
local sprite_sparks2		= Sprite.new("NemesisMercenarySparks2", path.combine(SPRITE_PATH, "sparks2.png"), 5, 56, 40)
local sprite_boost 			= Sprite.new("NemesisMercenaryBoost", path.combine(SPRITE_PATH, "boost.png"), 5, 59, 20)

local sprite_portal 		= Sprite.new("NemesisMercenaryPortal", path.combine(SPRITE_PATH, "portal.png"), 27, 108, 170)
local sprite_portal_inside	= Sprite.new("NemesisMercenaryPortalInside", path.combine(SPRITE_PATH, "portal_inside.png"), 27, 108, 170)
local sound_portal			= Sound.new("NemesisMercenaryPortal", path.combine(SOUND_PATH, "portal.ogg"))

local sprite_log			= Sprite.new("NemesisMercenaryLog", path.combine(SPRITE_PATH, "log.png"))

sprite_walk:set_speed(0.75)
sprite_walk_back:set_speed(0.75)

local sound_shoot2a			= Sound.new("NemesisMercenaryShoot2a", path.combine(SOUND_PATH, "shoot2a.ogg"))
local sound_shoot2b			= Sound.new("NemesisMercenaryShoot2b", path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_shoot3a			= Sound.new("NemesisMercenaryShoot3a", path.combine(SOUND_PATH, "shoot3a.ogg"))
local sound_shoot3b			= Sound.new("NemesisMercenaryShoot3b", path.combine(SOUND_PATH, "shoot3b.ogg"))
local sound_disappear		= Sound.new("NemesisMercenaryDisappear", path.combine(SOUND_PATH, "disappear.ogg"))
local sound_teleport		= Sound.new("NemesisMercenaryTeleport", path.combine(SOUND_PATH, "teleport.ogg"))
local sound_shoot4			= Sound.new("NemesisMercenaryShoot4", path.combine(SOUND_PATH, "shoot4.ogg"))
local sound_slide			= Sound.new("NemesisMercenarySlide", path.combine(SOUND_PATH, "slide.ogg"))
--local sound_select			= Sound.new("UISurvivorsNemesisMercenary", path.combine(SOUND_PATH, "select.ogg"))

local particleWispGTracer 	= Particle.find("WispGTracer")
local particleBlood 		= Particle.find("Blood1")

local particleSpecialTrail = Particle.new("NemmercSpecialTrail")
particleSpecialTrail:set_shape(Particle.Shape.DISK)
particleSpecialTrail:set_scale(1, 1)
particleSpecialTrail:set_size(0.3, 0.3, -0.01, 0)
particleSpecialTrail:set_life(60, 60)
particleSpecialTrail:set_color2(Color.WHITE, Color.from_rgb(233, 142, 67))

local nemmerc = Survivor.new("nemesisMercenary")

nemmerc:set_stats_base({
	health = 118,
	damage = 11,
	regen = 0.02,
})

nemmerc:set_stats_level({
	health = 36,
	damage = 3.5,
	regen = 0.0025,
	armor = 3,
})
--[[
local nemmerc_log = SurvivorLog.new_from_survivor(nemmerc)
nemmerc_log.portrait_id = sprite_log
nemmerc_log.sprite_id = sprite_walk
nemmerc_log.sprite_icon_id = sprite_portrait
]]
nemmerc.primary_color = Color.from_hex(0xFC4E45)

nemmerc.sprite_loadout = sprite_loadout
nemmerc.sprite_portrait = sprite_portrait
nemmerc.sprite_portrait_small = sprite_portrait_small

nemmerc.sprite_idle = sprite_idle -- used by skin systen for idle sprite
nemmerc.sprite_title = sprite_walk -- also used by skin system for walk sprite
nemmerc.sprite_credits = sprite_credits

nemmerc.sprite_palette = sprite_palette
nemmerc.sprite_portrait_palette = sprite_palette
nemmerc.sprite_loadout_palette = sprite_palette

nemmerc.select_sound_id = gm.constants.wUI_Survivors_Bandit --sound_select
nemmerc.cape_offset = Array.new({-3, -8, 0, -5})

Callback.add(nemmerc.on_init, function(actor)
	-- setup half-sprite nonsense
	actor.sprite_idle_half = Array.new({sprite_idle, nil, 0})
	actor.sprite_walk_half = Array.new({sprite_walk, nil, 0, sprite_walk_back})
	actor.sprite_jump_half = Array.new({sprite_jump, nil, 0})
	actor.sprite_jump_peak_half = Array.new({sprite_jump_peak, nil, 0})
	actor.sprite_fall_half = Array.new({sprite_fall, nil, 0})
	
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_climb = sprite_climb
	actor.sprite_death = sprite_death
	actor.sprite_decoy = sprite_decoy
	actor.sprite_drone_idle = sprite_drone_idle
	actor.sprite_drone_shoot = sprite_drone_shoot
	
	-- slide sprites	
	actor.sprite_idle_slide = sprite_idle2
	actor.sprite_shoot1_slide = sprite_shoot1b
	actor.sprite_shoot2_slide = sprite_shoot2b
	
	actor.sprite_idle_slide_left = sprite_idle2l
	actor.sprite_shoot1_slide_left = sprite_shoot1lb
	actor.sprite_shoot2_slide_left = sprite_shoot2lb
	
	actor.sprite_idle_normal = sprite_idle
	actor.sprite_jump_normal = sprite_jump
	actor.sprite_jump_peak_normal = sprite_jump_peak
	actor.sprite_fall_normal = sprite_fall
	
	local data = Instance.get_data(actor)
	
	data.nemmerc_slide = 0
	data.nemmerc_slide_dir = 0
	data.nemmerc_slide_prep = 0
	data.nemmerc_primary_combo_timer = 0
	data.nemmerc_primary_combo_count = 0
	
	actor.is_nemesis = true -- toggles the portal spawning animation
	
	actor.sprite_portal = sprite_portal
	actor.sprite_portal_inside = sprite_portal_inside
	actor.sound_portal = sound_portal

	actor:survivor_util_init_half_sprites()
end)

Callback.add(nemmerc.on_step, function(actor)
	local data = Instance.get_data(actor)
	
	if data.nemmerc_primary_combo_timer > 0 then
		data.nemmerc_primary_combo_timer = data.nemmerc_primary_combo_timer - 1
	else
		data.nemmerc_primary_combo_count = 0
	end
	
	if data.nemmerc_slide > 0 then
		data.nemmerc_slide = data.nemmerc_slide - 1
		
		local braking_left = (Util.bool(actor.moveLeft) and not Util.bool(actor.moveRight) and data.nemmerc_slide_dir > 0)
		local braking_right = (Util.bool(actor.moveRight) and not Util.bool(actor.moveLeft) and data.nemmerc_slide_dir < 0)
		
		if braking_left or braking_right then
			data.nemmerc_slide = math.max(data.nemmerc_slide - 1, 0)
		end
		
		actor.pHspeed = data.nemmerc_slide / 50 * 2 * actor.pHmax * data.nemmerc_slide_dir + actor.pHmax * data.nemmerc_slide_dir
		actor.image_xscale = data.nemmerc_slide_dir
		actor.moveLeft = 0
		actor.moveRight = 0
		
		if actor.hold_facing_direction_xscale ~= data.nemmerc_slide_dir then
			actor.sprite_idle = actor.sprite_idle_slide_left
			actor.sprite_jump = actor.sprite_idle_slide_left
			actor.sprite_jump_peak = actor.sprite_idle_slide_left
			actor.sprite_fall = actor.sprite_idle_slide_left
			actor.sprite_shoot1 = actor.sprite_shoot1_slide_left
			actor.sprite_shoot2 = actor.sprite_shoot2_slide_left
		else
			actor.sprite_idle = actor.sprite_idle_slide
			actor.sprite_jump = actor.sprite_idle_slide
			actor.sprite_jump_peak = actor.sprite_idle_slide
			actor.sprite_fall = actor.sprite_idle_slide
			actor.sprite_shoot1 = actor.sprite_shoot1_slide
			actor.sprite_shoot2 = actor.sprite_shoot2_slide
		end
	else
		actor.sprite_idle = actor.sprite_idle_normal
		actor.sprite_jump = actor.sprite_jump_normal
		actor.sprite_jump_peak = actor.sprite_jump_peak_normal
		actor.sprite_fall = actor.sprite_fall_normal
	end
end)

local primary = nemmerc:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = nemmerc:get_skills(Skill.Slot.SECONDARY)[1]
local utility = nemmerc:get_skills(Skill.Slot.UTILITY)[1]
local special = nemmerc:get_skills(Skill.Slot.SPECIAL)[1]
local specialS = Skill.new("nemesisMercenaryVBoosted")

-- Lascerate
primary.sprite = sprite_skills
primary.subimage = 0
primary.damage = 0.8
primary.cooldown = 0
primary.is_primary = true
primary.required_interrupt_priority = ActorState.InterruptPriority.ANY

local statePrimaryA = ActorState.new("nemMercenaryAttachmentStabA")
local statePrimaryB = ActorState.new("nemMercenaryAttachmentStabB")
local statePrimaryC = ActorState.new("nemMercenaryAttachmentStabC")
local statePrimaryD = ActorState.new("nemMercenaryAttachmentStabD")
local statePrimaryE = ActorState.new("nemMercenaryAttachmentStabE")

Callback.add(primary.on_activate, function(actor, skill, slot)
	local data = Instance.get_data(actor)
	
	if data.nemmerc_slide <= 0 then
		if data.nemmerc_primary_combo_count == 0 then
			actor:set_state(statePrimaryA)
		elseif data.nemmerc_primary_combo_count == 1 then
			actor:set_state(statePrimaryB)
		elseif data.nemmerc_primary_combo_count == 2 then
			actor:set_state(statePrimaryC)
		elseif data.nemmerc_primary_combo_count == 3 then
			actor:set_state(statePrimaryD)
		end
	else
		actor:set_state(statePrimaryE)
	end
end)

local function nemmerc_primary_code(actor, data, sprite_a, sound, combo)
	local get_data = Instance.get_data(actor)
	
	local speed = 0.2
	if combo == 3 then
		speed = 0.17
	end
	
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_a, speed)
	
	local condition = (actor.image_index >= 1 and data.fired == 0)
	if combo == 1 then
		condition = ((actor.image_index >= 0 and data.fired == 0) or (actor.image_index >= 2 and data.fired == 1))
	end
	
	if condition then
		data.fired = data.fired + 1
		get_data.nemmerc_primary_combo_timer = 45
		
		if combo < 3 then
			get_data.nemmerc_primary_combo_count = combo + 1
		else
			get_data.nemmerc_primary_combo_count = 0
		end
		
		if data.fired == 2 then
			sound = gm.constants.wMercenaryShoot1_3
		end
		
		actor:sound_play(sound, 1, 0.9 + math.random() * 0.2)
		actor:skill_util_nudge_forward(2 * actor.image_xscale)
		
		if actor:is_authority() then
			local damage = actor:skill_get_damage(primary)
			local offset = 40
			local range = 100
			
			if combo == 3 then
				damage = damage * 1.5
				offset = 60
				range = 140
			end
			
			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					local attack = actor:fire_explosion(actor.x + offset * actor.image_xscale, actor.y, range, 80, damage, nil, sprite_sparks).attack_info
					attack.climb = i * 8 * 1.35
					
					if combo == 3 then
						attack.knockback = attack.knockback + 3
						attack.knockback_direction = actor.image_xscale
					end
				end
			end
		end
	end
end

Callback.add(statePrimaryA.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryA.on_step, function(actor, data)
	nemmerc_primary_code(actor, data, sprite_shoot1_1a, gm.constants.wMercenaryShoot1_2, 0)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryA.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryB.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryB.on_step, function(actor, data)
	nemmerc_primary_code(actor, data, sprite_shoot1_2a, gm.constants.wMercenaryShoot1_1, 1)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryB.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryC.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryC.on_step, function(actor, data)
	nemmerc_primary_code(actor, data, sprite_shoot1_3a, gm.constants.wMercenaryShoot1_2, 2)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryC.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryD.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryD.on_step, function(actor, data)
	nemmerc_primary_code(actor, data, sprite_shoot1_4a, gm.constants.wMercenary_Parry_StandardSlash, 3)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryD.on_get_interrupt_priority, function(actor, data)
	return ActorState.InterruptPriority.PRIORITY_SKILL
end)

Callback.add(statePrimaryE.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.dir = actor.hold_facing_direction_xscale
end)

Callback.add(statePrimaryE.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	actor:actor_animation_set(actor.sprite_shoot1, 0.2)
	
	if actor.image_index >= 1 and data.fired == 0 then
		data.fired = 1
		
		actor:sound_play(gm.constants.wMercenaryShoot1_2, 1, 0.9 + math.random() * 0.2)
		
		if actor:is_authority() then
			local damage = actor:skill_get_damage(primary)
			local offset = 40
			local range = 100
			
			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					local attack = actor:fire_explosion(actor.x + offset * data.dir, actor.y, range, 80, damage, nil, sprite_sparks).attack_info
					attack.climb = i * 8 * 1.35
				end
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryE.on_get_interrupt_priority, function(actor, data)
	return ActorState.InterruptPriority.PRIORITY_SKILL
end)

-- Quick Trigger
secondary.sprite = sprite_skills
secondary.subimage = 1
secondary.cooldown = 6 * 60
secondary.damage = 4
secondary.required_interrupt_priority = ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD

local stateSecondary = ActorState.new("nemMercenaryQuickTrigger")

Callback.add(secondary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary)
end)

Callback.add(stateSecondary.on_enter, function(actor, data)
	local get_data = Instance.get_data(actor)
	
	actor.image_index = 0
	data.fired = 0
	data.reloaded = 0
	
	data.sprite = nil
	if get_data.nemmerc_slide > 0 then
		data.sprite = actor.sprite_shoot2
	else
		data.sprite = sprite_shoot2a.value
	end
end)

Callback.add(stateSecondary.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	
	actor:actor_animation_set(data.sprite, 0.2)
	
	if get_data.nemmerc_slide <= 0 then
		actor:skill_util_fix_hspeed()
	end
	
	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot2a.value, 1.5, 0.9 + math.random() * 0.2)
		actor:screen_shake(3)
		
		if actor:is_authority() then
			local damage = actor:skill_get_damage(secondary)
			
			local buff_shadow_clone = Buff.find("shadowClone")
			for i=0, actor:buff_count(buff_shadow_clone) do
				local attack = actor:fire_bullet(actor.x, actor.y - 4, 200, actor:skill_util_facing_direction(), damage, 1, sprite_sparks2, Tracer.ENFORCER1)
				attack.attack_info.stun = 2
				attack.attack_info.climb = i * 8 * 1.35
			end
		end
	end
	
	if data.reloaded == 0 and actor.image_index >= 3 then
		data.reloaded = 1
		actor:sound_play(sound_shoot2b.value, 0.6, 0.9 + math.random() * 0.2)
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(stateSecondary.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

-- Blinding Slide
utility.sprite = sprite_skills
utility.subimage = 2
utility.cooldown = 3 * 60
utility.is_utility = true
utility.override_strafe_direction = true
utility.ignore_aim_direction = true
utility.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateUtility = ActorState.new("nemMercenaryBlindingSlide")
stateUtility.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL

Callback.add(utility.on_activate, function(actor, skill, slot)
	actor:set_state(stateUtility)
end)

Callback.add(stateUtility.on_enter, function(actor, data)
	local get_data = Instance.get_data(actor)
	get_data.nemmerc_slide_prep = 1
	
	actor.image_index = 0
	data.fired = 0
	data.sound = 0
	data.counter = 0
end)

Callback.add(stateUtility.on_step, function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.3, false)
	
	local get_data = Instance.get_data(actor)
	
	local release = not Util.bool(actor.c_skill)
	
	if not actor:is_authority() then
		release = Util.bool(actor.activity_var2)
	end
	
	if release then
		if Net.online then
			if Net.host then
				gm.server_message_send(0, 43, actor:get_object_index_self(), actor.m_id, 1, Math.sign(actor.image_xscale))
			else
				gm.client_message_send(43, 1, Math.sign(actor.image_xscale))
			end
		end
		
		if actor.image_index < 6 then
			actor.image_index = 6
		end
	end
	
	if actor.image_index >= 1 and data.sound == 0 then
		data.sound = 1
		actor:sound_play(sound_shoot3a.value, 1, 0.9 + math.random() * 0.2)
	end
	
	if get_data.nemmerc_slide < 25 then
		actor:skill_util_fix_hspeed()
	end
	
	if data.fired == 0 then
		actor.invincible = math.max(actor.invincible, 5)
	end
	
	if actor.image_index >= 6 and data.fired == 0 then
		
		data.counter = 11
		data.fired = 1
		
		local sparks = Object.find("EfSparks"):create(actor.x, actor.y - 2)
		sparks.sprite_index = sprite_boost
		sparks.image_xscale = actor.image_xscale
		sparks.image_yscale = 1
		
		actor:sound_play(sound_slide.value, 1, 0.9 + math.random() * 0.2)
		
		get_data.nemmerc_slide = 50
		get_data.nemmerc_slide_dir = actor.image_xscale
	end
	
	if data.counter > 0 and data.fired == 1 then
		data.counter = data.counter - 1
	elseif data.counter == 1 and data.fired == 1 then
		get_data.nemmerc_slide_prep = 0
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(stateUtility.on_exit, function(actor, data)
	local get_data = Instance.get_data(actor)
	get_data.nemmerc_slide_prep = 0
end)

Callback.add(stateUtility.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 7 then
		return ActorState.InterruptPriority.ANY
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

DamageDodge.add(function(api, current_dodge)
	if not Instance.exists(api.hit) then return end
	
	local data = Instance.get_data(api.hit)
	
	if data.nemmerc_slide_prep == 1 then
		api.hit:get_default_skill(Skill.Slot.SECONDARY):reset_cooldown()
		data.nemmerc_slide_prep = 0
		api.hit:sound_play(sound_shoot3b.value, 0.7, 0.9 + math.random() * 0.2)
		api.hit:sound_play(sound_shoot2b.value, 0.6, 0.9 + math.random() * 0.2)
		
		local flash = Object.find("EfFlash"):create(api.hit.x, api.hit.y)
		flash.parent = api.hit
		flash.rate = 0.1
		flash.image_alpha = 1
		
		api.hit.invincible = math.max(api.hit.invincible, 50)
		return DamageDodge.DEFLECTED
	end
end)

-- Devitalize
special.sprite = sprite_skills
special.subimage = 3
special.cooldown = 8 * 60
special.damage = 7
special.required_interrupt_priority = ActorState.InterruptPriority.SKILL
special.upgrade_skill = specialS

specialS.sprite = sprite_skills
specialS.subimage = 4
specialS.cooldown = 8 * 60
specialS.damage = 7
specialS.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateSpecialPre = ActorState.new("nemMercenaryDevitalizePre")
local stateSpecial = ActorState.new("nemMercenaryDevitalize")
local stateSpecialEnd = ActorState.new("nemMercenaryDevitalizePost")

local function nemmerc_get_target(actor)
	local target = nil
		
	for _, enemy in ipairs(actor:get_collisions_rectangle(gm.constants.pActorCollisionBase, actor.x - 500 * actor.image_xscale, actor.y - 500, actor.x + 500 * actor.image_xscale, actor.y + 500)) do
		if actor:attack_collision_canhit(enemy) and Math.distance(actor.x, actor.y, enemy.x, enemy.y) < 500 and GM.attack_collision_resolve(enemy).stunned and ssr_instance_line_of_sight(actor, enemy) then
			if target == nil then
				target = enemy
			else
				if GM.attack_collision_resolve(enemy).hp < GM.attack_collision_resolve(target).hp then
					target = enemy
				elseif GM.attack_collision_resolve(enemy).hp == GM.attack_collision_resolve(target).hp and Math.distance(actor.x, actor.y, enemy.x, enemy.y) <= Math.distance(actor.x, actor.y, target.x, target.y) then
					target = enemy
				end
			end
		end
	end
		
	if target == nil then
		for _, enemy in ipairs(actor:get_collisions_rectangle(gm.constants.pActorCollisionBase, actor.x - 500 * actor.image_xscale, actor.y - 500, actor.x + 500 * actor.image_xscale, actor.y + 500)) do
			if actor:attack_collision_canhit(enemy) and Math.distance(actor.x, actor.y, enemy.x, enemy.y) < 500 and ssr_instance_line_of_sight(actor, enemy) then
				if target == nil then
					target = enemy
				else
					if GM.attack_collision_resolve(enemy).hp < GM.attack_collision_resolve(target).hp then
						target = enemy
					elseif GM.attack_collision_resolve(enemy).hp == GM.attack_collision_resolve(target).hp and Math.distance(actor.x, actor.y, enemy.x, enemy.y) <= Math.distance(actor.x, actor.y, target.x, target.y) then
						target = enemy
					end
				end
			end
		end
	end
	
	return target
end

Callback.add(special.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecialPre)
end)

Callback.add(specialS.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecialPre)
end)

Callback.add(stateSpecialPre.on_enter, function(actor, data)
	Instance.get_data(actor).nemmerc_slide = 0
	actor.image_index = 0

	actor:sound_play(sound_disappear.value, 1, 1)
	
	local target = nil
	target = nemmerc_get_target(actor)
	
	if target then
		data.target = target.value
		data.target_x = target.x
		data.target_y = target.y
		
		if target.x >= actor.x then
			actor.image_xscale = 1
		else
			actor.image_xscale = -1
		end
	else
		data.target = nil
	end
	
	if not (data.killed and data.killed == 1) then
		data.begin_x = actor.x
		data.begin_y = actor.y
	end
	
	Instance.get_data(actor).nemmerc_special_state = 1
end)

Callback.add(stateSpecialPre.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot4_1, 0.3)
	
	actor:get_active_skill(Skill.Slot.SPECIAL):freeze_cooldown()
	actor.invincible = math.max(actor.invincible, 5)
	
	if (actor.image_index + actor.image_speed >= actor.image_number) or (data.killed and data.killed == 1) then
		if data.target then
			actor:set_state(stateSpecial)
		else
			actor:set_state(stateSpecialEnd)
		end
	end
end)

Callback.add(stateSpecialPre.on_get_interrupt_priority, function(actor, data)
	return ActorState.InterruptPriority.PRIORITY_SKILL
end)

Callback.add(stateSpecial.on_enter, function(actor, data)
	actor.image_index = 0
	
	data.fired = 0
	data.killed = 0
	data.v_held = 1
	data.life = 0
	data.slash = math.random(3)
end)

local slashes = {
	sprite_shoot4_2,
	sprite_shoot4_2b,
	sprite_shoot4_2c,
}

local efFollow = Object.new("NemmercSpecialFollow")
efFollow:set_sprite(sprite_shoot4_2)
efFollow:set_depth(-200)

Callback.add(efFollow.on_create, function(self)
	self.image_speed = 0.25
end)

Callback.add(efFollow.on_step, function(self)
	if self.image_index < 4 and self.target and Instance.exists(self.target) then
		self.x = self.target.x
		self.y = self.target.y
	end
	
	if self.image_index >= 10 then
		self:destroy()
	end
end)

Callback.add(stateSpecial.on_step, function(actor, data)
	actor:get_default_skill(Skill.Slot.SPECIAL):freeze_cooldown()
	actor.invincible = math.max(actor.invincible, 5)
	actor.activity_type = 8
	actor.visible = false
	actor.pVspeed = actor.pVspeed * 0.7
	actor.pHspeed = 0
	data.life = data.life + 1
	
	local release = not Util.bool(actor.v_skill)
	
	if not actor:is_authority() then
		release = Util.bool(actor.activity_var2)
	end
		
	if release then
		if Net.online then
			if Net.host then
				gm.server_message_send(0, 43, actor:get_object_index_self(), actor.m_id, 1, Math.sign(actor.image_xscale))
			else
				gm.client_message_send(43, 1, Math.sign(actor.image_xscale))
			end
		end
		
		data.v_held = 0
	end
	
	local target = Instance.wrap(GM.attack_collision_resolve(data.target))
	local xx = target.x or data.target_x
	local yy = target.y or data.target_y
	
	if not (xx and yy) then
		actor:set_state(stateSpecialEnd)
	end
	
	local x_offset = 0
	local y_offset = 0
	local x2_offset = 0
	local y2_offset = 0
	
	if data.slash == 1 then
		x_offset = 0
		y_offset = -130
		x2_offset = 0
		y2_offset = 90
	elseif data.slash == 2 then
		x_offset = -45 * actor.image_xscale
		y_offset = 70
		x2_offset = 60 * actor.image_xscale
		y2_offset = -50
	else
		x_offset = -70 * actor.image_xscale
		y_offset = -70
		x2_offset = 50 * actor.image_xscale
		y2_offset = 65
	end
	
	if data.fired == 0 then
		local spark = efFollow:create(xx, yy)
		spark.sprite_index = slashes[data.slash]
		spark.target = target
		spark.image_xscale = actor.image_xscale
		
		if ssr_is_near_ground(actor, xx, yy, 64) then
			GM.teleport_nearby(actor, xx, yy)
		else
			actor:move_contact_solid(Math.direction(actor.x, actor.y, xx, yy), Math.distance(actor.x, actor.y, xx, yy))
			actor:move_contact_solid(Math.direction(actor.x, actor.y, xx + x2_offset, yy + y2_offset), Math.distance(actor.x, actor.y, xx + x2_offset, yy + y2_offset))
		end
		
		local amount = gm.round(Math.distance(data.begin_x, data.begin_y, xx + x_offset, yy + y_offset) / 16)
		for i = 1, amount do
			particleSpecialTrail:set_size(0.45 * (1 - (i / amount)), 0.45 * (1 - (i / amount)), -0.015, 0) -- set the size of the particle, bigger near the enemy
			particleSpecialTrail:create(Math.lerp(data.begin_x, xx + x_offset, 1 - (i / amount)), Math.lerp(data.begin_y, yy + y_offset, 1 - (i / amount)), 1) -- create the particle, each time approaching the enemy more and more
		end
		
		data.begin_x = xx + x_offset
		data.begin_y = yy + y_offset
		
		actor:sound_play(sound_teleport.value, 0.7, 0.9 + math.random() * 0.2)
		data.fired = 1
	elseif data.life >= 14 and data.fired == 1 then		
		data.fired = 2
		
		data.begin_x = xx + x2_offset
		data.begin_y = yy + y2_offset
			
		actor:sound_play(sound_shoot4.value, 1, 0.9 + math.random() * 0.2)
		actor:screen_shake(3)

		if target and Instance.exists(target) then
			if actor:is_authority() then
				local damage = actor:skill_get_damage(special)
				
				if actor:item_count(Item.find("ancientScepter")) > 0 then
					damage = actor:skill_get_damage(specialS)
				end
					
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					local attack = actor:fire_direct(target, damage, actor:skill_util_facing_direction(), target.x, target.y).attack_info
					attack.climb = i * 8 * 1.35
					attack.__ssr_nemmerc_devitalize = 1 + actor:item_count(Item.find("ancientScepter"))
				end
			end
		else
			data.killed = 1
		end
	end
	
	if data.life >= 35 then -- after 35 frames, end
		if not Instance.exists(target) or (Instance.exists(target) and not GM.actor_is_alive(target)) or data.killed == 1 then
			data.killed = 1
		else
			data.killed = 0
		end
		
		if data.killed == 1 then
			if data.v_held == 1 then
				actor:set_state(stateSpecialPre)
			else
				actor:set_state(stateSpecialEnd)
			end
		else
			actor:set_state(stateSpecialEnd)
		end
	end
end)

Callback.add(stateSpecial.on_get_interrupt_priority, function(actor, data)
	return ActorState.InterruptPriority.PRIORITY_SKILL
end)

Callback.add(stateSpecialEnd.on_enter, function(actor, data)
	actor.image_index = 0
	actor.free = 1
	actor.visible = true
	
	if ssr_is_near_ground(actor, actor.x, actor.y, 128) then
		GM.teleport_nearby(actor, actor.x, actor.y)
	end
	
	actor:sound_play(gm.constants.wMercenary_EviscerateWhiff, 1, 1)
	
	if data.killed == 1 then
		actor:get_active_skill(Skill.Slot.SPECIAL):reset_cooldown()
	end
	
	data.killed = 0
	
	Instance.get_data(actor).nemmerc_special_state = 0
end)

Callback.add(stateSpecialEnd.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot4_3, 0.25, false)
	actor.invincible = math.max(actor.invincible, 5)
	
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(stateSpecialEnd.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.ANY
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

DamageCalculate.add(function(api)
	if not api.hit_info.attack_info.__ssr_nemmerc_devitalize then return end
	if not Instance.exists(api.parent) then return end
	if not api.hit_info then return end
	
	if api.hit_info.attack_info.__ssr_nemmerc_devitalize >= 1 then
		if api.hit.stunned == true then
			particleBlood:set_direction(0, 360, 0, 0)
			particleBlood:create(api.hit_x, api.hit_y, 25, Particle.System.MIDDLE)
			api.hit:screen_shake(2)
			
			if api.critical then
				api.damage_mult(2, true)
			else
				api:set_critical(true)
			end
		end
		
		if api.hit_info.attack_info.__ssr_nemmerc_devitalize >= 2 then
			if GM.actor_get_hp_percent(api.hit) <= 0.25 then
				api.damage_col = Color.from_hex(0xf77c8e)
				api.hit.hp = -10000
			end
		end
	end
end)