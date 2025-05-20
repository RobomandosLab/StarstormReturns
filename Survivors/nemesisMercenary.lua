local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisMercenary")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisMercenary")

local sprite_loadout		= Resources.sprite_load(NAMESPACE, "NemesisMercenarySelect", path.combine(SPRITE_PATH, "select.png"), 19, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryPortrait", path.combine(SPRITE_PATH, "portrait.png"), 4)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "NemesisMercenaryPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "NemesisMercenarySkills", path.combine(SPRITE_PATH, "skills.png"), 5)
local sprite_credits		= Resources.sprite_load(NAMESPACE, "CreditsSurvivorNemesisMercenary", path.combine(SPRITE_PATH, "credits.png"), 1, 8, 10)

local sprite_idle			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 12, 15)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryIdle2", path.combine(SPRITE_PATH, "idle2.png"), 1, 8, 10)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 13, 17, 0.75)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 13, 17, 0.75)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryJump", path.combine(SPRITE_PATH, "jump.png"), 1, 11, 20)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 14, 20)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryFall", path.combine(SPRITE_PATH, "fall.png"), 1, 16, 20)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 13, 29)
local sprite_death			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryDeath", path.combine(SPRITE_PATH, "death.png"), 10, 18, 16)
local sprite_decoy			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 16, 18)

local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot1a", path.combine(SPRITE_PATH, "shoot1a.png"), 9, 14, 20)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot1b", path.combine(SPRITE_PATH, "shoot1b.png"), 9, 18, 20)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 6, 13, 56)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 5, 14, 28)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 8, 18, 10)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 18, 60, 32)
local sprite_shoot5			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot5", path.combine(SPRITE_PATH, "shoot5.png"), 18, 60, 32)
local sprite_sparks			= Resources.sprite_load(NAMESPACE, "NemesisMercenarySparks", path.combine(SPRITE_PATH, "slash.png"), 5, 52, 50)
local sprite_sparks2		= Resources.sprite_load(NAMESPACE, "NemesisMercenarySparks2", path.combine(SPRITE_PATH, "slash2.png"), 5, 52, 50)

local sprite_log			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryLog", path.combine(SPRITE_PATH, "log.png"))

local sound_shoot2a			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot2a", path.combine(SOUND_PATH, "shoot2a.ogg"))
local sound_shoot2b			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot2b", path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_shoot4			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4", path.combine(SOUND_PATH, "shoot4.ogg"))

local particleWispGTracer 	= Particle.find("ror", "WispGTracer")
local particleBlood 		= Particle.find("ror-Blood1")

local nemmerc = Survivor.new(NAMESPACE, "nemesisMercenary")
local nemmerc_id = nemmerc.value

nemmerc:set_stats_base({
	maxhp = 115,
	damage = 11,
	regen = 0.04,
})
nemmerc:set_stats_level({
	maxhp = 38,
	damage = 3,
	regen = 0.002,
	armor = 3,
})

nemmerc:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump_peak,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy,
	--drone_idle = sprite_drone_idle,
	--drone_shoot = sprite_drone_shoot,
})

nemmerc:set_cape_offset(-3, -8, 0, -5)
nemmerc:set_primary_color(Color.from_hex(0xFC4E45))

nemmerc.sprite_loadout = sprite_loadout
nemmerc.sprite_portrait = sprite_portrait
nemmerc.sprite_portrait_small = sprite_portrait_small
nemmerc.sprite_idle = sprite_idle -- used by skin systen for idle sprite
nemmerc.sprite_title = sprite_walk -- also used by skin system for walk sprite
nemmerc.sprite_credits = sprite_credits
nemmerc:clear_callbacks()

nemmerc:onInit(function(actor)
	actor:get_data().slide = 0
	actor:get_data().slideDir = 0
	actor:get_data().slidePrep = 0
end)

nemmerc:onStep(function(actor)
	if actor:get_data().slide > 0 then
		actor:get_data().slide = actor:get_data().slide - 1
		actor.pHspeed = actor:get_data().slide / 50 * 2 * actor.pHmax * actor:get_data().slideDir + actor.pHmax * actor:get_data().slideDir
		actor.moveLeft = 0
		actor.moveRight = 0
		actor.sprite_idle = sprite_idle2
		actor.sprite_jump = sprite_idle2
		actor.sprite_jump_peak = sprite_idle2
		actor.sprite_fall = sprite_idle2
	else
		actor.sprite_idle = sprite_idle
		actor.sprite_jump = sprite_jump
		actor.sprite_jump_peak = sprite_jump_peak
		actor.sprite_fall = sprite_fall
	end
end)

local stab = nemmerc:get_primary()
local trigger = nemmerc:get_secondary()
local slide = nemmerc:get_utility()
local devit = nemmerc:get_special()
local absDevit = Skill.new(NAMESPACE, "nemesisMercenaryVBoosted")

-- stab
stab:set_skill_icon(sprite_skills, 0)
stab.cooldown = 0
stab.damage = 1.3
stab.is_primary = true
stab.require_key_press = false
stab.hold_facing_direction = true
stab.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
stab:clear_callbacks()

local stateStab = State.new(NAMESPACE, "attachmentStab")
stateStab:clear_callbacks()

stab:onActivate(function(actor, skill)
	actor:enter_state(stateStab)
end)

stateStab:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

stateStab:onStep(function(actor, data)
	if actor:get_data().slide > 0 then
		actor:actor_animation_set(sprite_shoot1b, 0.2)
	else
		actor:skill_util_fix_hspeed()
		actor:actor_animation_set(sprite_shoot1a, 0.2)
	end
	
	if actor.image_index >= 3 and data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wMercenaryShoot1_2, 1, 0.9 + math.random() * 0.2)
		actor:skill_util_nudge_forward(4 * actor.image_xscale)
		
		if actor:is_authority() then
			local damage = actor:skill_get_damage(stab)
			
			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack = actor:fire_explosion(actor.x + actor.image_xscale * 30, actor.y, 100, 65, damage, nil, gm.constants.sSparks9)
					attack.attack_info.climb = i * 8
				end
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

stateStab:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 6 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	end
end)

-- quick trigger
trigger:set_skill_icon(sprite_skills, 1)
trigger.cooldown = 6 * 60
trigger.damage = 6
trigger.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
trigger:clear_callbacks()

local stateTrigger = State.new(NAMESPACE, "quickTrigger")
stateTrigger:clear_callbacks()

trigger:onActivate(function(actor, skill)
	actor:enter_state(stateTrigger)
end)

stateTrigger:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.reloaded = 0
end)

stateTrigger:onStep(function(actor, data)
	if actor:get_data().slide > 0 then
		actor:actor_animation_set(sprite_shoot2b, 0.22) -- 0.22 here because uhhh idk 0.2 felt a bit too slow i guess??
	else
		actor:skill_util_fix_hspeed()
		actor:actor_animation_set(sprite_shoot2a, 0.22)
	end
	
	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot2a, 1, 0.9 + math.random() * 0.2)
		actor:screen_shake(3)
		
		if actor:is_authority() then
			local damage = actor:skill_get_damage(trigger)
			
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack = actor:fire_bullet(actor.x, actor.y, 200, actor:skill_util_facing_direction(), damage, 1, gm.constants.sSparks4, Attack_Info.TRACER.enforcer1)
				attack.attack_info:set_stun(2)
				attack.attack_info.climb = i * 8 -- 8 is here because the second damage number will be 8 pixels above the first one thats how vanilla does it
			end
		end
	end
	
	if data.reloaded == 0 and actor.image_index >= 3 then
		data.reloaded = 1
		actor:sound_play(sound_shoot2b, 0.6, 0.9 + math.random() * 0.2)
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

stateTrigger:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	end
end)

-- blinding slide
slide:set_skill_icon(sprite_skills, 2)
slide.cooldown = 3 * 60
slide.is_utility = true
slide.override_strafe_direction = true
slide.ignore_aim_direction = true
slide:clear_callbacks()

local stateSlide = State.new(NAMESPACE, "blindingSlide")
stateSlide:clear_callbacks()

slide:onActivate(function(actor, skill)
	actor:enter_state(stateSlide)
end)

stateSlide:onEnter(function(actor, data)
	actor.image_index = 0
	actor:get_data().slidePrep = 1
	data.fired = 0
	data.counter = 0
	actor:sound_play(gm.constants.wMercenary_Parry_Release, 1, 0.9 + math.random() * 0.2)
end)

stateSlide:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.3, false)
	if actor:get_data().slide < 25 then
		actor:skill_util_fix_hspeed()
		actor:skill_util_nudge_forward(1 * -actor.image_xscale)
	end
	
	if data.fired == 0 then
		if actor.invincible < 10 then
			actor.invincible = 10
		end
	end
	
	if actor.image_index >= 6 and data.fired == 0 then
		data.counter = 11
		data.fired = 1
		actor:sound_play(gm.constants.wCommandoSlide, 1, 0.9 + math.random() * 0.2)
		actor:get_data().slide = 50
		actor:get_data().slideDir = actor.image_xscale
	end
	
	if data.counter > 0 and data.fired == 1 then
		data.counter = data.counter - 1
	elseif data.counter == 1 and data.fired == 1 then
		actor:get_data().slidePrep = 0
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

stateSlide:onExit(function(actor, data)
	actor:get_data().slidePrep = 0
end)

Callback.add(Callback.TYPE.onDamageBlocked, "SSRNemmercSlideReloadShotgun", function(actor, attacker, hit_info)
	if actor.object_index == gm.constants.oP and actor.class == nemmerc_id then
		if actor:get_data().slidePrep == 1 then
			actor:refresh_skill(Skill.SLOT.secondary)
			actor:get_data().slidePrep = 0
			actor:sound_play(sound_shoot2b, 0.6, 0.9 + math.random() * 0.2)
		end
	end
end)

-- devitalize
devit:set_skill_icon(sprite_skills, 3)
devit.cooldown = 8 * 60
devit.damage = 8.5
devit.require_key_press = false
devit.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
devit:set_skill_upgrade(absDevit)
devit:clear_callbacks()

local stateDevit = State.new(NAMESPACE, "devitalize")
stateDevit:clear_callbacks()

devit:onActivate(function(actor, skill)
	actor:enter_state(stateDevit)
end)

stateDevit:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.reloaded = 0
end)

stateDevit:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot4, 0.3)
	
	if actor.invincible < 5 then
		actor.invincible = 5
	end
	
	if actor.image_index >= 5 then
		local target = nil
		local enemies = List.new()
		actor:collision_rectangle_list(actor.x - 25 * actor.image_xscale, actor.y - 500, actor.x + 500 * actor.image_xscale, actor.y + 500, gm.constants.pActor, false, true, enemies, false)
		for _, enemy in ipairs(enemies) do
			if enemy.team ~= actor.team and gm.point_distance(actor.x, actor.y, enemy.x, enemy.y) < 500 and enemy.stunned then
				if target == nil then
					target = enemy
				else
					if enemy.hp < target.hp then
						target = enemy
					end
				end
			end
		end
		enemies:destroy()
		
		if target == nil then
			local enemies = List.new()
			actor:collision_rectangle_list(actor.x - 25 * actor.image_xscale, actor.y - 250, actor.x + 250 * actor.image_xscale, actor.y + 250, gm.constants.pActor, false, true, enemies, true)
			for _, enemy in ipairs(enemies) do
				if enemy.team ~= actor.team and gm.point_distance(actor.x, actor.y, enemy.x, enemy.y) < 250 then
					if target == nil then
						target = enemy
					else
						if enemy.hp < target.hp then
							target = enemy
						end
					end
				end
			end
			enemies:destroy()
		end
		
		if target == nil then
			local enemies = List.new()
			actor:collision_rectangle_list(actor.x - 25 * actor.image_xscale, actor.y - 250, actor.x + 250 * actor.image_xscale, actor.y + 250, gm.constants.pActorCollisionBase, false, true, enemies, true)
			for _, enemy in ipairs(enemies) do
				if enemy.team ~= actor.team and gm.point_distance(actor.x, actor.y, enemy.x, enemy.y) < 250 then
					if target == nil then
						target = enemy
					end
				end
			end
			enemies:destroy()
		end
		
		if target ~= nil and data.fired == 0 then
			data.fired = 1
			actor:sound_play(sound_shoot4, 1, 0.9 + math.random() * 0.2)
			actor:screen_shake(3)
			if gm._mod_net_isHost() then
				local damage = actor:skill_get_damage(devit)
				local sparks = sprite_sparks
				if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
					damage = actor:skill_get_damage(absDevit)
					sparks = sprite_sparks2
				end
				
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack = actor:fire_direct(target, damage, actor:skill_util_facing_direction(), target.x, target.y, sparks)
					attack.attack_info.__ssr_nemmerc_devitalize = 1
				end
			end
		elseif target == nil and data.fired == 0 then
			data.fired = 1
			actor:sound_play(gm.constants.wMercenary_EviscerateWhiff, 1, 0.9 + math.random() * 0.2)
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

stateDevit:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 12 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	end
end)

local devitalizeSync = Packet.new()
devitalizeSync:onReceived(function(msg)
	local x = msg:read_ushort()
	local y = msg:read_ushort()
	local parent = msg:read_instance()
	local target = msg:read_instance()
	local damage = msg:read_float()

	if not parent:exists() then return end
	
	if target.stunned == true and Instance.exists(parent) then
		particleBlood:set_direction(0, 360, 0, 0)
		particleBlood:create(x, y, 25, Particle.SYSTEM.middle)
		parent:screen_shake(2)
	end
	if target.hp - damage <= 0 and Instance.exists(parent) then
		parent:refresh_skill(Skill.SLOT.special)
	end
end)

local function sync_devit(x, y, parent, target, damage)
	if not gm._mod_net_isHost() then
		log.warning("sync_devit called on client!")
		return
	end

	local msg = devitalizeSync:message_begin()
	msg:write_ushort(x)
	msg:write_ushort(y)
	msg:write_instance(parent)
	msg:write_instance(target)
	msg:write_float(damage)
	msg:send_to_all()
end

Callback.add(Callback.TYPE.onAttackHit, "SSRNemmercDevitalize", function(hit_info)
	if hit_info.attack_info.__ssr_nemmerc_devitalize == 1 then
		if gm._mod_net_isOnline() then
			sync_devit(hit_info.x, hit_info.y, hit_info.parent, hit_info.target, hit_info.damage)
		end
		if hit_info.target.stunned == true and Instance.exists(hit_info.parent) then
			particleBlood:set_direction(0, 360, 0, 0)
			particleBlood:create(hit_info.x, hit_info.y, 25, Particle.SYSTEM.middle)
			gm.draw_damage_networked(hit_info.x, hit_info.y - 16, hit_info.damage * 0.5, hit_info.critical, Color.from_hex(0xFC4E45), hit_info.parent.team, 0)
			hit_info.parent:screen_shake(2)
			hit_info.damage = hit_info.damage * 1.5
		end
		if hit_info.target.hp - hit_info.damage <= 0 and Instance.exists(hit_info.parent) then
			hit_info.parent:refresh_skill(Skill.SLOT.special)
		end
	end
end)

-- absolute devitalization
absDevit:set_skill_icon(sprite_skills, 4)
absDevit.cooldown = 6 * 60
absDevit.damage = 11
absDevit.require_key_press = false
absDevit.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
absDevit:clear_callbacks()

absDevit:onActivate(function(actor, skill)
	actor:enter_state(stateDevit)
end)

local nemmercLog = Survivor_Log.new(nemmerc, sprite_log)