local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/NemesisMercenary")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/NemesisMercenary")

local sprite_loadout		= Resources.sprite_load(NAMESPACE, "NemesisMercenarySelect", path.combine(SPRITE_PATH, "select.png"), 19, 28, 0)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryPortrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
local sprite_portrait_small	= Resources.sprite_load(NAMESPACE, "NemesisMercenaryPortraitSmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
local sprite_skills			= Resources.sprite_load(NAMESPACE, "NemesisMercenarySkills", path.combine(SPRITE_PATH, "skills.png"), 5)
local sprite_credits		= Resources.sprite_load(NAMESPACE, "CreditsSurvivorNemesisMercenary", path.combine(SPRITE_PATH, "credits.png"), 1, 8, 10)

local sprite_idle			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryIdle", path.combine(SPRITE_PATH, "idle.png"), 1, 11, 15)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryIdle2", path.combine(SPRITE_PATH, "idle2.png"), 1, 8, 10)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 10, 10)
local sprite_walk_back		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryWalkBack", path.combine(SPRITE_PATH, "walkBack.png"), 8, 10, 10)
local sprite_jump			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryJump", path.combine(SPRITE_PATH, "jump.png"), 1, 8, 10)
local sprite_jump_peak		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryJumpPeak", path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 8, 10)
local sprite_fall			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryFall", path.combine(SPRITE_PATH, "fall.png"), 1, 8, 10)
local sprite_climb			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryClimb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 14)
local sprite_death			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryDeath", path.combine(SPRITE_PATH, "death.png"), 10, 18, 16)
local sprite_decoy			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryDecoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 16, 18)

local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot1a", path.combine(SPRITE_PATH, "shoot1a.png"), 9, 14, 20)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot1b", path.combine(SPRITE_PATH, "shoot1b.png"), 9, 18, 20)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot2a", path.combine(SPRITE_PATH, "shoot2a.png"), 5, 12, 28)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot2b", path.combine(SPRITE_PATH, "shoot2b.png"), 5, 14, 28)
local sprite_shoot3			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot3", path.combine(SPRITE_PATH, "shoot3.png"), 2, 18, 10)
local sprite_shoot4			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot4", path.combine(SPRITE_PATH, "shoot4.png"), 18, 60, 32)
local sprite_shoot5			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryShoot5", path.combine(SPRITE_PATH, "shoot5.png"), 18, 60, 32)
local sprite_sparks			= Resources.sprite_load(NAMESPACE, "NemesisMercenarySparks", path.combine(SPRITE_PATH, "slash.png"), 5, 52, 50)
local sprite_sparks2		= Resources.sprite_load(NAMESPACE, "NemesisMercenarySparks2", path.combine(SPRITE_PATH, "slash2.png"), 5, 52, 50)

local sprite_log			= Resources.sprite_load(NAMESPACE, "NemesisMercenaryLog", path.combine(SPRITE_PATH, "log.png"))

local sound_shoot2a			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot2a", path.combine(SOUND_PATH, "shoot2a.ogg"))
local sound_shoot2b			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot2b", path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_shoot4			= Resources.sfx_load(NAMESPACE, "ExecutionerShoot4", path.combine(SOUND_PATH, "shoot4.ogg"))

local particleWispGTracer = Particle.find("ror", "WispGTracer")

local nemmerc = Survivor.new(NAMESPACE, "nemesisMercenary")
local nemmerc_id = nemmerc.value

nemmerc:set_stats_base({
	maxhp = 115,
	damage = 11,
	regen = 0.04,
})
nemmerc:set_stats_level({
	maxhp = 38,
	damage = 3,
	regen = 0.002,
	armor = 3,
})

nemmerc:set_animations({
	idle = sprite_idle,
	walk = sprite_walk,
	jump = sprite_jump,
	jump_peak = sprite_jump_peak,
	fall = sprite_fall,
	climb = sprite_climb,
	death = sprite_death,
	decoy = sprite_decoy,
	--drone_idle = sprite_drone_idle,
	--drone_shoot = sprite_drone_shoot,
})

nemmerc:set_cape_offset(0, -8, 0, -5)
nemmerc:set_primary_color(Color.from_hex(0xFC4E45))

nemmerc.sprite_loadout = sprite_loadout
nemmerc.sprite_portrait = sprite_portrait
nemmerc.sprite_portrait_small = sprite_portrait_small
nemmerc.sprite_idle = sprite_idle -- used by skin systen for idle sprite
nemmerc.sprite_title = sprite_walk -- also used by skin system for walk sprite
nemmerc.sprite_credits = sprite_credits
nemmerc:clear_callbacks()

local stab = nemmerc:get_primary()
local trigger = nemmerc:get_secondary()
local slide = nemmerc:get_utility()
local devit = nemmerc:get_special()
local absDevit = Skill.new(NAMESPACE, "nemesisMercenaryVBoosted")

-- stab
stab.sprite = sprite_skills
stab.subimage = 0
stab.cooldown = 0
stab.damage = 1.3
stab.is_primary = true
stab.require_key_press = false
stab.hold_facing_direction = true
stab.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
stab:clear_callbacks()

-- quick trigger
trigger.sprite = sprite_skills
trigger.subimage = 1
trigger.cooldown = 3 * 60
trigger.damage = 5
trigger.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill
trigger:clear_callbacks()

-- blinding slide
slide.sprite = sprite_skills
slide.subimage = 2
slide.cooldown = 3 * 60
slide.is_utility = true
slide.override_strafe_direction = true
slide.ignore_aim_direction = true
slide:clear_callbacks()

-- devitalize
devit.sprite = sprite_skills
devit.subimage = 3
devit.cooldown = 6 * 60
devit.damage = 8.5
devit.require_key_press = true
devit.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill
devit:clear_callbacks()

-- absolute devitalization
absDevit.sprite = sprite_skills
absDevit.subimage = 4
absDevit.cooldown = 6 * 60
absDevit.damage = 11
absDevit.require_key_press = true
absDevit.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.skill
absDevit:clear_callbacks()

local nemmercLog = Survivor_Log.new(nemmerc, sprite_log)