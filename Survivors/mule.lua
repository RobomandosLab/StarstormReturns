local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/MULE")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/MULE")

local sprite_loadout		= Resources.sprite_load(NAMESPACE, "MuleSelect", path.combine(SPRITE_PATH, "select.png"), 16, 28, 0)
local sprite_portrait 		= Resources.sprite_load(NAMESPACE, "MulePortrait", path.combine(SPRITE_PATH, "portrait.png"), 4)
local sprite_portrait_small = Resources.sprite_load(NAMESPACE, "MulePortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "MuleSkills", path.combine(SPRITE_PATH, "skills.png"), 5)
local sprite_credits 		= Resources.sprite_load(NAMESPACE, "MuleCredits", path.combine(SPRITE_PATH, "credits.png"), 1, 12, 22)
local sprite_log			= Resources.sprite_load(NAMESPACE, "MuleLog", path.combine(SPRITE_PATH, "log.png"), 1)
local sprite_wave_mask		= Resources.sprite_load(NAMESPACE, "MuleShockwaveMask", path.combine(SPRITE_PATH, "wave_mask.png"), 1, 8, 8)

local sprite_idle 			= Resources.sprite_load(NAMESPACE, "MuleIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 20, 26)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "MuleWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 22, 28)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "MuleClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 25, 51)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "MuleJump", path.combine(SPRITE_PATH, "jump_start.png"), 1, 22, 32)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "MuleJumpPeak", path.combine(SPRITE_PATH, "jump_peak.png"), 1, 22, 32)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "MuleFall", path.combine(SPRITE_PATH, "jump_fall.png"), 1, 22, 32)
local sprite_death			= Resources.sprite_load(NAMESPACE, "MuleDeath", path.combine(SPRITE_PATH, "death.png"), 10, 45, 55)
local sprite_decoy			= Resources.sprite_load(NAMESPACE, "MuleDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 16, 18)

local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "MuleShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 6, 21, 34)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "MuleShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 21, 34)
local sprite_shoot1c		= Resources.sprite_load(NAMESPACE, "MuleShoot1_33", path.combine(SPRITE_PATH, "shoot1_2.png"), 6, 21, 34)
local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "MuleShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 30, 33)
local sprite_shoot1charge	= Resources.sprite_load(NAMESPACE, "MuleShoot1Charge", path.combine(SPRITE_PATH, "shoot1_charge.png"), 6, 21, 28)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "MuleShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 15, 48, 33)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "MuleShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 15, 23, 27)
local sprite_shoot4drone	= Resources.sprite_load(NAMESPACE, "MuleShoot4Drone", path.combine(SPRITE_PATH, "drone.png"), 5, 9, 12)
local sprite_shoot4heal		= Resources.sprite_load(NAMESPACE, "MuleShoot4Heal", path.combine(SPRITE_PATH, "droneheal.png"), 5, 16, 14)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "MuleShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 15, 23, 27)
local sprite_drone_idle		= Resources.sprite_load(NAMESPACE, "MulePlayerDroneIdle", path.combine(SPRITE_PATH, "playerdrone.png"), 5, 15, 13)
local sprite_drone_shoot	= Resources.sprite_load(NAMESPACE, "MulePlayerDroneShoot", path.combine(SPRITE_PATH, "playerdroneshoot.png"), 5, 33, 13)
local sprite_trap_debuff	= Resources.sprite_load(NAMESPACE, "MuleTrapDebuff", path.combine(SPRITE_PATH, "trap_debuff.png"), 8, 18, 18)
local sprite_snare_debuff	= Resources.sprite_load(NAMESPACE, "MuleSnareDebuff", path.combine(SPRITE_PATH, "snare_debuff.png"), 1, 18, 12)
local sprite_sparks1		= Resources.sprite_load(NAMESPACE, "MuleSparks1", path.combine(SPRITE_PATH, "sparks1.png"), 3, 10, 16)
local sprite_sparks2		= Resources.sprite_load(NAMESPACE, "MuleSparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 14, 10)
local sprite_sparks3		= Resources.sprite_load(NAMESPACE, "MuleSparks3", path.combine(SPRITE_PATH, "sparks3.png"), 4, 8, 16)

local sound_shoot1a			= Resources.sfx_load(NAMESPACE, "MuleShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b			= Resources.sfx_load(NAMESPACE, "MuleShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_shoot1c			= Resources.sfx_load(NAMESPACE, "MuleShoot1c", path.combine(SOUND_PATH, "skill1c.ogg"))
local sound_shoot2a			= Resources.sfx_load(NAMESPACE, "MuleShoot2a", path.combine(SOUND_PATH, "skill2a.ogg"))
local sound_shoot2b			= Resources.sfx_load(NAMESPACE, "MuleShoot2b", path.combine(SOUND_PATH, "skill2b.ogg"))
local sound_shoot3			= Resources.sfx_load(NAMESPACE, "MuleShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a			= Resources.sfx_load(NAMESPACE, "MuleShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b			= Resources.sfx_load(NAMESPACE, "MuleShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))
local sound_shoot4c			= Resources.sfx_load(NAMESPACE, "MuleShoot4c", path.combine(SOUND_PATH, "skill4c.ogg"))
local sound_shoot4e			= Resources.sfx_load(NAMESPACE, "MuleShoot4d", path.combine(SOUND_PATH, "skill4d.ogg"))
local sound_shoot4e			= Resources.sfx_load(NAMESPACE, "MuleShoot4e", path.combine(SOUND_PATH, "skill4e.ogg"))
local sound_drone_death		= Resources.sfx_load(NAMESPACE, "MuleDroneDeath", path.combine(SOUND_PATH, "drone_death.ogg"))

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
	actor:get_data().z_count = 0
end)

local snare = Buff.new(NAMESPACE, "muleSnare")
snare.icon_sprite = sprite_snare_debuff
snare.show_icon = true
snare.is_debuff = true
snare:clear_callbacks()

snare:onApply(function(actor, stack)
	actor.pHspeed = 0
	if not GM.actor_is_boss(actor) then
		actor.activity = 46
		actor.pHspeed = 0
	end
end)

snare:onPostStep(function(actor, stack)
	actor.pHspeed = 0
	if not GM.actor_is_boss(actor) then
		actor.activity = 46
		if actor.sprite_idle then
			actor.sprite_index = actor.sprite_idle
		end
	end
end)

snare:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax - 4
end)

snare:onRemove(function(actor, stack)
	if not GM.actor_is_boss(actor) then
		actor:skill_util_reset_activity_state()
	end
end)

local trap = Buff.new(NAMESPACE, "muleTrap")
trap.icon_sprite = sprite_trap_debuff
trap.icon_frame_speed = 0.25
trap.show_icon = true
trap.is_debuff = true
trap:clear_callbacks()

trap:onPostDraw(function(actor, stack)
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
				gm.draw_line_width(victim.x, victim.y, parent.x, parent.y + victim:get_data().trap_offset_a, 3)
				
				if victim:get_data().trap_offset_c then
					gm.draw_line_width(victim.x, victim.y, victim:get_data().trap_offset_b, victim:get_data().trap_offset_c, 3)
				end
			end
		end
	end
end)

trap:onRemove(function(actor, stack)
	actor:get_data().trapped_enemies:destroy()
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
	data.timer = 140
	data.color = Color.from_hex(0xE7967E)
end)

objWave:onStep(function(self)
	local data = self:get_data()
	
	for s = 0, 32 do 
		if self:is_colliding(gm.constants.pBlock, self.x, self.y) then
			self.y = self.y - 1
		end
	end
	
	self:move_contact_solid(270, -1)
	
	if self:is_colliding(gm.constants.pBlock) then
		self:destroy()
	end
	
	local parent = self.parent
	if Instance.exists(parent) and parent:is_authority() then
		local actors = self:get_collisions(gm.constants.pActorCollisionBase)

		for _, actor in ipairs(actors) do
			if parent:attack_collision_canhit(actor) then
				self.explode = 1
				self:destroy()
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
end)

objWave:onDestroy(function(self)
	local data = self:get_data()
	local parent = self.parent
	
	if self.explode == 1 then
		if Instance.exists(parent) and parent:is_authority() then
			local attack_info = parent:fire_explosion(self.x, self.y, 32, 32, 4.1, nil, nil).attack_info
			attack_info.knockup = 4
		end

		self:screen_shake(4)
		local sparks = gm.instance_create(self.x, self.y + 8, gm.constants.oEfExplosion)
		sparks.sprite_index = gm.constants.sBoss1Shoot1Pillar
		sparks.image_yscale = 1
		self:sound_play(gm.constants.wSmite, 0.5, 1.3 + math.random() * 0.2)
	end
end)

local primary = mule:get_primary()
local secondary = mule:get_secondary()
local utility = mule:get_utility()
local special = mule:get_special()

-- INTERFERENCE REMOVAL
primary:set_skill_icon(sprite_skills, 0)

primary.cooldown = 5
primary.require_key_press = true
primary.is_primary = true

local statePrimary = State.new(NAMESPACE, "mulePrimary")

primary:clear_callbacks()
primary:onActivate(function(actor)
	actor:enter_state(statePrimary)
end)

statePrimary:clear_callbacks()
statePrimary:onEnter(function(actor, data)
	data.fired = 0
	data.strength = 1.6
	actor:actor_animation_set(sprite_shoot1charge, 0.06)
	actor.image_index = 0
	data.charging_sound = -1
	
	if not data.attack_side then
		data.attack_side = 0
	end
end)

statePrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:freeze_active_skill(Skill.SLOT.primary)
	
	if data.fired < 1 then
	
		if data.charging_sound == -1 and actor.image_index >= 0.5 then
			data.charging_sound = gm.audio_play_sound(sound_shoot1a, 1, false, 0.4, 0, (0.9 + math.random() * 0.2))
		end
		
		if actor.image_index < 5 and actor.sprite_index == sprite_shoot1charge then
			data.strength = 1.6 + 0.6 * math.min(4, math.floor(actor.image_index))
		end
		
		if actor.image_index >= 5 and actor.sprite_index == sprite_shoot1charge then
			data.fired = 2
			actor:actor_animation_set(sprite_shoot1c, 0.2)
			actor.image_index = 0
		end
		
		local release = not actor:control("skill1", 0)
		if not actor:is_authority() then
			release = gm.bool(actor.activity_var2)
		end

		if release and data.fired < 1 and actor.sprite_index == sprite_shoot1charge then
			if gm._mod_net_isOnline() then
				if gm._mod_net_isHost() then
					gm.server_message_send(0, 43, actor:get_object_index_self(), actor.m_id, 1, gm.sign(actor.image_xscale))
				else
					gm.client_message_send(43, 1, gm.sign(actor.image_xscale))
				end
			end
			actor:actor_animation_set(sprite_shoot1a, 0.25)
			if data.attack_side == 1 then
				actor:actor_animation_set(sprite_shoot1b, 0.25)
			end
			actor.image_index = 0
			data.fired = 1
		end
	else
		if gm.audio_is_playing(data.charging_sound) then
			gm.audio_stop_sound(data.charging_sound)
		end
		if data.fired == 2 and actor.image_index >= 1 then
			data.fired = 3
			actor:screen_shake(7)
			actor:skill_util_nudge_forward(10 * actor.image_xscale)
			actor:sound_play(sound_shoot1c, 1, (0.9 + math.random() * 0.2))
			actor:get_data().z_count = actor:get_data().z_count + 1
			
			if not gm.bool(actor.free) then
				par_fire4:create(actor.x + 40 * actor.image_xscale, actor.y + 8, 2, Particle.SYSTEM.middle)
				par_debris:create(actor.x + 40 * actor.image_xscale, actor.y + 8, 2, Particle.SYSTEM.middle)
			end
			
			if gm._mod_net_isHost() then
				local heaven_cracker_count = actor:item_stack_count(Item.find("ror", "heavenCracker"))
				local cracker_shot = false

				if heaven_cracker_count > 0 and actor:get_data().z_count >= 5 - heaven_cracker_count then
					cracker_shot = true
					actor:get_data().z_count = 0
				end
				
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					if cracker_shot then
						attack_info = actor:fire_bullet(actor.x + 20 * actor.image_xscale, actor.y - 8, 700, actor:skill_util_facing_direction(), 10, 1, gm.constants.sSparks1, Attack_Info.TRACER.drill).attack_info
						attack_info.climb = i * 8
					else
						local attack_info = actor:fire_explosion(actor.x + 50 * actor.image_xscale, actor.y, 120, 60, 10, nil, sprite_sparks1).attack_info
						attack_info.climb = i * 8
						attack_info.knockback = attack_info.knockback + 1.5 * data.strength
						attack_info.knockback_direction = actor.image_xscale
						attack_info.knockup = 3
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
				end
			end
		elseif data.fired == 1 and actor.image_index >= 1 then
			data.fired = 3
			actor:screen_shake(2)
			actor:skill_util_nudge_forward(1.6 * actor.image_xscale * data.strength)
			actor:sound_play(sound_shoot1b, 1, (0.9 + math.random() * 0.2))
			actor:get_data().z_count = actor:get_data().z_count + 1
			data.attack_side = (data.attack_side + 1) % 2
			if gm._mod_net_isHost() then
				local dmg = 1.7 * data.strength
				local heaven_cracker_count = actor:item_stack_count(Item.find("ror", "heavenCracker"))
				local cracker_shot = false

				if heaven_cracker_count > 0 and actor:get_data().z_count >= 5 - heaven_cracker_count then
					cracker_shot = true
					actor:get_data().z_count = 0
				end
				
				local buff_shadow_clone = Buff.find("ror", "shadowClone")
				for i=0, actor:buff_stack_count(buff_shadow_clone) do
					if cracker_shot then
						attack_info = actor:fire_bullet(actor.x + 20 * actor.image_xscale, actor.y - 8, 700, actor:skill_util_facing_direction(), dmg, 1, gm.constants.sSparks1, Attack_Info.TRACER.drill).attack_info
						attack_info.climb = i * 8
					else
						local attack_info = actor:fire_explosion(actor.x + 30 * actor.image_xscale, actor.y, 80, 60, dmg, nil, sprite_sparks1).attack_info
						attack_info.climb = i * 8
						attack_info.knockback = attack_info.knockback + 1.5 * data.strength
						attack_info.knockback_direction = actor.image_xscale
					end
				end
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

statePrimary:onExit(function(actor, data)
end)

-- IMMOBILIZE
secondary:set_skill_icon(sprite_skills, 1)

secondary.cooldown = 4 * 60
secondary.damage = 1.25

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
		if actor:is_authority() then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y - 4, 1300, actor:skill_util_facing_direction(), 1.25, nil, sprite_sparks3).attack_info
				attack_info.climb = i * 8
				attack_info.mule_immobilize = 1
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(Callback.TYPE.onAttackHit, "muleInflictImmobilize", function(hit_info)
	if hit_info.attack_info.mule_immobilize == 1 then
		actor = hit_info.target
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
	actor.pHspeed = 0
end)

stateUtility:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot3, 0.25, false)
	
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
			local damage = actor:skill_get_damage(utility)

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i = 0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_explosion(actor.x, actor.y, 160, 100, damage, nil, sprite_sparks2).attack_info
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

local muleLog = Survivor_Log.new(mule, sprite_log)