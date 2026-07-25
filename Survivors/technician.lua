local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Technician")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Technician")

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

local sprite_turret_t1			= Sprite.new("TechnicianTurretaIdle", path.combine(SPRITE_PATH, "turreta.png"), 4, 12, 14)
local sprite_turret_t1_shoot	= Sprite.new("TechnicianTurretaShoot", path.combine(SPRITE_PATH, "turretashoot.png"), 4, 17, 14)
local sprite_turret_t2			= Sprite.new("TechnicianTurretbIdle", path.combine(SPRITE_PATH, "turretb.png"), 4, 20, 17)
local sprite_turret_t2_shoot	= Sprite.new("TechnicianTurretbshoot", path.combine(SPRITE_PATH, "turretbshoot.png"), 4, 26, 17)
local sprite_turret_t3			= Sprite.new("TechnicianTurretcIdle", path.combine(SPRITE_PATH, "turretc.png"), 4, 21, 17)
local sprite_turret_t3_shoot	= Sprite.new("TechnicianTurretcshoot", path.combine(SPRITE_PATH, "turretcshoot.png"), 4, 30, 16)
local sprite_turret_t3_missile1	= Sprite.new("TechnicianTurretcMissile1", path.combine(SPRITE_PATH, "turretc_mis1.png"), 4, 21, 17)
local sprite_turret_t3_missile2	= Sprite.new("TechnicianTurretcMissile2", path.combine(SPRITE_PATH, "turretc_mis2.png"), 5, 21, 19)
local sprite_turret_t3_missile3	= Sprite.new("TechnicianTurretcMissile3", path.combine(SPRITE_PATH, "turretc_mis3.png"), 5, 29, 32)

local sprite_vending1			= Sprite.new("TechnicianVendingMachine", path.combine(SPRITE_PATH, "vendinga.png"), 10, 21, 34)
local sprite_vending2			= Sprite.new("TechnicianVendingMachine2", path.combine(SPRITE_PATH, "vendingb.png"), 10, 19, 37)
local sprite_buff_vending 		= Sprite.new("BuffHydrated", path.combine(PATH, "Sprites/Buffs/hydrated.png"), 1, 8, 12)
local sprite_buff_vending2		= Sprite.new("BuffReallyHydrated", path.combine(PATH, "Sprites/Buffs/reallyHydrated.png"), 1, 8, 12)

local sprite_mine1				= Sprite.new("TechnicianMine1", path.combine(SPRITE_PATH, "minea.png"), 6, 7, 32)
local sprite_mine2				= Sprite.new("TechnicianMine2", path.combine(SPRITE_PATH, "mineb.png"), 6, 13, 36)
local sprite_mine_explosion 	= Sprite.new("TechnicianMineExplosion", path.combine(SPRITE_PATH, "mineExplosion.png"), 7, 63, 92)

local sprite_wrench				= Sprite.new("TechnicianWrench", path.combine(SPRITE_PATH, "wrench.png"), 1, 9, 9)

-- object hitbox sprites
local sprite_mine_mask 			= Sprite.new("TechnicianMineMask", path.combine(SPRITE_PATH, "minemask.png"), 1, 7, 18)
local sprite_turret_mask 		= Sprite.new("TechnicianTurretMask", path.combine(SPRITE_PATH, "turretmask.png"), 1, 11, 8)
local sprite_wrench_mask 		= Sprite.new("TechnicianWrenchMask", path.combine(SPRITE_PATH, "wrenchmask.png"), 1, 11, 8)
local sprite_amplifier_mask 	= Sprite.new("TechnicianAmplifierMask", path.combine(SPRITE_PATH, "amplifiermask.png"), 1, 8, 24)

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

local technician = Survivor.new("technician")

-- change stats later !!
technician:set_stats_base({
	maxhp = 110,
	damage = 12,
	regen = 0.01,
})

technician:set_stats_level({
	maxhp = 32,
	damage = 3,
	regen = 0.002,
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

technician.select_sound_id = sound_select
technician.cape_offset = Array.new({-4, -7, -3, -9})

Callback.add(technician.on_init, function(actor)
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
	
	local data = Instance.get_data(actor)
end)

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

-- default skills
local primary = technician:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = technician:get_skills(Skill.Slot.SECONDARY)[1]
local utility = technician:get_skills(Skill.Slot.UTILITY)[1]
local special = technician:get_skills(Skill.Slot.SPECIAL)[1]

-- fine tune

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
	data.fired = 0 
	
	if not data.primary_variation then
		data.primary_variation = 0
	end
	
	actor:skill_util_strafe_init()
	actor:skill_util_strafe_turn_init()
end)

Callback.add(statePrimary.on_step, function(actor, data)
	if not data.primary_variation then
		data.primary_variation = 0
	elseif data.primary_variation == 0 then
		actor.sprite_index2 = sprite_shoot1_1
	else
		actor.sprite_index2 = sprite_shoot1_2
	end

	actor:skill_util_strafe_update(0.18 * actor.attack_speed, gm.constants.STRAFE_SPEED_NORMAL)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()

	handle_strafing_yoffset(actor)

	if data.fired == 0 and actor.image_index2 >= 2 then
		data.fired = 1

		actor:sound_play(sound_shoot1.value, 0.3, 0.9 + math.random() * 0.2)
		
		local damage = actor:skill_get_damage(primary)

		if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
			for i = 0, actor:buff_count(Buff.find("shadowClone")) do
				if actor:is_authority() then
					local attack_info = actor:fire_explosion(actor.x + 25 * actor.image_xscale, actor.y - 25, 70, 40, damage).attack_info
					attack_info.climb = i * 8 * 1.35
				end
			end
		end
	end

	if actor.image_index2 >= GM.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)

Callback.add(statePrimary.on_exit, function(actor, data)
	if not data.primary_variation then
		data.primary_variation = 1
	elseif data.primary_variation == 0 then
		data.primary_variation = 1
	else
		data.primary_variation = 0
	end
	
	actor:skill_util_strafe_exit()
end)

Callback.add(statePrimary.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 6 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	end
end)