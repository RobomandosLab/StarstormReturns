local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Technician")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Technician")

local buff_mirror = Buff.find("shadowClone") -- shattered mirror buff
local item_scepter = Item.find("ancientScepter")
local object_sparks = Object.find("EfSparks") -- standard hit sparks object
local object_flash = Object.find("EfFlash")
local object_missile = Object.find("EfMissile")
local particle_spark = Particle.find("Spark")

-- define all the assets
local sprite_loadout			= Sprite.new("TechnicianSelect", path.combine(SPRITE_PATH, "select.png"), 18, 28, 0)
local sprite_portrait			= Sprite.new("TechnicianPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3) -- CSS screen/general UI survivor icons
local sprite_portrait_small		= Sprite.new("TechnicianPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png")) -- ditto
local sprite_skills				= Sprite.new("TechnicianSkills", path.combine(SPRITE_PATH, "skills.png"), 7)
local sprite_credits 			= Sprite.new("TechnicianCredits", path.combine(SPRITE_PATH, "credits.png"), 1, 7, 12) -- the sprite used at the end of the credits; 2x scale ror1 idle sprite if it exists
local sprite_palette 			= Sprite.new("TechnicianPalette", path.combine(SPRITE_PATH, "palette.png")) -- the color palette used to map skins
local sprite_log				= Sprite.new("TechnicianLog", path.combine(SPRITE_PATH, "log.png")) -- the logbook portrait

local sprite_idle				= Sprite.new("TechnicianIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 9, 13)
local sprite_idle_half			= Sprite.new("TechnicianIdleHalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 9, 13)
local sprite_walk				= Sprite.new("TechnicianWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 11, 15)
local sprite_walk_half			= Sprite.new("TechnicianWalkHalf", path.combine(SPRITE_PATH, "walkHalf.png"), 8, 10, 15)
local sprite_walk_back			= Sprite.new("TechnicianWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 13, 15)
local sprite_jump				= Sprite.new("TechnicianJump", path.combine(SPRITE_PATH, "jump.png"), 1, 14, 14)
local sprite_jump_half			= Sprite.new("TechnicianJumpHalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 14, 14)
local sprite_jump_peak			= Sprite.new("TechnicianJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 14, 14)
local sprite_jump_peak_half		= Sprite.new("TechnicianJumpPeakHalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 14, 12)
local sprite_fall				= Sprite.new("TechnicianFall", path.combine(SPRITE_PATH, "fall.png"), 1, 14, 12)
local sprite_climb				= Sprite.new("TechnicianClimb", path.combine(SPRITE_PATH, "climb.png"), 6, 10, 15)
local sprite_fall_half			= Sprite.new("TechnicianFallHalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 14, 12)
local sprite_death				= Sprite.new("TechnicianDeath", path.combine(SPRITE_PATH, "death.png"), 8, 13, 12)
local sprite_decoy				= Sprite.new("TechnicianDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 17, 16)
local sprite_drone_idle			= Sprite.new("DronePlayerTechnicianIdle", path.combine(SPRITE_PATH, "drone_idle.png"), 5, 11, 15)
local sprite_drone_shoot		= Sprite.new("DronePlayerTechnicianShoot", path.combine(SPRITE_PATH, "drone_shoot.png"), 5, 25, 15)

local sprite_shoot1_1			= Sprite.new("TechnicianShoot1_1", path.combine(SPRITE_PATH, "shoot1_1.png"), 7, 31, 28)
local sprite_shoot1_2			= Sprite.new("TechnicianShoot1_2", path.combine(SPRITE_PATH, "shoot1_2.png"), 7, 31, 28)
local sprite_shoot1T_1			= Sprite.new("TechnicianShoot1T_1", path.combine(SPRITE_PATH, "shoot1T_1.png"), 7, 23, 21)
local sprite_shoot1T_2			= Sprite.new("TechnicianShoot1T_2", path.combine(SPRITE_PATH, "shoot1T_2.png"), 7, 12, 17)
local sprite_shoot2				= Sprite.new("TechnicianShoot2", path.combine(SPRITE_PATH, "shoot2.png"), 7, 17, 13)
local sprite_shoot4				= Sprite.new("TechnicianShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 8, 16, 23)
local sprite_shoot5				= Sprite.new("TechnicianShoot4S", path.combine(SPRITE_PATH, "shoot5.png"), 8, 16, 25)

local sprite_sparks1			= Sprite.new("TechnicianSparks1", path.combine(SPRITE_PATH, "sparks1.png"), 4, 12, 16)
local sprite_sparks2			= Sprite.new("TechnicianSparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 17, 22)
local sprite_sparks3			= Sprite.new("TechnicianSparks3", path.combine(SPRITE_PATH, "sparks3.png"), 4, 16, 22)
local sprite_sparks4			= Sprite.new("TechnicianSparks4", path.combine(SPRITE_PATH, "sparks4.png"), 4, 9, 12)
local sprite_sparks5			= Sprite.new("TechnicianSparks5", path.combine(SPRITE_PATH, "sparks5.png"), 4, 26, 4)

local sprite_drink_technician_1	= Sprite.new("TechnicianDrink", path.combine(SPRITE_PATH, "Drink/technician_drink_1.png"), 12, 9, 13)
local sprite_drink_technician_2	= Sprite.new("TechnicianDrinkUp", path.combine(SPRITE_PATH, "Drink/technician_drink_2.png"), 12, 9, 13)

local sprite_turretaI			= Sprite.new("TechnicianTurretaIdle", path.combine(SPRITE_PATH, "turreta.png"), 4, 12, 14)
local sprite_turretashoot		= Sprite.new("TechnicianTurretaShoot", path.combine(SPRITE_PATH, "turretashoot.png"), 4, 17, 14)
local sprite_turretbI			= Sprite.new("TechnicianTurretbIdle", path.combine(SPRITE_PATH, "turretb.png"), 4, 20, 17)
local sprite_turretbshoot		= Sprite.new("TechnicianTurretbshoot", path.combine(SPRITE_PATH, "turretbshoot.png"), 4, 26, 17)
local sprite_turretcI			= Sprite.new("TechnicianTurretcIdle", path.combine(SPRITE_PATH, "turretc.png"), 4, 21, 17)
local sprite_turretcshoot		= Sprite.new("TechnicianTurretcshoot", path.combine(SPRITE_PATH, "turretcshoot.png"), 4, 30, 16)
local sprite_turretc_mis1		= Sprite.new("TechnicianTurretcMissile1", path.combine(SPRITE_PATH, "turretc_mis1.png"), 4, 21, 17)
local sprite_turretc_mis2		= Sprite.new("TechnicianTurretcMissile2", path.combine(SPRITE_PATH, "turretc_mis2.png"), 5, 21, 19)
local sprite_turretc_mis3		= Sprite.new("TechnicianTurretcMissile3", path.combine(SPRITE_PATH, "turretc_mis3.png"), 5, 29, 32)

local sprite_vending1			= Sprite.new("TechnicianVendingMachine", path.combine(SPRITE_PATH, "vendinga.png"), 10, 21, 34)
local sprite_vending2			= Sprite.new("TechnicianVendingMachine2", path.combine(SPRITE_PATH, "vendingb.png"), 10, 19, 37)
local buff_vending_sprite 		= Sprite.new("BuffHydrated", path.combine(PATH, "Sprites/Buffs/hydrated.png"), 1, 8, 12)
local buff_vending_2_sprite		= Sprite.new("BuffReallyHydrated", path.combine(PATH, "Sprites/Buffs/reallyHydrated.png"), 1, 8, 12)

local sprite_mine1				= Sprite.new("TechnicianMine1", path.combine(SPRITE_PATH, "minea.png"), 6, 7, 32)
local sprite_mine2				= Sprite.new("TechnicianMine2", path.combine(SPRITE_PATH, "mineb.png"), 6, 13, 36)

local sprite_amplifier1			= Sprite.new("TechnicianAmplifier1", path.combine(SPRITE_PATH, "amplifiera.png"), 1, 10, 38)
local sprite_amplifier2			= Sprite.new("TechnicianAmplifier2", path.combine(SPRITE_PATH, "amplifierb.png"), 1, 10, 38)
local buff_exposed_sprite 		= Sprite.new("BuffExposed", path.combine(PATH, "Sprites/Buffs/exposed.png"), 1, 10, 10)
local buff_exposed_2_sprite 	= Sprite.new("BuffExposed2", path.combine(PATH, "Sprites/Buffs/exposed2.png"), 1, 10, 10)

local sprite_wrench				= Sprite.new("TechnicianWrench", path.combine(SPRITE_PATH, "wrench.png"), 1, 9, 9)

-- object hitbox sprites
local mine_mask 				= Sprite.new("TechnicianMineMask", path.combine(SPRITE_PATH, "minemask.png"), 1, 7, 18)
local turret_mask 				= Sprite.new("TechnicianTurretMask", path.combine(SPRITE_PATH, "turretmask.png"), 1, 11, 8)
local wrench_mask 				= Sprite.new("TechnicianWrenchMask", path.combine(SPRITE_PATH, "wrenchmask.png"), 1, 11, 8)
local amplifier_mask 			= Sprite.new("TechnicianAmplifierMask", path.combine(SPRITE_PATH, "amplifiermask.png"), 1, 8, 24)

local mine_explosion 			= Sprite.new("TechnicianMineExplosion", path.combine(SPRITE_PATH, "mineExplosion.png"), 7, 63, 92)

local sound_select				= Sound.new("TechnicianSelect", path.combine(SOUND_PATH, "select.ogg"))
local sound_shoot1				= Sound.new("TechnicianShoot1", path.combine(SOUND_PATH, "shoot1.ogg"))
local sound_shoot1T				= Sound.new("TechnicianShoot1T", path.combine(SOUND_PATH, "shoot1T.ogg"))
local sound_shoot2				= Sound.new("TechnicianShoot2", path.combine(SOUND_PATH, "shoot2.ogg"))
local sound_shoot4				= Sound.new("TechnicianShoot4", path.combine(SOUND_PATH, "shoot4.ogg"))
local sound_mineExplode1		= Sound.new("TechnicianMineExplode1", path.combine(SOUND_PATH, "mineExplode1.ogg"))
local sound_mineExplode2		= Sound.new("TechnicianMineExplode1", path.combine(SOUND_PATH, "mineExplode2.ogg"))
local sound_mineUpgrade			= Sound.new("TechnicianMineUpgrade", path.combine(SOUND_PATH, "mineUpgrade.ogg"))
local sound_vendingDispense		= Sound.new("TechnicianVendingDispense", path.combine(SOUND_PATH, "vendingDispense.ogg"))
local sound_vendingDrink		= Sound.new("TechnicianVendingDrink", path.combine(SOUND_PATH, "vendingDrink.ogg"))
local sound_vendingUpgrade		= Sound.new("TechnicianVendingUpgrade", path.combine(SOUND_PATH, "vendingUpgrade.ogg"))
local sound_turretShoot1		= Sound.new("TechnicianTurretShoot1", path.combine(SOUND_PATH, "turretShoot1.ogg"))
local sound_turretShoot2		= Sound.new("TechnicianTurretShoot2", path.combine(SOUND_PATH, "turretShoot2.ogg"))
local sound_turretDeath			= Sound.new("TechnicianTurretDeath", path.combine(SOUND_PATH, "turretDeath.ogg"))
local sound_turretUpgrade		= Sound.new("TechnicianTurretUpgrade", path.combine(SOUND_PATH, "turretUpgrade.ogg"))
local sound_wrenchHit			= Sound.new("TechnicianWrenchHit", path.combine(SOUND_PATH, "wrenchHit.ogg"))
local sound_upgrade				= Sound.new("TechnicianUpgrade", path.combine(SOUND_PATH, "upgrade.ogg"))
local sound_downgrade			= Sound.new("TechnicianDowngrade", path.combine(SOUND_PATH, "downgrade.ogg"))
local sound_downgradeBeep		= Sound.new("TechnicianDowngradeBeep", path.combine(SOUND_PATH, "downgradeBeep.ogg"))

local color_tech_red			= Color.from_hex(0xFF4843)
local color_tech_blue			= Color.from_hex(0x96FFFF)
local color_tech_orange			= Color.from_hex(0xFFC479)

local explosion2				= gm.constants.sMinerExplosion
local explosion3				= gm.constants.sDroneDeath
local soundImpact				= gm.constants.wTurtleExplosion

-- constants for various things
local WRENCH_BLAST_OFFSET_X = ssr_get_tiles(0.8)
local WRENCH_BLAST_OFFSET_Y = -ssr_get_tiles(0.1)
local WRENCH_BLAST_W = ssr_get_tiles(2.2)
local WRENCH_BLAST_H = ssr_get_tiles(1.2)
local WRENCH_DOWNGRADE_TIME = 60 * 20
local WRENCH_THROW_DOWNGRADE_TIME = 60 * 20

local MACHINE_VENDING_GRAV = 0.2
local MACHINE_VENDING_DAMAGE_THRESHOLD = 6
local MACHINE_VENDING_MOVESPEED = 0.56
local MACHINE_VENDING_ATTACKSPEED = 0.2
local MACHINE_VENDING_ATTACKSPEED2 = 0.4
local MACHINE_VENDING_CRIT = 20
local MACHINE_VENDING_BLAST_W = ssr_get_tiles(4)
local MACHINE_VENDING_BLAST_H = ssr_get_tiles(2)

local MACHINE_MINE_GRAV = 0.2
local MACHINE_MINE_PULL_RADIUS = ssr_get_tiles(4)
local MACHINE_MINE_PULL_INTERVAL = 75 --80
local MACHINE_MINE_PULL_LIFE = 90

local MACHINE_AMPLIFIER_RADIUS = 140

-- his only friends are machines
local technician = Survivor.new("technician")

-- set base and level stats
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

-- create the survivor log
-- all text is defined in the language file
local technician_log = SurvivorLog.new_from_survivor(technician)
technician_log.portrait_id = sprite_log
technician_log.sprite_id = sprite_walk
technician_log.sprite_icon_id = sprite_portrait

technician.primary_color = Color.from_rgb(104, 191, 208)

technician.sprite_loadout = sprite_loadout
technician.sprite_portrait = sprite_portrait
technician.sprite_portrait_small = sprite_portrait_small

technician.sprite_idle = sprite_idle
technician.sprite_title = sprite_walk
technician.sprite_credits = sprite_credits

-- set palettes to be used for skins
technician.sprite_palette = sprite_palette
technician.sprite_portrait_palette = sprite_palette
technician.sprite_loadout_palette = sprite_palette

technician.select_sound_id = sound_select
technician.cape_offset = Array.new({-4, -7, -3, -9})

--[[
-- add a few skins
-- 1st arg is internal name, 2nd is the column in the palette sprite where the skin is located, 3rd-5th are recolored sprites in the CSS
technician:add_skin("TechnicianRose", 1, Sprite.new("TechnicianSelect_PAL2", path.combine(SPRITE_PATH, "selectS1.png"), 18, 28, 0),
Sprite.new("TechnicianPortrait_PAL2", path.combine(SPRITE_PATH, "portraitS1.png"), 3),
Sprite.new("TechnicianPortraitSmall_PAL2", path.combine(SPRITE_PATH, "portraitSmallS1.png")))

technician:add_skin("TechnicianBlack", 2, Sprite.new("TechnicianSelect_PAL4", path.combine(SPRITE_PATH, "selectS2.png"), 18, 28, 0),
Sprite.new("TechnicianPortrait_PAL4", path.combine(SPRITE_PATH, "portraitS2.png"), 3),
Sprite.new("TechnicianPortraitSmall_PAL4", path.combine(SPRITE_PATH, "portraitSmallS2.png")))

technician:add_skin("TechnicianBlue", 3, Sprite.new("TechnicianSelect_PAL5", path.combine(SPRITE_PATH, "selectS3.png"), 18, 28, 0),
Sprite.new("TechnicianPortrait_PAL5", path.combine(SPRITE_PATH, "portraitS3.png"), 3),
Sprite.new("TechnicianPortraitSmall_PAL5", path.combine(SPRITE_PATH, "portraitSmallS3.png")))
]]--

--[[technician:add_skin("TechnicianOperator", 4, Sprite.new("TechnicianSelect_PAL1", path.combine(SPRITE_PATH, "selectS4.png"), 18, 28, 0),
Sprite.new("TechnicianPortrait_PAL1", path.combine(SPRITE_PATH, "portraitS4.png"), 3),
Sprite.new("TechnicianPortraitSmall_PAL1", path.combine(SPRITE_PATH, "portraitSmallS4.png")))]]

--[[technician:add_skin("TechnicianEngineer", 5, Sprite.new("TechnicianSelect_PAL3", path.combine(SPRITE_PATH, "selectS1.png"), 18, 28, 0),
Sprite.new("TechnicianPortrait_PAL3", path.combine(SPRITE_PATH, "portraitS1.png"), 3),
Sprite.new("TechnicianPortraitSmall_PAL3", path.combine(SPRITE_PATH, "portraitSmallS1.png")))]]

--[[technician:add_skin("TechnicianProvidence", 5, Sprite.new("TechnicianSelect_PROV", path.combine(SPRITE_PATH, "selectPROV.png"), 18, 28, 0),
Sprite.new("TechnicianPortrait_PROV", path.combine(SPRITE_PATH, "portraitPROV.png"), 3),
Sprite.new("TechnicianPortraitSmall_PROV", path.combine(SPRITE_PATH, "portraitSmallPROV.png")))]]

-- default skills
local primary = technician:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = technician:get_skills(Skill.Slot.SECONDARY)[1]
local secondary_det = Skill.new("technicianXD")
local utility = technician:get_skills(Skill.Slot.UTILITY)[1]
local special = technician:get_skills(Skill.Slot.SPECIAL)[1]
local specialS = Skill.new("technicianVBoosted")

-- alt primary
local primary2 = Skill.new("technicianZ2")
technician:add_skill(Skill.Slot.PRIMARY, primary2)

-- alt utility
local utility2 = Skill.new("technicianC2")
--technician:add_skill(Skill.Slot.UTILITY, utility2)

Callback.add(technician.on_init, function(actor)
	-- setup half-sprite nonsense
	actor.sprite_idle_half = Array.new({sprite_idle, sprite_idle_half, 0})
	actor.sprite_walk_half = Array.new({sprite_walk, sprite_walk_half, 0, sprite_walk_back})
	actor.sprite_jump_half = Array.new({sprite_jump, sprite_jump_half, 0})
	actor.sprite_jump_peak_half = Array.new({sprite_jump_peak, sprite_jump_peak_half, 0})
	actor.sprite_fall_half = Array.new({sprite_fall, sprite_fall_half, 0})
	
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

-- adjusts your vertical offset to keep in line with the legs animation while strafing
-- offsets and frames may vary per survivor
local handle_strafing_yoffset = function(actor)
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

-- create some buffs
local buff_vending = Buff.new("hydrated")
local buff_vending_2 = Buff.new("really_hydrated")
local buff_exposed = Buff.new("exposed")
local buff_exposed_2 = Buff.new("exposed2")

-- if a mocha is added to a turret the game crashes. create fake mochas to replace real ones when they get added to the turret
local fake_mocha = Item.new("fakeMocha")
fake_mocha.is_hidden = true

RecalculateStats.add(function(actor, api)
	local stack = actor:item_count(fake_mocha)
	if stack <= 0 then return end

	api.attack_speed_add(0.15 * stack)
	api.pHmax_add(0.06 * stack)
end)

-- All the machines.........!

-- create an EfFlash (fading solid color overlay of the object)
local machineFlash = function(inst, color)
	local flash = object_flash:create(inst.x, inst.y)
	flash.parent = inst.id
	flash.image_blend = color or Color.WHITE
end

-- MULTIPLAYER: create a new packet, when it is retrieved by a client the cooresponding machine flashes and plays a sound
local machine_temp_visual_packet = Packet.new("SyncTechnicianMachineVisuals")

local machine_temp_visual_packet_deserializer = function(buffer)
	local inst = buffer:read_instance()
	local isFinal = buffer:read_byte() -- plays a different sound when downgrading finishes
	
	machineFlash(inst, color_tech_red)
	
	local sound = sound_downgradeBeep.value
	if Util.bool(isFinal) then
		sound = sound_downgrade.value
	end
	
	gm.sound_play_at(sound, 1, 1, inst.x, inst.y)
end

local machine_temp_visual_packet_serializer = function(buffer, inst)
	buffer:write_instance(inst) -- add the machine as an argument to the packet
	
	local final = 0
	if inst.upgrade_progress_temp_timer <= 0 then
		final = 1
	end
	
	buffer:write_byte(final) -- tells the client whether or not to play the full downgrade sound (1) or beep sound (0)
end

machine_temp_visual_packet:set_serializers(machine_temp_visual_packet_serializer, machine_temp_visual_packet_deserializer)

-- update machine temporary upgrade logic
local machine_update_temp = function(inst)
	if inst.upgrade_progress_temp > 0 then
		if inst.upgrade_progress_temp_timer < 300 and inst.upgrade_progress_temp_timer % 120 == 0 then
			if Net.host then -- only ran by the host in a multiplayer game, must be done to have properly synced visuals (through packets)
				machineFlash(inst, color_tech_red) -- create a red flash on the instance
				if inst.upgrade_progress_temp_timer <= 0 then
					inst.upgrade_progress = inst.upgrade_progress - inst.upgrade_progress_temp -- reduce the upgrade_progress of the instance; The machine itself handles the reprecussions
					inst.upgrade_progress_temp = 0
					gm.sound_play_at(sound_downgrade.value, 1, 1, inst.x, inst.y) -- play a non-moving sound at the instance's location
				else
					gm.sound_play_at(sound_downgradeBeep.value, 1, 1, inst.x, inst.y) -- ditto
				end
				
				-- MULTIPLAYER: create and send the temp packet visual which runs code similar to above on all clients
				if Net.online then
					machine_temp_visual_packet:send_to_all(inst)
				end
			end
		end
		inst.upgrade_progress_temp_timer = inst.upgrade_progress_temp_timer - 1
	end
end

local create_particles_packet = Packet.new("SyncTechnicianUpgradeParticles")

local create_particles_packet_deserializer = function(buffer)
	local inst = buffer:read_instance()
	
	particle_spark:create(inst.x, inst.y, math.random(2, 4), Particle.System.MIDDLE) -- creates 2-4 spark particles at the machine's location
	gm.sound_play_at(sound_wrenchHit.value, 1, 0.9 + math.random() * 0.2, inst.x, inst.y) -- plays a non-moving sound at the machine's location
end

local create_particles_packet_serializer = function(buffer, inst)
	buffer:write_instance(inst)
end

create_particles_packet:set_serializers(create_particles_packet_serializer, create_particles_packet_deserializer)

-- increments the upgrade_progress variable on a machine
local upgrade_machine = function(inst, amount, tempTimer)
	local shouldTempReset = (inst.upgrade_progress_temp_timer <= 240 and inst.upgrade_progress_temp_timer > 0)
	if inst.upgrade_progress < inst.upgrade_progress_max or shouldTempReset then
		if Net.host then -- host handles all upgrade logic
			if tempTimer or shouldTempReset then
				if inst.upgrade_progress < inst.upgrade_progress_max then
					inst.upgrade_progress_temp = math.min(inst.upgrade_progress_temp + amount, inst.upgrade_progress_max) -- stores the amount of progress to be reverted when the machine is downgraded
				end
				inst.upgrade_progress_temp_timer = math.max(inst.upgrade_progress_temp_timer, tempTimer or 0) -- reset the machine's temporary upgrade timer
			end
			
			inst.upgrade_progress = math.min(inst.upgrade_progress + amount, inst.upgrade_progress_max) -- increments the machine's upgrade_progress variable; The machine itself handles the reprecussions
			particle_spark:create(inst.x, inst.y, math.random(2, 4), Particle.System.MIDDLE) -- creates 2-4 spark particles at the machine's location
			gm.sound_play_at(sound_wrenchHit.value, 1, 0.9 + math.random() * 0.2, inst.x, inst.y) -- plays a non-moving sound at the machine's location
			create_particles_packet:send_to_all(inst)
		end
	end
end

-- turret

-- MULTIPLAYER: define a few new packets for the Turret machine
-- each one is for purely visual and auditory purposes

-- plays the fire animation and sound when recieved by clients
local turret_shoot_packet = Packet.new("SyncTechnicianTurretAttack")

local turret_shoot_packet_deserializer = function(buffer)
	local inst = buffer:read_instance()
	
	inst.playanim = 1
	inst.image_index = 0
	
	local sound = sound_turretShoot1.value
	if inst.upgradeState >= 1 then
		sound = sound_turretShoot2.value
	end
	
	gm.sound_play_at(sound, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
end

local turret_shoot_packet_serializer = function(buffer, inst)
	buffer:write_instance(inst)
end

turret_shoot_packet:set_serializers(turret_shoot_packet_serializer, turret_shoot_packet_deserializer)

-- plays the fire animation and sound when recieved by the host, then sends the above packet to all clients except the one who sent this packet
local turret_shoot_packet_host = Packet.new("SyncTechnicianTurretAttackHost")

local turret_shoot_packet_host_deserializer = function(buffer)
	local inst = buffer:read_instance()
	local owner = buffer:read_instance()
	
	inst.playanim = 1
	inst.image_index = 0
	
	local sound = sound_turretShoot1.value
	if inst.upgradeState >= 1 then
		sound = sound_turretShoot2.value
	end
	
	gm.sound_play_at(sound, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
	
	turret_shoot_packet:send_exclude(owner, inst)
end

local turret_shoot_packet_host_serializer = function(buffer, inst, owner)
	buffer:write_instance(inst)
	buffer:write_instance(owner)
end

turret_shoot_packet_host:set_serializers(turret_shoot_packet_host_serializer, turret_shoot_packet_host_deserializer)

-- changes the display state of the missile silo on Scepter turret when recieved by clients
local turret_missile_state_packet = Packet.new("SyncTechnicianTurretMissileState")

local turret_missile_state_packet_deserializer = function(buffer)
	local inst = buffer:read_instance()
	local missileState = buffer:read_byte() - 1
	
	inst.switchMissileState = missileState
end

local turret_missile_state_packet_serializer = function(buffer, inst)
	buffer:write_instance(inst)
	buffer:write_byte(inst.switchMissileState + 1)
end

turret_missile_state_packet:set_serializers(turret_missile_state_packet_serializer, turret_missile_state_packet_deserializer)

local shoot_missiledis_offset_map = {
	{-8, 2},
	{-4, 1},
	{-1, 0},
	{0, 0},
}

local obj_turret = Object.new("TechnicianTurret", Object.Parent.ACTOR)
obj_turret:set_sprite(sprite_turretaI)

Callback.add(obj_turret.on_create, function(inst)
	inst:init_actor_default()
	
	inst.mask_index = turret_mask
	inst.idle = sprite_turretaI
	inst.shoot = sprite_turretashoot
	inst.sparks = sprite_sparks1
	inst.intangible = true
	inst.init = nil
	
	inst.team = 1
	
	inst.upgrade_progress = 0
	inst.upgrade_progress_max = 3
	inst.upgrade_progress_temp = 0
	inst.upgrade_progress_temp_timer = 0
	inst.upgradeState = 0
	
	inst.cooldown = 0
	inst.basecooldown = 50
	inst.secondarycooldown = 0
	inst.secondarystocks = 0
	inst.basesecondarycooldown = 90
	inst.extrasecondarycooldown = 12
	inst.basesecondarystocks = 4
	
	inst.damage = 1
	inst.co_damage = special.damage
	
	inst.ff = 0
	inst.image_speed = 0.2
	
	inst:init_actor_late(true)
	
	inst.dirty = 1
	inst:instance_sync()
end)

Callback.add(obj_turret.on_step, function(inst)
	inst:step_actor()
	
	if inst.parent and Instance.exists(inst.parent) then
		if not inst.oy then inst.oy = inst.y end
		inst.ff = inst.ff + 1
		inst.y = inst.oy - math.sin(inst.ff / 20) * 2 - 2
		
		inst.scepter = inst.parent:item_count(item_scepter)
		if not inst.init then
			local xx, _ = ssr_move_point_contact_solid(inst.x, inst.y, 90 - 90 * inst.image_xscale, 1000, inst)
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
			inst.co_damage = special.damage
			inst.upgradeState = 0
			inst.cooldown = math.min(inst.cooldown, inst.basecooldown)
			inst.playanim = nil
			inst.skin_layer.visible = true
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
			inst.skin_layer.visible = true
			if (inst.prevUpgradeState or inst.upgradeState) < inst.upgradeState then
				machineFlash(inst)
				gm.sound_play_at(sound_turretUpgrade.value, 1, 1, inst.x, inst.y)
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
			inst.skin_layer.visible = false
			inst.secondarystocks = inst.basesecondarystocks
			inst.missileState = 1
			inst.upgradeState = 2
			inst.playanim = nil
			machineFlash(inst)
			machineFlash(inst.missileDis)
			gm.sound_play_at(sound_turretUpgrade.value, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
			doResync = true
		end
		
		if inst.playanim then
			inst.image_speed = 0.2 * inst.attack_speed
			inst.sprite_index = inst.shoot
			if inst.image_index >= GM.sprite_get_number(inst.shoot) - 1 then
				inst.playanim = nil
			end
		else
			inst.sprite_index = inst.idle
			inst.image_speed = 0.2
		end
		if Net.host and doResync then
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
						inst.missileDis.image_index = math.min(inst.missileDis.image_index + 0.3, GM.sprite_get_number(sprite_turretc_mis3) - 1)
						if inst.missileDis.image_index >= GM.sprite_get_number(inst.missileDis.sprite_index) - 1 then
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
					inst.missileDis.image_index = math.min(inst.missileDis.image_index + 0.3, GM.sprite_get_number(inst.missileDis.sprite_index) - 1)
					if inst.missileDis.image_index >= GM.sprite_get_number(inst.missileDis.sprite_index) - 1 then
						inst.missileState = 2
						inst.switchMissileState = nil
					end
				end
			elseif inst.missileState == 2 then
				inst.missileDis.sprite_index = sprite_turretc_mis3
				inst.missileDis.image_index = math.min(inst.missileDis.image_index + 0.2, GM.sprite_get_number(inst.missileDis.sprite_index) - 1)
			else
				inst.missileDis.sprite_index = sprite_turretc_mis1
				inst.missileDis.image_index = inst.image_index
			end
			inst.missileDis.x = inst.x + xo * inst.image_xscale
			inst.missileDis.y = inst.y + yo
		end
		
		if inst.parent:is_authority() or (inst.upgradeState == 2 and Net.host) then
			local wantattack = false
			local victims = List.new()
			inst:collision_line_list(inst.x, inst.y + (inst.upgradeState >= 1 and 8 or 10), inst.x + inst.range * inst.image_xscale, inst.y, gm.constants.pActorCollisionBase, false, true, victims, false)
			for _, victim in ipairs(victims) do
				if inst:attack_collision_canhit(victim) then
					wantattack = victim
					break
				end
			end
			
			victims:destroy()
			
			inst.cooldown = inst.cooldown - 1
			inst.secondarycooldown = inst.secondarycooldown - 1
			if wantattack then
				if inst.cooldown <= 0 and inst.parent:is_authority() then
					inst.playanim = 1
					inst.image_index = 0
					inst.cooldown = inst.basecooldown / inst.attack_speed
					inst.damage = inst.parent.damage
					
					local turret_tracer = Tracer.COMMANDO1
					if inst.upgradeState == 1 then
						turret_tracer = Tracer.PLAYER_DRONE
					elseif inst.upgradeState == 2 then
						turret_tracer = Tracer.SNIPER1
					end
					
					for i = 0, inst.parent:buff_count(buff_mirror) do
						local attack_info = inst:fire_bullet(inst.x, inst.y + (inst.upgradeState >= 1 and 8 or 10), 1000, 90 - 90 * inst.image_xscale, inst.co_damage, nil, inst.sparks, turret_tracer).attack_info
						attack_info.climb = i * 8 * 1.35
					end
					
					gm.sound_play_at(inst.upgradeState >= 1 and sound_turretShoot2.value or sound_turretShoot1.value, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
					if Net.online then
						if Net.host then
							turret_shoot_packet:send_to_all(inst)
						else
							turret_shoot_packet_host:send_to_host(inst, inst.parent)
						end
					end
				end
				if inst.upgradeState == 2 and Net.host then
					if inst.missileState == 2 then
						if inst.secondarycooldown <= 0 then
							local missile = object_missile:create(inst.x - 16 * inst.image_xscale, inst.y - 20)
							missile.parent = inst.parent
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
								
								if Net.online then
									turret_missile_state_packet:send_to_all(inst)
								end
							end
						end
					elseif inst.secondarycooldown <= GM.sprite_get_number(sprite_turretc_mis2) and not inst.switchMissileState then
						inst.missileDis.image_index = 0
						inst.switchMissileState = 1
						
						if Net.online then
							turret_missile_state_packet:send_to_all(inst)
						end
					end
				end
			else
				if inst.switchMissileState ~= -1 then
					inst.switchMissileState = -1
					
					if Net.online then
						turret_missile_state_packet:send_to_all(inst)
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

Callback.add(obj_turret.on_destroy, function(inst)
	local ef_sparks = object_sparks:create(inst.x, inst.y)
	ef_sparks.sprite_index = explosion3
	ef_sparks.image_speed = 0.3
	ef_sparks.image_yscale = 1
	
	gm.sound_play_at(sound_turretDeath.value, 1, 1, inst.x, inst.y)
	inst:screen_shake(2)
	
	if Net.host then
		inst:instance_destroy_sync()
	end
end)

local obj_turret_serializer = function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_byte(self.image_xscale + 1) -- we have to add +1 otherwise the byte will underflow if -1
	buffer:write_byte(self.upgrade_progress)
end

local obj_turret_deserializer = function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.image_xscale = buffer:read_byte() - 1 -- revert the +1 after being recieved
	self.upgrade_progress = buffer:read_byte()
end

Object.add_serializers(obj_turret, obj_turret_serializer, obj_turret_deserializer)

-- vending Machine

buff_vending.icon_sprite = buff_vending_sprite
buff_vending_2.icon_sprite = buff_vending_2_sprite

RecalculateStats.add(function(actor, api)
	local stack = actor:buff_count(buff_vending)
	if stack <= 0 then return end
	
	api.attack_speed_add(MACHINE_VENDING_ATTACKSPEED)
	api.pHmax_add(MACHINE_VENDING_MOVESPEED)
end)

RecalculateStats.add(function(actor, api)
	local stack = actor:buff_count(buff_vending_2)
	if stack <= 0 then return end
	
	api.attack_speed_add(MACHINE_VENDING_ATTACKSPEED2)
	api.pHmax_add(MACHINE_VENDING_MOVESPEED)
	api.critical_chance_add(MACHINE_VENDING_CRIT)
end)

local drinkSprites = {
	[technician.value] = {sprite_drink_technician_1, sprite_drink_technician_2}
}

local stateDrink = ActorState.new("technicianDrink")

Callback.add(stateDrink.on_enter, function(actor, data)
	actor.image_index2 = 0
	data.sprite = actor.__ssr_current_drink_sprite or drinkSprites[technician.value][1]
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

Callback.add(stateDrink.on_step, function(actor, data)
	actor.sprite_index2 = data.sprite

	actor:skill_util_strafe_update(0.2, 1)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	handle_strafing_yoffset(actor)
	
	if actor.image_index2 >= GM.sprite_get_number(data.sprite) then
		actor:skill_util_reset_activity_state()
	end
end)

Callback.add(stateDrink.on_exit, function(actor, data)
	actor:skill_util_strafe_exit()
end)

Callback.add(stateDrink.on_get_interrupt_priority, function(actor, data)
	return ActorState.InterruptPriority.ANY
end)

local vending_shoot_packet = Packet.new("SyncVendingDispense")

local vending_shoot_packet_deserializer = function(buffer, self)
	local inst = buffer:read_instance()
	local recipient = buffer:read_instance()
	
	inst.playanim = 1
	
	if recipient.actor_state_current_id == -1 and drinkSprites[recipient.class] then
		recipient:sound_play(sound_vendingDrink.value, 1, 1)
		recipient.__ssr_current_drink_sprite = drinkSprites[recipient.class][inst:get_data().upgraded and 2 or 1]
		recipient:set_state(stateDrink)
	end
end

local vending_shoot_packet_serializer = function(buffer, self, inst, recipient)
	buffer:write_instance(inst)
	buffer:write_instance(recipient)
end

vending_shoot_packet:set_serializers(vending_shoot_packet_serializer, vending_shoot_packet_deserializer)

local obj_vending = Object.new("TechnicianVendingMachine")
obj_vending:set_sprite(sprite_vending1)
obj_vending:set_depth(20)

Callback.add(obj_vending.on_create, function(inst)
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

Callback.add(obj_vending.on_step, function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		local height = inst.bbox_bottom - inst.bbox_top
		for i = 1, (math.floor((inst.vspeed + inst.gravity) / height) + 1) do
			if ssr_is_colliding_stage(inst, inst.x, inst.y + inst.vspeed + inst.gravity - height * (i - 1)) then
				ssr_move_contact_solid(inst, 90, 32)
				if inst.vspeed > MACHINE_VENDING_DAMAGE_THRESHOLD then
					if inst.parent:is_authority() then
						for i = 0, inst.parent:buff_count(buff_mirror) do
							local attack_info = inst.parent:fire_explosion(inst.x, inst.y - MACHINE_VENDING_BLAST_H / 2, MACHINE_VENDING_BLAST_W, MACHINE_VENDING_BLAST_H, inst.parent:skill_get_damage(utility) * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD)^1.5).attack_info
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
				local trail = Object.find("EfTrail"):create(inst.x, inst.y - height * (i - 1))
				trail.sprite_index = inst.sprite_index
				trail.image_index = inst.image_index
				trail.image_blend = gm.merge_colour(inst.image_blend, Color.BLACK, 0.25)
				trail.image_xscale = inst.image_xscale
				trail.image_yscale = inst.image_yscale
				trail.image_alpha = trail.image_alpha * (0.2 * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD))
				trail.depth = inst.depth + 1
				--trail:actor_skin_skinnable_set_skin(inst.parent) BUG
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
			gm.sound_play_at(sound_vendingUpgrade.value, 1, 1, inst.x, inst.y)
			doResync = true
		end
		if inst.playanim then
			if inst.image_index >= GM.sprite_get_number(inst.sprite_index) - 1 then
				inst.playanim = nil
			end
		else
			inst.image_index = 0
		end
		if Net.host then
			if doResync then
				inst:instance_resync()
			end
			
			for _, player in ipairs(inst:get_collisions(gm.constants.oP)) do
				if player.team == inst.team and player:buff_count(inst.buff) <= 0 then
					gm.sound_play_at(sound_vendingDispense.value, 1, 1, inst.x, inst.y)
					player:buff_remove(buff_vending)
					player:buff_apply(inst.buff, 5 * 60)
					
					if player.actor_state_current_id == -1 and drinkSprites[player.class] then
						player:sound_play(sound_vendingDrink.value, 1, 1)
						player.__ssr_current_drink_sprite = drinkSprites[player.class][inst.upgraded and 2 or 1]
						player:set_state(stateDrink)
					end
					
					inst.playanim = 1
					
					if Net.online then
						vending_shoot_packet:send_to_all(inst, player)
					end
					break
				end
			end
		end
	else
		inst:destroy()
	end
end)

Callback.add(obj_vending.on_draw, function(inst)
	inst:actor_skin_skinnable_draw_self()
end)

Callback.add(obj_vending.on_destroy, function(inst)
	if Net.host then
		inst:instance_destroy_sync()
	end
end)

local obj_vending_serializer = function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_byte(self.image_xscale + 1) -- we have to add +1 otherwise the byte will underflow if -1
	buffer:write_byte(self.upgrade_progress)
end

local obj_vending_deserializer = function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.image_xscale = buffer:read_byte() - 1 -- revert the +1 after being recieved
	self.upgrade_progress = buffer:read_byte()
	self:actor_skin_skinnable_set_skin(self.parent)
end

Object.add_serializers(obj_vending, obj_vending_serializer, obj_vending_deserializer)

-- and they called it a mine

local obj_mine_pull = Object.new("TechnicianMinePull")

Callback.add(obj_mine_pull.on_create, function(inst)
	inst.life = MACHINE_MINE_PULL_LIFE
	inst.ff = 0
end)

Callback.add(obj_mine_pull.on_step, function(inst)
	inst.ff = inst.ff + 1
	
	for _, target in ipairs(inst:get_collisions_circle(gm.constants.pActor, MACHINE_MINE_PULL_RADIUS, inst.x, inst.y)) do
		-- check if we should pull the target
		-- fulling is weird with ropes so climbing enemies are excluded
		-- and intangible enemies are usually doing special behavior so best not to interrupt
		if target.team ~= inst.team and not target.intangible and not target:is_climbing() then
			local lastx = target.x
			local lasty = target.y
			local strength = math.max(1, math.ceil((0.5 + 2.5 * (1 - inst.life / MACHINE_MINE_PULL_LIFE) + math.max(-1.5 + 3 * (1 - inst.life / MACHINE_MINE_PULL_LIFE), 0)) * (0.2 + 0.8 * (1 - gm.point_distance(inst.x, inst.y, target.x, target.y) / MACHINE_MINE_PULL_RADIUS))))
			if GM.actor_is_classic(target) then -- classic enemies (Eg. NOT Jellyfish or Archer Bugs) are pulled horizontally to the center of the pull
				target:move_contact_solid(180 + Math.direction(inst.x, target.y, target.x, target.y), strength)
			elseif not GM.actor_is_boss(target) then -- non-boss, non-classic enemies are pulled directly to the center
				target.x = target.x - math.cos(math.rad(Math.direction(inst.x, inst.y, target.x, target.y))) * strength
				target.y = target.y + math.sin(math.rad(Math.direction(inst.x, inst.y, target.x, target.y))) * strength
			end
			
			-- prevent overshooting on both axes
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

Callback.add(obj_mine_pull.on_draw, function(inst)
	gm.draw_set_alpha(((0.2 * math.sin(inst.ff / 10)) + 0.4) * math.min(inst.ff / (int1 / 2), 1))
	gm.draw_set_colour(color_tech_blue)
	
	local a = inst.ff > int1 and (int1 * int2 - (inst.ff - int1) * int1 / (MACHINE_MINE_PULL_LIFE - int1) * int2) or (inst.ff * int2)
	local t = math.min(inst.ff > int1 and (1 - (inst.ff - int1) / (MACHINE_MINE_PULL_LIFE - int1)) or (inst.ff / int1), 1)
	
	gm.draw_circle(math.floor(inst.x + 0.5), math.floor(inst.y + 0.5), a + (MACHINE_MINE_PULL_RADIUS - a) * t, true)
	gm.draw_set_alpha(1)
end)

local obj_mine = Object.new("TechnicianMine")
obj_mine:set_sprite(sprite_mine1)
-- obj_mine:set_depth(218) -- GRAAAAAAH THIS WONT GO BACK -- note from the future: now it does, thanks kris :) -- never mind I don't like it

Callback.add(obj_mine.on_create, function(inst)
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

Callback.add(obj_mine.on_step, function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		inst.ff = inst.ff + 1
		inst.hspeed = inst.hspeed * 0.9
		
		if ssr_is_colliding_stage(inst, inst.x + inst.hspeed, inst.y) then
			inst.hspeed = 0
		end
		
		if ssr_is_colliding_stage(inst, inst.x, inst.y + inst.vspeed + inst.gravity) then
			ssr_move_contact_solid(inst, 90)
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
			gm.sound_play_at(sound_mineUpgrade.value, 1, 1, inst.x, inst.y)
			doResync = true
		end
		
		if Net.online and doResync then
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

Callback.add(obj_mine.on_draw, function(inst)
	inst:actor_skin_skinnable_draw_self()
	
	if not inst.upgraded then
		gm.draw_set_alpha((0.3 * math.sin(inst.ff / 10)) + 0.4)
		gm.draw_set_colour(color_tech_red)
		gm.draw_circle(math.floor(inst.x + 0.5), math.floor(inst.y + 0.5), inst.ff * 2.5 + (70 - inst.ff * 2.5) * math.min(inst.ff / 30, 1), true)
		gm.draw_set_alpha(1)
	end
end)

Callback.add(obj_mine.on_destroy, function(inst)
	for _, pull in ipairs(Instance.find_all(obj_mine_pull)) do
		if pull.parent == inst.id then
			pull:destroy()
		end
	end
	
	local ef_sparks = object_sparks:create(inst.x, inst.y)
	ef_sparks.sprite_index = mine_explosion
	ef_sparks.image_speed = 0.2
	ef_sparks.image_yscale = 1
	
	gm.sound_play_at(sound_mineExplode1.value, 1, 0.9 + math.random() * 0.2, inst.x, inst.y)
	inst:screen_shake(5)
	
	if Net.host then
		for i = 0, inst.parent:buff_count(buff_mirror) do
			local attack_info = inst.parent:fire_explosion(inst.x, inst.y, ssr_get_tiles(6), ssr_get_tiles(6), inst.parent:skill_get_damage(secondary)).attack_info
			attack_info.knockback = 6
			attack_info.climb = i * 8 * 1.35
			if inst.upgraded then
				attack_info.stun = 1.2
			end
		end
		
		inst:instance_destroy_sync()
	end
end)

local obj_mine_serializer = function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_int(self.hspeed)
	buffer:write_byte(self.upgrade_progress)
end

local obj_mine_deserializer = function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.hspeed = buffer:read_int()
	self.upgrade_progress = buffer:read_byte()
	self:actor_skin_skinnable_set_skin(self.parent)
end

Object.add_serializers(obj_mine, obj_mine_serializer, obj_mine_deserializer)

-- Stick of Death

buff_exposed.icon_sprite = buff_exposed_sprite
buff_exposed_2.icon_sprite = buff_exposed_2_sprite

local obj_amplifier = Object.new("amplifier")
obj_amplifier:set_sprite(sprite_amplifier1)

Callback.add(obj_amplifier.on_create, function(inst)
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

Callback.add(obj_amplifier.on_step, function(inst)
	if inst.parent and Instance.exists(inst.parent) then
		inst.ff = inst.ff + 1
		if ssr_is_colliding_stage(inst, inst.x, inst.y + inst.vspeed + inst.gravity) then
			ssr_move_contact_solid(inst, 90, 32)
			if inst.vspeed > MACHINE_VENDING_DAMAGE_THRESHOLD and inst.parent:is_authority() then
				inst.parent:fire_explosion(inst.x, inst.y - MACHINE_VENDING_BLAST_H / 2, MACHINE_VENDING_BLAST_W, MACHINE_VENDING_BLAST_H, inst.parent:skill_get_damage(utility2) * (inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD) * 2 - inst.parent:skill_get_damage(utility2))
				inst:screen_shake(math.floor(inst.vspeed / MACHINE_VENDING_DAMAGE_THRESHOLD) + 2)
			
				local ef_sparks = object_sparks:create(inst.x, inst.y - 9)
				ef_sparks.sprite_index = explosion2
				ef_sparks.image_speed = 0.25
				ef_sparks.image_yscale = 1
			end
			inst.vspeed = 0
			inst.gravity = 0
		end
		
		inst.visual_radius = Math.lerp(inst.visual_radius, inst.radius, 0.2)
		
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
		
		if Net.host then
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

Callback.add(obj_amplifier.on_draw, function(inst)
	gm.draw_set_alpha((0.4 * math.sin(inst.ff * 0.07)) + 0.4)
	gm.draw_set_colour(inst.upgraded and color_tech_orange or color_tech_red)
	gm.draw_circle(math.floor(inst.x + 0.5), math.floor(inst.y + 0.5), inst.visual_radius, true)
	gm.draw_set_alpha(1)
end)

Callback.add(obj_amplifier.on_destroy, function(inst)
	if Net.host then
		inst:instance_destroy_sync()
	end
end)

local obj_amplifier_serializer = function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.team)
	buffer:write_byte(self.upgrade_progress)
end

local obj_amplifier_deserializer = function(self, buffer)
	self.parent = buffer:read_instance()
	self.team = buffer:read_byte()
	self.upgrade_progress = buffer:read_byte()
end

Object.add_serializers(obj_amplifier, obj_amplifier_serializer, obj_amplifier_deserializer)

-- Misc

local machines = {obj_turret, obj_vending, obj_mine, obj_amplifier}

local healable_survivors = {
	[Survivor.find("chef").value] = true,
	[Survivor.find("hand").value] = true,
	[Survivor.find("mule").value] = true,
}

local healable_objects = {Object.find("EngiTurret"), Object.find("EngiTurretB")}

Callback.add(Callback.ON_ATTACK_HIT, function(hit_info)
	--[[local expose = 0
	if hit_info.target:buff_stack_count(buff_exposed) >= 1 then expose = 1 end
	if hit_info.target:buff_stack_count(buff_exposed_2) >= 1 then expose = 2 end
	if not hit_info.attack_info.__ssr_technician_is_expose and hit_info.inflictor and Instance.exists(hit_info.inflictor) and expose >= 1 and gm._mod_net_isHost() then
		local attack_info = hit_info.inflictor:fire_direct(hit_info.target, hit_info.damage * 0.15 / hit_info.inflictor.damage, hit_info.attack_info.direction, hit_info.target.x - 10, hit_info.target.y).attack_info
		attack_info.__ssr_technician_is_expose = expose
		attack_info.damage_color = expose == 2 and color_tech_orange or color_tech_red
		attack_info.climb = 8 * 1.35
	end]]
	
	if hit_info.attack_info.__wrench_hit then
		if hit_info.attack_info.__wrench_hit == 1 then
			gm.sound_play_at(sound_wrenchHit.value, 1, 0.8 + math.random() * 0.3, hit_info.target.x, hit_info.target.y)
			hit_info.attack_info.__wrench_hit = 2
		end
		
		local sparks = object_sparks:create(hit_info.target.x, hit_info.target.y)
		sparks.sprite_index = (hit_info.attack_info.__wrench_hit == 3 and sprite_sparks5 or sprite_sparks4)
		sparks.image_speed = 0.33
		sparks.image_xscale = Math.sign(hit_info.target.x - hit_info.inflictor.x)
		sparks.depth = hit_info.target.depth - 1
	end
end)

DamageCalculate.add(function(api)
	if not Instance.exists(api.parent) then return end
	
	if not (api.hit_info and (api.hit_info.attack_info.__ssr_technician_is_expose or 0) >= 2 and not api.critical) then return end
	
	api:set_critical(true)
end)

-- wrench whack
primary.sprite = sprite_skills
primary.subimage = 0
primary.cooldown = 5
primary.damage = 1.8
primary.require_key_press = false
primary.is_primary = true
primary.does_change_activity_state = true
primary.hold_facing_direction = true
primary.required_interrupt_priority = ActorState.InterruptPriority.ANY

local statePrimary = ActorState.new("technicianPrimary")

Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary)
end)

Callback.add(statePrimary.on_enter, function(actor, data)
	actor.image_index2 = 0
	data.fired = 0 -- gamemaker bools are a pain to deal with in lua, so just use numbers instead
	data.currentAnim = ((data.currentAnim or 1) + 1) % 2
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

Callback.add(statePrimary.on_step, function(actor, data)
	actor.sprite_index2 = (data.currentAnim == 1 and sprite_shoot1_2 or sprite_shoot1_1)

	actor:skill_util_strafe_update(0.18 * actor.attack_speed, gm.constants.STRAFE_SPEED_NORMAL)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	handle_strafing_yoffset(actor)

	if data.fired == 0 and actor.image_index2 >= 2 then
		data.fired = 1

		actor:sound_play(sound_shoot1.value, 0.3, 0.9 + math.random() * 0.2)
		
		local damage = actor:skill_get_damage(primary)
		local dir = actor:skill_util_facing_direction()

		if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
			for i = 0, actor:buff_count(buff_mirror) do
				if actor:is_authority() then
					local attack_info = actor:fire_explosion(actor.x + WRENCH_BLAST_OFFSET_X * actor.image_xscale, actor.y + WRENCH_BLAST_OFFSET_Y, WRENCH_BLAST_W, WRENCH_BLAST_H, actor:skill_get_damage(primary)).attack_info
					attack_info.climb = i * 8 * 1.35
					
					attack_info.knockback_direction = actor.image_xscale
					attack_info.knockback = 3
					
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
				
				machinesHit:destroy()
				
				local healablesHit = List.new()
				
				actor:collision_rectangle_list(x, y, x2, y2, gm.constants.oP, false, true, healablesHit, false)
				
				for _, object in ipairs(healable_objects) do
					actor:collision_rectangle_list(x, y, x2, y2, object, false, true, healablesHit, false)
				end
				
				for _, instance in ipairs(healablesHit) do
					if instance.object_index ~= gm.constants.oP or healable_survivors[instance.class] then
						instance:heal(10)
						gm.sound_play_at(sound_wrenchHit.value, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
						particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.System.MIDDLE)
					end
				end
				
				healablesHit:destroy()
			end
		else
			local machinesHit = List.new()
			local endX, _ = ssr_move_point_contact_solid(actor.x, actor.y, 90 - 90 * actor.image_xscale, 700, actor)
			
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
			
			machinesHit:destroy()
			
			local healablesHit = List.new()
			
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oP, false, true, healablesHit, false)
			
			for _, object in ipairs(healable_objects) do
				actor:collision_line_list(actor.x, actor.y, endX, actor.y, object, false, true, healablesHit, false)
			end
			
			for _, instance in ipairs(healablesHit) do
				if instance.object_index ~= gm.constants.oP or healable_survivors[instance.class] then
					instance:heal(10)
					gm.sound_play_at(sound_wrenchHit.value, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
					particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.System.MIDDLE)
				end
			end
			
			healablesHit:destroy()
		end
	end

	if actor.image_index2 >= GM.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)

Callback.add(statePrimary.on_exit, function(actor, data)
	actor:skill_util_strafe_exit()
end)

Callback.add(statePrimary.on_get_interrupt_priority, function(actor, data)
	return actor.image_index2 >= 6 and ActorState.InterruptPriority.ANY or ActorState.InterruptPriority.SKILL
end)

-- Wrench Throw
local obj_wrench = Object.new("wrench")
obj_wrench:set_sprite(sprite_wrench)

Callback.add(obj_wrench.on_create, function(inst)
	local data = Instance.get_data(inst)
	data.hit = {}
	inst.mask_index = wrench_mask
	inst.image_speed = 0.2
	data.damage = 1
	inst.speed = 5
	data.climb = 0
	data.life = 170
	data.hits = 3
	
	inst.team = 1
	inst.parent = -4
	inst:actor_skin_skinnable_init()
end)

Callback.add(obj_wrench.on_step, function(inst)
	local data = Instance.get_data(inst)
	
	if data.life <= 0 or not (inst.parent and Instance.exists(inst.parent)) then
		inst.image_alpha = inst.image_alpha - 0.04
		inst.image_angle = inst.image_angle - inst.speed * 3
		
		if inst.image_alpha <= 0 then
			inst:destroy()
		end
	elseif data.hits <= 0 then
		inst:destroy()
	elseif inst:is_colliding(gm.constants.pBlock) then
		particle_spark:create(inst.x, inst.y, math.random(2, 3), Particle.System.MIDDLE)
		gm.sound_play_at(sound_wrenchHit.value, 1, 0.8 + math.random() * 0.3, inst.x, inst.y)
		inst:destroy()
	else
		data.life = data.life - 1
		inst.image_angle = inst.image_angle - inst.speed * 3
		for _, actor in ipairs(inst:get_collisions(gm.constants.pActorCollisionBase)) do
			if inst:attack_collision_canhit(actor) and not data.hit[actor.id] then
				if inst.parent:is_authority() then
					for i = 0, inst.parent:buff_count(buff_mirror) do
						local attack_info = inst.parent:fire_direct(actor, data.damage, inst.direction, inst.x, inst.y).attack_info
						attack_info.climb = i * 8 * 1.35
						attack_info.__wrench_hit = 3
					end
				end
				data.hits = data.hits - 1
				data.hit[actor.id] = true
				gm.sound_play_at(sound_wrenchHit.value, 1, 0.8 + math.random() * 0.3, inst.x, inst.y)
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
		
		machinesHit:destroy()
		
		local healablesHit = List.new()
		inst.parent:collision_rectangle_list(inst.x - 9, inst.y - 9, inst.x + 9, inst.y + 9, gm.constants.oP, false, true, healablesHit, false)
		
		for _, object in ipairs(healable_objects) do
			inst.parent:collision_rectangle_list(inst.x - 9, inst.y - 9, inst.x + 9, inst.y + 9, object, false, true, healablesHit, false)
		end
		
		for _, instance in ipairs(healablesHit) do
			if (instance.object_index ~= gm.constants.oP or healable_survivors[instance.class]) and not data.hit[instance.id] then
				instance:heal(10)
				particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.System.MIDDLE)
				gm.sound_play_at(sound_wrenchHit.value, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
				data.hit[instance.id] = true
			end
		end
		
		healablesHit:destroy()
	end
end)

Callback.add(obj_wrench.on_draw, function(inst)
	inst:actor_skin_skinnable_draw_self()
end)

primary2.sprite = sprite_skills
primary2.subimage = 6
primary2.cooldown = 5
primary2.damage = 1.6
primary2.require_key_press = false
primary2.is_primary = true
primary2.does_change_activity_state = true
primary2.hold_facing_direction = true
primary2.required_interrupt_priority = ActorState.InterruptPriority.ANY

local statePrimary2 = ActorState.new("technicianPrimaryAlt")

Callback.add(primary2.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary2)
end)

Callback.add(statePrimary2.on_enter, function(actor, data)
	actor.image_index2 = 0
	data.currentAnim = math.random(0, 1)
	
	data.fired = 0
	
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

Callback.add(statePrimary2.on_step, function(actor, data)
	actor.sprite_index2 = data.currentAnim == 1 and sprite_shoot1T_2 or sprite_shoot1T_1

	actor:skill_util_strafe_update(0.2 * actor.attack_speed, gm.constants.STRAFE_SPEED_NORMAL)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	handle_strafing_yoffset(actor)

	if data.fired == 0 and actor.image_index2 >= 3 then
		data.fired = 1

		actor:sound_play(sound_shoot1T.value, 1, 0.9 + math.random() * 0.2)
		
		local damage = actor:skill_get_damage(primary2)
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
			local endX, _ = ssr_move_point_contact_solid(actor.x, actor.y, 90 - 90 * actor.image_xscale, 700, actor)
			
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
			
			machinesHit:destroy()
			
			local healablesHit = List.new()
			actor:collision_line_list(actor.x, actor.y, endX, actor.y, gm.constants.oP, false, true, healablesHit, false)
			
			for _, object in ipairs(healable_objects) do
				actor:collision_line_list(actor.x, actor.y, endX, actor.y, object, false, true, healablesHit, false)
			end
			
			for _, instance in ipairs(healablesHit) do
				if instance.object_index ~= gm.constants.oP or healable_survivors[instance.class] then
					instance:heal(10)
					gm.sound_play_at(sound_wrenchHit.value, 1, 0.9 + math.random() * 0.2, instance.x, instance.y)
					particle_spark:create(instance.x, instance.y, math.random(2, 4), Particle.SYSTEM.middle)
				end
			end
			
			healablesHit:destroy()
		end
	end

	if actor.image_index2 >= GM.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)

Callback.add(statePrimary2.on_exit, function(actor, data)
	actor:skill_util_strafe_exit()
end)

-- Forced Shutdown
secondary.sprite = sprite_skills
secondary.subimage = 1
secondary.cooldown = 3 * 60
secondary.damage = 5
secondary.require_key_press = true
secondary.does_change_activity_state = true
secondary.use_delay = 10
secondary.required_interrupt_priority = ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD

-- Big Red Button
secondary_det.sprite = sprite_skills
secondary_det.subimage = 2
secondary_det.cooldown = 0.5 * 60
secondary_det.damage = 1.0 -- this damage isn't used for anything, only the original skill is
secondary_det.require_key_press = true
secondary_det.does_change_activity_state = true
secondary_det.hold_facing_direction = true
secondary_det.auto_restock = false -- makes stocks not regenerate by themselves
secondary_det.use_delay = 10
secondary_det.required_interrupt_priority = ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD

local stateSecondary = ActorState.new("technician_secondary")

Callback.add(secondary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary)
end)

Callback.add(stateSecondary.on_enter, function(actor, data)
	actor.image_index = 0
	data.used = nil
end)

Callback.add(stateSecondary.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2, 0.2, true)
	
	if actor.image_index >= 3 and not data.used then
		actor.tech_saved_stock = actor:get_active_skill(Skill.Slot.SECONDARY).stock
		actor:add_skill_override(Skill.Slot.SECONDARY, secondary_det, 1) -- replaces the secondary with a new secondary (Remote Detonator)
		actor:get_active_skill(Skill.Slot.SECONDARY).stock = math.max(actor.tech_saved_stock, 1)
		
		gm.sound_play_at(sound_shoot2.value, 1, 1, actor.x, actor.y)
		
		if Net.host then
			local mine_inst = obj_mine:create(actor.x + 12 * actor.image_xscale, actor.y)
			mine_inst.team = actor.team
			mine_inst.parent = actor
			mine_inst.hspeed = 8 * actor.image_xscale
			mine_inst:actor_skin_skinnable_set_skin(actor)
		end
		
		data.used = 1
	end
	
	if not data.used then
		actor:get_active_skill(Skill.Slot.SECONDARY):freeze_cooldown()
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

-- blows up mine with mind...

Callback.add(secondary_det.on_activate, function(actor, skill, slot)
	actor:remove_skill_override(Skill.Slot.SECONDARY, secondary_det)
	actor:get_active_skill(Skill.Slot.SECONDARY).stock = actor.tech_saved_stock
	actor:get_active_skill(Skill.Slot.SECONDARY):override_cooldown(actor:get_active_skill(Skill.Slot.SECONDARY).cooldown_base * (1 - actor.cdr))
	
	if Net.host then
		local mines, _ = Instance.find_all(obj_mine)
		for _, mine in ipairs(mines) do
			if mine.parent.id == actor.id then
				mine:destroy()
			end
		end
	end
end)

Callback.add(secondary_det.on_step, function(actor, data)
	actor:get_active_skill(Skill.Slot.SECONDARY):freeze_cooldown()
end)

-- skill overrides aren't removed when transitioning between stages so this does that
-- otherwise the skill stocks of it get all messed up and secondary does nothing because there's no mine to detonate
Callback.add(Callback.ON_STAGE_START, function()
	for _, actor in ipairs(Instance.find_all(gm.constants.oP)) do
		if actor.class == technician.value then
			actor:remove_skill_override(Skill.Slot.SECONDARY, secondary_det)
		end
	end
end)

-- Vending Machine

utility.sprite = sprite_skills
utility.damage = 2
utility.subimage = 3
utility.cooldown = 7 * 60
utility.is_utility = true
utility.require_key_press = true
utility.override_strafe_direction = true
utility.ignore_aim_direction = true

Callback.add(utility.on_activate, function(actor, skill, slot)
	if Net.host then
		local vendings, _ = Instance.find_all(obj_vending)
		if #vendings >= actor:get_active_skill(Skill.Slot.UTILITY).max_stock then
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
utility2.sprite = sprite_skills
utility2.damage = 0.5
utility2.subimage = 0
utility2.cooldown = 12 * 60
utility2.is_utility = true
utility2.override_strafe_direction = true
utility2.ignore_aim_direction = true

local stateUtility2 = ActorState.new("technicianUtilityAlt")
stateUtility2.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL

Callback.add(utility2.on_activate, function(actor, skill, slot)
	actor:set_state(stateUtility2)
end)

Callback.add(stateUtility2.on_enter, function(actor, data)
	actor.image_index = 0
	data.created = nil
end)

Callback.add(stateUtility2.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	local animation = sprite_shoot4
	
	if not data.created and actor.image_index >= 4 and Net.host then
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

special.sprite = sprite_skills
special.subimage = 4
special.cooldown = 9 * 60
special.damage = 1.8
special.require_key_press = true
special.does_change_activity_state = true
special.required_interrupt_priority = ActorState.InterruptPriority.SKILL
special.upgrade_skill = specialS

-- Backup Firewall 2.0
specialS.sprite = sprite_skills
specialS.subimage = 5
specialS.cooldown = 9 * 60
specialS.damage = 1.8
specialS.require_key_press = true
specialS.does_change_activity_state = true
specialS.required_interrupt_priority = ActorState.InterruptPriority.SKILL

local stateSpecial = ActorState.new("technicianSpecial")

Callback.add(special.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)

Callback.add(specialS.on_activate, function(actor, skill, slot)
	actor:set_state(stateSpecial)
end)

Callback.add(stateSpecial.on_enter, function(actor, data)
	actor.image_index = 0
	actor:sound_play(sound_shoot4.value, 1, 0.9 + math.random() * 0.2)

	data.created = nil
	data.scepter = actor:item_count(item_scepter)
end)

Callback.add(stateSpecial.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(data.scepter > 0 and sprite_shoot5 or sprite_shoot4, 0.2, true)
	
	if not data.created and actor.image_index >= 6 and Net.host then
		local turrets, _ = Instance.find_all(obj_turret)
		if #turrets >= actor:get_active_skill(Skill.Slot.SPECIAL).max_stock then
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
		GM.actor_queue_dirty(turret_inst)
		GM.inventory_items_copy(actor, turret_inst, Item.LootTag.ITEM_BLACKLIST_ENGI_TURRETS)
		
		turret_inst:item_give(fake_mocha, turret_inst:item_count(Item.find("mocha"))) -- this is stupid but has to be done because for whatever reason mochas crash the game when certain actors get it (like drones)
		turret_inst:item_take(Item.find("mocha"), turret_inst:item_count(Item.find("mocha")), Item.StackKind.ANY)
		
		if data.scepter > 0 then
			turret_inst.upgrade_progress = 3
		end
		
		data.created = 1
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)