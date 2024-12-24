local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Exploder")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Exploder")

local sprite_mask		= Resources.sprite_load(NAMESPACE, "ExploderMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 15, 13)
local sprite_palette	= Resources.sprite_load(NAMESPACE, "ExploderPalette",	path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn		= Resources.sprite_load(NAMESPACE, "ExploderSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 5, 21, 31)
local sprite_idle		= Resources.sprite_load(NAMESPACE, "ExploderIdle",		path.combine(SPRITE_PATH, "idle.png"), 6, 15, 14)
local sprite_walk		= Resources.sprite_load(NAMESPACE, "ExploderWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 15, 15)
local sprite_jump		= Resources.sprite_load(NAMESPACE, "ExploderJump",		path.combine(SPRITE_PATH, "jump.png"), 1, 24, 16)
local sprite_jump_peak	= Resources.sprite_load(NAMESPACE, "ExploderJumpPeak",	path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 24, 16)
local sprite_fall		= Resources.sprite_load(NAMESPACE, "ExploderFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 24, 16)
local sprite_death		= Resources.sprite_load(NAMESPACE, "ExploderDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 24, 33)

local sprite_shoot1		= Resources.sprite_load(NAMESPACE, "ExploderShoot1",	path.combine(SPRITE_PATH, "shoot1.png"), 20, 32, 55, nil, -16, -16, 16, 10)

gm.elite_generate_palettes(sprite_palette)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "ExploderSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit			= Resources.sfx_load(NAMESPACE, "ExploderHit",		path.combine(SOUND_PATH, "hit.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "ExploderDeath",	path.combine(SOUND_PATH, "death.ogg"))
local sound_shoot1a		= Resources.sfx_load(NAMESPACE, "ExploderShoot1a",	path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b		= Resources.sfx_load(NAMESPACE, "ExploderShoot1b",	path.combine(SOUND_PATH, "skill1b.ogg"))

local exploder = Object.new(NAMESPACE, "Exploder", Object.PARENT.enemyClassic)
local exploder_id = exploder.value

exploder.obj_sprite = sprite_idle
exploder.obj_depth = 11 -- depth of vanilla pEnemyClassic objects

local exploderPrimary = Skill.new(NAMESPACE, "exploderZ")
local stateExploderPrimary = State.new(NAMESPACE, "exploderPrimary")

exploder:clear_callbacks()
exploder:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_jump = true

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = sound_hit
	actor.sound_death = sound_death

	actor:enemy_stats_init(17, 100, 22, 18)
	actor.pHmax_base = 2.6

	actor.z_range = 28
	actor:set_default_skill(Skill.SLOT.primary, exploderPrimary)

	actor:init_actor_late()
end)

exploderPrimary:clear_callbacks()
exploderPrimary:onActivate(function(actor)
	actor:enter_state(stateExploderPrimary)
end)

stateExploderPrimary:clear_callbacks()
stateExploderPrimary:onEnter(function(actor, data)
	actor.image_index = 0
	data.exploded = 0

	actor.interrupt_sound = actor:sound_play(sound_shoot1a, 1.0, (0.9 + math.random() * 0.2) * actor.attack_speed)
end)
stateExploderPrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1, 0.2)

	if data.exploded == 0 and actor.image_index >= 14 then
		data.exploded = 1
		actor.intangible = true -- make the exploder untouchable, so it can't be hit after it has exploded but before it's deleted

		actor:sound_play(sound_shoot1b, 1.0, (0.9 + math.random() * 0.2) * actor.attack_speed)
		actor:screen_shake(2)

		-- every player's game simulates the explosion locally, making it easier to dodge on high ping.
		actor:fire_explosion_local(actor.x, actor.y - 16, 120, 56, 2)
	end
end)

-- destroying an actor anywhere in its state or step code causes errors in certain cases. do this in a separate pass
Callback.add("postStep", "SSDestroyExploders", function()
	local exploders = Instance.find_all(exploder)
	for _, actor in ipairs(exploders) do
		local state_data = actor.actor_state_current_data_table

		-- check that it's advanced to the next frame. this gives time for the attack's procs and game report ("Killed by" info) to work
		if state_data.exploded == 1 and actor.image_index >= 15 then
			-- manually create a corpse. plays the remainder of the explosion animation
			local body = gm.instance_create(actor.x, actor.y, gm.constants.oBody)
			body.sprite_index = actor.sprite_index
			body.image_xscale = actor.image_xscale
			body.image_index = actor.image_index
			body.image_speed = actor.image_speed
			body.image_blend = actor.image_blend
			body.sprite_palette = actor.sprite_palette
			body.elite_type = actor.elite_type

			actor:destroy()
		end
	end
end)

local monsterCardExploder = Monster_Card.new(NAMESPACE, "exploder")
monsterCardExploder.object_id = exploder_id
monsterCardExploder.spawn_cost = 18
monsterCardExploder.spawn_type = Monster_Card.SPAWN_TYPE.classic
monsterCardExploder.can_be_blighted = false -- HELL no

if HOTLOADING then return end

-- TODO: evaluate a better approach for populating stages..
local stages = {
	"ror-dampCaverns",
	"ror-skyMeadow",
	"ror-hiveCluster",
	"ror-riskOfRain",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	stage:add_monster(monsterCardExploder)
end
