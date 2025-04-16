local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Gatekeeper")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Gatekeeper")

local sprite_mask			= Resources.sprite_load(NAMESPACE, "GatekeeperMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 32, 94)
local sprite_palette		= Resources.sprite_load(NAMESPACE, "GatekeeperPalette",		path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn			= Resources.sprite_load(NAMESPACE, "GatekeeperSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 22, 66, 141)
local sprite_idle			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle",		path.combine(SPRITE_PATH, "idle.png"), 1, 52, 125)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle2",		path.combine(SPRITE_PATH, "idle2.png"), 1, 52, 125)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "GatekeeperWalk",		path.combine(SPRITE_PATH, "walk.png"), 6, 58, 126)
local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 7, 58, 126)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 17, 58, 126)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2a",		path.combine(SPRITE_PATH, "shoot2a.png"), 5, 58, 126)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2b",		path.combine(SPRITE_PATH, "shoot2b.png"), 5, 58, 126)
local sprite_death			= Resources.sprite_load(NAMESPACE, "GatekeeperDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 79, 148)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "GatekeeperPortrait",	path.combine(SPRITE_PATH, "portrait.png"))

gm.elite_generate_palettes(sprite_palette)

local sound_spawn			= Resources.sfx_load(NAMESPACE, "GatekeeperSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_laser_hit		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserHit",			path.combine(SOUND_PATH, "laserHit.ogg"))
local sound_laser_fire		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserFire",		path.combine(SOUND_PATH, "laserFire.ogg"))
local sound_laser_fire2		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserFire2",		path.combine(SOUND_PATH, "laserFire2.ogg"))
local sound_laser_charge	= Resources.sfx_load(NAMESPACE, "GatekeeperLaserCharge",		path.combine(SOUND_PATH, "laserCharge.ogg"))
local sound_death			= Resources.sfx_load(NAMESPACE, "GatekeeperDeath",			path.combine(SOUND_PATH, "death.ogg"))

local keeper = Object.new(NAMESPACE, "Gatekeeper", Object.PARENT.enemyClassic)
local keeper_id = keeper.value

keeper.obj_sprite = sprite_idle
keeper.obj_depth = 11 -- depth of vanilla pEnemyClassic objects

keeper:clear_callbacks()
keeper:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_idle
	actor.sprite_jump_peak = sprite_idle
	actor.sprite_fall = sprite_idle
	actor.sprite_death = sprite_death

	actor.can_jump = false
	actor.can_drop = false

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wGuardHit
	actor.sound_death = sound_death

	actor:enemy_stats_init(24, 800, actor.maxhp / 3, 780)
	actor.pHmax_base = 1.4
	actor.knockback_immune = true
	actor.stun_immune = true
	actor.attack_mode = 1

	--actor:set_default_skill(Skill.SLOT.primary, keeperPrimary)

	actor:init_actor_late()
end)

keeper:onStep(function(actor)
	actor:move_contact_solid(270, 40)
end)