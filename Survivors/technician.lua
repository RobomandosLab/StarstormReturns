local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Technician")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Executioner")

local buff_mirror = Buff.find("ror", "shadowClone")
local item_scepter = Item.find("ror", "ancientScepter")
local object_sparks = Object.find("ror", "EfSparks")

-- assets.
local sprite_loadout		= Resources.sprite_load(NAMESPACE, "TechnicianSelect", path.combine(SPRITE_PATH, "select.png"), 1, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "TechnicianPortrait", path.combine(SPRITE_PATH, "portrait.png"), 2)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "TechnicianSkills", path.combine(SPRITE_PATH, "skills.png"), 6)

local sprite_idle			= Resources.sprite_load(NAMESPACE, "TechnicianIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 9, 12)
local sprite_idle_half		= Resources.sprite_load(NAMESPACE, "TechnicianIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 12, 17)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "TechnicianWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 11, 14)
local sprite_walk_half		= Resources.sprite_load(NAMESPACE, "TechnicianWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 14, 14)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "TechnicianWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 14, 18)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "TechnicianJump", path.combine(SPRITE_PATH, "jump.png"), 1, 14, 12)
local sprite_jump_half		= Resources.sprite_load(NAMESPACE, "TechnicianJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 14, 12)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "TechnicianJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 14, 12)
local sprite_jump_peak_half	= Resources.sprite_load(NAMESPACE, "TechnicianJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 14, 12)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "TechnicianFall", path.combine(SPRITE_PATH, "fall.png"), 1, 14, 12)
local sprite_fall_half		= Resources.sprite_load(NAMESPACE, "TechnicianFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 14, 12)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "TechnicianClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 18)
local sprite_death			= Resources.sprite_load(NAMESPACE, "TechnicianDeath", path.combine(SPRITE_PATH, "death.png"), 5, 14, 8)
local sprite_decoy			= Resources.sprite_load(NAMESPACE, "TechnicianDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 17, 16)

local sprite_shoot1_1		= Resources.sprite_load(NAMESPACE, "TechnicianShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 5, 12, 24)
local sprite_shoot1_2		= Resources.sprite_load(NAMESPACE, "TechnicianShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 5, 12, 24)
local sprite_shoot1_half	= Resources.sprite_load(NAMESPACE, "TechnicianShoot1Half", path.combine(SPRITE_PATH, "shoot1Half.png"), 5, 10, 17)
local sprite_shoot2			= Resources.sprite_load(NAMESPACE, "TechnicianShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 17, 12)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "TechnicianShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 12, 12, 14)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "TechnicianShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 6, 8, 14)
local sprite_shoot5			= Resources.sprite_load(NAMESPACE, "TechnicianShoot4S", path.combine(SPRITE_PATH, "shoot5.png"), 22, 39, 63)

local sprite_sparks2		= Resources.sprite_load(NAMESPACE, "TechnicianSparks", path.combine(SPRITE_PATH, "sparks2.png"), 4, 24, 14)
local sprite_tracer2		= Resources.sprite_load(NAMESPACE, "TechnicianIonTracer", path.combine(SPRITE_PATH, "tracer2.png"), 5, 0, 2)

local sprite_turretaI		= Resources.sprite_load(NAMESPACE, "TechnicianTurretaIdle", path.combine(SPRITE_PATH, "turreta.png"), 4, 12, 14)
local sprite_turretashoot	= Resources.sprite_load(NAMESPACE, "TechnicianTurretaShoot", path.combine(SPRITE_PATH, "turretashoot.png"), 4, 17, 14)
local sprite_turretexplosion= Resources.sprite_load(NAMESPACE, "TechnicianTurretExplosion", path.combine(SPRITE_PATH, "turretexplosion.png"), 4, 20, 20)
local sprite_turretsparks	= Resources.sprite_load(NAMESPACE, "TechnicianTurretSparks", path.combine(SPRITE_PATH, "turretsparks.png"), 3, 26, 16)

local sprite_turretbI		= Resources.sprite_load(NAMESPACE, "TechnicianTurretbIdle", path.combine(SPRITE_PATH, "turretb.png"), 4, 20, 17)
local sprite_turretbshoot	= Resources.sprite_load(NAMESPACE, "TechnicianTurretbshoot", path.combine(SPRITE_PATH, "turretbshoot.png"), 4, 26, 17)

local sprite_turretcI		= Resources.sprite_load(NAMESPACE, "TechnicianTurretcIdle", path.combine(SPRITE_PATH, "turretc.png"), 2, 16, 18)
local sprite_turretcshoot	= Resources.sprite_load(NAMESPACE, "TechnicianTurretcshoot", path.combine(SPRITE_PATH, "turretcshoot.png"), 4, 18, 18)

local sprite_vending1		= Resources.sprite_load(NAMESPACE, "TechnicianVendingMachine", path.combine(SPRITE_PATH, "shoot3ma.png"), 10, 10, 34)
local sprite_vending2		= Resources.sprite_load(NAMESPACE, "TechnicianVendingMachine2", path.combine(SPRITE_PATH, "shoot3mb.png"), 10, 10, 34)
local buff_sprite 			= Resources.sprite_load(NAMESPACE, "BuffHydrated", path.combine(PATH, "Sprites/Buffs/hydrated.png"), 1, 8, 12)
local buff_sprite2 			= Resources.sprite_load(NAMESPACE, "BuffReallyHydrated", path.combine(PATH, "Sprites/Buffs/reallyHydrated.png"), 1, 8, 12)


local sprite_mine1			= Resources.sprite_load(NAMESPACE, "TechnicianMine1", path.combine(SPRITE_PATH, "minea.png"), 6, 7, 32)
local sprite_mine2			= Resources.sprite_load(NAMESPACE, "TechnicianMine2", path.combine(SPRITE_PATH, "mineb.png"), 6, 13, 36)

local mine_mask 			= Resources.sprite_load(NAMESPACE, "TechnicianMineMask", path.combine(SPRITE_PATH, "minemask.png"), 1, 7, 8)
local turret_mask 			= Resources.sprite_load(NAMESPACE, "TechnicianTurretMask", path.combine(SPRITE_PATH, "turretmask.png"), 1, 11, 8)

local mine_explosion 		= Resources.sprite_load(NAMESPACE, "TechnicianMineExplosion", path.combine(SPRITE_PATH, "mineExplosion.png"), 7, 63, 92)

local sound_shoot1			= Resources.sfx_load(NAMESPACE, "TechnicianShoot1", path.combine(SOUND_PATH, "skill1.ogg"))
local sound_shoot2			= Resources.sfx_load(NAMESPACE, "TechnicianShoot2", path.combine(SOUND_PATH, "skill2.ogg"))
local sound_shoot3			= Resources.sfx_load(NAMESPACE, "TechnicianShoot3", path.combine(SOUND_PATH, "skill3.ogg"))
local sound_shoot4a			= Resources.sfx_load(NAMESPACE, "TechnicianShoot4a", path.combine(SOUND_PATH, "skill4a.ogg"))
local sound_shoot4b			= Resources.sfx_load(NAMESPACE, "TechnicianShoot4b", path.combine(SOUND_PATH, "skill4b.ogg"))

-- local explosion1			= gm.constants.sEfBombExplode -- WWWWWWWWWWWWWWWWWWWWWWWOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO

local WRENCH_BLAST_OFFSET_X = get_tiles(0.8)
local WRENCH_BLAST_OFFSET_Y = -get_tiles(0.1)
local WRENCH_BLAST_W = get_tiles(2.2)
local WRENCH_BLAST_H = get_tiles(1.2)
local MACHINE_VENDING_BLAST_H = get_tiles(1)
local MACHINE_VENDING_GRAV = 0.2
local MACHINE_VENDING_DAMAGE_THRESHOLD = 6
local MACHINE_VENDING_MOVESPEED = 0.56
local MACHINE_VENDING_ATTACKSPEED = 0.2
local MACHINE_VENDING_ATTACKSPEED2 = 0.3
local MACHINE_VENDING_CRIT = 17
local MACHINE_VENDING_BLAST_W = get_tiles(2)
local MACHINE_VENDING_BLAST_H = get_tiles(3)
local MACHINE_MINE_GRAV = 0.2
local MACHINE_MINE_PULL_RADIUS = get_tiles(4)
local MACHINE_MINE_PULL_INTERVAL = 80
local MACHINE_MINE_PULL_LIFE = 90

-- His only friends are machines
local technician = Survivor.new(NAMESPACE, "technician")
local technician_id = technician.value

technician:set_stats_base({
	maxhp = 102,
	damage = 11,
	regen = 0.011,
})
technician:set_stats_level({
	maxhp = 29,
	damage = 3,
	regen = 0.0018,
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
technician:set_primary_color(Color.from_rgb(104, 191, 208))

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
obj_turret:clear_callbacks()
obj_turret:onCreate(function(inst)
	local data = inst:get_data()
	inst.mask_index = turret_mask
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
			--print(data.range)
			data.init = 1
			--print("xx "..(xx).." inst.x "..(inst.x))
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
			if victim.team ~= inst.team then
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
		-- print(data.cooldown.." LOUD INCORRECT BUZZER")
	else
		inst:destroy()
	end
end)

-- Vending Machine

local buff_vending = Buff.new(NAMESPACE, "hydrated")
local buff_vending_2 = Buff.new(NAMESPACE, "really_hydrated")
buff_vending.icon_sprite = buff_sprite
buff_vending_2.icon_sprite = buff_sprite2
buff_vending:clear_callbacks()
buff_vending_2:clear_callbacks()
buff_vending:onStatRecalc(function(actor)	
	actor.attack_speed = actor.attack_speed + MACHINE_VENDING_ATTACKSPEED
	actor.pHmax = actor.pHmax + MACHINE_VENDING_MOVESPEED
end)
buff_vending_2:onStatRecalc(function(actor)
	actor.attack_speed = actor.attack_speed + MACHINE_VENDING_ATTACKSPEED2
	actor.pHmax = actor.pHmax + MACHINE_VENDING_MOVESPEED
	actor.critical_chance = actor.critical_chance + MACHINE_VENDING_CRIT
end)

local obj_vending = Object.new(NAMESPACE, "vending")
obj_vending:set_sprite(sprite_vending1)
obj_vending:set_depth(1)
obj_vending:clear_callbacks()
obj_vending:onCreate(function(inst)
	local data = inst:get_data()
	inst.gravity = MACHINE_VENDING_GRAV
	data.init = nil
	data.hits_taken = 0
	inst.image_speed = 0.2
	data.upgraded = nil
	data.buff = buff_vending
end)
obj_vending:onStep(function(inst)
	local data = inst:get_data()
	if data.parent then
		-- print("TRY AGAIN!")
		-- print(data.hits_taken.. "hits taken")
		if is_colliding_stage(inst, inst.x, inst.y + inst.vspeed) then
			move_contact_solid(inst, 90)
			if inst.vspeed > MACHINE_VENDING_DAMAGE_THRESHOLD then
				data.parent:fire_explosion(inst.x, inst.y - MACHINE_VENDING_BLAST_H / 2, MACHINE_VENDING_BLAST_W, MACHINE_VENDING_BLAST_H, data.parent:skill_get_damage(technicianUtility))
			end
			inst.vspeed = 0
			inst.gravity = 0
		end
		if data.hits_taken >= 3 and not data.upgraded then
			inst.sprite_index = sprite_vending2
			data.upgraded = 1
			data.buff = buff_vending_2
		end
		if data.playanim then
			if inst.image_index >= gm.sprite_get_number(inst.sprite_index) - 1 then
				data.playanim = nil
			end
		else
			inst.image_index = 0
		end
		for _, player in ipairs(inst:get_collisions(gm.constants.oP)) do
			-- print(player)
			-- print(player:buff_stack_count(data.buff).. " buffmaxxing")
			-- print(player.team.. " this is our team")
			-- print(inst.team.. " vending team")
			if player.team == inst.team and player:buff_stack_count(data.buff) == 0 then
				player:buff_remove(buff_vending)
				player:buff_apply(data.buff, 5 * 60)
				data.playanim = 1
				break
			end
		end
	else
		inst:destroy()
	end
end)

-- and they called it a mine

local obj_mine_pull = Object.new(NAMESPACE, "mine_pull")
obj_mine_pull:clear_callbacks()
obj_mine_pull:onCreate(function(inst)
	local data = inst:get_data()
	data.life = MACHINE_MINE_PULL_LIFE
end)
obj_mine_pull:onStep(function(inst)
	local data = inst:get_data()
	local targets = List.wrap(gm.find_characters_circle(inst.x, inst.y, MACHINE_MINE_PULL_RADIUS, true, inst.team == 1 and 2 or 1, true))
	for _, target in ipairs(targets) do
		-- move_contact_solid(target, 360 - gm.point_direction(inst.x, inst.y, target.x, target.y), 1)--(0.5 + 0.5 * data.life / 120) * (1 - gm.point_distance(inst.x, inst.y, target.x, target.y) / MACHINE_MINE_PULL_RADIUS))
		local lastx = target.x
		local strength = math.max(1, math.ceil((0.5 + 2.5 * (1 - data.life / MACHINE_MINE_PULL_LIFE)) * (0.2 + 0.8 * (1 - gm.point_distance(inst.x, inst.y, target.x, target.y) / MACHINE_MINE_PULL_RADIUS))))
		if GM.actor_is_classic(target) then
			target:move_contact_solid(180 + gm.point_direction(inst.x, target.y, target.x, target.y), strength)
			if target.y < inst.y then
				--target:move_contact_solid(180 + gm.point_direction(target.x, inst.y, target.x, target.y), strength)
			end
		else
			--print("i'm not classic")
			--move_in_direction(target, gm.point_direction(target.x, inst.y, target.x, target.y), 100)
			--target.y = (target.pVspeed > 0 and math.min(target.y, inst.y) or math.max(target.y, inst.y))
		end
		if lastx < inst.x and target.x >= inst.x then
			target.x = math.min(target.x, inst.x)
		elseif lastx > inst.x and target.x <= inst.x then
			target.x = math.max(target.x, inst.x)
		end
	end
	data.life = data.life - 1
	if data.life <= 0 then
		inst:destroy()
	end
end)

local obj_mine = Object.new(NAMESPACE, "mine")
obj_mine:set_sprite(sprite_mine1)
obj_mine.obj_depth = 218 -- GRAAAAAAH THIS WONT GO BACK   --- Note from the future: Now it does, thanks kris :)
obj_mine:clear_callbacks()
obj_mine:onCreate(function(inst)
	local data = inst:get_data()
	inst.gravity = MACHINE_MINE_GRAV
	inst.mask_index = mine_mask
	data.hits_taken = 0
	inst.image_speed = 0.2
	data.upgraded = nil
	data.pull_timer = MACHINE_MINE_PULL_INTERVAL
end)
obj_mine:onStep(function(inst)
	local data = inst:get_data()
	if data.parent then
		inst.hspeed = inst.hspeed * 0.9
		if is_colliding_stage(inst, inst.x + inst.hspeed, inst.y) then
			inst.hspeed = 0
		end
		if is_colliding_stage(inst, inst.x, inst.y + inst.vspeed) then
			inst.vspeed = 0
			inst.gravity = 0
			move_contact_solid(inst, 90)
		end
		if data.hits_taken >= 3 and not data.upgraded then
			inst.sprite_index = sprite_mine2
			data.upgraded = 1
		end
		if data.upgraded == 1 then
			data.pull_timer = data.pull_timer - 1
			if data.pull_timer <= 0 then
				local JimmyJohnsPizzeria = obj_mine_pull:create(inst.x, inst.y)
				JimmyJohnsPizzeria.team = inst.team
				data.pull_timer = MACHINE_MINE_PULL_INTERVAL
			end
		end
	else
		inst:destroy()
	end
end)


local machines = {obj_turret, obj_vending, obj_mine}

-- Wrench Whack
technicianPrimary.sprite = sprite_skills
technicianPrimary.subimage = 0

technicianPrimary.cooldown = 5
technicianPrimary.damage = 1.5
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

stateTechnicianPrimary:onStep(function(actor, data)
	actor.sprite_index2 = (data.currentAnim == 1 and sprite_shoot1_2 or sprite_shoot1_1)

	actor:skill_util_strafe_update(0.2 * actor.attack_speed, gm.constants.STRAFE_SPEED_NORMAL)
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

	if data.fired == 0 and actor.image_index2 >= 1 then
		data.fired = 1

		actor:sound_play(sound_shoot1, 1, 0.9 + math.random() * 0.2)

		if actor:is_authority() then
			local damage = actor:skill_get_damage(technicianPrimary)
			local dir = actor:skill_util_facing_direction()

			if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				for i=0, actor:buff_stack_count(buff_mirror) do
					local attack_info = actor:fire_explosion(actor.x + WRENCH_BLAST_OFFSET_X * actor.image_xscale, actor.y + WRENCH_BLAST_OFFSET_Y, WRENCH_BLAST_W, WRENCH_BLAST_H, actor:skill_get_damage(technicianPrimary)).attack_info
					attack_info.climb = i * 8
					attack_info.knockback_direction = actor.image_xscale
					local machinesHit = List.new()
					actor:collision_rectangle_list(actor.x + (WRENCH_BLAST_OFFSET_X - WRENCH_BLAST_W / 2) * actor.image_xscale, actor.y - WRENCH_BLAST_H / 2 + WRENCH_BLAST_OFFSET_Y, actor.x + (WRENCH_BLAST_OFFSET_X + WRENCH_BLAST_W / 2) * actor.image_xscale, actor.y + WRENCH_BLAST_H / 2 + WRENCH_BLAST_OFFSET_Y, gm.constants.oCustomObject, false, true, machinesHit, false)
					-- ^ finding all machines in machines table that collides with the explosion to upgrade
					-- print(" Machines ")
					-- print(tableToString(machines))
					-- print(" Machines Hit ")
					-- print(tableToString(machinesHit))
					for _, machineObj in ipairs(machines) do
						for _, instance in ipairs(machinesHit) do
							if machineObj.value == instance.__object_index then
								local machineData = instance:get_data()
								if instance.team == actor.team then
									machineData.hits_taken = machineData.hits_taken + 1
									--print((machineData.hits_taken).. " Hits Taken ")
								end
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

-- Forced Shutdown
technicianSecondary.sprite = sprite_skills
technicianSecondary.subimage = 1
technicianSecondary.cooldown = 0.5 * 60
technicianSecondary.damage = 7
technicianSecondary.max_stock = 1
technicianSecondary.does_change_activity_state = true
technicianSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- big red button
local technicianSecondary_2 = Skill.new(NAMESPACE, "technicianX2")
technicianSecondary_2.sprite = sprite_skills
technicianSecondary_2.subimage = 5
  
technicianSecondary_2.cooldown = 3 * 60
technicianSecondary_2.damage = 1.0 --This damage isn't used for anything, only the original skill is
technicianSecondary_2.require_key_press = true
technicianSecondary_2.does_change_activity_state = true
technicianSecondary_2.hold_facing_direction = true
technicianSecondary_2.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period

local state_technician_secondary = State.new(NAMESPACE, "technician_secondary")

technicianSecondary:clear_callbacks()
technicianSecondary:onActivate(function(actor)
	actor:enter_state(state_technician_secondary)
end)
state_technician_secondary:clear_callbacks()
state_technician_secondary:onEnter(function(actor, data)
	actor.image_index = 0
	data.used = nil
end)
state_technician_secondary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2, 0.2, true)
	
	if actor.image_index >= 3 and not data.used then
		local cooldown = actor:get_default_skill(Skill.SLOT.secondary).cooldown
		actor:add_skill_override(Skill.SLOT.secondary, technicianSecondary_2, 1) --Replaces the secondary with a new secondary (Remote Detonator)
		actor:override_active_skill_cooldown(Skill.SLOT.secondary, cooldown)
		
		
		local mine_inst = obj_mine:create(actor.x + 12 * actor.image_xscale, actor.y)
			local mine_data = mine_inst:get_data()
			mine_inst.team = actor.team
			mine_data.parent = actor
			mine_inst.hspeed = 8 * actor.image_xscale
		data.used = 1
	end
	if not data.used then
		actor:freeze_default_skill(Skill.SLOT.secondary)
	end
	actor:skill_util_exit_state_on_anim_end()
end)

-- blows up mine with mind...

technicianSecondary_2:clear_callbacks()
technicianSecondary_2:onActivate(function(actor)
	local cooldown = actor:get_active_skill(Skill.SLOT.secondary).cooldown_base * (1 - actor.cdr)
	actor:remove_skill_override(Skill.SLOT.secondary, technicianSecondary_2, 1)
	actor:override_default_skill_cooldown(Skill.SLOT.secondary, cooldown)
	
	local mines, _ = Instance.find_all(obj_mine)
	for _, mine in ipairs(mines) do
		if mine:get_data().parent.id == actor.id then
			for i = 0, actor:buff_stack_count(buff_mirror) do
				local attack_info = actor:fire_explosion(mine.x, mine.y, get_tiles(6), get_tiles(6), actor:skill_get_damage(technicianSecondary)).attack_info
				attack_info.knockback = 6
				attack_info:set_stun(1.2)
			end
			local ef_sparks = object_sparks:create(mine.x, mine.y)
			ef_sparks.sprite_index = mine_explosion
			ef_sparks.image_speed = 0.2
			ef_sparks.image_yscale = 1
			mine:destroy()
		end
	end
end)

technicianSecondary_2:onStep(function(actor)
	actor:freeze_default_skill(Skill.SLOT.secondary)
end)

-- Vending Machine
technicianUtility.sprite = sprite_skills
technicianUtility.damage = 2
technicianUtility.subimage = 2
technicianUtility.cooldown = 12 * 60
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

	data.created = nil
	data.scepter = actor:item_stack_count(item_scepter)
end)
stateTechnicianUtility:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	local animation = sprite_shoot3
	if not data.created and actor.image_index >= 4 then
		local vendings, _ = Instance.find_all(obj_vending)
		for _, vending in ipairs(vendings) do
			if vending:get_data().parent.id == actor.id then
				vending:destroy()
			end
		end
		local vending_inst = obj_vending:create(actor.x, actor.y - 4)
		local vending_data = vending_inst:get_data()
		vending_data.parent = actor
		vending_inst.team = actor.team
		vending_inst.image_xscale = actor.image_xscale
		-- move_contact_solid(vending_inst, 90)
		data.created = 1
	end
	actor:actor_animation_set(animation, 0.25, true)
	actor:skill_util_exit_state_on_anim_end()
end)

-- Backup Firewall



technicianSpecial.sprite = sprite_skills
technicianSpecial.subimage = 3
technicianSpecial.cooldown = 7 * 60
technicianSpecial.damage = 1.8
-- technicianSpecial.damage2 = 0.7
technicianSpecial.require_key_press = true
technicianSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- Backup Firewall 2.0
local technicianSpecialScepter = Skill.new(NAMESPACE, "technicianVBoosted")
technicianSpecial:set_skill_upgrade(technicianSpecialScepter)

technicianSpecialScepter.sprite = sprite_skills
technicianSpecialScepter.subimage = 4
technicianSpecialScepter.cooldown = 7 * 60
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
		turret_inst.team = actor.team
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
