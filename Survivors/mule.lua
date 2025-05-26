local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/MULE")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/MULE")

local sprite_loadout			= Resources.sprite_load(NAMESPACE, "MuleSelect", path.combine(SPRITE_PATH, "select.png"), 16, 28, 0)
local sprite_portrait 			= Resources.sprite_load(NAMESPACE, "MulePortrait", path.combine(SPRITE_PATH, "portrait.png"), 4)
local sprite_portrait_small 	= Resources.sprite_load(NAMESPACE, "MulePortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills				= Resources.sprite_load(NAMESPACE, "MuleSkills", path.combine(SPRITE_PATH, "skills.png"), 5)
local sprite_credits 			= Resources.sprite_load(NAMESPACE, "MuleCredits", path.combine(SPRITE_PATH, "credits.png"), 1, 12, 22)
local sprite_log				= Resources.sprite_load(NAMESPACE, "MuleLog", path.combine(SPRITE_PATH, "log.png"), 1)
local sprite_wave_mask			= Resources.sprite_load(NAMESPACE, "MuleShockwaveMask", path.combine(SPRITE_PATH, "wave_mask.png"), 1, 8, 8)

local sprite_idle 				= Resources.sprite_load(NAMESPACE, "MuleIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 20, 26)
local sprite_idle_half			= Resources.sprite_load(NAMESPACE, "MuleIdleHalf", path.combine(SPRITE_PATH, "idle_half.png"), 1, 10, 6)
local sprite_walk				= Resources.sprite_load(NAMESPACE, "MuleWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 22, 28)
local sprite_walk_half			= Resources.sprite_load(NAMESPACE, "MuleWalkHalf", path.combine(SPRITE_PATH, "walk_half.png"), 8, 14, 7)
local sprite_climb				= Resources.sprite_load(NAMESPACE, "MuleClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 25, 51)
local sprite_jump				= Resources.sprite_load(NAMESPACE, "MuleJump", path.combine(SPRITE_PATH, "jump_start.png"), 1, 22, 32)
local sprite_jump_half			= Resources.sprite_load(NAMESPACE, "MuleJumpHalf", path.combine(SPRITE_PATH, "jump_start_half.png"), 1, 12, 6)
local sprite_jump_peak			= Resources.sprite_load(NAMESPACE, "MuleJumpPeak", path.combine(SPRITE_PATH, "jump_peak.png"), 1, 22, 32)
local sprite_jump_peak_half		= Resources.sprite_load(NAMESPACE, "MuleJumpPeakHalf", path.combine(SPRITE_PATH, "jump_peak_half.png"), 1, 12, 6)
local sprite_fall				= Resources.sprite_load(NAMESPACE, "MuleFall", path.combine(SPRITE_PATH, "jump_fall.png"), 1, 22, 32)
local sprite_fall_half			= Resources.sprite_load(NAMESPACE, "MuleFallHalf", path.combine(SPRITE_PATH, "jump_fall_half.png"), 1, 12, 6)
local sprite_death				= Resources.sprite_load(NAMESPACE, "MuleDeath", path.combine(SPRITE_PATH, "death.png"), 10, 45, 55)
local sprite_decoy				= Resources.sprite_load(NAMESPACE, "MuleDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 16, 18)

local sprite_shoot1a			= Resources.sprite_load(NAMESPACE, "MuleShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 21, 34)
local sprite_shoot1b			= Resources.sprite_load(NAMESPACE, "MuleShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 21, 34)
local sprite_shoot1c			= Resources.sprite_load(NAMESPACE, "MuleShoot1_3", path.combine(SPRITE_PATH, "shoot1_3.png"), 9, 39, 36)
local sprite_shoot2				= Resources.sprite_load(NAMESPACE, "MuleShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 30, 33)
local sprite_shoot1charge		= Resources.sprite_load(NAMESPACE, "MuleShoot1Charge", path.combine(SPRITE_PATH, "shoot1_charge.png"), 6, 21, 28)
local sprite_shoot3				= Resources.sprite_load(NAMESPACE, "MuleShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 15, 48, 33)
local sprite_shoot4				= Resources.sprite_load(NAMESPACE, "MuleShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 15, 23, 27)
local sprite_shoot4boosted		= Resources.sprite_load(NAMESPACE, "MuleShoot4Boosted", path.combine(SPRITE_PATH, "shoot4boosted.png"), 15, 23, 27)
local sprite_shoot4drone		= Resources.sprite_load(NAMESPACE, "MuleShoot4Drone", path.combine(SPRITE_PATH, "drone.png"), 5, 9, 12)
local sprite_shoot4heal			= Resources.sprite_load(NAMESPACE, "MuleShoot4Heal", path.combine(SPRITE_PATH, "droneheal.png"), 5, 16, 14)
local sprite_shoot4droneboosted	= Resources.sprite_load(NAMESPACE, "MuleShoot4DroneBoosted", path.combine(SPRITE_PATH, "droneboosted.png"), 5, 14, 14)
local sprite_shoot4healboosted	= Resources.sprite_load(NAMESPACE, "MuleShoot4HealBoosted", path.combine(SPRITE_PATH, "dronehealboosted.png"), 5, 17, 14)
local sprite_drone_idle			= Resources.sprite_load(NAMESPACE, "MulePlayerDroneIdle", path.combine(SPRITE_PATH, "playerdrone.png"), 5, 15, 13)
local sprite_drone_shoot		= Resources.sprite_load(NAMESPACE, "MulePlayerDroneShoot", path.combine(SPRITE_PATH, "playerdroneshoot.png"), 5, 33, 13)
local sprite_trap_debuff		= Resources.sprite_load(NAMESPACE, "MuleTrapDebuff", path.combine(SPRITE_PATH, "trap_debuff.png"), 8, 18, 18)
local sprite_snare_debuff		= Resources.sprite_load(NAMESPACE, "MuleSnareDebuff", path.combine(SPRITE_PATH, "snare_debuff.png"), 1, 18, 12)
local sprite_sparks1			= Resources.sprite_load(NAMESPACE, "MuleSparks1", path.combine(SPRITE_PATH, "sparks1.png"), 3, 10, 16)
local sprite_sparks2			= Resources.sprite_load(NAMESPACE, "MuleSparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 14, 10)
local sprite_sparks3			= Resources.sprite_load(NAMESPACE, "MuleSparks3", path.combine(SPRITE_PATH, "sparks3.png"), 4, 8, 16)

local sound_shoot1a				= Resources.sfx_load(NAMESPACE, "MuleShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b				= Resources.sfx_load(NAMESPACE, "MuleShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c				= Resources.sfx_load(NAMESPACE, "MuleShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot2a				= Resources.sfx_load(NAMESPACE, "MuleShoot2a", path.combine(SOUND_PATH, "skill2a.ogg"))
local sound_shoot2b				= Resources.sfx_load(NAMESPACE, "MuleShoot2b", path.combine(SOUND_PATH, "skill2b.ogg"))
local sound_shoot3				= Resources.sfx_load(NAMESPACE, "MuleShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a				= Resources.sfx_load(NAMESPACE, "MuleShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b				= Resources.sfx_load(NAMESPACE, "MuleShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))
local sound_shoot4c				= Resources.sfx_load(NAMESPACE, "MuleShoot4c", path.combine(SOUND_PATH, "skill4c.ogg"))
local sound_shoot4d				= Resources.sfx_load(NAMESPACE, "MuleShoot4d", path.combine(SOUND_PATH, "skill4d.ogg"))
local sound_shoot4e				= Resources.sfx_load(NAMESPACE, "MuleShoot4e", path.combine(SOUND_PATH, "skill4e.ogg"))
local sound_drone_death			= Resources.sfx_load(NAMESPACE, "MuleDroneDeath", path.combine(SOUND_PATH, "drone_death.ogg"))

local par_fire4 = Particle.find("ror", "Fire4")
local par_debris = Particle.new(NAMESPACE, "Debris")
par_debris:set_sprite(gm.constants.sEfRubble, false, false, true)
par_debris:set_color1(Color.WHITE)
par_debris:set_alpha2(1, 0)
par_debris:set_size(0.1, 0.9, -0.01, 0)
par_debris:set_orientation(0, 360, 3, 0, true)
par_debris:set_speed(0.9, 4.4, -0.03, 0.1)
par_debris:set_direction(45, 135, 0, 0)
par_debris:set_gravity(0.13, 270)
par_debris:set_life(20, 100)

local mule = Survivor.new(NAMESPACE, "mule")
local mule_id = mule.value

mule:set_stats_base({
	maxhp = 115,
	damage = 11,
	regen = 0.012
})
mule:set_stats_level({
	maxhp = 37,
	damage = 3,
	regen = 0.0018,
	armor = 3
})

mule:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump_peak,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy,
	drone_idle = sprite_drone_idle,
	drone_shoot = sprite_drone_shoot,
})

mule:set_cape_offset(0, -14, 0, -18)
mule:set_primary_color(Color.from_rgb(211,176,122))

mule.sprite_loadout = sprite_loadout
mule.sprite_portrait = sprite_portrait
mule.sprite_portrait_small = sprite_portrait_small
mule.sprite_idle = sprite_idle
mule.sprite_title = sprite_walk
mule.sprite_credits = sprite_credits

mule:clear_callbacks()
mule:onInit(function(actor)
	actor.sprite_idle_half		= Array.new({sprite_idle,		sprite_idle_half, 0})
	actor.sprite_walk_half		= Array.new({sprite_walk,		sprite_walk_half, 0, sprite_walk})
	actor.sprite_jump_half		= Array.new({sprite_jump,		sprite_jump_half, 0})
	actor.sprite_jump_peak_half	= Array.new({sprite_jump_peak,	sprite_jump_peak_half, 0})
	actor.sprite_fall_half		= Array.new({sprite_fall,		sprite_fall_half, 0})

	actor:survivor_util_init_half_sprites()
end)

local snare = Buff.new(NAMESPACE, "muleSnare")
snare.icon_sprite = sprite_snare_debuff
snare.show_icon = true
snare.is_debuff = true
snare:clear_callbacks()

snare:onApply(function(actor, stack)
	actor.pHspeed = 0
	actor.pHmax = 0
	if not GM.actor_is_boss(actor) then
		actor.activity = 50
		actor.__activity_handler_state = 50
		actor.state = 0
	end
end)

snare:onPostStep(function(actor, stack)
	actor.pHspeed = 0
	actor.pHmax = 0
	if not GM.actor_is_boss(actor) then
		actor.activity = 50
		actor.__activity_handler_state = 50
		if actor.sprite_climb and GM.actor_state_is_climb_state(actor.actor_state_current_id) then
			actor.sprite_index = actor.sprite_climb
			actor.image_index = 0
		elseif actor.sprite_idle then
			actor.sprite_index = actor.sprite_idle
		end
	end
end)

snare:onRemove(function(actor, stack)
	if not GM.actor_is_boss(actor) then
		actor:skill_util_reset_activity_state()
	end
end)

local trap = Buff.new(NAMESPACE, "muleTrap")
trap.show_icon = false
trap.is_debuff = true
trap:clear_callbacks()

trap:onApply(function(actor, stack)
	actor:get_data().trapspeed = 0
end)

trap:onPostDraw(function(actor, stack)
	actor:get_data().trapspeed = actor:get_data().trapspeed + 0.25
	
	if actor:get_data().trapspeed > 8 then
		actor:get_data().trapspeed = 0 
	end
	
	gm.draw_sprite(sprite_trap_debuff, actor:get_data().trapspeed, actor.x, actor.y)
	
	for _, victim in ipairs(actor:get_data().trapped_enemies) do
		if Instance.exists(victim) then
			local parent = victim.trap_parent
			if parent and Instance.exists(parent) then
				if not (victim:get_data().trap_offset_a and victim:get_data().trap_offset_b) then
					victim:get_data().trap_offset_a = math.random(-8, 8)
					victim:get_data().trap_offset_b = victim.x + math.random(-16, 16)
					
					local yy = 0
					while yy < 100 and victim:collision_point(victim.x, victim.y + yy, gm.constants.pBlock, true, false) == -4.0 do
						yy = yy + 2
					end
					if yy < 100 and not victim:get_data().trap_offset_c then
						victim:get_data().trap_offset_c = victim.y + yy
					else
						victim:get_data().trap_offset_c = nil
					end
				end
				
				gm.draw_set_alpha(0.8)
				gm.draw_set_colour(Color.from_rgb(205, 205, 205))
				gm.draw_line_width(victim.x, victim.y, parent.x, parent.y + victim:get_data().trap_offset_a, 2)
				
				if victim:get_data().trap_offset_c then
					gm.draw_line_width(victim.x, victim.y, victim:get_data().trap_offset_b, victim:get_data().trap_offset_c, 2)
				end
				gm.draw_set_alpha(1)
			end
		end
	end
end)

trap:onRemove(function(actor, stack)
	actor:get_data().trapped_enemies:destroy()
	actor:get_data().trapspeed = nil
end)

local objWave = Object.new(NAMESPACE, "MuleShockwave")
objWave.obj_depth = 1
objWave:clear_callbacks()

objWave:onCreate(function(self)
	local data = self:get_data()
	self.mask = sprite_wave_mask
	self.sprite_index = sprite_wave_mask
	self.image_alpha = 0
	self.direction = 0
	self.speed = 4.8
	self.parent = -4
	self.team = 1
	data.timer = 140
end)

objWave:onStep(function(self)
	local data = self:get_data()
	local parent = self.parent
	
	for s = 0, 32 do 
		if self:is_colliding(gm.constants.pBlock, self.x, self.y) then
			self.y = self.y - 1
		end
	end
	
	self:move_contact_solid(270, -1)
	
	if self:is_colliding(gm.constants.pBlock) then
		self:destroy()
	end
	
	local explode = false
	if Instance.exists(parent) and not explode then
		for _, actor in ipairs(self:get_collisions(gm.constants.pActorCollisionBase)) do
			if parent:attack_collision_canhit(actor) then
				explode = true
				break
			end
		end
	end
	
	if data.timer < 0 then
		self:destroy()
	else
		data.timer = data.timer - 1
		
		if data.timer % 7 == 0 then
			local sparks = gm.instance_create(self.x, self.y - 6, gm.constants.oEfExplosion)
			sparks.depth = -12
			sparks.sprite_index = gm.constants.sMinerShoot2Dust2
			sparks.image_xscale = 1 - ((self.direction * 2) / 180)
			sparks.image_yscale = 1
		end
	end
	
	if explode == true then
		self:screen_shake(4)
		local sparks = gm.instance_create(self.x, self.y + 8, gm.constants.oEfExplosion)
		sparks.sprite_index = gm.constants.sBoss1Shoot1Pillar
		sparks.image_yscale = 1
		self:sound_play(gm.constants.wSmite, 0.5, 1.3 + math.random() * 0.2)
		
		if Instance.exists(parent) and parent:is_authority() then
			local attack_info = parent:fire_explosion(self.x, self.y, 32, 32, 4, nil, nil).attack_info
			attack_info.knockup = 4
		end
		
		self:destroy()
	end
end)

local primary = mule:get_primary()
local secondary = mule:get_secondary()
local utility = mule:get_utility()
local special = mule:get_special()

-- INTERFERENCE REMOVAL
primary:set_skill_icon(sprite_skills, 0)

primary.cooldown = 10
primary.damage = 1.6
primary.require_key_press = true
primary.is_primary = true

local statePrimaryCharge = State.new(NAMESPACE, "mulePrimaryCharge")
local statePrimaryPunch = State.new(NAMESPACE, "mulePrimaryPunch")
local statePrimarySlam = State.new(NAMESPACE, "mulePrimarySlam")

primary:clear_callbacks()
primary:onActivate(function(actor)
	actor:enter_state(statePrimaryCharge)
end)

statePrimaryCharge:clear_callbacks()
statePrimaryCharge:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.fired = 0
	data.strength = 1.6
	data.charging_sound = -1
	data.bullshitfixtimer = 0
	
	if not data.attack_side then
		data.attack_side = 0
	end
	
	actor:skill_util_strafe_init()
end)

statePrimaryCharge:onStep(function(actor, data)
	actor.sprite_index2 = sprite_shoot1charge
	actor:skill_util_strafe_update(0.06 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	data.bullshitfixtimer = data.bullshitfixtimer + 1
	
	if actor.sprite_index == actor.sprite_walk_half[2] then
		local walk_offset = 0
		local leg_frame = math.floor(actor.image_index)
		if leg_frame == 0 or leg_frame == 1 or leg_frame == 4 or leg_frame == 5 then
			walk_offset = -1
		elseif leg_frame == 2 or leg_frame == 6 then
			walk_offset = 1
		end
		actor.ydisp = walk_offset -- ydisp controls upper body offset
	end
	
	if data.fired < 1 then
	
		if data.charging_sound == -1 and actor.image_index2 >= 0.5 then
			data.charging_sound = gm.audio_play_sound(sound_shoot1a, 1, false, 0.4, 0, (0.9 + math.random() * 0.2))
		end
		
		if actor.image_index2 < 5 and actor.sprite_index2 == sprite_shoot1charge then
			data.strength = actor:skill_get_damage(primary) + 0.6 * math.min(4, math.floor(actor.image_index2))
		end
		
		if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) and actor.sprite_index2 == sprite_shoot1charge then
			data.fired = 1
		end

		local release = not actor:control("skill1", 0)
		if not actor:is_authority() then
			release = gm.bool(actor.activity_var2)
		end

		if release and data.fired < 1 and actor.sprite_index2 == sprite_shoot1charge and data.bullshitfixtimer > 1 then
			if gm._mod_net_isOnline() then
				if gm._mod_net_isHost() then
					gm.server_message_send(0, 43, actor:get_object_index_self(), actor.m_id, 1, gm.sign(actor.image_xscale))
				else
					gm.client_message_send(43, 1, gm.sign(actor.image_xscale))
				end
			end
			if actor:is_authority() then
				GM.actor_set_state_networked(actor, statePrimaryPunch)
			end
		end
	else
		if actor:is_authority() then
			GM.actor_set_state_networked(actor, statePrimarySlam)
		end
	end
end)

statePrimaryCharge:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
	actor:get_data().strength = data.strength
	if gm.audio_is_playing(data.charging_sound) then
		gm.audio_stop_sound(data.charging_sound)
	end
end)

statePrimaryPunch:clear_callbacks()
statePrimaryPunch:onEnter(function(actor, data)
	data.fired = 0
	data.strength = actor:get_data().strength
	actor.image_index = 0
	
	if not data.attack_side then
		data.attack_side = 0
	end
	
	actor:actor_animation_set(sprite_shoot1a, 0.2)
	if data.attack_side == 1 then
		actor:actor_animation_set(sprite_shoot1b, 0.2)
	end
end)

statePrimaryPunch:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	
	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1
		actor:screen_shake(2)
		actor:skill_util_nudge_forward(1.6 * actor.image_xscale * data.strength)
		actor:sound_play(sound_shoot1b, 1, (0.9 + math.random() * 0.2))
		data.attack_side = (data.attack_side + 1) % 2
		if actor:is_authority() then
			if not GM.skill_util_update_heaven_cracker(actor, 1.25 * data.strength, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack_info = actor:fire_explosion(actor.x + 30 * actor.image_xscale, actor.y, 80, 60, 1.25 * data.strength, nil, sprite_sparks1).attack_info
					attack_info.climb = i * 8
					attack_info.knockback_direction = actor.image_xscale
				end
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

statePrimaryPunch:onExit(function(actor, data)
	actor:get_data().strength = nil
end)

statePrimarySlam:clear_callbacks()
statePrimarySlam:onEnter(function(actor, data)	
	data.fired = 0
	actor.image_index = 0
	actor:actor_animation_set(sprite_shoot1c, 0.2)
end)

statePrimarySlam:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	
	if data.fired == 0 and actor.image_index >= 3 then
		data.fired = 1
		actor:screen_shake(7)
		actor:skill_util_nudge_forward(10 * actor.image_xscale)
		actor:sound_play(sound_shoot1c, 1, (0.9 + math.random() * 0.2))
		
		if not gm.bool(actor.free) then
			par_fire4:create(actor.x + 40 * actor.image_xscale, actor.y + 8, 2, Particle.SYSTEM.middle)
			par_debris:create(actor.x + 40 * actor.image_xscale, actor.y + 8, 2, Particle.SYSTEM.middle)
		end
			
		if actor:is_authority() then
			if not GM.skill_util_update_heaven_cracker(actor, 1.25 * data.strength, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					local attack_info = actor:fire_explosion(actor.x + 20 * actor.image_xscale, actor.y, 120, 60, 10, nil, sprite_sparks1).attack_info
					attack_info.climb = i * 8
					attack_info.knockback = attack_info.knockback + 9
					attack_info.knockback_direction = actor.image_xscale
					attack_info.knockup = 6
				end
			end
		end
		
		if not gm.bool(actor.free) then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local wave = objWave:create(actor.x + i * 32 * actor.image_xscale, actor.y)
				wave.direction = actor:skill_util_facing_direction()
				wave.depth = wave.depth + i
				wave.parent = actor
				wave.team = actor.team
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

-- IMMOBILIZE
secondary:set_skill_icon(sprite_skills, 1)
secondary.damage = 1.25
secondary.cooldown = 6 * 60

local stateSecondary = State.new(NAMESPACE, "muleSecondary")

secondary:clear_callbacks()
secondary:onActivate(function(actor)
	actor:enter_state(stateSecondary)
end)

stateSecondary:clear_callbacks()
stateSecondary:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

stateSecondary:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot2, 0.2)
	actor:skill_util_fix_hspeed()
	
	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1
		actor:sound_play(sound_shoot2a, 1, 0.9 + math.random() * 0.2)
		if gm._mod_net_isHost then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y - 4, 1300, actor:skill_util_facing_direction(), actor:skill_get_damage(secondary), nil, sprite_sparks3).attack_info
				attack_info.climb = i * 8
				attack_info.mule_immobilize = 1
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

local immobilizeSync = Packet.new()
immobilizeSync:onReceived(function(msg)
	local actor = msg:read_instance()

	if not actor:exists() then return end
	
	GM.apply_buff(actor, trap, 3 * 60, 1)
		
	local victims = List.new()
	
	actor:get_data().trapped_enemies = List.new()
	actor:get_data().trapped_enemies:clear()
	
	actor:collision_ellipse_list(actor.x - 280, actor.y - 200, actor.x + 280, actor.y + 200, gm.constants.pActor, false, false, victims, true)
	local count = 0
	for _, victim in ipairs(victims) do
		if victim.team == actor.team then
			GM.apply_buff(victim, snare, 3 * 60, 1)
			victim.trap_parent = actor
			victim:get_data().trap_offset_a = nil
			victim:get_data().trap_offset_b = nil
			victim:get_data().trap_offset_c = nil
			actor:get_data().trapped_enemies:add(victim.value)
			count = count + 1
			if count > 4 then
				break
			end
		end
	end
	
	victims:destroy()
end)

local function sync_immobilize(actor)
	if not gm._mod_net_isHost() then
		log.warning("sync_immobilize called on client!")
		return
	end

	local msg = immobilizeSync:message_begin()
	msg:write_instance(actor)
	msg:send_to_all()
end

Callback.add(Callback.TYPE.onAttackHit, "muleInflictImmobilize", function(hit_info)
	if hit_info.attack_info.mule_immobilize == 1 then
		actor = hit_info.target
		if gm._mod_net_isOnline() then
			sync_immobilize(actor)
		end
		
		GM.apply_buff(actor, trap, 3 * 60, 1)
		
		actor:sound_play(sound_shoot2b, 1, 0.9 + math.random() * 0.2)
	
		local victims = List.new()
	
		actor:get_data().trapped_enemies = List.new()
		actor:get_data().trapped_enemies:clear()
	
		actor:collision_ellipse_list(actor.x - 280, actor.y - 200, actor.x + 280, actor.y + 200, gm.constants.pActor, false, false, victims, true)
		local count = 0
		for _, victim in ipairs(victims) do
			if victim.team == actor.team then
				GM.apply_buff(victim, snare, 3 * 60, 1)
				victim.trap_parent = actor
				victim:get_data().trap_offset_a = nil
				victim:get_data().trap_offset_b = nil
				victim:get_data().trap_offset_c = nil
				actor:get_data().trapped_enemies:add(victim.value)
				count = count + 1
				if count > 4 then
					break
				end
			end
		end

		victims:destroy()
	end
end)

-- TORQUE CALIBRATION
utility:set_skill_icon(sprite_skills, 2)

utility.cooldown = 4 * 60
utility.damage = 1.0
utility.is_utility = true
utility.override_strafe_direction = true
utility.ignore_aim_direction = true

local stateUtility = State.new(NAMESPACE, "muleUtility")
stateUtility.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

utility:clear_callbacks()
utility:onActivate(function(actor)
	actor:enter_state(stateUtility)
end)

stateUtility:clear_callbacks()
stateUtility:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.sound = 0
end)

stateUtility:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.25, false)
	
	if actor.image_index < 4 then
		actor:skill_util_fix_hspeed()
	end
	
	if actor.image_index >= 4 and actor.image_index < 10 then 
		actor.pHspeed = actor.pHmax * actor.image_xscale * math.sqrt(10 - actor.image_index) * 1.5
	end
	
	if actor.image_index >= 4 and data.sound == 0 then
		data.sound = 1
		actor:sound_play(sound_shoot3, 1.0, 1.0)
	end
	
	if actor.image_index >= 4 + data.fired * 2 and data.fired < 4 then
		data.fired = data.fired + 1

		if actor:is_authority() then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i = 0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_explosion(actor.x, actor.y, 160, 100, actor:skill_get_damage(utility), nil, sprite_sparks2).attack_info
				attack_info.climb = i * 8
				attack_info.knockback = 5
				attack_info.knockback_direction = actor.image_xscale
				if data.fired == 4 then 
					attack_info:set_stun(1.5)
				end
			end
		end		
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

-- FAIL-SAFE ASSISTANCE
special:set_skill_icon(sprite_skills, 3)
special.cooldown = 20 * 60

local scepter = Skill.new(NAMESPACE, "muleVBoosted")
scepter:set_skill_icon(sprite_skills, 4)
scepter.cooldown = 20 * 60
special:set_skill_upgrade(scepter)

local stateSpecial = State.new(NAMESPACE, "muleSpecial")

special:clear_callbacks()
special:onActivate(function(actor)
	actor:enter_state(stateSpecial)
end)

scepter:clear_callbacks()
scepter:onActivate(function(actor)
	actor:enter_state(stateSpecial)
end)

-- this sucks but whatever lmao
local function muleSoundHeal(self)
	local chance = math.random()
	
	if chance > 0.75 then
		self:sound_play(sound_shoot4b, 1, 0.9 + math.random() * 0.2)
	elseif chance > 0.5 then
		self:sound_play(sound_shoot4c, 1, 0.9 + math.random() * 0.2)
	elseif chance > 0.25 then
		self:sound_play(sound_shoot4d, 1, 0.9 + math.random() * 0.2)
	else
		self:sound_play(sound_shoot4e, 1, 0.9 + math.random() * 0.2)
	end
end

local objDrone = Object.new(NAMESPACE, "muleDrone")
objDrone.obj_sprite = sprite_drone_idle
objDrone.obj_depth = 2
objDrone:clear_callbacks()

objDrone:onCreate(function(self)
	local data = self:get_data()
	
	self.image_speed = 0.3
	data.timer = 0
	data.life = 300
	data.regen = 0.07
	data.base_sprite = sprite_shoot4drone
	data.heal_sprite = sprite_shoot4heal
	data.healing = 0
end)

objDrone:onStep(function(self)
	local data = self:get_data()
	local parent = data.parent
	
	if parent.dead then
		data.life = 0
	end
	
	if parent and Instance.exists(parent) then
		local float = math.sin(Global._current_frame * 0.1) * 8
		local xx = self.x + ((parent.ghost_x + (24 * (parent.image_xscale * -1))) - self.x) * 0.1
		local yy = self.y + (parent.ghost_y - 48 - float - self.y) * 0.1
		if data.timer > 44 and data.regen and parent.hp > 0 then
			self.sprite_index = data.heal_sprite
			self.image_index = 0
			data.healing = 1
			xx = self.x + ((parent.ghost_x + (6 * (parent.image_xscale * -1))) - self.x) * 0.1
			yy = self.y + (parent.ghost_y - 4 - float - self.y) * 0.1
		end
		self.x = xx 
		self.y = yy
		self.image_xscale = parent.image_xscale
		if data.timer >= 55 then
			data.timer = 0
			if data.regen then
				Particle.find("ror", "Spark"):create(parent.ghost_x + 8 * parent.image_xscale, parent.ghost_y - 6, 3, Particle.SYSTEM.middle)
				muleSoundHeal(self)
				if parent.maxhp > parent.hp then
					if gm._mod_net_isHost() then
						parent:heal(data.regen)
					end
					
					parent:sound_play(gm.constants.wHANDShoot2_2, 0.5, 0.9 + math.random() * 0.2)
					
					local flash = GM.instance_create(parent.x, parent.y, gm.constants.oEfFlash)
					flash.parent = parent
					flash.image_blend = Color.from_rgb(189, 231, 90)
					flash.rate = 0.05
					flash.image_alpha = 0.5
				else
					if gm._mod_net_isHost() then
						parent:add_barrier(data.regen)
					end
					
					parent:sound_play(gm.constants.wHANDShoot2_2, 0.5, 0.9 + math.random() * 0.2)
					
					local flash = GM.instance_create(parent.x, parent.y, gm.constants.oEfFlash)
					flash.parent = parent
					flash.image_blend = Color.from_rgb(255, 255, 155)
					flash.rate = 0.05
					flash.image_alpha = 0.5
				end
			end
		else
			data.timer = data.timer + 1
		end
	end
	
	if not (data.healing == 1 and self.sprite_index == data.heal_sprite and self.image_index < 4) then
		self.sprite_index = data.base_sprite
	end
	
	if data.life > 0 then
		data.life = data.life - 1
	else
		local sparks = Object.find("ror", "efSparks"):create(self.x, self.y)
		sparks.sprite_index = gm.constants.sEfExplosive
		self:sound_play(sound_drone_death, 1, 0.9 + math.random() * 0.2)
		self:screen_shake(2)
		self:destroy()
	end
end)

stateSpecial:clear_callbacks()
stateSpecial:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.sound = 0
end)

stateSpecial:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
		actor:actor_animation_set(sprite_shoot4boosted, 0.27, false)
	else
		actor:actor_animation_set(sprite_shoot4, 0.27, false)
	end
	
	if actor.image_index >= 1 and data.sound == 0 then
		data.sound = 1
		actor:sound_play(sound_shoot4a, 1.0, 0.9 + math.random() * 0.2)
	end
	
	if actor.image_index >= 9 and data.fired == 0 then
		data.fired = 1

		local drone = objDrone:create(actor.x - (6 * actor.image_xscale * -1), actor.y - 24)
		drone:get_data().parent = actor
		drone:get_data().life = 300
		if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
			drone:get_data().regen = actor.maxhp * (0.1)
			drone:get_data().base_sprite = sprite_shoot4droneboosted
			drone:get_data().heal_sprite = sprite_shoot4healboosted
		else
			drone:get_data().regen = actor.maxhp * (0.07)
			drone:get_data().base_sprite = sprite_shoot4drone
			drone:get_data().heal_sprite = sprite_shoot4heal
		end	
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

local muleLog = Survivor_Log.new(mule, sprite_log)