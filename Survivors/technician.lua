local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Technician")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Executioner")

local buff_mirror = Buff.find("ror", "shadowClone")
local item_scepter = Item.find("ror", "ancientScepter")

-- assets.
local sprite_loadout		= Resources.sprite_load(NAMESPACE, "TechnicianSelect", path.combine(SPRITE_PATH, "select.png"), 1, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "TechnicianPortrait", path.combine(SPRITE_PATH, "portrait.png"), 2)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "TechnicianSkills", path.combine(SPRITE_PATH, "skills.png"), 9)

local sprite_idle			= Resources.sprite_load(NAMESPACE, "TechnicianIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 8, 12)
local sprite_idle_half		= Resources.sprite_load(NAMESPACE, "TechnicianIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 12, 17)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "TechnicianWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 10, 14)
local sprite_walk_half		= Resources.sprite_load(NAMESPACE, "TechnicianWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 14, 18)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "TechnicianWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 14, 18)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "TechnicianJump", path.combine(SPRITE_PATH, "jump.png"), 1, 12, 15)
local sprite_jump_half		= Resources.sprite_load(NAMESPACE, "TechnicianJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 12, 15)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "TechnicianJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 12, 14)
local sprite_jump_peak_half	= Resources.sprite_load(NAMESPACE, "TechnicianJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 12, 14)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "TechnicianFall", path.combine(SPRITE_PATH, "fall.png"), 1, 12, 13)
local sprite_fall_half		= Resources.sprite_load(NAMESPACE, "TechnicianFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 12, 13)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "TechnicianClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 18)
local sprite_death			= Resources.sprite_load(NAMESPACE, "TechnicianDeath", path.combine(SPRITE_PATH, "death.png"), 5, 14, 8)
local sprite_decoy			= Resources.sprite_load(NAMESPACE, "TechnicianDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 17, 16)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "TechnicianShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 5, 12, 24)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "TechnicianShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 5, 12, 24)
local sprite_shoot1_half	= Resources.sprite_load(NAMESPACE, "TechnicianShoot1Half", path.combine(SPRITE_PATH, "shoot1Half.png"), 5, 10, 17)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "TechnicianShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 6, 12, 25)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "TechnicianShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 6, 12, 25)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "TechnicianShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 8, 44, 40)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "TechnicianShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 6, 8, 14)
local sprite_shoot5			= Resources.sprite_load(NAMESPACE, "TechnicianShoot4S", path.combine(SPRITE_PATH, "shoot5.png"), 22, 39, 63)

local sprite_sparks2		= Resources.sprite_load(NAMESPACE, "TechnicianSparks", path.combine(SPRITE_PATH, "sparks2.png"), 4, 24, 14)
local sprite_tracer2		= Resources.sprite_load(NAMESPACE, "TechnicianIonTracer", path.combine(SPRITE_PATH, "tracer2.png"), 5, 0, 2)

local sprite_turretaI		= Resources.sprite_load(NAMESPACE, "TechnicianTurretaIdle", path.combine(SPRITE_PATH, "turreta.png"), 2, 14, 14)
local sprite_turretashoot	= Resources.sprite_load(NAMESPACE, "TechnicianTurretaShoot", path.combine(SPRITE_PATH, "turretashoot.png"), 4, 14, 14)
local sprite_turretexplosion= Resources.sprite_load(NAMESPACE, "TechnicianTurretExplosion", path.combine(SPRITE_PATH, "turretexplosion.png"), 4, 20, 20)
local sprite_turretsparks	= Resources.sprite_load(NAMESPACE, "TechnicianTurretSparks", path.combine(SPRITE_PATH, "turretsparks.png"), 3, 26, 16)

local sprite_turretbI		= Resources.sprite_load(NAMESPACE, "TechnicianTurretbIdle", path.combine(SPRITE_PATH, "turretb.png"), 2, 16, 18)
local sprite_turretbshoot	= Resources.sprite_load(NAMESPACE, "TechnicianTurretbshoot", path.combine(SPRITE_PATH, "turretbshoot.png"), 4, 18, 18)

local sprite_turretcI		= Resources.sprite_load(NAMESPACE, "TechnicianTurretcIdle", path.combine(SPRITE_PATH, "turretc.png"), 2, 16, 18)
local sprite_turretcshoot	= Resources.sprite_load(NAMESPACE, "TechnicianTurretcshoot", path.combine(SPRITE_PATH, "turretcshoot.png"), 4, 18, 18)

local sound_shoot1			= Resources.sfx_load(NAMESPACE, "TechnicianShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2			= Resources.sfx_load(NAMESPACE, "TechnicianShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3			= Resources.sfx_load(NAMESPACE, "TechnicianShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a			= Resources.sfx_load(NAMESPACE, "TechnicianShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b			= Resources.sfx_load(NAMESPACE, "TechnicianShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))

-- His only friends are machines
local technician = Survivor.new(NAMESPACE, "technician")
local technician_id = technician.value

technician:set_stats_base({
	maxhp = 95,
	damage = 14,
	regen = 0.008,
})
technician:set_stats_level({
	maxhp = 24,
	damage = 3,
	regen = 0.0012,
	armor = 2,
})

technician:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump_peak,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy,
})

technician:set_cape_offset(0, -8, 0, -12)
technician:set_primary_color(Color.from_rgb(175, 113, 126))

technician.sprite_loadout = sprite_loadout
technician.sprite_portrait = sprite_portrait
technician.sprite_portrait_small = sprite_portrait_small
technician.sprite_title = sprite_walk

technician:clear_callbacks()
technician:onInit(function(actor)
	-- setup half-sprite nonsense
	local idle_half = Array.new()
	local walk_half = Array.new()
	local jump_half = Array.new()
	local jump_peak_half = Array.new()
	local fall_half = Array.new()
	idle_half:push(sprite_idle, sprite_idle_half, 0)
	walk_half:push(sprite_walk, sprite_walk_half, 0, sprite_walk_back)
	jump_half:push(sprite_jump, sprite_jump_half, 0)
	jump_peak_half:push(sprite_jump_peak, sprite_jump_peak_half, 0)
	fall_half:push(sprite_fall, sprite_fall_half, 0)

	actor.sprite_idle_half = idle_half
	actor.sprite_walk_half = walk_half
	actor.sprite_jump_half = jump_half
	actor.sprite_jump_peak_half = jump_peak_half
	actor.sprite_fall_half = fall_half

	actor:survivor_util_init_half_sprites()
end)

local technicianPrimary = technician:get_primary()
local technicianSecondary = technician:get_secondary()
local technicianUtility = technician:get_utility()
local technicianSpecial = technician:get_special()

-- machines
local obj_turret = Object.new(NAMESPACE, "turret")
obj_turret:set_sprite(sprite_turretaI)
obj_turret:set_depth(1)
obj_turret:onCreate(function(inst)
	local data = inst:get_data()
	data.idle = sprite_turretaI
	data.shoot = sprite_turretashoot
	data.init = nil
	data.hits_taken = 0
	inst.image_speed = 0.2
	data.cooldown = 0
	data.basecooldown = 50
	data.damage = technicianSpecial.damage
	data.upgradeState = 0
end)
obj_turret:onStep(function(inst)
	local data = inst:get_data()
	if data.parent then
		-- print("TRY AGAIN!")
		data.scepter = data.parent:item_stack_count(item_scepter)
		if not data.init then
			local xx,_ = move_point_contact_solid(inst.x, inst.y, 90 - 90 * inst.image_xscale)
			data.range = math.min(math.abs(xx - inst.x), 1000)
			print(data.range)
			data.init = 1
			print("xx "..(xx).." inst.x "..(inst.x))
		end
		if data.hits_taken >= 3 and data.upgradeState <= 0 then
			data.idle = sprite_turretbI
			data.shoot = sprite_turretbshoot
			data.basecooldown = 12
			data.damage = 0.7
			data.upgradeState = 1
			data.cooldown = math.min(data.cooldown, data.basecooldown)
		end
		if data.hits_taken >= 6 and data.upgradeState <= 1 and data.scepter > 0 then
			data.idle = sprite_turretcI
			data.shoot = sprite_turretcshoot
			data.upgradeState = 2
			data.basecooldown = 8
			data.cooldown = math.min(data.cooldown, data.basecooldown)
		end
		local victims = List.new()
		inst:collision_line_list(inst.x, inst.y, inst.x + data.range * inst.image_xscale, inst.y, gm.constants.pActor, false, true, victims, false)
		local wantattack = false
		for _, victim in ipairs(victims) do
			if victim.team ~= data.team then
				wantattack = true
				break
			end
		end
		data.cooldown = data.cooldown - 1
		if data.playanim then
			inst.sprite_index = data.shoot
			if inst.image_index >= gm.sprite_get_number(data.shoot) - 1 then
				data.playanim = nil
			end
		else
			inst.sprite_index = data.idle
		end
		if wantattack then
			if data.cooldown <= 0 then
				data.playanim = 1
				inst.image_index = 0
				data.cooldown = data.basecooldown
				for i = 0, data.parent:buff_stack_count(buff_mirror) do
					local attack = data.parent:fire_bullet(inst.x, inst.y, 1000, 90 - 90 * inst.image_xscale, data.damage, nil, sprite_turretsparks, Attack_Info.TRACER.commando1)
					attack.climb = i * 8
				end
			end
		end
	else
		inst:destroy()
	end
end)

local machines = {obj_turret}

-- Wrench Whack
technicianPrimary.sprite = sprite_skills
technicianPrimary.subimage = 0

technicianPrimary.cooldown = 5
technicianPrimary.damage = 1.0
technicianPrimary.require_key_press = false
technicianPrimary.is_primary = true
technicianPrimary.does_change_activity_state = true
technicianPrimary.hold_facing_direction = true
technicianPrimary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateTechnicianPrimary = State.new(NAMESPACE, "technicianPrimary")

technicianPrimary:clear_callbacks()
technicianPrimary:onActivate(function(actor)
	actor:enter_state(stateTechnicianPrimary)
end)

stateTechnicianPrimary:clear_callbacks()
stateTechnicianPrimary:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.fired = 0 -- gamemaker bools are a pain to deal with in lua, so just use numbers instead
	data.currentAnim = ((data.currentAnim or 1) + 1) % 2
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

local primaryOffset = get_tiles(0.6)
local primaryWidth = get_tiles(1.2)
local primaryHeight = get_tiles(0.7)
stateTechnicianPrimary:onStep(function(actor, data)
	actor.sprite_index2 = (data.currentAnim == 1 and sprite_shoot1_2 or sprite_shoot1_1)

	actor:skill_util_strafe_update(0.2 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	-- adjust vertical offset so the upper body bobs up and down depending on the leg animation
	if actor.sprite_index == actor.sprite_walk_half[2] then
		local walk_offset = 0
		local leg_frame = math.floor(actor.image_index)
		if leg_frame == 1 or leg_frame == 5 then
			walk_offset = 1
		elseif leg_frame == 3 or leg_frame == 7 then
			walk_offset = -1
		end
		actor.ydisp = walk_offset -- ydisp controls upper body offset
	end

	if data.fired == 0 and actor.image_index >= 1 then
		data.fired = 1

		actor:sound_play(sound_shoot1, 1, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(technicianPrimary)
			local dir = actor:skill_util_facing_direction()

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				for i=0, actor:buff_stack_count(buff_mirror) do
					local attack = actor:fire_explosion(actor.x + primaryOffset * actor.image_xscale, actor.y, primaryWidth, primaryHeight, actor:skill_get_damage(technicianPrimary))
					local attackinfo = attack.attack_info
					attackinfo.climb = i * 8
					--[[ local machinesHit = List.new()
					for _, machineType in ipairs(machines) do
						actor:collision_rectangle_list(actor.x + (primaryOffset - primaryWidth / 2) * actor.image_xscale, actor.y - primaryHeight / 2, actor.x + (primaryOffset + primaryWidth / 2) * actor.image_xscale, actor.y + primaryHeight / 2, machineType, false, true, machinesHit, false)
					-- ^ finding all machines in machines table that collides with the explosion to upgrade 
					end
					print(" Machines ")
					print(tableToString(machines))
					print(" Machines Hit ")
					print(tableToString(machinesHit)) ]]
					for _, machineInst in ipairs(Instance.find_all(machines)) do
						local xDelta = machineInst.x - actor.x
						if xDelta <= (primaryOffset + primaryWidth / 2) and math.abs(machineInst.y - actor.y) <= (primaryHeight / 2) and( (actor.image_xscale < 0 and xDelta < 0) or (actor.image_xscale >= 0 and xDelta >= 0)) then
							local machineData = machineInst:get_data()
							if machineData.team == actor.team then
								machineData.hits_taken = machineData.hits_taken + 1
								print((machineData.hits_taken).. " Hits Taken ")
							end
						end
					end
				end
			end
		end
	end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)
stateTechnicianPrimary:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)
stateTechnicianPrimary:onGetInterruptPriority(function(actor, data)
	-- enables extremely high attack rates -- allow interrupting if the next frame is calculated to reach the end of the anim
	-- FIXME: breaks strafe turn queuing
	if actor.image_index2 + 0.33 * actor.attack_speed >= gm.sprite_get_number(actor.sprite_index2)+1 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	end
	if actor.image_index2 > 2 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	else
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill
	end
end)

-- Ion Burst
technicianSecondary.sprite = sprite_skills
technicianSecondary.subimage = 2
technicianSecondary.cooldown = -1
technicianSecondary.damage = 3.2
technicianSecondary.max_stock = 10
technicianSecondary.auto_restock = false
technicianSecondary.start_with_stock = false
technicianSecondary.does_change_activity_state = true
technicianSecondary.use_delay = 30
technicianSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local tracer_particle = Particle.find("ror", "WispGTracer")
local tracer_color = Color.from_rgb(110, 129, 195)
local ion_tracer, ion_tracer_info = CustomTracer.new(function(x1, y1, x2, y2)
	if x1 < x2 then x1 = x1 + 16 else x1 = x1 - 16 end

	y1 = y1 - 5
	y2 = y2 - 5

	-- line tracer
	local tracer = gm.instance_create(x1, y1, gm.constants.oEfLineTracer)

	tracer.xend = x2
	tracer.yend = y2
	tracer.sprite_index = sprite_tracer2
	tracer.image_speed = 1
	tracer.rate = 0.1
	tracer.blend_1 = Color.from_rgb(255, 255, 255)
	tracer.blend_2 = tracer_color
	tracer.blend_rate = 0.2
	tracer.image_alpha = 1.5
	tracer.bm = 1
	tracer.width = 3

	-- particles
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
ion_tracer_info.sparks_offset_y = -5

local stateTechnicianSecondary = State.new(NAMESPACE, "technicianSecondary")

technicianSecondary:clear_callbacks()
technicianSecondary:onActivate(function(actor, skill)
	actor:enter_state(stateTechnicianSecondary)
end)
stateTechnicianSecondary:clear_callbacks()
stateTechnicianSecondary:onEnter(function(actor, data)
	actor.image_index = 0
	data.ion_rounds = actor:get_active_skill(Skill.SLOT.secondary).stock + 1 -- compensate for first stock being decremented already
	data.should_fire = 1
	data.is_first_shot = 1
	data.sprite = sprite_shoot2a
end)
stateTechnicianSecondary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(data.sprite, 0.33)

	if data.ion_rounds > 0 and actor.image_index >= 2 then
		actor.image_index = 0
		data.should_fire = 1

		if data.sprite == sprite_shoot2a then
			data.sprite = sprite_shoot2b
		else
			data.sprite = sprite_shoot2a
		end
	end
	if data.should_fire == 1 then
		data.ion_rounds = data.ion_rounds - 1
		data.should_fire = 0

		actor:sound_play(sound_shoot2, 1.0, 0.9 + (data.ion_rounds * 0.02) + math.random() * 0.2)
		actor:screen_shake(2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(technicianSecondary)
			local dir = actor:skill_util_facing_direction()

			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local attack_info = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, sprite_sparks2, ion_tracer).attack_info
				attack_info:set_stun(1.0)
				attack_info.climb = i * 8
			end
		end

		if data.is_first_shot == 0 then
			local skill = actor:get_active_skill(Skill.SLOT.secondary)
			skill.stock = skill.stock - 1
		else
			data.is_first_shot = 0
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)
stateTechnicianSecondary:onGetInterruptPriority(function(actor, data)
	if actor.image_index > 3 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	else
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill
	end
end)

Callback.add(Callback.TYPE.onKillProc, "SSIonCharge", function(victim, killer)
	if killer.object_index == gm.constants.oP and killer.class == technician_id then
		local charges = 1
		if GM.actor_is_elite(victim) then
			charges = charges * 2
		end
		if GM.actor_is_boss(victim) then
			charges = charges * 5
		end
		for i=1, charges do
			GM.actor_skill_add_stock_networked(killer, 1)
		end
	end
end)

-- Crowd Dispersion
technicianUtility.sprite = sprite_skills
technicianUtility.subimage = 6
technicianUtility.cooldown = 7 * 60
technicianUtility.is_utility = true
technicianUtility.override_strafe_direction = true
technicianUtility.ignore_aim_direction = true

local stateTechnicianUtility = State.new(NAMESPACE, "technicianUtility")
stateTechnicianUtility.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

technicianUtility:clear_callbacks()
technicianUtility:onActivate(function(actor)
	actor:enter_state(stateTechnicianUtility)
end)
stateTechnicianUtility:clear_callbacks()
stateTechnicianUtility:onEnter(function(actor, data)
	actor.image_index = 0
	data.feared = 0
end)
stateTechnicianUtility:onStep(function(actor, data)
	actor.sprite_index = sprite_shoot3
	actor.image_speed = 0.25

	actor.pHspeed = actor.pHmax * 2.2 * actor.image_xscale
	actor:set_immune(8)

	if data.feared == 0 then
		data.feared = 1

		actor:sound_play(sound_shoot3, 1.0, 1.0)

		-- buff application is host-side
		if not GM._mod_net_isClient() then
			-- fear rectangle gets expanded in the direction that exe is dashing
			local left, right = actor.x - 100, actor.x + 100
			local bias = 1.1 * actor.pHspeed * 30 -- extrapolate distance in 0.5 sec, 1.1x multiplier to account for momentum
			left = math.min(left, left + bias)
			right = math.max(right, right + bias)

			local fear = Buff.find("ror", "fear")
			local victims = List.new()
			actor:collision_rectangle_list(left, actor.y - 48, right, actor.y + 48, gm.constants.pActor, false, true, victims, false)

			for _, victim in ipairs(victims) do
				if victim.team ~= actor.team then
					victim:buff_apply(fear, 2 * 60)
				end
			end

			victims:destroy()
		end
	end

	actor:skill_util_exit_state_on_anim_end()
end)

-- Backup Firewall



technicianSpecial.sprite = sprite_skills
technicianSpecial.subimage = 7
technicianSpecial.cooldown = 8 * 60
technicianSpecial.damage = 1.8
-- technicianSpecial.damage2 = 0.7
technicianSpecial.require_key_press = true
technicianSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- Crowd Execution
local technicianSpecialScepter = Skill.new(NAMESPACE, "technicianVBoosted")
technicianSpecial:set_skill_upgrade(technicianSpecialScepter)

technicianSpecialScepter.sprite = sprite_skills
technicianSpecialScepter.subimage = 8
technicianSpecialScepter.cooldown = 8 * 60
technicianSpecialScepter.damage = 15
technicianSpecialScepter.require_key_press = true
technicianSpecialScepter.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

local stateTechnicianSpecial = State.new(NAMESPACE, "technicianSpecial")

technicianSpecial:clear_callbacks()
technicianSpecial:onActivate(function(actor)
	actor:enter_state(stateTechnicianSpecial)
end)
technicianSpecialScepter:clear_callbacks()
technicianSpecialScepter:onActivate(function(actor)
	actor:enter_state(stateTechnicianSpecial)
end)

stateTechnicianSpecial:clear_callbacks()
stateTechnicianSpecial:onEnter(function(actor, data)
	actor.image_index = 0

	data.created = nil
	data.scepter = actor:item_stack_count(item_scepter)
end)
stateTechnicianSpecial:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	local animation = sprite_shoot4
	if data.scepter > 0 then
		animation = sprite_shoot5
	end
	if not data.created and actor.image_index >= 4 then
		local turrets, _ = Instance.find_all(obj_turret)
		for _, turret in ipairs(turrets) do
			if turret:get_data().parent.id == actor.id then
				turret:destroy()
			end
		end
		local turret_inst = obj_turret:create(actor.x + 5 * actor.image_xscale, actor.y - 8)
		local turret_data = turret_inst:get_data()
		turret_data.parent = actor
		turret_data.team = actor.team
		turret_inst.image_xscale = actor.image_xscale
		move_contact_solid(turret_inst, 90)
		if data.scepter > 0 then
			turret_data.hits_taken = 3
		end
		data.created = 1
	end
	actor:actor_animation_set(animation, 0.25, true)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(Callback.TYPE.onAttackHandleEnd, "SSExecutionCDR", function(attack_info)
	if attack_info.execution == 1 then
		local kill_count = attack_info.kill_number
		GM.actor_skill_reset_cooldowns(attack_info.parent, -60 * kill_count, true, false, true)
	end
end)
