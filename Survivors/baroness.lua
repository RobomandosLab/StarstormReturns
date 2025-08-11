local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Baroness")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Baroness")

local sprite_loadout			= Resources.sprite_load(NAMESPACE, "BaronessSelect", path.combine(SPRITE_PATH, "select.png"), 27, 28, 0)
local sprite_portrait			= Resources.sprite_load(NAMESPACE, "BaronessPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small		= Resources.sprite_load(NAMESPACE, "BaronessPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills				= Resources.sprite_load(NAMESPACE, "BaronessSkills", path.combine(SPRITE_PATH, "skills.png"), 7)
local sprite_credits			= Resources.sprite_load(NAMESPACE, "CreditsSurvivorBaroness", path.combine(SPRITE_PATH, "credits.png"), 1, 10, 14)

local sprite_idle				= Resources.sprite_load(NAMESPACE, "BaronessIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 10, 12)
local sprite_idle2				= Resources.sprite_load(NAMESPACE, "BaronessIdle2", path.combine(SPRITE_PATH, "idle2.png"), 1, 18, 16)
local sprite_idle_half			= Resources.sprite_load(NAMESPACE, "BaronessIdleHalf", path.combine(SPRITE_PATH, "idle_half.png"), 1, 10, 12)
local sprite_walk				= Resources.sprite_load(NAMESPACE, "BaronessWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 10, 12)
local sprite_walk2				= Resources.sprite_load(NAMESPACE, "BaronessWalk2", path.combine(SPRITE_PATH, "walk2.png"), 8, 38, 16)
local sprite_walk_half			= Resources.sprite_load(NAMESPACE, "BaronessWalkHalf", path.combine(SPRITE_PATH, "walk_half.png"), 8, 10, 12)
local sprite_walk_back			= Resources.sprite_load(NAMESPACE, "BaronessWalkBack", path.combine(SPRITE_PATH, "walk_back.png"), 8, 10, 12)
local sprite_walk_back2			= Resources.sprite_load(NAMESPACE, "BaronessWalkBack2", path.combine(SPRITE_PATH, "walk_back2.png"), 8, 38, 16)
local sprite_jump				= Resources.sprite_load(NAMESPACE, "BaronessJump", path.combine(SPRITE_PATH, "jump.png"), 1, 10, 12)
local sprite_jump2				= Resources.sprite_load(NAMESPACE, "BaronessJump2", path.combine(SPRITE_PATH, "jump2.png"), 1, 18, 16)
local sprite_jump_half			= Resources.sprite_load(NAMESPACE, "BaronessJumpHalf", path.combine(SPRITE_PATH, "jump_half.png"), 1, 10, 12)
local sprite_jump_peak			= Resources.sprite_load(NAMESPACE, "BaronessJumpPeak", path.combine(SPRITE_PATH, "jump_peak.png"), 1, 10, 12)
local sprite_jump_peak2			= Resources.sprite_load(NAMESPACE, "BaronessJumpPeak2", path.combine(SPRITE_PATH, "jump_peak2.png"), 1, 18, 16)
local sprite_jump_peak_half		= Resources.sprite_load(NAMESPACE, "BaronessJumpPeakHalf", path.combine(SPRITE_PATH, "jump_peak_half.png"), 1, 10, 12)
local sprite_fall				= Resources.sprite_load(NAMESPACE, "BaronessFall", path.combine(SPRITE_PATH, "fall.png"), 1, 10, 12)
local sprite_fall2				= Resources.sprite_load(NAMESPACE, "BaronessFall2", path.combine(SPRITE_PATH, "fall2.png"), 1, 18, 16)
local sprite_fall_half			= Resources.sprite_load(NAMESPACE, "BaronessFallHalf", path.combine(SPRITE_PATH, "fall_half.png"), 1, 10, 12)
local sprite_climb				= Resources.sprite_load(NAMESPACE, "BaronessClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 18)
local sprite_death				= Resources.sprite_load(NAMESPACE, "BaronessDeath", path.combine(SPRITE_PATH, "death.png"), 8, 60, 16)
local sprite_decoy				= Resources.sprite_load(NAMESPACE, "BaronessDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 18, 20)
local sprite_palette			= Resources.sprite_load(NAMESPACE, "BaronessPalette", path.combine(SPRITE_PATH, "palette.png"))

local sprite_shoot1a			= Resources.sprite_load(NAMESPACE, "BaronessShoot1a", path.combine(SPRITE_PATH, "shoot1a.png"), 3, 10, 13)
local sprite_shoot1b			= Resources.sprite_load(NAMESPACE, "BaronessShoot1b", path.combine(SPRITE_PATH, "shoot1b.png"), 4, 38, 16)
local sprite_shoot2a			= Resources.sprite_load(NAMESPACE, "BaronessShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 7, 10, 28)
local sprite_shoot2b			= Resources.sprite_load(NAMESPACE, "BaronessShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 7, 30, 30)
local sprite_shoot3a			= Resources.sprite_load(NAMESPACE, "BaronessShoot3a", path.combine(SPRITE_PATH, "shoot3a.png"), 6, 16, 20)
local sprite_shoot3a_stationary	= Resources.sprite_load(NAMESPACE, "BaronessShoot3aStationary", path.combine(SPRITE_PATH, "shoot3a_stationary.png"), 6, 16, 20)
local sprite_dismount_jump		= Resources.sprite_load(NAMESPACE, "BaronessDismountJump", path.combine(SPRITE_PATH, "dismount_jump.png"), 8, 38, 36)
local sprite_shoot3b			= Resources.sprite_load(NAMESPACE, "BaronessShoot3b", path.combine(SPRITE_PATH, "shoot3b.png"), 8, 38, 36)
local sprite_shoot3b_stationary	= Resources.sprite_load(NAMESPACE, "BaronessShoot3b", path.combine(SPRITE_PATH, "shoot3b_stationary.png"), 8, 38, 36)
local sprite_shoot4a			= Resources.sprite_load(NAMESPACE, "BaronessShoot4a", path.combine(SPRITE_PATH, "shoot4a.png"), 7, 14, 18)
local sprite_shoot4b			= Resources.sprite_load(NAMESPACE, "BaronessShoot4b", path.combine(SPRITE_PATH, "shoot4b.png"), 7, 32, 30)

local sprite_vehicle_mask 		= Resources.sprite_load(NAMESPACE, "BaronessVehicleMask", path.combine(SPRITE_PATH, "vehicle_mask.png"), 1, 12, 10)
local sprite_nade				= Resources.sprite_load(NAMESPACE, "BaronessGrenade", path.combine(SPRITE_PATH, "nade.png"))
local sprite_sparks				= Resources.sprite_load(NAMESPACE, "BaronessSparks", path.combine(SPRITE_PATH, "sparks.png"), 3, 26, 16)
local sprite_sparks2			= Resources.sprite_load(NAMESPACE, "BaronessSparksLaser", path.combine(SPRITE_PATH, "sparks2.png"), 3, 24, 16)
local sprite_sparks3			= Resources.sprite_load(NAMESPACE, "BaronessSparksBombA", path.combine(SPRITE_PATH, "sparks3.png"), 3, 30, 16)
local sprite_sparks4			= Resources.sprite_load(NAMESPACE, "BaronessSparksBombB", path.combine(SPRITE_PATH, "sparks4.png"), 5, 112, 60)
local sprite_sparks5			= Resources.sprite_load(NAMESPACE, "BaronessSparksBombC", path.combine(SPRITE_PATH, "sparks5.png"), 5, 112, 60)

local sound_nade				= Resources.sfx_load(NAMESPACE, "BaronessGrenade", path.combine(SOUND_PATH, "grenade.ogg"))
local sound_skill1a				= Resources.sfx_load(NAMESPACE, "BaronessSkill1A", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_skill1b				= Resources.sfx_load(NAMESPACE, "BaronessSkill1B", path.combine(SOUND_PATH, "skill1b.ogg"))
local sound_skill2a				= Resources.sfx_load(NAMESPACE, "BaronessSkill2A", path.combine(SOUND_PATH, "skill2a.ogg"))
local sound_skill2b				= Resources.sfx_load(NAMESPACE, "BaronessSkill2B", path.combine(SOUND_PATH, "skill2b.ogg"))
local sound_skill3a				= Resources.sfx_load(NAMESPACE, "BaronessSkill3A", path.combine(SOUND_PATH, "skill3a.ogg"))
local sound_skill3b				= Resources.sfx_load(NAMESPACE, "BaronessSkill3B", path.combine(SOUND_PATH, "skill3b.ogg"))
local sound_skill3c				= Resources.sfx_load(NAMESPACE, "BaronessSkill3C", path.combine(SOUND_PATH, "skill3c.ogg"))
local sound_skill4a				= Resources.sfx_load(NAMESPACE, "BaronessSkill4A", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_skill4b				= Resources.sfx_load(NAMESPACE, "BaronessSkill4B", path.combine(SOUND_PATH, "skill4b.ogg"))
local sound_skill4c				= Resources.sfx_load(NAMESPACE, "BaronessSkill4C", path.combine(SOUND_PATH, "skill4c.ogg"))

local baroness = Survivor.new(NAMESPACE, "baroness")

baroness:set_stats_base({
	maxhp = 100,
	damage = 12,
	regen = 0.01,
})
baroness:set_stats_level({
	maxhp = 28,
	damage = 3,
	regen = 0.002,
	armor = 2,
})

baroness:set_animations({
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

baroness:set_cape_offset(0, -8, 0, -5)
baroness:set_primary_color(Color.from_rgb(117, 135, 119))

baroness.sprite_loadout = sprite_loadout
baroness.sprite_portrait = sprite_portrait
baroness.sprite_portrait_small = sprite_portrait_small
baroness.sprite_idle = sprite_idle
baroness.sprite_title = sprite_walk
baroness.sprite_credits = sprite_credits

baroness:clear_callbacks()
baroness:onInit(function(actor)
	actor.sprite_idle_half		= Array.new({sprite_idle,		sprite_idle_half, 0})
	actor.sprite_walk_half		= Array.new({sprite_walk,		sprite_walk_half, 0, sprite_walk_back})
	actor.sprite_jump_half		= Array.new({sprite_jump,		sprite_jump_half, 0})
	actor.sprite_jump_peak_half	= Array.new({sprite_jump_peak,	sprite_jump_peak_half, 0})
	actor.sprite_fall_half		= Array.new({sprite_fall,		sprite_fall_half, 0})
	
	actor.sprite_idle2 = sprite_idle2
	actor.sprite_walk2 = sprite_walk2
	actor.sprite_jump2 = sprite_jump2
	actor.sprite_jump_peak2 = sprite_jump_peak2
	actor.sprite_fall2 = sprite_fall2
	actor.sprite_shoot1b = sprite_shoot1b
	actor.sprite_shoot2b = sprite_shoot2b
	actor.sprite_shoot3a = sprite_shoot3a
	actor.sprite_shoot3a_stationary = sprite_shoot3a_stationary
	actor.sprite_dismount_jump = sprite_dismount_jump
	actor.sprite_shoot3b = sprite_shoot3b
	actor.sprite_shoot3b_stationary = sprite_shoot3b_stationary
	actor.sprite_shoot4b = sprite_shoot4b
	
	actor.vehicle = false
	actor:get_data().baroness_bike_strafing = 0
	actor:get_data().baroness_beam_used = 0
	actor:get_data().baroness_beam_damage = 0
	actor:get_data().baroness_beam_damage_reset = 120
	actor:get_data().baroness_beam_x = 0

	actor:survivor_util_init_half_sprites()
end)

local trigger = baroness:get_primary()
local beam = Skill.new(NAMESPACE, "baronessFocusingBeam")
local steady = baroness:get_secondary()
local relocation = baroness:get_utility()
local relocation2 = Skill.new(NAMESPACE, "baronessFaceToFace")
local nade = baroness:get_special()
local nade2 = Skill.new(NAMESPACE, "baronessVBoosted")

local shock = Particle.new(NAMESPACE, "BaronessShock")
shock:set_shape(Particle.SHAPE.disk)
shock:set_color1(Color(0x61c3cd))
shock:set_alpha2(0.75, 0)
shock:set_size(0.09, 0.16, -0.015, 0)
shock:set_speed(0, 0.6, -0.002, 0)
shock:set_direction(0, 360, 0, 50)
shock:set_life(3, 8)

local bike_speed = Buff.new(NAMESPACE, "baronessBikeSpeed")
bike_speed.show_icon = false
bike_speed.is_timed = false
bike_speed:clear_callbacks()

bike_speed:onPostStep(function(actor, stack)
	actor.mask_index = sprite_vehicle_mask
	actor.can_rope = false
	actor.walk_speed_coeff = 0.4
end)

bike_speed:onPostStatRecalc(function(actor, stack)
	if actor.pHmax + 3.4 < actor.pHmax * 1.75 then
		actor.pHmax = actor.pHmax * 1.75
	else
		actor.pHmax = actor.pHmax + 3.4
	end
	
	actor.pVmax = actor.pVmax + 3
end)

bike_speed:onRemove(function(actor, stack)
	actor.mask_index = gm.constants.sPMask
	actor.can_rope = true
	actor.walk_speed_coeff = 1
end)

Callback.add(Callback.TYPE.onDraw, "BaronessBeamVisual", function()
	for _, actor in ipairs(Instance.find_all(Object.find("ror-P"))) do
		if actor:get_data().baroness_beam_used > 0 and actor:get_data().baroness_beam_x > 0 then
			local col = gm.merge_colour(Color.RED, Color.WHITE, actor:get_data().baroness_beam_used / 2)
			gm.draw_set_colour(col)
			gm.draw_set_alpha(actor:get_data().baroness_beam_used)
			gm.draw_line_width(actor.x + 19 * actor.image_xscale, actor.y - 2, actor:get_data().baroness_beam_x, actor.y - 2, 2)
			gm.draw_set_colour(Color.WHITE)
			gm.draw_set_alpha(1)
		end
	end
end)

baroness:onStep(function(actor)
	if actor.vehicle == true then
		if actor:buff_stack_count(bike_speed) == 0 then
			actor:buff_apply(bike_speed, 60)
		end
		
		if Global._current_frame % 30 == 0 then
			actor:sound_play(sound_skill3c, math.min(math.abs(actor.pHspeed / 2) * 0.13, 0.6), 1 + math.random() * 0.2)
		end
		
		if gm.bool(actor.moveUp) then
			if not actor.free then
				actor.vehicle = false
				
				if actor:get_skill(Skill.SLOT.utility).value == relocation2.value then
					actor:remove_skill_override(Skill.SLOT.utility, relocation2)
				end
		
				if actor:get_skill(Skill.SLOT.primary).value == beam.value then
					actor:remove_skill_override(Skill.SLOT.primary, beam)
				end
				
				actor:sound_play(sound_skill3b, 1, 1 + math.random() * 0.2)
				
				local effect = GM.instance_create(actor.x, actor.y, gm.constants.oEfExplosion)
				effect.sprite_index = actor.sprite_dismount_jump
				effect.image_yscale = 1
				effect.image_xscale = actor.image_xscale
			else
				actor.moveUpHold = 0
				actor.moveUp_buffered = 0
				actor.moveUp = 0
			end
		end
		
		if actor:get_skill(Skill.SLOT.utility).value == relocation2.value then
			actor:freeze_default_skill(Skill.SLOT.utility)
		end
		
		actor.sprite_idle = actor.sprite_idle2
		actor.sprite_walk = actor.sprite_walk2
		actor.sprite_jump = actor.sprite_jump2
		actor.sprite_jump_peak = actor.sprite_jump_peak2
		actor.sprite_fall = actor.sprite_fall2
		actor.sprite_walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk_back2})
		baroness:set_cape_offset(0, -14, 0, -5)
		
		if (gm.bool(actor.moveLeft) or gm.bool(actor.moveRight)) and not actor.free and actor.image_index ~= actor.sprite_shoot3a then
			shock:create(actor.x - 20 * actor.image_xscale, actor.y + math.random(1, 4), 2, Particle.SYSTEM.middle)
		end
	else
		if actor:buff_stack_count(bike_speed) > 0 then
			actor:buff_remove(bike_speed) 
		end
		
		actor.sprite_idle = sprite_idle
		actor.sprite_walk = sprite_walk
		actor.sprite_jump = sprite_jump
		actor.sprite_jump_peak = sprite_jump_peak
		actor.sprite_fall = sprite_fall
		actor.sprite_walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk_back})
		baroness:set_cape_offset(0, -8, 0, -5)
	end
	
	if actor:get_data().baroness_beam_used > 0 then
		actor:get_data().baroness_beam_used = math.max(actor:get_data().baroness_beam_used - 0.1, 0)
		actor:get_data().baroness_beam_damage_reset = 120
	else
		actor:get_data().baroness_beam_damage_reset = actor:get_data().baroness_beam_damage_reset - 1
	end
	
	if actor:get_data().baroness_beam_damage_reset <= 0 then
		actor:get_data().baroness_beam_damage = 0
	end
end)

local shocked = Buff.new(NAMESPACE, "baronessShocked")
shocked.is_debuff = true
shocked.show_icon = false
shocked:clear_callbacks()

shocked:onPostStep(function(actor, stack)
	local parent = actor:get_data().baroness_shock_parent
	
	actor:alarm_set(7, 60)
	actor:alarm_set(2, 100)
	actor.pVspeed = parent.pVspeed
	
	local xx, yy = move_point_contact_solid(parent.x, parent.y, parent:skill_util_facing_direction(), 150)
	
	actor.x = gm.lerp(actor.x, xx, 0.2)
	actor.ghost_x = actor.x
	actor.y = parent.bbox_bottom - (actor.bbox_bottom - actor.y) - 4
	actor.ghost_y = actor.y
	
	if gm.actor_state_is_climb_state(parent.actor_state_current_id) then
		actor:buff_remove(shocked)
	end
end)

shocked:onPostDraw(function(actor, stack)
	local size = ((actor.bbox_bottom - actor.bbox_top) + (actor.bbox_right - actor.bbox_left)) / 2
	
	for i = 1, 6 do
		local aa = (math.random(0, 360000) / 1000)
		local xx = math.cos(aa) * size
		local yy = math.sin(aa) * size
		shock:create(actor.x + xx + 1, actor.y + yy + 1)
	end
	
	gm.draw_set_alpha(0.75)
	gm.draw_set_colour(Color(0x61c3cd))
	gm.draw_circle(actor.x, actor.y, size, true)
	gm.draw_set_alpha(1)
	gm.draw_set_colour(Color.WHITE)
end)

shocked:onRemove(function(actor, stack)
	actor.activity = 0
	actor:sound_play(sound_skill2b, 1, 1 + math.random() * 0.2)
	actor:get_data().baroness_shock_parent = nil
	actor:skill_util_reset_activity_state()
	
	local n = 0
	while actor:is_colliding(gm.constants.pBlock, actor.x, actor.y) and n < 200 do
		if not actor:is_colliding(gm.constants.pBlock, actor.x + 5, actor.y) then
			actor.x = actor.x + 5
		elseif not actor:is_colliding(gm.constants.pBlock, actor.x - 5, actor.y) then
			actor.x = actor.x - 5
		else
			actor.y = actor.y - 1
			n = n + 1
		end
	end
	
	actor:apply_stun(1, -actor.image_xscale, 0.5)
end)

local grenade = Object.new(NAMESPACE, "baronessGrenade")
grenade.obj_depth = -9
grenade.obj_sprite = sprite_nade
grenade:clear_callbacks()

grenade:onCreate(function(self)
	self.life = 150
	self.scepter = 0
	self.shadow_buff = 0
	self.attack_speed_mult = 1
	self.yaccel = 0
	self.xaccel = 0
	self.team = 1
	self.image_blend = Color.RED
	
	self:sound_play(sound_skill4c, 1, 1.5 + math.random() * 0.07)
end)

grenade:onStep(function(self)
	if self.life > 0 then
		if self.life % 70 == 0 then
			local circle = GM.instance_create(self.x, self.y, gm.constants.oEfCircle)
			circle.parent = self
			circle.radius = -10
			circle.image_blend = self.image_blend
			self:sound_play(sound_nade, 1, 0.9 + math.random() * 0.2)
		end
		
		if self.stuck and Instance.exists(self.stuck) then
			self.x = self.stuck.x
			self.y = self.stuck.y
		else
			self.yaccel = self.yaccel + 0.1
			
			for i = 1, math.abs(self.yaccel * 10) do
				local newy = self.y + gm.sign(self.yaccel) * 0.2
				if self:is_colliding(gm.constants.pBlock, self.x, newy) then
					if gm.sign(self.yaccel) > 0 then
						self.xaccel = approach(self.xaccel, 0, 0.4)
					end
					self.yaccel = self.yaccel * -0.6
					break
				else
					self.y = newy
				end				
			end
			
			self.xaccel = approach(self.xaccel, 0, 0.015)
			for i = 1, math.abs(self.xaccel) * 10 do
				local newx = self.x + gm.sign(self.xaccel) * 0.2
				if self:is_colliding(gm.constants.pBlock, newx, self.y) then
					self.xaccel = self.xaccel * -0.8
					break
				else
					self.x = newx
				end				
			end
			
			if self.life < 140 then
				local victims = List.new()
				self:collision_circle_list(self.x, self.y, 80, gm.constants.pActorCollisionBase, false, true, victims, false)
				for _, victim in ipairs(victims) do
					if victim.team ~= self.team then
						self.stuck = victim
						self.travel = 40
						self.travelx = self.x
						self.travely = self.y
						self.travelx2 = victim.x
						self.travely2 = victim.y
						self.yaccel = -2
						self.xaccel = 0
						break
					end
				end
				victims:destroy()
			end
		end
		
		if self.travel and self.travel > 0 then
			self.travel = self.travel - 1
		end
		
		local last_life = self.life
		self.life = self.life - self.attack_speed_mult
		
		local explosions = 3 + self.scepter * 2
		for i = 1, explosions do
			local ii = (i - 1) * 20
			if self.life <= ii and last_life > ii then
				if self.parent and Instance.exists(self.parent) then
					if self.parent:is_authority() then
						if self.scepter > 0 then
							attack = self.parent:fire_explosion(self.x, self.y, 30, 30, self.parent:skill_get_damage(nade), sprite_sparks5, gm.constants.sSparks6)
							attack.attack_info.knockback = 6
						else
							attack = self.parent:fire_explosion(self.x, self.y, 30, 30, self.parent:skill_get_damage(nade), sprite_sparks4, gm.constants.sSparks5)
							attack.attack_info.knockback = 6
						end
					end
					self:screen_shake(5)
					self:sound_play(sound_skill4b, 0.7, 2 + math.random() * 0.08)
				end
				break
			end
		end
		if self.life < 120 then
			local pixeldust = Particle.find("ror-PixelDust")
			pixeldust:create_color(self.x, self.y, self.image_blend, 1, Particle.SYSTEM.middle)
		end
	else
		self:destroy()
	end
end)

grenade:onDraw(function(self)
	if self.travel then
		local mult = self.travel / 40
		gm.draw_set_alpha(mult)
		gm.draw_set_colour(self.image_blend)
		gm.draw_line_width(self.travelx, self.travely, self.travelx2, self.travely2, mult * 4)
		gm.draw_set_alpha(1)
		gm.draw_set_colour(Color.WHITE)
	end
end)

-- pulling the trigger
trigger:set_skill_icon(sprite_skills, 0)
trigger.cooldown = 5
trigger.damage = 0.95
trigger.require_key_press = false
trigger.hold_facing_direction = true
trigger.is_primary = true
trigger.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local sttrigger = State.new(NAMESPACE, "baronessPullingTheTrigger")

trigger:clear_callbacks()
trigger:onActivate(function(actor)
	actor:enter_state(sttrigger)
end)

sttrigger:clear_callbacks()
sttrigger:onEnter(function(actor, data)
	data.fired = 0
	
	if actor.vehicle == false then
		actor.image_index2 = 0
		actor:skill_util_strafe_init()
		actor:skill_util_strafe_turn_init()
	else
		actor.image_index = 0
		actor:skill_util_strafe_and_slide_init()
	end
end)

sttrigger:onStep(function(actor, data)
	actor.sprite_index2 = sprite_shoot1a
	
	if actor.vehicle then
		actor:skill_util_strafe_and_slide(0.7)
		actor:actor_animation_set(actor.sprite_shoot1a, 0.21)
	else
		-- first arg: speed for attack animation, in sprite frames per game frame
		-- second arg: multiplier for movement speed while strafing
		actor:skill_util_strafe_update(0.21 * actor.attack_speed, 0.5)
		actor:skill_util_step_strafe_sprites()
		actor:skill_util_strafe_turn_update()
	end
	
	if not actor.vehicle then
		-- adjust vertical offset so the upper body bobs up and down depending on the leg animation
		if actor.sprite_index == actor.sprite_walk_half[2] then
			local walk_offset = 0
			local leg_frame = math.floor(actor.image_index)
			if leg_frame == 0 or leg_frame == 4 then
				walk_offset = 1
			end
			actor.ydisp = walk_offset -- ydisp controls upper body offset
		end
	end
	
	local fire = (actor.image_index >= 1 and data.fired == 0)
	if not actor.vehicle then
		fire = (actor.image_index2 >= 1 and data.fired == 0)
	end
	
	if fire then
		data.fired = 1

		actor:sound_play(sound_skill1a, 0.93, 1 + math.random() * 0.07)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(trigger)
			local dir = actor:skill_util_facing_direction()

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				for i=0, actor:buff_stack_count(Buff.find("ror", "shadowClone")) do
					local attack = actor:fire_bullet(actor.x, actor.y, 960, dir, damage, nil, sprite_sparks, Attack_Info.TRACER.commando1)
					attack.attack_info.climb = i * 8
				end
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

sttrigger:onExit(function(actor, data)
	if actor.vehicle == false then
		actor:skill_util_strafe_exit()
	end
end)

sttrigger:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 2 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

-- focusing beam
beam:set_skill_icon(sprite_skills, 5)
beam.cooldown = 6
beam.require_key_press = false
beam.hold_facing_direction = true
beam.is_primary = true
beam.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stbeam = State.new(NAMESPACE, "baronessFocusingBeam")

beam:clear_callbacks()
beam:onActivate(function(actor)
	actor:enter_state(stbeam)
end)

stbeam:clear_callbacks()
stbeam:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.fire_frame = 0
	
	if data.proc == nil then
		data.proc = 1
	end
	
	actor:skill_util_strafe_and_slide_init()
end)

stbeam:onStep(function(actor, data)
	actor:actor_animation_set(sprite_shoot1b, 0.3, false)

	local victims = List.new()
	
	actor:collision_line_list(actor.x, actor.y, actor.x + 400 * actor.image_xscale, actor.y, gm.constants.pActorCollisionBase, false, true, victims, true)
	target = nil
	target_block = nil
		
	for _, victim in ipairs(victims) do
		if victim.team ~= actor.team then
			target = victim
		end
	end
	victims:destroy()
	
	local blocks = List.new()
	actor:collision_line_list(actor.x, actor.y, actor.x + 400 * actor.image_xscale, actor.y, gm.constants.pBlock, false, true, blocks, true)
		
	for _, block in ipairs(blocks) do
		target_block = block
		break
	end
	blocks:destroy()
		
	if target then
		actor:skill_util_strafe_and_slide(0.7)
		
		if actor.image_index >= data.fire_frame and data.fired == 0 then
		
			data.fire_frame = math.min(2, data.fire_frame + 1)
			
			if data.fire_frame >= 2 then
				data.fired = 1
			end
		
			actor:sound_play(sound_skill1b, 1, 1 + math.random() * 0.07)
				
			if actor:is_authority() then
				local damage = math.min(0.05 + (0.04 * actor:get_data().baroness_beam_damage), 2)
				local dir = actor:skill_util_facing_direction()
				
				if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
					for i=0, actor:buff_stack_count(Buff.find("ror", "shadowClone")) do
						local attack = actor:fire_bullet(actor.x, actor.y, 400, dir, damage, 2 / 3, nil)
						attack.attack_info.climb = i * 8
						attack.attack_info.proc = gm.bool(data.proc)
					end
				end
			end
			
			if data.proc == 1 then
				data.proc = 0
			else
				data.proc = 1
			end
			
			actor:get_data().baroness_beam_x = target.x
				
			local victims = List.new()
			actor:collision_line_list(actor.x, actor.y, actor.x + 400 * actor.image_xscale, actor.y, gm.constants.pActorCollisionBase, false, true, victims, true)
					
			for _, victim in ipairs(victims) do
				if victim.team ~= actor.team and math.abs(actor.x - victim.x) <= math.abs(actor.x - target.x) then
					local effect = GM.instance_create(victim.x, actor.y, gm.constants.oEfExplosion)
					effect.sprite_index = sprite_sparks2
					effect.image_yscale = 1
					effect.image_xscale = actor.image_xscale
				end
			end
			victims:destroy()
			
			local increase = 0.4
			
			if actor:get_data().baroness_shock_victim and Instance.exists(actor:get_data().baroness_shock_victim) then
				if actor:get_data().baroness_shock_victim:get_data().baroness_shock_parent then
					increase = 0.9
				end
			end
			
			actor:get_data().baroness_beam_damage = actor:get_data().baroness_beam_damage + ((increase + 0.1 * actor.attack_speed) / 6)
				
			if target_block ~= nil then
				actor:collision_line_advanced(actor.x, actor.y, actor.x + 400 * actor.image_xscale, actor.y, gm.constants.pBlock, true, true)
				actor:get_data().baroness_beam_x = gm.variable_global_get("collision_x")
				
				local effect = GM.instance_create(actor:get_data().baroness_beam_x, actor.y, gm.constants.oEfExplosion)
				effect.sprite_index = sprite_sparks2
				effect.image_yscale = 1
				effect.image_xscale = actor.image_xscale
			end
			
			actor:get_data().baroness_beam_used = 2
		end
	else
		actor:skill_util_strafe_and_slide(1)
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

-- steady target
steady:set_skill_icon(sprite_skills, 1)
steady.cooldown = 6 * 60
steady.damage = 1
steady.require_key_press = true
steady.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local ststeady = State.new(NAMESPACE, "baronessSteadyTarget")

steady:clear_callbacks()
steady:onActivate(function(actor)
	actor:enter_state(ststeady)
end)

ststeady:clear_callbacks()
ststeady:onEnter(function(actor, data)
	actor.image_index = 0

	data.fired = 0
	
	if actor.vehicle then
		actor:skill_util_strafe_and_slide_init()
	end
end)

ststeady:onStep(function(actor, data)
	if actor.vehicle then
		actor:skill_util_strafe_and_slide(1)
		actor:actor_animation_set(actor.sprite_shoot2b, 0.25)
	else
		actor:skill_util_fix_hspeed()
		actor:actor_animation_set(sprite_shoot2a, 0.25)
	end
	
	if actor.image_index >= 3 and data.fired == 0 then
		data.fired = 1
		
		actor:sound_play(sound_skill2a, 1, 1 + math.random() * 0.2)
		
		local victims = List.new()
		actor:collision_rectangle_list(actor.x, actor.y - 16, actor.x + 400 * actor.image_xscale, actor.y + 16, gm.constants.pActor, false, true, victims, false)
		target = nil
		
		for _, victim in ipairs(victims) do
			if victim.team ~= actor.team and not GM.actor_is_boss(victim) then
				if target == nil then
					target = victim
				else
					if victim.hp > target.hp then
						target = victim
					end
				end
			end
		end
		victims:destroy()
		
		if target then
			if actor:get_data().baroness_shock_victim and Instance.exists(actor:get_data().baroness_shock_victim) then
				if actor:get_data().baroness_shock_victim:get_data().baroness_shock_parent then
					if actor:get_data().baroness_shock_victim:get_data().baroness_shock_parent.value == actor.value then
						actor:get_data().baroness_shock_victim:buff_remove(shocked)
					end
				end
			end
			
			if actor:is_authority() then
				local damage = actor:skill_get_damage(steady)

				for i=0, actor:buff_stack_count(Buff.find("ror", "shadowClone")) do
					local attack = actor:fire_direct(target, damage)
					attack.attack_info.climb = i * 8
				end
			end
			
			actor:get_data().baroness_shock_victim = target
			target:get_data().baroness_shock_parent = actor
			target.activity = 52
			target:apply_stun(1, actor.image_xscale, 0.5)
			target:buff_apply(shocked, 4 * 60)
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

ststeady:onGetInterruptPriority(function(actor, data)
	if actor.image_index >= 4 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	end
end)

-- active relocation
relocation:set_skill_icon(sprite_skills, 2)
relocation.cooldown = 5 * 60
relocation.override_strafe_direction = true
relocation.ignore_aim_direction = true
relocation.is_utility = true

local stbike = State.new(NAMESPACE, "baronessActiveRelocation")

relocation:clear_callbacks()
relocation:onActivate(function(actor)
	actor:enter_state(stbike)
end)

stbike:clear_callbacks()
stbike:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	
	if actor:get_skill(Skill.SLOT.utility).value ~= relocation2.value then
		actor:add_skill_override(Skill.SLOT.utility, relocation2)
	end
	
	if actor:get_skill(Skill.SLOT.primary).value ~= beam.value then
		actor:add_skill_override(Skill.SLOT.primary, beam)
	end
	
	actor.vehicle = true
end)

stbike:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	
	if (not gm.bool(actor.moveLeft) and not gm.bool(actor.moveRight)) or (gm.bool(actor.moveLeft) and gm.bool(actor.moveRight)) then
		actor:actor_animation_set(actor.sprite_shoot3a_stationary, 0.2, false)
	else
		actor:actor_animation_set(actor.sprite_shoot3a, 0.2, false)
		actor.pHspeed = actor.pHmax * actor.image_xscale
	end
	
	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_skill3a, 1, 1 + math.random() * 0.2)
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

-- face to face
relocation2:set_skill_icon(sprite_skills, 4)
relocation2.cooldown = 60
relocation2.override_strafe_direction = true
relocation2.ignore_aim_direction = true
relocation2.is_utility = true

local stbike2 = State.new(NAMESPACE, "baronessActiveRelocation2")
stbike2.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

relocation2:clear_callbacks()
relocation2:onActivate(function(actor)
	actor:enter_state(stbike2)
end)

stbike2:clear_callbacks()
stbike2:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	
	if actor:get_skill(Skill.SLOT.utility).value == relocation2.value then
		actor:remove_skill_override(Skill.SLOT.utility, relocation2)
	end
	
	if actor:get_skill(Skill.SLOT.primary).value == beam.value then
		actor:remove_skill_override(Skill.SLOT.primary, beam)
	end
	
	actor.vehicle = false
end)

stbike2:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	
	if (not gm.bool(actor.moveLeft) and not gm.bool(actor.moveRight)) or (gm.bool(actor.moveLeft) and gm.bool(actor.moveRight)) then
		actor:actor_animation_set(actor.sprite_shoot3b_stationary, 0.25, false)
	else
		actor:actor_animation_set(actor.sprite_shoot3b, 0.25, false)
		actor.pHspeed = actor.pHmax * actor.image_xscale
	end
	
	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_skill3b, 1, 1 + math.random() * 0.2)
	end
	actor:skill_util_exit_state_on_anim_end()
end)

-- saturated o charge
nade:set_skill_icon(sprite_skills, 3)
nade.cooldown = 8 * 60
nade.damage = 3.2

local stnade = State.new(NAMESPACE, "baronessSaturatedOCharge")

nade:clear_callbacks()
nade:onActivate(function(actor)
	actor:enter_state(stnade)
end)

-- bursting o charge
nade2:set_skill_icon(sprite_skills, 6)
nade2.cooldown = 8 * 60
nade2.damage = 3.2
nade:set_skill_upgrade(nade2)

nade2:clear_callbacks()
nade2:onActivate(function(actor)
	actor:enter_state(stnade)
end)

stnade:clear_callbacks()
stnade:onEnter(function(actor, data)
	actor.image_index = 0

	data.fired = 0
	
	if actor.vehicle then
		actor:skill_util_strafe_and_slide_init()
	end
end)

stnade:onStep(function(actor, data)
	if actor.vehicle then
		actor:skill_util_strafe_and_slide(1)
		actor:actor_animation_set(actor.sprite_shoot4b, 0.25)
	else
		actor:skill_util_fix_hspeed()
		actor:actor_animation_set(sprite_shoot4a, 0.25)
	end
	
	if actor.image_index >= 5 and data.fired == 0 then
		data.fired = 1
		
		for i=0, actor:buff_stack_count(Buff.find("ror", "shadowClone")) do
			local inst = grenade:create(actor.x, actor.y)
			inst.xaccel = actor.image_xscale * (4 + (math.min(1, actor:buff_stack_count(Buff.find("ror", "shadowClone"))) * math.random(-1, 1) / 2))
			inst.yaccel = -3 + (math.min(1, actor:buff_stack_count(Buff.find("ror", "shadowClone"))) * math.random(-1, 1) / 2)
			inst.attack_speed_mult = math.min(actor.attack_speed, 3)
			inst.shadow_buff = actor:buff_stack_count(Buff.find("ror", "shadowClone"))
			inst.scepter = math.min(1, actor:item_stack_count(Item.find("ror", "ancientScepter")))
			inst.team = actor.team
			inst.parent = actor
			if inst.scepter > 0 then
				inst.image_blend = Color.YELLOW
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)