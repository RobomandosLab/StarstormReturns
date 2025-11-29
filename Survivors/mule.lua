local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/MULE")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/MULE")

local sprite_loadout			= Sprite.new("MuleSelect", path.combine(SPRITE_PATH, "select.png"), 15, 56, 0)
local sprite_portrait 			= Sprite.new("MulePortrait", path.combine(SPRITE_PATH, "portrait.png"), 4)
local sprite_portrait_small 	= Sprite.new("MulePortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_palette 			= Sprite.new("MulePalette", path.combine(SPRITE_PATH, "palette.png"))
local sprite_skills				= Sprite.new("MuleSkills", path.combine(SPRITE_PATH, "skills.png"), 5)
local sprite_credits 			= Sprite.new("MuleCredits", path.combine(SPRITE_PATH, "credits.png"), 1, 12, 22)
local sprite_log				= Sprite.new("MuleLog", path.combine(SPRITE_PATH, "log.png"), 1)
local sprite_wave_mask			= Sprite.new("MuleShockwaveMask", path.combine(SPRITE_PATH, "wave_mask.png"), 1, 8, 8)

local sprite_idle 				= Sprite.new("MuleIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 20, 26)
local sprite_idle_half			= Sprite.new("MuleIdleHalf", path.combine(SPRITE_PATH, "idle_half.png"), 1, 7, 26)
local sprite_walk				= Sprite.new("MuleWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 22, 28)
local sprite_walk_back			= Sprite.new("MuleWalkBack", path.combine(SPRITE_PATH, "walk_back.png"), 8, 22, 27)
local sprite_walk_half			= Sprite.new("MuleWalkHalf", path.combine(SPRITE_PATH, "walk_half.png"), 8, 10, 28)
local sprite_climb				= Sprite.new("MuleClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 25, 51)
local sprite_jump				= Sprite.new("MuleJump", path.combine(SPRITE_PATH, "jump_start.png"), 1, 22, 32)
local sprite_jump_half			= Sprite.new("MuleJumpHalf", path.combine(SPRITE_PATH, "jump_start_half.png"), 1, 9, 28)
local sprite_jump_peak			= Sprite.new("MuleJumpPeak", path.combine(SPRITE_PATH, "jump_peak.png"), 1, 22, 32)
local sprite_jump_peak_half		= Sprite.new("MuleJumpPeakHalf", path.combine(SPRITE_PATH, "jump_peak_half.png"), 1, 9, 28)
local sprite_fall				= Sprite.new("MuleFall", path.combine(SPRITE_PATH, "jump_fall.png"), 1, 22, 32)
local sprite_fall_half			= Sprite.new("MuleFallHalf", path.combine(SPRITE_PATH, "jump_fall_half.png"), 1, 9, 28)
local sprite_death				= Sprite.new("MuleDeath", path.combine(SPRITE_PATH, "death.png"), 10, 45, 55)
local sprite_decoy				= Sprite.new("MuleDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 17, 17)

local sprite_shoot1a			= Sprite.new("MuleShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 21, 34)
local sprite_shoot1b			= Sprite.new("MuleShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 21, 34)
local sprite_shoot1c			= Sprite.new("MuleShoot1_3", path.combine(SPRITE_PATH, "shoot1_3.png"), 9, 39, 36)
local sprite_shoot2				= Sprite.new("MuleShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 30, 33)
local sprite_shoot1charge		= Sprite.new("MuleShoot1Charge", path.combine(SPRITE_PATH, "shoot1_charge.png"), 6, 17, 38)
local sprite_shoot3				= Sprite.new("MuleShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 15, 48, 33)
local sprite_shoot4				= Sprite.new("MuleShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 15, 23, 27)
local sprite_shoot4boosted		= Sprite.new("MuleShoot4Boosted", path.combine(SPRITE_PATH, "shoot4boosted.png"), 15, 23, 27)
local sprite_shoot4drone		= Sprite.new("MuleShoot4Drone", path.combine(SPRITE_PATH, "drone.png"), 5, 9, 12)
local sprite_shoot4heal			= Sprite.new("MuleShoot4Heal", path.combine(SPRITE_PATH, "droneheal.png"), 5, 16, 14)
local sprite_shoot4droneboosted	= Sprite.new("MuleShoot4DroneBoosted", path.combine(SPRITE_PATH, "droneboosted.png"), 5, 14, 14)
local sprite_shoot4healboosted	= Sprite.new("MuleShoot4HealBoosted", path.combine(SPRITE_PATH, "dronehealboosted.png"), 5, 17, 14)
local sprite_drone_idle			= Sprite.new("MulePlayerDroneIdle", path.combine(SPRITE_PATH, "playerdrone.png"), 5, 15, 13)
local sprite_drone_shoot		= Sprite.new("MulePlayerDroneShoot", path.combine(SPRITE_PATH, "playerdroneshoot.png"), 5, 33, 13)
local sprite_trap_debuff		= Sprite.new("MuleTrapDebuff", path.combine(SPRITE_PATH, "trap_debuff.png"), 8, 18, 13)
local sprite_snare_debuff		= Sprite.new("MuleSnareDebuff", path.combine(SPRITE_PATH, "snare_debuff.png"), 1, 18, 12)
local sprite_sparks1			= Sprite.new("MuleSparks1", path.combine(SPRITE_PATH, "sparks1.png"), 3, 13, 25)
local sprite_sparks2			= Sprite.new("MuleSparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 27, 24)
local sprite_sparks3			= Sprite.new("MuleSparks3", path.combine(SPRITE_PATH, "sparks3.png"), 4, 22, 16)

local sound_select				= Sound.new("MuleSelect", path.combine(SOUND_PATH, "select.ogg"))
local sound_shoot1a				= Sound.new("MuleShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b				= Sound.new("MuleShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c				= Sound.new("MuleShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot2a				= Sound.new("MuleShoot2a", path.combine(SOUND_PATH, "skill2a.ogg"))
local sound_shoot2b				= Sound.new("MuleShoot2b", path.combine(SOUND_PATH, "skill2b.ogg"))
local sound_shoot3				= Sound.new("MuleShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a				= Sound.new("MuleShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b				= Sound.new("MuleShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))
local sound_shoot4c				= Sound.new("MuleShoot4c", path.combine(SOUND_PATH, "skill4c.ogg"))
local sound_shoot4d				= Sound.new("MuleShoot4d", path.combine(SOUND_PATH, "skill4d.ogg"))
local sound_shoot4e				= Sound.new("MuleShoot4e", path.combine(SOUND_PATH, "skill4e.ogg"))
local sound_drone_death			= Sound.new("MuleDroneDeath", path.combine(SOUND_PATH, "drone_death.ogg"))

local par_fire4 = Particle.find("Fire4")

local par_debris = Particle.new("Debris")
par_debris:set_sprite(gm.constants.sEfRubble, false, false, true)
par_debris:set_color1(Color.WHITE)
par_debris:set_alpha2(1, 0)
par_debris:set_size(0.1, 0.9, -0.01, 0)
par_debris:set_orientation(0, 360, 3, 0, true)
par_debris:set_speed(0.9, 4.4, -0.03, 0.1)
par_debris:set_direction(45, 135, 0, 0)
par_debris:set_gravity(0.13, 270)
par_debris:set_life(20, 100)

local mule = Survivor.new("mule")

local mule_log = SurvivorLog.new_from_survivor(mule)
mule_log.portrait_id = sprite_log
mule_log.sprite_id = sprite_walk
mule_log.sprite_icon_id = sprite_portrait

mule:set_stats_base({
	health = 115,
	damage = 11,
	regen = 0.012
})

mule:set_stats_level({
	health = 37,
	damage = 3,
	regen = 0.0018,
	armor = 3
})

mule.primary_color = Color.from_rgb(211, 176, 122)

mule.sprite_loadout = sprite_loadout
mule.sprite_portrait = sprite_portrait
mule.sprite_portrait_small = sprite_portrait_small

mule.sprite_idle = sprite_idle -- used by skin systen for idle sprite
mule.sprite_title = sprite_walk -- also used by skin system for walk sprite
mule.sprite_credits = sprite_credits

mule.sprite_palette = sprite_palette
mule.sprite_portrait_palette = sprite_palette
mule.sprite_loadout_palette = sprite_palette

mule.select_sound_id = sound_select
mule.cape_offset = Array.new({0, -14, 0, -18})

--[[
--skins
mule:add_skin("Yellow Rose", 1, Sprite.new("MuleSelect2", path.combine(SPRITE_PATH, "select2.png"), 15, 56, 0),
Sprite.new("MulePortrait2", path.combine(SPRITE_PATH, "portrait2.png"), 4),
Sprite.new("MulePortraitSmall2", path.combine(SPRITE_PATH, "portraitSmall2.png")))

mule:add_skin("Steel Soul", 2, Sprite.new("MuleSelect3", path.combine(SPRITE_PATH, "select3.png"), 15, 56, 0),
Sprite.new("MulePortrait3", path.combine(SPRITE_PATH, "portrait3.png"), 4),
Sprite.new("MulePortraitSmall3", path.combine(SPRITE_PATH, "portraitSmall3.png")))

mule:add_skin("Automated Hunter", 3, Sprite.new("MuleSelect4", path.combine(SPRITE_PATH, "select4.png"), 15, 56, 0),
Sprite.new("MulePortrait4", path.combine(SPRITE_PATH, "portrait4.png"), 4),
Sprite.new("MulePortraitSmall4", path.combine(SPRITE_PATH, "portraitSmall4.png")))

mule:add_skin("Military Grade", 4, Sprite.new("MuleSelect5", path.combine(SPRITE_PATH, "select5.png"), 15, 56, 0),
Sprite.new("MulePortrait5", path.combine(SPRITE_PATH, "portrait5.png"), 4),
Sprite.new("MulePortraitSmall5", path.combine(SPRITE_PATH, "portraitSmall5.png")))
]]

Callback.add(mule.on_init, function(actor)
	actor.sprite_idle_half		= Array.new({sprite_idle,		sprite_idle_half, 0})
	actor.sprite_walk_half		= Array.new({sprite_walk,		sprite_walk_half, 0, sprite_walk_back})
	actor.sprite_jump_half		= Array.new({sprite_jump,		sprite_jump_half, 0})
	actor.sprite_jump_peak_half	= Array.new({sprite_jump_peak,	sprite_jump_peak_half, 0})
	actor.sprite_fall_half		= Array.new({sprite_fall,		sprite_fall_half, 0})
	
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

	actor:survivor_util_init_half_sprites()
end)

local snare = Buff.new("muleSnare")
snare.icon_sprite = sprite_snare_debuff
snare.show_icon = true
snare.is_debuff = true

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(snare:get_holding_actors()) do
		if Instance.exists(actor) then
			actor.pHspeed = 0
			if not GM.actor_is_boss(actor) then
				actor.activity = 50
				actor:alarm_set(7, 10)
				actor:alarm_set(2, 10)
				if actor.sprite_climb and actor:is_climbing() then
					actor.sprite_index = actor.sprite_climb
					actor.image_index = 0
				elseif actor.sprite_idle then
					actor.sprite_index = actor.sprite_idle
				end
			end
		end
	end
end)

Callback.add(snare.on_remove, function(actor, stack)
	if not GM.actor_is_boss(actor) then
		actor:skill_util_reset_activity_state()
	end
end)

local trap = Buff.new("muleTrap")
trap.show_icon = false
trap.is_debuff = true

Callback.add(trap.on_apply, function(actor, stack)
	local data = Instance.get_data(actor)
	data.trapspeed = 0
end)

trap.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	local data = Instance.get_data(actor)
	
	data.trapspeed = data.trapspeed + 0.25
	
	if data.trapspeed > 8 then
		data.trapspeed = 0 
	end
	
	GM.draw_sprite(sprite_trap_debuff, data.trapspeed, actor.x, actor.y)
	
	for _, victim in ipairs(data.trapped_enemies) do
		if Instance.exists(victim) then
			local parent = victim.trap_parent
			if parent and Instance.exists(parent) then
				if not (data.trap_offset_a and data.trap_offset_b) then
					data.trap_offset_a = math.random(-8, 8)
					data.trap_offset_b = victim.x + math.random(-16, 16)
					
					local yy = 0
					while yy < 100 and victim:collision_point(victim.x, victim.y + yy, gm.constants.pBlock, true, false) == -4.0 do
						yy = yy + 2
					end
					if yy < 100 and not data.trap_offset_c then
						data.trap_offset_c = victim.y + yy
					else
						data.trap_offset_c = nil
					end
				end
				
				gm.draw_set_alpha(0.8)
				gm.draw_set_colour(Color.from_rgb(205, 205, 205))
				gm.draw_line_width(victim.x, victim.y, parent.x, parent.y + data.trap_offset_a, 2)
				
				if data.trap_offset_c then
					gm.draw_line_width(victim.x, victim.y, data.trap_offset_b, data.trap_offset_c, 2)
				end
				gm.draw_set_alpha(1)
			end
		end
	end
end)

Callback.add(trap.on_remove, function(actor, stack)
	local data = Instance.get_data(actor)
	data.trapped_enemies = {}
	data.trapspeed = nil
end)

local objWave = Object.new("MuleShockwave")
objWave:set_depth(1)

Callback.add(objWave.on_create, function(self)
	local data = Instance.get_data(self)
	self.mask = sprite_wave_mask
	self.sprite_index = sprite_wave_mask
	self.image_alpha = 0
	self.direction = 0
	self.speed = 4.8
	self.parent = -4
	self.team = 1
	data.timer = 140
end)

Callback.add(objWave.on_step, function(self)
	local data = Instance.get_data(self)
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
			local sparks = Object.find("EfExplosion"):create(self.x, self.y - 6)
			sparks.depth = -12
			sparks.sprite_index = gm.constants.sMinerShoot2Dust2
			sparks.image_xscale = 1 - ((self.direction * 2) / 180)
			sparks.image_yscale = 1
		end
	end
	
	if explode == true then
		self:screen_shake(4)
		local sparks = Object.find("EfExplosion"):create(self.x, self.y + 8)
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

-- default skills
local primary = mule:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = mule:get_skills(Skill.Slot.SECONDARY)[1]
local utility = mule:get_skills(Skill.Slot.UTILITY)[1]
local special = mule:get_skills(Skill.Slot.SPECIAL)[1]
local specialS = Skill.new("muleVBoosted")

-- INTERFERENCE REMOVAL
primary.sprite = sprite_skills
primary.subimage = 0
primary.cooldown = 10
primary.damage = 1.6
primary.require_key_press = false
primary.is_primary = true

local statePrimaryCharge = ActorState.new("mulePrimaryCharge")
local statePrimaryPunch = ActorState.new("mulePrimaryPunch")
local statePrimarySlam = ActorState.new("mulePrimarySlam")

Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimaryCharge)
end)

Callback.add(statePrimaryCharge.on_enter, function(actor, data)
	actor.image_index2 = 0
	data.fired = 0
	data.strength = 1.6
	data.charging_sound = -1
	
	if not data.attack_side then
		data.attack_side = 0
	end
	
	actor:skill_util_strafe_init()
end)

Callback.add(statePrimaryCharge.on_step, function(actor, data)
	actor.sprite_index2 = sprite_shoot1charge
	actor:skill_util_strafe_update(0.06 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	
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
			data.charging_sound = actor:sound_play(sound_shoot1a, 1, (0.9 + math.random() * 0.2))
		end
		
		if actor.image_index2 < 5 and actor.sprite_index2 == sprite_shoot1charge.value then
			data.strength = actor:skill_get_damage(primary) + 0.6 * math.min(4, math.floor(actor.image_index2))
		end
		
		if actor.image_index2 >= GM.sprite_get_number(actor.sprite_index2) - 1 and actor.sprite_index2 == sprite_shoot1charge.value then
			data.fired = 1
		end

		local release = not Util.bool(actor.z_skill)
		if not actor:is_authority() then
			release = Util.bool(actor.activity_var2)
		end
		
		if release and data.fired < 1 and actor.sprite_index2 == sprite_shoot1charge.value then
			if Net.online then
				if Net.host then
					gm.server_message_send(0, 43, actor:get_object_index_self(), actor.m_id, 1, Math.sign(actor.image_xscale))
				else
					gm.client_message_send(43, 1, Math.sign(actor.image_xscale))
				end
			end
			
			actor:set_state(statePrimaryPunch)
		end
	else
		actor:set_state(statePrimarySlam)
	end
end)

Callback.add(statePrimaryCharge.on_exit, function(actor, data)
	actor:skill_util_strafe_exit()
	
	Instance.get_data(actor).strength = data.strength
	
	if gm.audio_is_playing(data.charging_sound) then
		gm.audio_stop_sound(data.charging_sound)
	end
end)

Callback.add(statePrimaryPunch.on_enter, function(actor, data)
	data.fired = 0
	data.strength = Instance.get_data(actor).strength
	actor.image_index = 0
	
	if not data.attack_side then
		data.attack_side = 0
	end
	
	actor:actor_animation_set(sprite_shoot1a, 0.2)
	if data.attack_side == 1 then
		actor:actor_animation_set(sprite_shoot1b, 0.2)
	end
end)

Callback.add(statePrimaryPunch.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	
	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1
		actor:screen_shake(2)
		actor:skill_util_nudge_forward(1.6 * actor.image_xscale * data.strength)
		actor:sound_play(sound_shoot1b, 1, (0.9 + math.random() * 0.2))
		data.attack_side = (data.attack_side + 1) % 2
		if actor:is_authority() then
			if not GM.skill_util_update_heaven_cracker(actor, 1.25 * data.strength, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					local attack_info = actor:fire_explosion(actor.x + 30 * actor.image_xscale, actor.y, 80, 60, 1.25 * data.strength, nil, sprite_sparks1).attack_info
					attack_info.climb = i * 8
					attack_info.knockback_direction = actor.image_xscale
				end
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryPunch.on_exit, function(actor, data)
	Instance.get_data(actor).strength = nil
end)

Callback.add(statePrimarySlam.on_enter, function(actor, data)	
	data.fired = 0
	actor.image_index = 0
	actor:actor_animation_set(sprite_shoot1c, 0.2)
end)

Callback.add(statePrimarySlam.on_step, function(actor, data)	
	actor:skill_util_fix_hspeed()
	
	if data.fired == 0 and actor.image_index >= 3 then
		data.fired = 1
		actor:screen_shake(7)
		actor:skill_util_nudge_forward(10 * actor.image_xscale)
		actor:sound_play(sound_shoot1c, 1, (0.9 + math.random() * 0.2))
		
		if actor:is_grounded() then
			par_fire4:create(actor.x + 40 * actor.image_xscale, actor.y + 8, 2, Particle.System.MIDDLE)
			par_debris:create(actor.x + 40 * actor.image_xscale, actor.y + 8, 2, Particle.System.MIDDLE)
		end
			
		if actor:is_authority() then
			if not GM.skill_util_update_heaven_cracker(actor, 1.25 * data.strength, actor.image_xscale) then
				local buff_shadow_clone = Buff.find("shadowClone")
				for i=0, actor:buff_count(buff_shadow_clone) do
					local attack_info = actor:fire_explosion(actor.x + 20 * actor.image_xscale, actor.y, 120, 60, 10, nil, sprite_sparks1).attack_info
					attack_info.climb = i * 8
					attack_info.knockback = attack_info.knockback + 9
					attack_info.knockback_direction = actor.image_xscale
					attack_info.knockup = 6
				end
			end
		end
		
		if actor:is_grounded() then
			local buff_shadow_clone = Buff.find("shadowClone")
			for i=0, actor:buff_count(buff_shadow_clone) do
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
secondary.sprite = sprite_skills
secondary.subimage = 1
secondary.damage = 1.25
secondary.cooldown = 6 * 60

local stateSecondary = ActorState.new("muleSecondary")

Callback.add(secondary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary)
end)

Callback.add(stateSecondary.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(stateSecondary.on_step, function(actor, data)
	actor:actor_animation_set(sprite_shoot2, 0.2)
	actor:skill_util_fix_hspeed()
	
	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1
		actor:sound_play(sound_shoot2a, 1, 0.9 + math.random() * 0.2)
		if Net.host then
			local buff_shadow_clone = Buff.find("shadowClone")
			for i=0, actor:buff_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y - 4, 1300, actor:skill_util_facing_direction(), actor:skill_get_damage(secondary), nil, sprite_sparks3).attack_info
				attack_info.climb = i * 8
				attack_info.mule_immobilize = 1
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

local immobilizeSyncPacket = Packet.new("SyncImmobilize")

local serializer = function(buffer, self, actor)
	buffer:write_instance(actor)
end

local deserializer = function(buffer, self)
	local actor = buffer:read_instance()

	if not Instance.exists(actor) then return end
	local data = Instance.get_data(actor)
	
	GM.apply_buff(actor, trap, 3 * 60, 1)
	
	data.trapped_enemies = {}
	
	local victims = List.new()
	
	actor:collision_ellipse_list(actor.x - 280, actor.y - 200, actor.x + 280, actor.y + 200, gm.constants.pActor, false, false, victims, true)
	local count = 0
	for _, victim in ipairs(victims) do
		if victim.team == actor.team then
			GM.apply_buff(victim, snare, 3 * 60, 1)
			victim.trap_parent = actor
			Instance.get_data(victim).trap_offset_a = nil
			Instance.get_data(victim).trap_offset_b = nil
			Instance.get_data(victim).trap_offset_c = nil
			table.insert(data.trapped_enemies, victim.value)
			count = count + 1
			if count > 4 then
				break
			end
		end
	end
	
	victims:destroy()
end

Callback.add(Callback.ON_ATTACK_HIT, function(hit_info)
	if hit_info.attack_info.mule_immobilize == 1 then
		actor = hit_info.target
		
		if Net.online then
			immobilizeSyncPacket:send_to_all(actor)
		end
		
		local data = Instance.get_data(actor)
		
		GM.apply_buff(actor, trap, 3 * 60, 1)
		
		actor:sound_play(sound_shoot2b, 1, 0.9 + math.random() * 0.2)
		
		data.trapped_enemies = {}
	
		local victims = List.new()
	
		actor:collision_ellipse_list(actor.x - 280, actor.y - 200, actor.x + 280, actor.y + 200, gm.constants.pActor, false, false, victims, true)
		local count = 0
		for _, victim in ipairs(victims) do
			if victim.team == actor.team then
				GM.apply_buff(victim, snare, 3 * 60, 1)
				victim.trap_parent = actor
				Instance.get_data(victim)trap_offset_a = nil
				Instance.get_data(victim).trap_offset_b = nil
				Instance.get_data(victim).trap_offset_c = nil
				table.insert(data.trapped_enemies, victim.value)
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
utility.sprite = sprite_skills
utility.subimage = 2
utility.cooldown = 4 * 60
utility.damage = 1.0
utility.is_utility = true
utility.override_strafe_direction = true
utility.ignore_aim_direction = true

local stateUtility = ActorState.new("muleUtility")
stateUtility.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL

Callback.add(utility.on_activate, function(actor, skill, slot)
	actor:set_state(stateUtility)
end)

Callback.add(stateUtility.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.sound = 0
end)

Callback.add(stateUtility.on_step, function(actor, data)
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
			local buff_shadow_clone = Buff.find("shadowClone")
			for i = 0, actor:buff_count(buff_shadow_clone) do
				local attack_info = actor:fire_explosion(actor.x, actor.y, 160, 100, actor:skill_get_damage(utility), nil, sprite_sparks2).attack_info
				attack_info.climb = i * 8
				attack_info.knockback = 5
				attack_info.knockback_direction = actor.image_xscale
				if data.fired == 4 then 
					attack_info.stun = 1.5
				end
			end
		end		
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

-- FAIL-SAFE ASSISTANCE
special.sprite = sprite_skills
special.subimage = 3
special.cooldown = 20 * 60
special.upgrade_skill = specialS

specialS.sprite = sprite_skills
specialS.subimage = 4
specialS.cooldown = 20 * 60

local stateSpecial = ActorState.new("muleSpecial")

Callback.add(special.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)

Callback.add(specialS.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)

local mule_heal_sounds = {
	sound_shoot4b,
	sound_shoot4c,
	sound_shoot4d,
	sound_shoot4e,
}

local objDrone = Object.new("muleDrone")
objDrone:set_sprite(sprite_drone_idle)
objDrone:set_depth(2)

Callback.add(objDrone.on_create, function(self)
	local data = Instance.get_data(self)
	
	self.image_speed = 0.3
	data.timer = 0
	data.life = 300
	data.regen = 0.07
	data.base_sprite = sprite_shoot4drone
	data.heal_sprite = sprite_shoot4heal
	data.healing = 0
end)

Callback.add(objDrone.on_step, function(self)
	local data = Instance.get_data(self)
	local parent = data.parent
	
	if parent.dead or not Instance.exists(parent) then
		data.life = 0
	end
	
	if parent and Instance.exists(parent) then
		local float = math.sin(data.life * 0.1) * 8
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
				Particle.find("Spark"):create(parent.ghost_x + 8 * parent.image_xscale, parent.ghost_y - 6, 3, Particle.System.MIDDLE)
				
				self:sound_play(mule_heal_sounds[math.random(3)], 1, 0.9 + math.random() * 0.2)
				
				if parent.maxhp > parent.hp then
					if Net.host then
						parent:heal(data.regen)
					end
					
					parent:sound_play(gm.constants.wHANDShoot2_2, 0.5, 0.9 + math.random() * 0.2)
					
					local flash = Object.find("EfFlash"):create(parent.x, parent.y)
					flash.parent = parent
					flash.image_blend = Color.from_rgb(189, 231, 90)
					flash.rate = 0.05
					flash.image_alpha = 0.5
				else
					if Net.host then
						parent:heal_barrier(data.regen)
					end
					
					parent:sound_play(gm.constants.wHANDShoot2_2, 0.5, 0.9 + math.random() * 0.2)
					
					local flash = Object.find("EfFlash"):create(parent.x, parent.y)
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
		local sparks = Object.find("EfSparks"):create(self.x, self.y)
		sparks.sprite_index = gm.constants.sEfExplosive
		self:sound_play(sound_drone_death, 1, 0.9 + math.random() * 0.2)
		self:screen_shake(2)
		self:destroy()
	end
end)

Callback.add(stateSpecial.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.sound = 0
end)

Callback.add(stateSpecial.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	if actor:item_count(Item.find("ancientScepter")) > 0 then
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
		local drone_data = Instance.get_data(drone)
		drone_data.parent = actor
		drone_data.life = 300
		if actor:item_count(Item.find("ancientScepter")) > 0 then
			drone_data.regen = actor.maxhp * (0.1)
			drone_data.base_sprite = sprite_shoot4droneboosted
			drone_data.heal_sprite = sprite_shoot4healboosted
		else
			drone_data.regen = actor.maxhp * (0.07)
			drone_data.base_sprite = sprite_shoot4drone
			drone_data.heal_sprite = sprite_shoot4heal
		end	
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)