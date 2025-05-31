local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Technician")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Technician")

local buff_mirror = Buff.find("ror", "shadowClone")
local item_scepter = Item.find("ror", "ancientScepter")
local object_sparks = Object.find("ror", "EfSparks")
local object_flash = Object.find("ror", "EfFlash")
local object_missile = Object.find("ror", "EfMissile")
local particle_spark = Particle.find("ror", "Spark")

-- assets.
local sprite_loadout			= Resources.sprite_load(NAMESPACE, "TechnicianSelect", path.combine(SPRITE_PATH, "select.png"), 18, 28, 0)
local sprite_portrait			= Resources.sprite_load(NAMESPACE, "TechnicianPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small		= Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills				= Resources.sprite_load(NAMESPACE, "TechnicianSkills", path.combine(SPRITE_PATH, "skills.png"), 7)
local sprite_credits 			= Resources.sprite_load(NAMESPACE, "TechnicianCredits", path.combine(SPRITE_PATH, "credits.png"), 1, 7, 12)
local sprite_palette 			= Resources.sprite_load(NAMESPACE, "TechnicianPalette", path.combine(SPRITE_PATH, "palette.png"))
local sprite_log				= Resources.sprite_load(NAMESPACE, "TechnicianLog", path.combine(SPRITE_PATH, "log.png"))

local sprite_idle				= Resources.sprite_load(NAMESPACE, "TechnicianIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 9, 13)
local sprite_idle_half			= Resources.sprite_load(NAMESPACE, "TechnicianIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 9, 13)
local sprite_walk				= Resources.sprite_load(NAMESPACE, "TechnicianWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 11, 15)
local sprite_walk_half			= Resources.sprite_load(NAMESPACE, "TechnicianWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 10, 15)
local sprite_walk_back			= Resources.sprite_load(NAMESPACE, "TechnicianWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 13, 15)
local sprite_jump				= Resources.sprite_load(NAMESPACE, "TechnicianJump", path.combine(SPRITE_PATH, "jump.png"), 1, 14, 14)
local sprite_jump_half			= Resources.sprite_load(NAMESPACE, "TechnicianJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 14, 14)
local sprite_jump_peak			= Resources.sprite_load(NAMESPACE, "TechnicianJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 14, 14)
local sprite_jump_peak_half		= Resources.sprite_load(NAMESPACE, "TechnicianJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 14, 12)
local sprite_fall				= Resources.sprite_load(NAMESPACE, "TechnicianFall", path.combine(SPRITE_PATH, "fall.png"), 1, 14, 12)
local sprite_climb				= Resources.sprite_load(NAMESPACE, "TechnicianClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 10, 15)
local sprite_fall_half			= Resources.sprite_load(NAMESPACE, "TechnicianFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 14, 12)
local sprite_death				= Resources.sprite_load(NAMESPACE, "TechnicianDeath", path.combine(SPRITE_PATH, "death.png"), 8, 13, 12)
local sprite_decoy				= Resources.sprite_load(NAMESPACE, "TechnicianDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 17, 16)
local sprite_drone_idle			= Resources.sprite_load(NAMESPACE, "DronePlayerTechnicianIdle", path.combine(SPRITE_PATH, "drone_idle.png"), 5, 11, 15)
local sprite_drone_shoot		= Resources.sprite_load(NAMESPACE, "DronePlayerTechnicianShoot", path.combine(SPRITE_PATH, "drone_shoot.png"), 5, 25, 15)

local sprite_shoot1_1			= Resources.sprite_load(NAMESPACE, "TechnicianShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 7, 31, 28)
local sprite_shoot1_2			= Resources.sprite_load(NAMESPACE, "TechnicianShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 7, 31, 28)
local sprite_shoot1T_1			= Resources.sprite_load(NAMESPACE, "TechnicianShoot1T_1", path.combine(SPRITE_PATH, "shoot1T_1.png"), 7, 23, 21)
local sprite_shoot1T_2			= Resources.sprite_load(NAMESPACE, "TechnicianShoot1T_2", path.combine(SPRITE_PATH, "shoot1T_2.png"), 7, 12, 17)
local sprite_shoot2				= Resources.sprite_load(NAMESPACE, "TechnicianShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 17, 13)
local sprite_shoot4				= Resources.sprite_load(NAMESPACE, "TechnicianShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 8, 16, 23)
local sprite_shoot5				= Resources.sprite_load(NAMESPACE, "TechnicianShoot4S", path.combine(SPRITE_PATH, "shoot5.png"), 8, 16, 25)

local sprite_sparks1			= Resources.sprite_load(NAMESPACE, "TechnicianSparks1", path.combine(SPRITE_PATH, "sparks1.png"), 4, 12, 16)
local sprite_sparks2			= Resources.sprite_load(NAMESPACE, "TechnicianSparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 17, 22)
local sprite_sparks3			= Resources.sprite_load(NAMESPACE, "TechnicianSparks3", path.combine(SPRITE_PATH, "sparks3.png"), 4, 16, 22)
local sprite_sparks4			= Resources.sprite_load(NAMESPACE, "TechnicianSparks4", path.combine(SPRITE_PATH, "sparks4.png"), 4, 9, 12)
local sprite_sparks5			= Resources.sprite_load(NAMESPACE, "TechnicianSparks5", path.combine(SPRITE_PATH, "sparks5.png"), 4, 26, 4)

local sprite_drink_technician_1	= Resources.sprite_load(NAMESPACE, "TechnicianDrink", path.combine(SPRITE_PATH, "Drink/technician_drink_1.png"), 12, 9, 13)
local sprite_drink_technician_2	= Resources.sprite_load(NAMESPACE, "TechnicianDrinkUp", path.combine(SPRITE_PATH, "Drink/technician_drink_2.png"), 12, 9, 13)

local sprite_turretaI			= Resources.sprite_load(NAMESPACE, "TechnicianTurretaIdle", path.combine(SPRITE_PATH, "turreta.png"), 4, 12, 14)
local sprite_turretashoot		= Resources.sprite_load(NAMESPACE, "TechnicianTurretaShoot", path.combine(SPRITE_PATH, "turretashoot.png"), 4, 17, 14)
local sprite_turretbI			= Resources.sprite_load(NAMESPACE, "TechnicianTurretbIdle", path.combine(SPRITE_PATH, "turretb.png"), 4, 20, 17)
local sprite_turretbshoot		= Resources.sprite_load(NAMESPACE, "TechnicianTurretbshoot", path.combine(SPRITE_PATH, "turretbshoot.png"), 4, 26, 17)
local sprite_turretcI			= Resources.sprite_load(NAMESPACE, "TechnicianTurretcIdle", path.combine(SPRITE_PATH, "turretc.png"), 4, 21, 17)
local sprite_turretcshoot		= Resources.sprite_load(NAMESPACE, "TechnicianTurretcshoot", path.combine(SPRITE_PATH, "turretcshoot.png"), 4, 30, 16)
local sprite_turretc_mis1		= Resources.sprite_load(NAMESPACE, "TechnicianTurretcMissile1", path.combine(SPRITE_PATH, "turretc_mis1.png"), 4, 21, 17)
local sprite_turretc_mis2		= Resources.sprite_load(NAMESPACE, "TechnicianTurretcMissile2", path.combine(SPRITE_PATH, "turretc_mis2.png"), 5, 21, 19)
local sprite_turretc_mis3		= Resources.sprite_load(NAMESPACE, "TechnicianTurretcMissile3", path.combine(SPRITE_PATH, "turretc_mis3.png"), 5, 29, 32)

local sprite_vending1			= Resources.sprite_load(NAMESPACE, "TechnicianVendingMachine", path.combine(SPRITE_PATH, "vendinga.png"), 10, 21, 34)
local sprite_vending2			= Resources.sprite_load(NAMESPACE, "TechnicianVendingMachine2", path.combine(SPRITE_PATH, "vendingb.png"), 10, 19, 37)
local buff_vending_sprite 		= Resources.sprite_load(NAMESPACE, "BuffHydrated", path.combine(PATH, "Sprites/Buffs/hydrated.png"), 1, 8, 12)
local buff_vending_2_sprite		= Resources.sprite_load(NAMESPACE, "BuffReallyHydrated", path.combine(PATH, "Sprites/Buffs/reallyHydrated.png"), 1, 8, 12)

local sprite_mine1				= Resources.sprite_load(NAMESPACE, "TechnicianMine1", path.combine(SPRITE_PATH, "minea.png"), 6, 7, 32)
local sprite_mine2				= Resources.sprite_load(NAMESPACE, "TechnicianMine2", path.combine(SPRITE_PATH, "mineb.png"), 6, 13, 36)

local sprite_amplifier1			= Resources.sprite_load(NAMESPACE, "TechnicianAmplifier1", path.combine(SPRITE_PATH, "amplifiera.png"), 1, 10, 38)
local sprite_amplifier2			= Resources.sprite_load(NAMESPACE, "TechnicianAmplifier2", path.combine(SPRITE_PATH, "amplifierb.png"), 1, 10, 38)
local buff_exposed_sprite 		= Resources.sprite_load(NAMESPACE, "BuffExposed", path.combine(PATH, "Sprites/Buffs/exposed.png"), 1, 10, 10)
local buff_exposed_2_sprite 	= Resources.sprite_load(NAMESPACE, "BuffExposed2", path.combine(PATH, "Sprites/Buffs/exposed2.png"), 1, 10, 10)

local sprite_wrench				= Resources.sprite_load(NAMESPACE, "TechnicianWrench", path.combine(SPRITE_PATH, "wrench.png"), 1, 9, 9)

local mine_mask 				= Resources.sprite_load(NAMESPACE, "TechnicianMineMask", path.combine(SPRITE_PATH, "minemask.png"), 1, 7, 18)
local turret_mask 				= Resources.sprite_load(NAMESPACE, "TechnicianTurretMask", path.combine(SPRITE_PATH, "turretmask.png"), 1, 11, 8)
local wrench_mask 				= Resources.sprite_load(NAMESPACE, "TechnicianWrenchMask", path.combine(SPRITE_PATH, "wrenchmask.png"), 1, 11, 8)
local amplifier_mask 			= Resources.sprite_load(NAMESPACE, "TechnicianAmplifierMask", path.combine(SPRITE_PATH, "amplifiermask.png"), 1, 8, 24)

local mine_explosion 			= Resources.sprite_load(NAMESPACE, "TechnicianMineExplosion", path.combine(SPRITE_PATH, "mineExplosion.png"), 7, 63, 92)

local sound_select				= Resources.sfx_load(NAMESPACE, "TechnicianSelect", path.combine(SOUND_PATH, "select.ogg"))
local sound_shoot1				= Resources.sfx_load(NAMESPACE, "TechnicianShoot1", path.combine(SOUND_PATH, "shoot1.ogg"))
local sound_shoot1T				= Resources.sfx_load(NAMESPACE, "TechnicianShoot1T", path.combine(SOUND_PATH, "shoot1T.ogg"))
local sound_shoot2				= Resources.sfx_load(NAMESPACE, "TechnicianShoot2", path.combine(SOUND_PATH, "shoot2.ogg"))
local sound_shoot4				= Resources.sfx_load(NAMESPACE, "TechnicianShoot4", path.combine(SOUND_PATH, "shoot4.ogg"))
local sound_mineExplode1		= Resources.sfx_load(NAMESPACE, "TechnicianMineExplode1", path.combine(SOUND_PATH, "mineExplode1.ogg"))
local sound_mineExplode2		= Resources.sfx_load(NAMESPACE, "TechnicianMineExplode1", path.combine(SOUND_PATH, "mineExplode2.ogg"))
local sound_mineUpgrade			= Resources.sfx_load(NAMESPACE, "TechnicianMineUpgrade", path.combine(SOUND_PATH, "mineUpgrade.ogg"))
local sound_vendingDispense		= Resources.sfx_load(NAMESPACE, "TechnicianVendingDispense", path.combine(SOUND_PATH, "vendingDispense.ogg"))
local sound_vendingDrink		= Resources.sfx_load(NAMESPACE, "TechnicianVendingDrink", path.combine(SOUND_PATH, "vendingDrink.ogg"))
local sound_vendingUpgrade		= Resources.sfx_load(NAMESPACE, "TechnicianVendingUpgrade", path.combine(SOUND_PATH, "vendingUpgrade.ogg"))
local sound_turretShoot1		= Resources.sfx_load(NAMESPACE, "TechnicianTurretShoot1", path.combine(SOUND_PATH, "turretShoot1.ogg"))
local sound_turretShoot2		= Resources.sfx_load(NAMESPACE, "TechnicianTurretShoot2", path.combine(SOUND_PATH, "turretShoot2.ogg"))
local sound_turretDeath			= Resources.sfx_load(NAMESPACE, "TechnicianTurretDeath", path.combine(SOUND_PATH, "turretDeath.ogg"))
local sound_turretUpgrade		= Resources.sfx_load(NAMESPACE, "TechnicianTurretUpgrade", path.combine(SOUND_PATH, "turretUpgrade.ogg"))
local sound_wrenchHit			= Resources.sfx_load(NAMESPACE, "TechnicianWrenchHit", path.combine(SOUND_PATH, "wrenchHit.ogg"))
local sound_upgrade				= Resources.sfx_load(NAMESPACE, "TechnicianUpgrade", path.combine(SOUND_PATH, "upgrade.ogg"))
local sound_downgrade			= Resources.sfx_load(NAMESPACE, "TechnicianDowngrade", path.combine(SOUND_PATH, "downgrade.ogg"))
local sound_downgradeBeep		= Resources.sfx_load(NAMESPACE, "TechnicianDowngradeBeep", path.combine(SOUND_PATH, "downgradeBeep.ogg"))

local color_tech_red			= Color.from_hex(0xFF4843)
local color_tech_blue			= Color.from_hex(0x96FFFF)
local color_tech_orange			= Color.from_hex(0xFFC479)

local explosion1				= gm.constants.sEfBombExplode -- WWWWWWWWWWWWWWWWWWWWWWWOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
local explosion2				= gm.constants.sMinerExplosion
local explosion3				= gm.constants.sDroneDeath
local soundImpact				= gm.constants.wTurtleExplosion
local soundCommandoSelect		= gm.constants.wUI_Survivors_Commando

local WRENCH_BLAST_OFFSET_X = get_tiles(0.8)
local WRENCH_BLAST_OFFSET_Y = -get_tiles(0.1)
local WRENCH_BLAST_W = get_tiles(2.2)
local WRENCH_BLAST_H = get_tiles(1.2)
local WRENCH_DOWNGRADE_TIME = 60 * 30
local WRENCH_THROW_DOWNGRADE_TIME = 60 * 20

local MACHINE_VENDING_GRAV = 0.2
local MACHINE_VENDING_DAMAGE_THRESHOLD = 6
local MACHINE_VENDING_MOVESPEED = 0.56
local MACHINE_VENDING_ATTACKSPEED = 0.2
local MACHINE_VENDING_ATTACKSPEED2 = 0.4
local MACHINE_VENDING_CRIT = 20
local MACHINE_VENDING_BLAST_W = get_tiles(4)
local MACHINE_VENDING_BLAST_H = get_tiles(2)

local MACHINE_MINE_GRAV = 0.2
local MACHINE_MINE_PULL_RADIUS = get_tiles(4)
local MACHINE_MINE_PULL_INTERVAL = 75 --80
local MACHINE_MINE_PULL_LIFE = 90

local MACHINE_AMPLIFIER_RADIUS = 140

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
	drone_idle = sprite_drone_idle,
	drone_shoot = sprite_drone_shoot,
})

technician:set_cape_offset(-4, -7, -3, -9)
technician:set_primary_color(Color.from_rgb(104, 191, 208))

technician.sprite_loadout = sprite_loadout
technician.sprite_portrait = sprite_portrait
technician.sprite_portrait_small = sprite_portrait_small
technician.sprite_idle = sprite_idle
technician.sprite_title = sprite_walk
technician.sprite_credits = sprite_credits

technician:set_palettes(sprite_palette, sprite_palette, sprite_palette)

technician:add_skin("TechnicianRose", 1, Resources.sprite_load(NAMESPACE, "TechnicianSelect_PAL2", path.combine(SPRITE_PATH, "selectS1.png"), 18, 28, 0),
Resources.sprite_load(NAMESPACE, "TechnicianPortrait_PAL2", path.combine(SPRITE_PATH, "portraitS1.png"), 3),
Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall_PAL2", path.combine(SPRITE_PATH, "portraitSmallS1.png")))

technician:add_skin("TechnicianBlack", 2, Resources.sprite_load(NAMESPACE, "TechnicianSelect_PAL4", path.combine(SPRITE_PATH, "selectS2.png"), 18, 28, 0),
Resources.sprite_load(NAMESPACE, "TechnicianPortrait_PAL4", path.combine(SPRITE_PATH, "portraitS2.png"), 3),
Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall_PAL4", path.combine(SPRITE_PATH, "portraitSmallS2.png")))

technician:add_skin("TechnicianBlue", 3, Resources.sprite_load(NAMESPACE, "TechnicianSelect_PAL5", path.combine(SPRITE_PATH, "selectS3.png"), 18, 28, 0),
Resources.sprite_load(NAMESPACE, "TechnicianPortrait_PAL5", path.combine(SPRITE_PATH, "portraitS3.png"), 3),
Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall_PAL5", path.combine(SPRITE_PATH, "portraitSmallS3.png")))

--[[technician:add_skin("TechnicianOperator", 4, Resources.sprite_load(NAMESPACE, "TechnicianSelect_PAL1", path.combine(SPRITE_PATH, "selectS4.png"), 18, 28, 0),
Resources.sprite_load(NAMESPACE, "TechnicianPortrait_PAL1", path.combine(SPRITE_PATH, "portraitS4.png"), 3),
Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall_PAL1", path.combine(SPRITE_PATH, "portraitSmallS4.png")))]]

--[[technician:add_skin("TechnicianEngineer", 5, Resources.sprite_load(NAMESPACE, "TechnicianSelect_PAL3", path.combine(SPRITE_PATH, "selectS1.png"), 18, 28, 0),
Resources.sprite_load(NAMESPACE, "TechnicianPortrait_PAL3", path.combine(SPRITE_PATH, "portraitS1.png"), 3),
Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall_PAL3", path.combine(SPRITE_PATH, "portraitSmallS1.png")))]]

--[[technician:add_skin("TechnicianProvidence", 5, Resources.sprite_load(NAMESPACE, "TechnicianSelect_PROV", path.combine(SPRITE_PATH, "selectPROV.png"), 18, 28, 0),
Resources.sprite_load(NAMESPACE, "TechnicianPortrait_PROV", path.combine(SPRITE_PATH, "portraitPROV.png"), 3),
Resources.sprite_load(NAMESPACE, "TechnicianPortraitSmall_PROV", path.combine(SPRITE_PATH, "portraitSmallPROV.png")))]]

local technicianLog = Survivor_Log.new(technician, sprite_log)

local technicianPrimary = technician:get_primary()
local technicianSecondary = technician:get_secondary()
local technicianUtility = technician:get_utility()
local technicianSpecial = technician:get_special()
local technicianSecondary_Det = Skill.new(NAMESPACE, "technicianXD")

local technicianPrimaryAlt = Skill.new(NAMESPACE, "technicianZ2")
local technicianUtilityAlt = Skill.new(NAMESPACE, "technicianC2")

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
	
	--Skill overrides aren't removed when transitioning between stages so this does that
	--Otherwise the skill stocks of it get all messed up and secondary does nothing because there's no mine to detonate
	actor:add_callback("onStageStart", "SSOnStageStartTech", function(actor)
		actor:remove_skill_override(Skill.SLOT.secondary, technicianSecondary_Det, 1)
	end)

	actor:survivor_util_init_half_sprites()
end)

local handle_strafing_yoffset = function(actor)
	-- Adjust vertical offset so the upper body bobs up and down depending on the leg animation
	if actor.sprite_index == actor.sprite_walk_half[2] then
		local walk_offset = 0
		local leg_frame = math.floor(actor.image_index)
		if leg_frame == 0 or leg_frame == 4 then
			walk_offset = 1
		elseif leg_frame == 2 or leg_frame == 6 then
			walk_offset = -1
		end
		actor.ydisp = walk_offset - 1 -- ydisp controls upper body offset
	end
end

local buff_vending = Buff.new(NAMESPACE, "hydrated")
local buff_vending_2 = Buff.new(NAMESPACE, "really_hydrated")
local buff_exposed = Buff.new(NAMESPACE, "exposed")
local buff_exposed_2 = Buff.new(NAMESPACE, "exposed2")

-- machines
local machineFlash = function(inst, color)
	local flash = object_flash:create(inst.x, inst.y)
	flash.parent = inst.id
	flash.image_blend = color or Color.WHITE
end

local machine_temp_visual_packet = Packet.new()
machine_temp_visual_packet:onReceived(function(message, player)
	local inst = message:read_instance()
	local isFinal = message:read_byte() --Plays a different sound when downgrading finishes
	machineFlash(inst, color_tech_red)
	gm.sound_play_at(gm.bool(isFinal) and sound_downgrade or sound_downgradeBeep, 1, 1, inst.x, inst.y)
end)

local machine_update_temp = function(inst)
	if inst.upgrade_progress_temp > 0 then
		if inst.upgrade_progress_temp_timer < 300 and inst.upgrade_progress_temp_timer % 120 == 0 then
			machineFlash(inst, color_tech_red)
			if gm._mod_net_isHost() then
				if inst.upgrade_progress_temp_timer <= 0 then
					inst.upgrade_progress = inst.upgrade_progress - inst.upgrade_progress_temp
					inst.upgrade_progress_temp = 0
					gm.sound_play_at(sound_downgrade, 1, 1, inst.x, inst.y)
				else
					gm.sound_play_at(sound_downgradeBeep, 1, 1, inst.x, inst.y)
				end
				if not Net.is_single() then
					local buffer = machine_temp_visual_packet:message_begin()
					buffer:write_instance(inst)
					buffer:write_byte(inst.upgrade_progress_temp_timer <= 0 and 1 or 0)
					buffer:send_to_all()
				end
			end
		end
		inst.upgrade_progress_temp_timer = inst.upgrade_progress_temp_timer - 1
	end
end

local upgrade_machine = function(inst, amount, tempTimer)
	if inst.upgrade_progress < inst.upgrade_progress_max then
		if gm._mod_net_isHost() then
			inst.upgrade_progress = math.min(inst.upgrade_progress + amount, inst.upgrade_progress_max)
			if tempTimer then
				inst.upgrade_progress_temp = math.min(inst.upgrade_progress_temp + amount, inst.upgrade_progress_max)
				inst.upgrade_progress_temp_timer = tempTimer
			end
		end
		particle_spark:create(inst.x, inst.y, math.random(2, 4), Particle.SYSTEM.middle)
		gm.sound_play_at(sound_wrenchHit, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
	end
end

-- Turret

local turret_shoot_packet = Packet.new()
turret_shoot_packet:onReceived(function(message, player)
	local inst = message:read_instance()
	inst.playanim = 1
	inst.image_index = 0
	gm.sound_play_at(inst.upgradeState >= 1 and sound_turretShoot2 or sound_turretShoot1, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
end)

local turret_shoot_packet_host = Packet.new()
turret_shoot_packet_host:onReceived(function(message, player)
	local inst = message:read_instance()
	local owner = message:read_instance()
	inst.playanim = 1
	inst.image_index = 0
	gm.sound_play_at(inst.upgradeState >= 1 and sound_turretShoot2 or sound_turretShoot1, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
	
	local buffer = turret_shoot_packet:message_begin()
	buffer:write_instance(inst)
	buffer:send_exclude(owner)
end)

local turret_missile_state_packet = Packet.new()
turret_missile_state_packet:onReceived(function(message, player)
	local inst = message:read_instance()
	local missileState = message:read_byte() - 1
	inst.switchMissileState = missileState
end)

local shoot_missiledis_offset_map = {
	{-8, 2},
	{-4, 1},
	{-1, 0},
	{0, 0},
}

local obj_turret = Object.new(NAMESPACE, "turret", Object.PARENT.actor)
obj_turret:set_sprite(sprite_turretaI)
obj_turret:clear_callbacks()
obj_turret:onCreate(function(inst)
	inst.mask_index = turret_mask
	inst.idle = sprite_turretaI
	inst.shoot = sprite_turretashoot
	inst.sparks = sprite_sparks1
	inst.init = nil
	inst.upgrade_progress = 0
	inst.upgrade_progress_max = 3
	inst.upgrade_progress_temp = 0
	inst.upgrade_progress_temp_timer = 0
	inst.cooldown = 0
	inst.basecooldown = 50
	inst.secondarycooldown = 0
	inst.secondarystocks = 0
	inst.basesecondarycooldown = 90
	inst.extrasecondarycooldown = 12
	inst.basesecondarystocks = 4
	inst.damage = 1
	inst.co_damage = technicianSpecial.damage
	inst.upgradeState = 0
	inst.ff = 0
	inst.image_speed = 0.2
	inst.intangible = true
	inst:instance_sync()
end)
obj_turret:onStep(function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		if not inst.oy then inst.oy = inst.y end
		inst.ff = inst.ff + 1
		inst.y = inst.oy - math.sin(inst.ff / 20) * 2 - 2
		
		inst.scepter = inst.parent:item_stack_count(item_scepter)
		if not inst.init then
			local xx, _ = move_point_contact_solid(inst.x, inst.y, 90 - 90 * inst.image_xscale, 800)
			inst.range = math.abs(xx - inst.x)
			inst.init = 1
			
			obj_sprite_layer.obj_depth = -12
			inst.skin_layer = obj_sprite_layer:create(inst.x, inst.y)
			inst.skin_layer.parent = inst
			inst.skin_layer.sprite_index = inst.sprite_index
			inst.skin_layer.image_xscale = inst.image_xscale
			inst.skin_layer:actor_skin_skinnable_init()
			inst.skin_layer:actor_skin_skinnable_set_skin(inst.parent)
			inst.skin_layer.skinnable = 1
		end
		
		machine_update_temp(inst)
		if inst.upgrade_progress_max < 6 and inst.scepter > 0 then
			inst.upgrade_progress_max = 6
		end
		local doResync = false
		if inst.upgrade_progress < 3 and inst.upgradeState ~= 0 then
			inst.idle = sprite_turretaI
			inst.shoot = sprite_turretashoot
			inst.sparks = sprite_sparks1
			inst.basecooldown = 50
			inst.co_damage = technicianSpecial.damage
			inst.upgradeState = 0
			inst.cooldown = math.min(inst.cooldown, inst.basecooldown)
			inst.playanim = nil
			if inst.missileDis then inst.missileDis:destroy() end
			doResync = true
		end
		if inst.upgrade_progress >= 3 and inst.upgrade_progress < 6 and inst.upgradeState ~= 1 then
			inst.idle = sprite_turretbI
			inst.shoot = sprite_turretbshoot
			inst.sparks = sprite_sparks2
			inst.basecooldown = 12
			inst.co_damage = 0.7
			inst.upgradeState = 1
			inst.cooldown = math.min(inst.cooldown, inst.basecooldown)
			inst.playanim = nil
			if (inst.prevUpgradeState or inst.upgradeState) < inst.upgradeState then
				machineFlash(inst)
				gm.sound_play_at(sound_turretUpgrade, 1, 1, inst.x, inst.y)
			end
			if inst.missileDis then inst.missileDis:destroy() end
			doResync = true
		end
		if inst.upgrade_progress >= 6 and inst.upgradeState ~= 2 then
			inst.idle = sprite_turretcI
			inst.shoot = sprite_turretcshoot
			inst.sparks = sprite_sparks3
			obj_sprite_layer.obj_depth = 1
			inst.missileDis = obj_sprite_layer:create(inst.x, inst.y)
			inst.missileDis.parent = inst
			inst.missileDis.sprite_index = sprite_turretc_mis1
			inst.missileDis.image_xscale = inst.image_xscale
			inst.secondarystocks = inst.basesecondarystocks
			inst.missileState = 1
			inst.upgradeState = 2
			inst.playanim = nil
			machineFlash(inst)
			machineFlash(inst.missileDis)
			gm.sound_play_at(sound_turretUpgrade, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
			doResync = true
		end
		
		if inst.playanim then
			inst.image_speed = 0.2 * inst.attack_speed
			inst.sprite_index = inst.shoot
			if inst.image_index >= gm.sprite_get_number(inst.shoot) - 1 then
				inst.playanim = nil
			end
		else
			inst.sprite_index = inst.idle
			inst.image_speed = 0.2
		end
		if gm._mod_net_isHost() and doResync then
			inst:instance_resync()
		end
		
		if inst.missileDis and Instance.exists(inst.missileDis) then
			local xo, yo = 0, 0
			if inst.playanim then
				xo = shoot_missiledis_offset_map[math.floor(inst.image_index + 1)][1]
				yo = shoot_missiledis_offset_map[math.floor(inst.image_index + 1)][2]
			end
			if inst.switchMissileState then
				if inst.switchMissileState == -1 then
					if inst.missileDis.sprite_index == sprite_turretc_mis3 then
						inst.missileDis.image_index = math.min(inst.missileDis.image_index + 0.3, gm.sprite_get_number(sprite_turretc_mis3) - 1)
						if inst.missileDis.image_index >= gm.sprite_get_number(inst.missileDis.sprite_index) - 1 then
							inst.missileDis.sprite_index = sprite_turretc_mis2
						end
					else
						inst.missileDis.image_index = math.max(inst.missileDis.image_index - 0.2, 0)
						if inst.missileDis.image_index <= 0 then
							inst.missileState = 1
							inst.switchMissileState = nil
						end
					end
				else
					inst.missileDis.sprite_index = sprite_turretc_mis2
					inst.missileDis.image_index = math.min(inst.missileDis.image_index + 0.3, gm.sprite_get_number(inst.missileDis.sprite_index) - 1)
					if inst.missileDis.image_index >= gm.sprite_get_number(inst.missileDis.sprite_index) - 1 then
						inst.missileState = 2
						inst.switchMissileState = nil
					end
				end
			elseif inst.missileState == 2 then
				inst.missileDis.sprite_index = sprite_turretc_mis3
				inst.missileDis.image_index = math.min(inst.missileDis.image_index + 0.2, gm.sprite_get_number(sprite_turretc_mis3) - 1)
			else
				inst.missileDis.sprite_index = sprite_turretc_mis1
				inst.missileDis.image_index = inst.image_index
			end
			inst.missileDis.x = inst.x + xo * inst.image_xscale
			inst.missileDis.y = inst.y + yo
		end
		
		if inst.parent:is_authority() or (inst.upgradeState == 2 and gm._mod_net_isHost()) then
			local wantattack = false
			local victims = List.new()
			inst:collision_line_list(inst.x, inst.y, inst.x + inst.range * inst.image_xscale, inst.y, gm.constants.pActorCollisionBase, false, true, victims, false)
			for _, victim in ipairs(victims) do
				if inst:attack_collision_canhit(victim) then
					wantattack = victim
					break
				end
			end
			
			inst.cooldown = inst.cooldown - 1
			inst.secondarycooldown = inst.secondarycooldown - 1
			if wantattack then
				if inst.cooldown <= 0 and inst.parent:is_authority() then
					inst.playanim = 1
					inst.image_index = 0
					--print(inst.attack_speed)
					inst.cooldown = inst.basecooldown / inst.attack_speed
					inst.damage = inst.parent.damage
					for i = 0, inst.parent:buff_stack_count(buff_mirror) do
						local attack_info = inst:fire_bullet(inst.x, inst.y + (inst.upgradeState >= 1 and 8 or 10), 1000, 90 - 90 * inst.image_xscale, inst.co_damage, nil, inst.sparks, Attack_Info.TRACER.commando1).attack_info
						setNoProc(attack_info)
						attack_info.climb = i * 8 * 1.35
					end
					gm.sound_play_at(inst.upgradeState >= 1 and sound_turretShoot2 or sound_turretShoot1, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
					if not Net.is_single() then
						if gm._mod_net_isHost() then
							local buffer = turret_shoot_packet:message_begin()
							buffer:write_instance(inst)
							buffer:send_to_all()
						else
							local buffer = turret_shoot_packet_host:message_begin()
							buffer:write_instance(inst)
							buffer:write_instance(inst.parent)
							buffer:send_to_host()
						end
					end
				end
				if inst.upgradeState == 2 and gm._mod_net_isHost() then
					if inst.missileState == 2 then
						if inst.secondarycooldown <= 0 then
							local missile = object_missile:create(inst.x - 16 * inst.image_xscale, inst.y - 20)
							missile.parent = inst.id
							missile.team = inst.team
							missile.damage = inst.parent.damage
							missile.sync = true
							inst.missileDis.image_index = 0
							inst.secondarystocks = inst.secondarystocks - 1
							inst.secondarycooldown = inst.extrasecondarycooldown
							if inst.secondarystocks <= 0 then
								inst.secondarycooldown = inst.basesecondarycooldown
								inst.secondarystocks = inst.basesecondarystocks
								inst.switchMissileState = -1
								
								if not Net.is_single() then
									local buffer = turret_missile_state_packet:message_begin()
									buffer:write_instance(inst)
									buffer:write_byte(inst.switchMissileState + 1)
									buffer:send_to_all()
								end
							end
						end
					elseif inst.secondarycooldown <= 4 * gm.sprite_get_number(sprite_turretc_mis2) and not inst.switchMissileState then
						inst.missileDis.image_index = 0
						inst.switchMissileState = 1
						
						if not Net.is_single() then
							local buffer = turret_missile_state_packet:message_begin()
							buffer:write_instance(inst)
							buffer:write_byte(inst.switchMissileState + 1)
							buffer:send_to_all()
						end
					end
				end
			else
				if inst.switchMissileState ~= -1 then
					inst.switchMissileState = -1
					
					if not Net.is_single() then
						local buffer = turret_missile_state_packet:message_begin()
						buffer:write_instance(inst)
						buffer:write_byte(inst.switchMissileState + 1)
						buffer:send_to_all()
					end
				end
				if inst.secondarycooldown <= 0 then
					inst.secondarycooldown = inst.basesecondarycooldown
					inst.secondarystocks = inst.basesecondarystocks
				end
			end
		end
		
		if inst.skin_layer then
			inst.skin_layer.x = inst.x
			inst.skin_layer.y = inst.y
			inst.skin_layer.sprite_index = inst.sprite_index
			inst.skin_layer.image_index = inst.image_index
		end
		
		inst.prevUpgradeState = inst.upgradeState
	else
		inst:destroy()
	end
end)
obj_turret:onDestroy(function(inst)
	local ef_sparks = object_sparks:create(inst.x, inst.y)
	ef_sparks.sprite_index = explosion3
	ef_sparks.image_speed = 0.3
	ef_sparks.image_yscale = 1
	
	gm.sound_play_at(sound_turretDeath, 1, 1, inst.x, inst.y)
	inst:screen_shake(2)
	
	if gm._mod_net_isHost() then
		inst:instance_destroy_sync()
	end
end)
obj_turret:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_byte(self.image_xscale + 1) --We have to add +1 otherwise the byte will underflow if -1
	buffer:write_byte(self.upgrade_progress)
end)
obj_turret:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.image_xscale = buffer:read_byte() - 1 --Revert the +1 after being recieved
	self.upgrade_progress = buffer:read_byte()
end)

-- Vending Machine

buff_vending.icon_sprite = buff_vending_sprite
buff_vending_2.icon_sprite = buff_vending_2_sprite
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

local drinkSprites = {
	[technician_id] = {sprite_drink_technician_1, sprite_drink_technician_2}
}

local stateDrink = State.new(NAMESPACE, "technicianDrink")

stateDrink:clear_callbacks()
stateDrink:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.sprite = actor.__ssr_current_drink_sprite or drinkSprites[technician_id][1]
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)
stateDrink:onStep(function(actor, data)
	actor.sprite_index2 = data.sprite

	actor:skill_util_strafe_update(0.2, 1)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	handle_strafing_yoffset(actor)
	
	if actor.image_index2 >= gm.sprite_get_number(data.sprite) then
		actor:skill_util_reset_activity_state()
	end
end)
stateDrink:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)
stateDrink:onGetInterruptPriority(function(actor, data)
	return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
end)

local vending_shoot_packet = Packet.new()
vending_shoot_packet:onReceived(function(message, player)
	local inst = message:read_instance()
	local recipient = message:read_instance()
	inst.playanim = 1
	if recipient.actor_state_current_id == -1 and drinkSprites[recipient.class] then
		recipient:sound_play(sound_vendingDrink, 1, 1)
		recipient.__ssr_current_drink_sprite = drinkSprites[recipient.class][inst:get_data().upgraded and 2 or 1]
		recipient:enter_state(stateDrink)
	end
end)

local obj_vending = Object.new(NAMESPACE, "vending")
obj_vending:set_sprite(sprite_vending1)
obj_vending.obj_depth = 20
obj_vending:clear_callbacks()
obj_vending:onCreate(function(inst)
	inst.gravity = MACHINE_VENDING_GRAV
	inst.init = nil
	inst.upgrade_progress = 0
	inst.upgrade_progress_max = 3
	inst.upgrade_progress_temp = 0
	inst.upgrade_progress_temp_timer = 0
	inst.image_speed = 0.2
	inst.upgraded = nil
	inst.buff = buff_vending
	inst:actor_skin_skinnable_init()
	inst:instance_sync()
end)
obj_vending:onStep(function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		local height = inst.bbox_bottom - inst.bbox_top
		for i = 1, (math.floor((inst.vspeed + inst.gravity) / height) + 1) do
			if is_colliding_stage(inst, inst.x, inst.y + inst.vspeed + inst.gravity - height * (i - 1)) then
				move_contact_solid(inst, 90, 32)
				if inst.vspeed > MACHINE_VENDING_DAMAGE_THRESHOLD then
					if inst.parent:is_authority() then
						for i = 0, inst.parent:buff_stack_count(buff_mirror) do
							local attack_info = inst.parent:fire_explosion(inst.x, inst.y - MACHINE_VENDING_BLAST_H / 2, MACHINE_VENDING_BLAST_W, MACHINE_VENDING_BLAST_H, inst.parent:skill_get_damage(technicianUtility) * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD)^1.5).attack_info
							attack_info.climb = i * 8 * 1.35
						end
					end
				
					local ef_sparks = object_sparks:create(inst.x, inst.y)
					ef_sparks.sprite_index = mine_explosion
					ef_sparks.image_speed = 0.25
					ef_sparks.image_yscale = 1
				end
				if inst.vspeed > 0 then
					inst:screen_shake(math.floor(inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD * 2) + 3)
					gm.sound_play_at(soundImpact, math.min(0.7 + 0.4 * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD), 1.5), math.max(1.4 - 0.4 * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD), 0.6), inst.x, inst.y)
				
					inst.xo = inst.x
					inst.shakeTimer = math.floor(inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD * 4) + 6
				end
				
				inst.vspeed = 0
				inst.gravity = 0
			end
			
			if inst.vspeed > MACHINE_VENDING_DAMAGE_THRESHOLD and Global._current_frame % math.max(4 - math.floor(inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD), 1) == 0 then
				local trail = GM.instance_create(inst.x, inst.y - height * (i - 1), gm.constants.oEfTrail)
				trail.sprite_index = inst.sprite_index
				trail.image_index = inst.image_index
				trail.image_blend = gm.merge_colour(inst.image_blend, Color.BLACK, 0.25)
				trail.image_xscale = inst.image_xscale
				trail.image_yscale = inst.image_yscale
				trail.image_alpha = trail.image_alpha * (0.2 * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD))
				trail.depth = inst.depth + 1
				trail:actor_skin_skinnable_set_skin(inst.parent)
			end
		end
		
		if (inst.shakeTimer or 0) > 0 then
			inst.x = inst.xo + math.random(-math.floor(inst.shakeTimer * 0.75), math.floor(inst.shakeTimer * 0.75))
			inst.shakeTimer = inst.shakeTimer - 1
			if inst.shakeTimer <= 0 then
				inst.x = inst.xo
			end
		end
		
		local doResync = false
		machine_update_temp(inst)
		if inst.upgrade_progress < 3 and inst.upgraded then
			inst.sprite_index = sprite_vending1
			inst.upgraded = nil
			inst.buff = buff_vending
			doResync = true
		end
		if inst.upgrade_progress >= 3 and not inst.upgraded then
			inst.sprite_index = sprite_vending2
			inst.upgraded = 1
			inst.buff = buff_vending_2
			machineFlash(inst)
			gm.sound_play_at(sound_vendingUpgrade, 1, 1, inst.x, inst.y)
			doResync = true
		end
		if inst.playanim then
			if inst.image_index >= gm.sprite_get_number(inst.sprite_index) - 1 then
				inst.playanim = nil
			end
		else
			inst.image_index = 0
		end
		if gm._mod_net_isHost() then
			if doResync then
				inst:instance_resync()
			end
			for _, player in ipairs(inst:get_collisions(gm.constants.oP)) do
				if player.team == inst.team and player:buff_stack_count(inst.buff) <= 0 then
					gm.sound_play_at(sound_vendingDispense, 1, 1, inst.x, inst.y)
					player:buff_remove(buff_vending)
					player:buff_apply(inst.buff, 5 * 60)
					if player.actor_state_current_id == -1 and drinkSprites[player.class] then
						player:sound_play(sound_vendingDrink, 1, 1)
						player.__ssr_current_drink_sprite = drinkSprites[player.class][inst.upgraded and 2 or 1]
						player:enter_state(stateDrink)
					end
					inst.playanim = 1
					if not Net.is_single() then
						local buffer = vending_shoot_packet:message_begin()
						buffer:write_instance(inst)
						buffer:write_instance(player)
						buffer:send_to_all()
					end
					break
				end
			end
		end
	else
		inst:destroy()
	end
end)
obj_vending:onDraw(function(inst)
	inst:actor_skin_skinnable_draw_self()
end)
obj_vending:onDestroy(function(inst)
	if gm._mod_net_isHost() then
		inst:instance_destroy_sync()
	end
end)
obj_vending:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_byte(self.image_xscale + 1) --We have to add +1 otherwise the byte will underflow if -1
	buffer:write_byte(self.upgrade_progress)
end)
obj_vending:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.image_xscale = buffer:read_byte() - 1 --Revert the +1 after being recieved
	self.upgrade_progress = buffer:read_byte()
	self:actor_skin_skinnable_set_skin(self.parent)
end)

-- and they called it a mine

local obj_mine_pull = Object.new(NAMESPACE, "mine_pull")
obj_mine_pull:clear_callbacks()
obj_mine_pull:onCreate(function(inst)
	inst.life = MACHINE_MINE_PULL_LIFE
	inst.ff = 0
end)
obj_mine_pull:onStep(function(inst)
	inst.ff = inst.ff + 1
	local targets = List.wrap(gm.find_characters_circle(inst.x, inst.y, MACHINE_MINE_PULL_RADIUS, true, inst.team == 1 and 2 or 1, true))
	for _, target in ipairs(targets) do
		--Check if we should pull the target
		--Pulling is weird with ropes so climbing enemies are excluded
		--And intangible enemies are usually doing special behavior so best not to interrupt
		if target.team ~= inst.team and not target.intangible and not GM.actor_state_is_climb_state(target.actor_state_current_id) then
			local lastx = target.x
			local lasty = target.y
			local strength = math.max(1, math.ceil((0.5 + 2.5 * (1 - inst.life / MACHINE_MINE_PULL_LIFE) + math.max(-1.5 + 3 * (1 - inst.life / MACHINE_MINE_PULL_LIFE), 0)) * (0.2 + 0.8 * (1 - gm.point_distance(inst.x, inst.y, target.x, target.y) / MACHINE_MINE_PULL_RADIUS))))
			if GM.actor_is_classic(target) then --Classic enemies (Eg. NOT Jellyfish or Archer Bugs) are pulled horizontally to the center of the pull
				target:move_contact_solid(180 + gm.point_direction(inst.x, target.y, target.x, target.y), strength)
			elseif not GM.actor_is_boss(target) then --Non-boss, non-classic enemies are pulled directly to the center
				target.x = target.x - math.cos(math.rad(gm.point_direction(inst.x, inst.y, target.x, target.y))) * strength
				target.y = target.y + math.sin(math.rad(gm.point_direction(inst.x, inst.y, target.x, target.y))) * strength
			end
			
			--Prevent overshooting on both axes
			if lastx < inst.x and target.x >= inst.x then
				target.x = math.min(target.x, inst.x)
			elseif lastx > inst.x and target.x <= inst.x then
				target.x = math.max(target.x, inst.x)
			end
			
			if lasty < inst.y and target.y >= inst.y then
				target.y = math.min(target.y, inst.y)
			elseif lasty > inst.y and target.y <= inst.y then
				target.y = math.max(target.y, inst.y)
			end
		end
	end
	inst.life = inst.life - 1
	if inst.life <= 0 then
		inst:destroy()
	end
end)
local int1 = 60
local int2 = 120 / int1
obj_mine_pull:onDraw(function(inst)
	gm.draw_set_alpha(((0.2 * math.sin(inst.ff / 10)) + 0.4) * math.min(inst.ff / (int1 / 2), 1))
	gm.draw_set_colour(color_tech_blue)
	local a = inst.ff > int1 and (int1 * int2 - (inst.ff - int1) * int1 / (MACHINE_MINE_PULL_LIFE - int1) * int2) or (inst.ff * int2)
	local t = math.min(inst.ff > int1 and (1 - (inst.ff - int1) / (MACHINE_MINE_PULL_LIFE - int1)) or (inst.ff / int1), 1)
	gm.draw_circle(math.floor(inst.x + 0.5), math.floor(inst.y + 0.5), a + (MACHINE_MINE_PULL_RADIUS - a) * t, true)
	gm.draw_set_alpha(1)
end)

local obj_mine = Object.new(NAMESPACE, "mine")
obj_mine:set_sprite(sprite_mine1)
--obj_mine.obj_depth = 218 -- GRAAAAAAH THIS WONT GO BACK   --- Note from the future: Now it does, thanks kris :)      ----Never mind I don't like it
obj_mine:clear_callbacks()
obj_mine:onCreate(function(inst)
	inst.gravity = MACHINE_MINE_GRAV
	inst.mask_index = mine_mask
	inst.upgrade_progress = 0
	inst.upgrade_progress_max = 3
	inst.upgrade_progress_temp = 0
	inst.upgrade_progress_temp_timer = 0
	inst.upgraded = nil
	inst.pull_timer = MACHINE_MINE_PULL_INTERVAL
	inst.ff = 0
	inst.image_speed = 0.2
	inst:actor_skin_skinnable_init()
	inst:instance_sync()
end)
obj_mine:onStep(function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		inst.ff = inst.ff + 1
		inst.hspeed = inst.hspeed * 0.9
		if is_colliding_stage(inst, inst.x + inst.hspeed, inst.y) then
			inst.hspeed = 0
		end
		if is_colliding_stage(inst, inst.x, inst.y + inst.vspeed + inst.gravity) then
			move_contact_solid(inst, 90)
			inst.vspeed = 0
			inst.y = inst.y - inst.gravity
		end
		local doResync = false
		machine_update_temp(inst)
		if inst.upgrade_progress < 3 and inst.upgraded then
			inst.sprite_index = sprite_mine1
			for _, pull in ipairs(Instance.find_all(obj_mine_pull)) do
				if pull.parent == inst.id then
					pull:destroy()
				end
			end
			inst.upgraded = nil
			doResync = true
		end
		if inst.upgrade_progress >= 3 and not inst.upgraded then
			inst.sprite_index = sprite_mine2
			inst.pull_timer = 0
			inst.upgraded = 1
			machineFlash(inst)
			gm.sound_play_at(sound_mineUpgrade, 1, 1, inst.x, inst.y)
			doResync = true
		end
		if gm._mod_net_isHost() and doResync then
			inst:instance_resync()
		end
		if inst.upgraded == 1 then
			inst.pull_timer = inst.pull_timer - 1
			if inst.pull_timer <= 0 then
				local JimmyJohnsPizzeria = obj_mine_pull:create(inst.x, inst.y)
				JimmyJohnsPizzeria.parent = inst.id
				JimmyJohnsPizzeria.team = inst.team
				inst.pull_timer = MACHINE_MINE_PULL_INTERVAL
			end
		end
	else
		inst:destroy()
	end
end)
obj_mine:onDraw(function(inst)
	inst:actor_skin_skinnable_draw_self()
	if not inst.upgraded then
		gm.draw_set_alpha((0.3 * math.sin(inst.ff / 10)) + 0.4)
		gm.draw_set_colour(color_tech_red)
		gm.draw_circle(math.floor(inst.x + 0.5), math.floor(inst.y + 0.5), inst.ff * 2.5 + (70 - inst.ff * 2.5) * math.min(inst.ff / 30, 1), true)
		gm.draw_set_alpha(1)
	end
end)
obj_mine:onDestroy(function(inst)
	for _, pull in ipairs(Instance.find_all(obj_mine_pull)) do
		if pull.parent == inst.id then
			pull:destroy()
		end
	end
	local ef_sparks = object_sparks:create(inst.x, inst.y)
	ef_sparks.sprite_index = mine_explosion
	ef_sparks.image_speed = 0.2
	ef_sparks.image_yscale = 1
	
	gm.sound_play_at(sound_mineExplode1, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
	inst:screen_shake(5)
	
	if gm._mod_net_isHost() then
		for i = 0, inst.parent:buff_stack_count(buff_mirror) do
			local attack_info = inst.parent:fire_explosion(inst.x, inst.y, get_tiles(6), get_tiles(6), inst.parent:skill_get_damage(technicianSecondary)).attack_info
			attack_info.knockback = 6
			attack_info.climb = i * 8 * 1.35
			if inst.upgraded then
				attack_info:set_stun(1.2)
			end
		end
		
		inst:instance_destroy_sync()
	end
end)
obj_mine:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_int(self.hspeed)
	buffer:write_byte(self.upgrade_progress)
end)
obj_mine:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.hspeed = buffer:read_int()
	self.upgrade_progress = buffer:read_byte()
	self:actor_skin_skinnable_set_skin(self.parent)
end)

-- Stick of Death

buff_exposed.icon_sprite = buff_exposed_sprite
buff_exposed_2.icon_sprite = buff_exposed_2_sprite
buff_exposed:clear_callbacks()
buff_exposed_2:clear_callbacks()

local obj_amplifier = Object.new(NAMESPACE, "amplifier")
obj_amplifier:set_sprite(sprite_amplifier1)
obj_amplifier:clear_callbacks()
obj_amplifier:onCreate(function(inst)
	inst.gravity = MACHINE_VENDING_GRAV
	inst.mask_index = amplifier_mask
	inst.idle = sprite_turretaI
	inst.shoot = sprite_turretashoot
	inst.radius = MACHINE_AMPLIFIER_RADIUS
	inst.upgrade_progress = 0
	inst.upgrade_progress_max = 3
	inst.upgrade_progress_temp = 0
	inst.upgrade_progress_temp_timer = 0
	inst.visual_radius = 0
	inst.ff = 0
	inst.upgraded = nil
	inst.buff = buff_exposed
	inst:instance_sync()
end)
obj_amplifier:onStep(function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		inst.ff = inst.ff + 1
		if is_colliding_stage(inst, inst.x, inst.y + inst.vspeed + inst.gravity) then
			move_contact_solid(inst, 90, 32)
			if inst.vspeed > MACHINE_VENDING_DAMAGE_THRESHOLD and inst.parent:is_authority() then
				inst.parent:fire_explosion(inst.x, inst.y - MACHINE_VENDING_BLAST_H / 2, MACHINE_VENDING_BLAST_W, MACHINE_VENDING_BLAST_H, inst.parent:skill_get_damage(technicianUtilityAlt) * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD) * 2 - inst.parent:skill_get_damage(technicianUtilityAlt))
				inst:screen_shake(math.floor(inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD) + 2)
			
				local ef_sparks = object_sparks:create(inst.x, inst.y - 9)
				ef_sparks.sprite_index = explosion2
				ef_sparks.image_speed = 0.25
				ef_sparks.image_yscale = 1
			end
			inst.vspeed = 0
			inst.gravity = 0
		end
		
		inst.visual_radius = gm.lerp(inst.visual_radius, inst.radius, 0.2)
		
		local doResync = false
		machine_update_temp(inst)
		if inst.upgrade_progress < 3 and inst.upgraded then
			inst.sprite_index = sprite_amplifier1
			inst.buff = buff_exposed
			inst.upgraded = nil
			doResync = true
		end
		if inst.upgrade_progress >= 3 and not inst.upgraded then
			inst.sprite_index = sprite_amplifier2
			inst.buff = buff_exposed_2
			inst.upgraded = 1
			machineFlash(inst)
			doResync = true
		end
		
		if gm._mod_net_isHost() then
			if doResync then
				inst:instance_resync()
			end
			
			local targets = List.wrap(gm.find_characters_circle(inst.x, inst.y, inst.radius, true, inst.team == 1 and 2 or 1, true))
			for _, target in ipairs(targets) do
				if inst:attack_collision_canhit(target) then
					target:buff_remove(buff_exposed)
					target:buff_apply(inst.buff, 2)
				end
			end
		end
	else
		inst:destroy()
	end
end)
obj_amplifier:onDraw(function(inst)
	gm.draw_set_alpha((0.4 * math.sin(inst.ff * 0.07)) + 0.4)
	gm.draw_set_colour(inst.upgraded and color_tech_orange or color_tech_red)
	gm.draw_circle(math.floor(inst.x + 0.5), math.floor(inst.y + 0.5), inst.visual_radius, true)
	gm.draw_set_alpha(1)
end)
obj_amplifier:onDestroy(function(inst)
	if gm._mod_net_isHost() then
		inst:instance_destroy_sync()
	end
end)
obj_amplifier:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_byte(self.upgrade_progress)
end)
obj_amplifier:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.upgrade_progress = buffer:read_byte()
end)

-- Misc

local machines = {obj_turret, obj_vending, obj_mine, obj_amplifier}
local healable_survivors = {
	[Survivor.find("ror-chef").value] = true,
	[Survivor.find("ror-hand").value] = true,
}
local healable_objects = { Object.find("ror", "EngiTurret"), Object.find("ror", "EngiTurretB") }

Callback.add(Callback.TYPE.onAttackHit, "SSOnHitTechnician", function(hit_info)
	local expose = 0
	if hit_info.target:buff_stack_count(buff_exposed) >= 1 then expose = 1 end
	if hit_info.target:buff_stack_count(buff_exposed_2) >= 1 then expose = 2 end
	if not hit_info.attack_info.__ssr_technician_is_expose and hit_info.inflictor and Instance.exists(hit_info.inflictor) and expose >= 1 and gm._mod_net_isHost() then
		local attack_info = hit_info.inflictor:fire_direct(hit_info.target, hit_info.damage * 0.15 / hit_info.inflictor.damage, hit_info.attack_info.direction, hit_info.target.x - 10, hit_info.target.y).attack_info
		attack_info.__ssr_technician_is_expose = expose
		attack_info.damage_color = expose == 2 and color_tech_orange or color_tech_red
		attack_info.climb = 8 * 1.35
	end
	
	if hit_info.attack_info.__wrench_hit then
		if hit_info.attack_info.__wrench_hit == 1 then
			gm.sound_play_at(sound_wrenchHit, 1, 0.8 + math.random() * 0.3, hit_info.target.x, hit_info.target.y)
			hit_info.attack_info.__wrench_hit = 2
		end
		
		local sparks = object_sparks:create(hit_info.target.x, hit_info.target.y)
		sparks.sprite_index = (hit_info.attack_info.__wrench_hit == 3 and sprite_sparks5 or sprite_sparks4)
		sparks.image_speed = 0.33
		sparks.image_xscale = gm.sign(hit_info.target.x - hit_info.inflictor.x)
		sparks.depth = hit_info.target.depth - 1
	end
end)

--Hook from Needles
gm.pre_script_hook(gm.constants.damager_calculate_damage, function(self, other, result, args)
	local _hit_info = args[1]
	local _damage = args[4]
	local _critical = args[5]
	if _hit_info and _hit_info.value and (_hit_info.value.attack_info.__ssr_technician_is_expose or 0) >= 2 and not gm.bool(_critical.value) then
		_critical.value = true
		_damage.value = _damage.value * 2
	end
end)

----TEMPORARY: Will be removed when a proper solution is added to the api
--Plays the survivor's selection sound when being selected in the character select screen
local localSelectMenu
local playedSound = false
gm.pre_script_hook(gm.constants.game_lobby_start, function(self, other, result, args)
	local function WaitForInit()
		localSelectMenu = Instance.find(Object.find("ror", "SelectMenu"))
	end
	Alarm.create(WaitForInit, 25)
end)

gm.pre_script_hook(gm.constants._ui_update, function(self, other, result, args)
	if not Instance.exists(localSelectMenu) then return end
	
	if localSelectMenu.choice == technician.value then
		if not playedSound then
			gm.sound_play_at(sound_select, 1, 1, 1000, 100)
			
			if gm.audio_is_playing(soundCommandoSelect) then
				gm.audio_stop_sound(soundCommandoSelect)
			end
			
			playedSound = true
		end
	else
		playedSound = false
	end
end)

-- Wrench Whack
technicianPrimary.sprite = sprite_skills
technicianPrimary.subimage = 0

technicianPrimary.cooldown = 5
technicianPrimary.damage = 1.8
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

	handle_strafing_yoffset(actor)

	if data.fired == 0 and actor.image_index2 >= 2 then
		data.fired = 1

		actor:sound_play(sound_shoot1, 0.3, 0.9 + math.random() * 0.2)
		
		local damage = actor:skill_get_damage(technicianPrimary)
		local dir = actor:skill_util_facing_direction()

		if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
			for i = 0, actor:buff_stack_count(buff_mirror) do
				if actor:is_authority() then
					local attack_info = actor:fire_explosion(actor.x + WRENCH_BLAST_OFFSET_X * actor.image_xscale, actor.y + WRENCH_BLAST_OFFSET_Y, WRENCH_BLAST_W, WRENCH_BLAST_H, actor:skill_get_damage(technicianPrimary)).attack_info
					attack_info.climb = i * 8 * 1.35
					attack_info.knockback_direction = actor.image_xscale
					attack_info.__wrench_hit = 1
				end
				local machinesHit = List.new()
				local x, y, x2, y2 = (actor.x + (WRENCH_BLAST_OFFSET_X - WRENCH_BLAST_W / 2) * actor.image_xscale), (actor.y - WRENCH_BLAST_H / 2 + WRENCH_BLAST_OFFSET_Y), (actor.x + (WRENCH_BLAST_OFFSET_X + WRENCH_BLAST_W / 2) * actor.image_xscale), (actor.y + WRENCH_BLAST_H / 2 + WRENCH_BLAST_OFFSET_Y)
				actor:collision_rectangle_list(x, y, x2, y2, gm.constants.oCustomObject, false, true, machinesHit, false)
				actor:collision_rectangle_list(x, y, x2, y2, gm.constants.oCustomObject_pNPC, false, true, machinesHit, false)
				-- ^ finding all machines in machines table that collides with the explosion to upgrade
				for _, machineObj in ipairs(machines) do
					for _, instance in ipairs(machinesHit) do
						if machineObj.value == instance.__object_index then
							if instance.team == actor.team then
								upgrade_machine(instance, 1, WRENCH_DOWNGRADE_TIME)
							end
						end
					end
				end
				local healablesHit = List.new()
				actor:collision_rectangle_list(x, y, x2, y2, gm.constants.oP, false, true, healablesHit, false)
				for _, object in ipairs(healable_objects) do
					actor:collision_rectangle_list(x, y, x2, y2, object, false, true, healablesHit, false)
				end
				for _, instance in ipairs(healablesHit) do
					if instance.object_index ~= gm.constants.oP or healable_survivors[instance.class] then
						instance:heal(10)
						gm.sound_play_at(sound_wrenchHit, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
						particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.SYSTEM.middle)
					end
				end
			end
		else
			local machinesHit = List.new()
			local endX, _ = move_point_contact_solid(actor.x, actor.y, 90 - 90 * actor.image_xscale, 700)
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oCustomObject, false, true, machinesHit, false)
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oCustomObject_pNPC, false, true, machinesHit, false)
			for _, machineObj in ipairs(machines) do
				for _, instance in ipairs(machinesHit) do
					if machineObj.value == instance.__object_index then
						if instance.team == actor.team then
							upgrade_machine(instance, 1, WRENCH_DOWNGRADE_TIME)
						end
					end
				end
			end
			local healablesHit = List.new()
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oP, false, true, healablesHit, false)
			for _, object in ipairs(healable_objects) do
				actor:collision_line_list(actor.x, actor.y, endX, actor.y, object, false, true, healablesHit, false)
			end
			for _, instance in ipairs(healablesHit) do
				if instance.object_index ~= gm.constants.oP or healable_survivors[instance.class] then
					instance:heal(10)
					gm.sound_play_at(sound_wrenchHit, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
					particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.SYSTEM.middle)
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
	return actor.image_index2 >= 6 and State.ACTOR_STATE_INTERRUPT_PRIORITY.any or State.ACTOR_STATE_INTERRUPT_PRIORITY.skill
end)

-- Wrench Throw
local obj_wrench = Object.new(NAMESPACE, "wrench")
obj_wrench:set_sprite(sprite_wrench)
obj_wrench:clear_callbacks()
obj_wrench:onCreate(function(inst)
	local data = inst:get_data()
	data.hit = {}
	inst.mask_index = wrench_mask
	inst.image_speed = 0.2
	inst.damage = 1
	inst.speed = 5
	inst.climb = 0
	inst.life = 170
	inst.hits = 3
	
	inst.team = 1
	inst.parent = -4
	inst:actor_skin_skinnable_init()
end)
obj_wrench:onStep(function(inst)
	local data = inst:get_data()
	if inst.life <= 0 or not (inst.parent and Instance.exists(inst.parent)) then
		inst.image_alpha = inst.image_alpha - 0.04
		inst.image_angle = inst.image_angle - inst.speed * 3
		if inst.image_alpha <= 0 then
			inst:destroy()
		end
	elseif inst.hits <= 0 then
		inst:destroy()
	elseif inst:is_colliding(gm.constants.pBlock) then
		particle_spark:create(inst.x, inst.y, math.random(2, 3), Particle.SYSTEM.middle)
		gm.sound_play_at(sound_wrenchHit, 1, 0.8 + math.random() * 0.3, inst.x, inst.y)
		inst:destroy()
	else
		inst.life = inst.life - 1
		inst.image_angle = inst.image_angle - inst.speed * 3
		for _, actor in ipairs(inst:get_collisions(gm.constants.pActorCollisionBase)) do
			if inst:attack_collision_canhit(actor) and not data.hit[actor.id] then
				if inst.parent:is_authority() then
					for i = 0, inst.parent:buff_stack_count(buff_mirror) do
						local attack_info = inst.parent:fire_direct(actor, inst.damage, inst.direction, inst.x, inst.y).attack_info
						attack_info.climb = i * 8 * 1.35
						attack_info.__wrench_hit = 3
					end
				end
				inst.hits = inst.hits - 1
				data.hit[actor.id] = true
				gm.sound_play_at(sound_wrenchHit, 1, 0.8 + math.random() * 0.3, inst.x, inst.y)
				break
			end
		end
		local machinesHit = List.new()
		inst.parent:collision_rectangle_list(inst.x - 9, inst.y - 9, inst.x + 9, inst.y + 9, gm.constants.oCustomObject, false, true, machinesHit, false)
		inst.parent:collision_rectangle_list(inst.x - 9, inst.y - 9, inst.x + 9, inst.y + 9, gm.constants.oCustomObject_pNPC, false, true, machinesHit, false)
		for _, machineObj in ipairs(machines) do
			for _, instance in ipairs(machinesHit) do
				if machineObj.value == instance.__object_index then
					if instance.team == inst.team and not data.hit[instance.id] then
						upgrade_machine(instance, 1, WRENCH_THROW_DOWNGRADE_TIME)
						data.hit[instance.id] = true
						break
					end
				end
			end
		end
		local healablesHit = List.new()
		inst.parent:collision_rectangle_list(inst.x - 9, inst.y - 9, inst.x + 9, inst.y + 9, gm.constants.oP, false, true, healablesHit, false)
		for _, object in ipairs(healable_objects) do
			actor:collision_rectangle_list(inst.x - 9, inst.y - 9, inst.x + 9, inst.y + 9, object, false, true, healablesHit, false)
		end
		for _, instance in ipairs(healablesHit) do
			if (instance.object_index ~= gm.constants.oP or healable_survivors[instance.class]) and not data.hit[instance.id] then
				instance:heal(10)
				particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.SYSTEM.middle)
				gm.sound_play_at(sound_wrenchHit, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
				data.hit[instance.id] = true
			end
		end
	end
end)
obj_wrench:onDraw(function(inst)
	inst:actor_skin_skinnable_draw_self()
end)

technicianPrimaryAlt.sprite = sprite_skills
technicianPrimaryAlt.subimage = 6
technician:add_primary(technicianPrimaryAlt)

technicianPrimaryAlt.cooldown = 5
technicianPrimaryAlt.damage = 1.8
technicianPrimaryAlt.require_key_press = false
technicianPrimaryAlt.is_primary = true
technicianPrimaryAlt.does_change_activity_state = true
technicianPrimaryAlt.hold_facing_direction = true
technicianPrimaryAlt.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any

local stateTechnicianPrimaryAlt = State.new(NAMESPACE, "technicianPrimaryAlt")

technicianPrimaryAlt:clear_callbacks()
technicianPrimaryAlt:onActivate(function(actor)
	actor:enter_state(stateTechnicianPrimaryAlt)
end)

stateTechnicianPrimaryAlt:clear_callbacks()
stateTechnicianPrimaryAlt:onEnter(function(actor, data)
	actor.image_index2 = 0
	data.currentAnim = math.random(0, 1)
	
	data.fired = 0
	
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)
stateTechnicianPrimaryAlt:onStep(function(actor, data)
	actor.sprite_index2 = data.currentAnim == 1 and sprite_shoot1T_2 or sprite_shoot1T_1

	actor:skill_util_strafe_update(0.2 * actor.attack_speed, gm.constants.STRAFE_SPEED_NORMAL)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	handle_strafing_yoffset(actor)

	if data.fired == 0 and actor.image_index2 >= 3 then
		data.fired = 1

		actor:sound_play(sound_shoot1T, 1, 0.9 + math.random() * 0.2)
		
		local damage = actor:skill_get_damage(technicianPrimaryAlt)
		local dir = actor:skill_util_facing_direction()

		if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
			local wrench = obj_wrench:create(actor.x + 6 * actor.image_xscale, actor.y - 4)
			wrench.speed = wrench.speed * actor.image_xscale
			wrench.team = actor.team
			wrench.parent = actor
			wrench.damage = damage
			wrench:actor_skin_skinnable_set_skin(actor)
		else
			local machinesHit = List.new()
			local endX, _ = move_point_contact_solid(actor.x, actor.y, 90 - 90 * actor.image_xscale, 700)
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oCustomObject, false, true, machinesHit, false)
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oCustomObject_pNPC, false, true, machinesHit, false)
			for _, machineObj in ipairs(machines) do
				for _, instance in ipairs(machinesHit) do
					if machineObj.value == instance.__object_index then
						if instance.team == actor.team then
							upgrade_machine(instance, 1, WRENCH_THROW_DOWNGRADE_TIME)
						end
					end
				end
			end
			local healablesHit = List.new()
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oP, false, true, healablesHit, false)
			for _, object in ipairs(healable_objects) do
				actor:collision_line_list(actor.x, actor.y, endX, actor.y, object, false, true, healablesHit, false)
			end
			for _, instance in ipairs(healablesHit) do
				if instance.object_index ~= gm.constants.oP or healable_survivors[instance.class] then
					instance:heal(10)
					gm.sound_play_at(sound_wrenchHit, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
					particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.SYSTEM.middle)
				end
			end
		end
	end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)
stateTechnicianPrimaryAlt:onExit(function(actor, data)
	actor:skill_util_strafe_exit()
end)

-- Forced Shutdown
technicianSecondary.sprite = sprite_skills
technicianSecondary.subimage = 1
technicianSecondary.cooldown = 3 * 60
technicianSecondary.damage = 5
technicianSecondary.require_key_press = true
technicianSecondary.does_change_activity_state = true
technicianSecondary.use_delay = 10
technicianSecondary.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period

-- big red button
technicianSecondary_Det.sprite = sprite_skills
technicianSecondary_Det.subimage = 2
  
technicianSecondary_Det.cooldown = 0.5 * 60
technicianSecondary_Det.damage = 1.0 --This damage isn't used for anything, only the original skill is
technicianSecondary_Det.require_key_press = true
technicianSecondary_Det.does_change_activity_state = true
technicianSecondary_Det.hold_facing_direction = true
technicianSecondary_Det.auto_restock = false --Makes stocks not regenerate by themselves
technicianSecondary_Det.use_delay = 10
technicianSecondary_Det.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period

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
		actor.tech_saved_stock = actor:get_default_skill(Skill.SLOT.secondary).stock
		actor:add_skill_override(Skill.SLOT.secondary, technicianSecondary_Det, 1) --Replaces the secondary with a new secondary (Remote Detonator)
		actor:get_active_skill(Skill.SLOT.secondary).stock = math.max(actor.tech_saved_stock, 1)
		
		gm.sound_play_at(sound_shoot2, 1, 1, actor.x, actor.y)
		
		if gm._mod_net_isHost() then
			local mine_inst = obj_mine:create(actor.x + 12 * actor.image_xscale, actor.y)
			mine_inst.team = actor.team
			mine_inst.parent = actor
			mine_inst.hspeed = 8 * actor.image_xscale
			mine_inst:actor_skin_skinnable_set_skin(actor)
		end
		data.used = 1
	end
	if not data.used then
		actor:freeze_default_skill(Skill.SLOT.secondary)
	end
	actor:skill_util_exit_state_on_anim_end()
end)

-- blows up mine with mind...

technicianSecondary_Det:clear_callbacks()
technicianSecondary_Det:onActivate(function(actor)
	actor:remove_skill_override(Skill.SLOT.secondary, technicianSecondary_Det, 1)
	actor:get_default_skill(Skill.SLOT.secondary).stock = actor.tech_saved_stock
	actor:override_default_skill_cooldown(Skill.SLOT.secondary, actor:get_default_skill(Skill.SLOT.secondary).cooldown_base * (1 - actor.cdr))
	
	if gm._mod_net_isHost() then
		local mines, _ = Instance.find_all(obj_mine)
		for _, mine in ipairs(mines) do
			if mine.parent.id == actor.id then
				mine:destroy()
			end
		end
	end
end)
technicianSecondary_Det:onStep(function(actor)
	actor:freeze_default_skill(Skill.SLOT.secondary)
end)

-- Vending Machine
technicianUtility.sprite = sprite_skills
technicianUtility.damage = 2
technicianUtility.subimage = 3
technicianUtility.cooldown = 7 * 60
technicianUtility.is_utility = true
technicianUtility.require_key_press = true
technicianUtility.override_strafe_direction = true
technicianUtility.ignore_aim_direction = true

technicianUtility:clear_callbacks()
technicianUtility:onActivate(function(actor)
	if gm._mod_net_isHost() then
		local vendings, _ = Instance.find_all(obj_vending)
		if #vendings >= actor:get_default_skill(Skill.SLOT.utility).max_stock then
			local oldestID = math.huge
			local oldestInst = nil
			for _, vending in ipairs(vendings) do
				if vending.parent.id == actor.id and vending.id < oldestID then
					oldestID = vending.id
					oldestInst = vending
				end
			end
			if oldestInst then
				oldestInst:destroy()
			end
		end
		local vending_inst = obj_vending:create(actor.x, actor.y + 4)
		vending_inst.parent = actor
		vending_inst.team = actor.team
		vending_inst.image_xscale = actor.image_xscale
		vending_inst:actor_skin_skinnable_set_skin(actor)
	end
end)

-- Radial Amplifier
technicianUtilityAlt.sprite = sprite_skills
technicianUtilityAlt.damage = 0.5
technicianUtilityAlt.subimage = 0
technicianUtilityAlt.cooldown = 12 * 60
technicianUtilityAlt.is_utility = true
technicianUtilityAlt.override_strafe_direction = true
technicianUtilityAlt.ignore_aim_direction = true
--technician:add_utility(technicianUtilityAlt)

local stateTechnicianUtilityAlt = State.new(NAMESPACE, "technicianUtilityAlt")
stateTechnicianUtilityAlt.activity_flags = State.ACTIVITY_FLAG.allow_rope_cancel

technicianUtilityAlt:clear_callbacks()
technicianUtilityAlt:onActivate(function(actor)
	actor:enter_state(stateTechnicianUtilityAlt)
end)
stateTechnicianUtilityAlt:clear_callbacks()
stateTechnicianUtilityAlt:onEnter(function(actor, data)
	actor.image_index = 0
	data.created = nil
end)
stateTechnicianUtilityAlt:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	local animation = sprite_shoot4
	if not data.created and actor.image_index >= 4 and gm._mod_net_isHost() then
		local amplifiers, _ = Instance.find_all(obj_amplifier)
		for _, amplifier in ipairs(amplifiers) do
			if amplifier.parent.id == actor.id then
				amplifier:destroy()
			end
		end
		local amplifier_inst = obj_amplifier:create(actor.x, actor.y + 12)
		amplifier_inst.parent = actor
		amplifier_inst.team = actor.team
		data.created = 1
	end
	actor:actor_animation_set(animation, 0.25, true)
	actor:skill_util_exit_state_on_anim_end()
end)

-- Backup Firewall

technicianSpecial.sprite = sprite_skills
technicianSpecial.subimage = 4
technicianSpecial.cooldown = 9 * 60
technicianSpecial.damage = 1.8
technicianSpecial.require_key_press = true
technicianSpecial.does_change_activity_state = true
technicianSpecial.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill

-- Backup Firewall 2.0
local technicianSpecialScepter = Skill.new(NAMESPACE, "technicianVBoosted")
technicianSpecial:set_skill_upgrade(technicianSpecialScepter)

technicianSpecialScepter.sprite = sprite_skills
technicianSpecialScepter.subimage = 5
technicianSpecialScepter.cooldown = 9 * 60
technicianSpecialScepter.damage = 1.8
technicianSpecialScepter.require_key_press = true
technicianSpecialScepter.does_change_activity_state = true
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
	actor:sound_play(sound_shoot4, 1, 0.9 + math.random() * 0.2)

	data.created = nil
	data.scepter = actor:item_stack_count(item_scepter)
end)
stateTechnicianSpecial:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(data.scepter > 0 and sprite_shoot5 or sprite_shoot4, 0.2, true)
	if not data.created and actor.image_index >= 6 and gm._mod_net_isHost() then
		local turrets, _ = Instance.find_all(obj_turret)
		if #turrets >= actor:get_default_skill(Skill.SLOT.special).max_stock then
			local oldestID = math.huge
			local oldestInst = nil
			for _, turret in ipairs(turrets) do
				if turret.parent.id == actor.id and turret.id < oldestID then
					oldestID = turret.id
					oldestInst = turret
				end
			end
			if oldestInst then
				oldestInst:destroy()
			end
		end
		local turret_inst = obj_turret:create(actor.x + 18 * actor.image_xscale, actor.y - 8)
		turret_inst.parent = actor
		turret_inst.team = actor.team
		turret_inst.image_xscale = actor.image_xscale
		--GM.inventory_items_copy(actor, turret_inst, Item.LOOT_TAG.item_blacklist_engi_turrets)
		--GM.actor_queue_dirty(turret_inst)
		if data.scepter > 0 then
			turret_inst.upgrade_progress = 3
		end
		data.created = 1
	end
	actor:skill_util_exit_state_on_anim_end()
end)