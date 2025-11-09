local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Exploder")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Exploder")

local sprite_mask		= Sprite.new("ExploderMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 15, 13)
local sprite_palette	= Sprite.new("ExploderPalette",		path.combine(SPRITE_PATH, "palette.png"))
local sprite_portrait	= Sprite.new("ExploderPortrait",	path.combine(SPRITE_PATH, "portrait.png"))
local sprite_spawn		= Sprite.new("ExploderSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 5, 21, 31)
local sprite_idle		= Sprite.new("ExploderIdle",		path.combine(SPRITE_PATH, "idle.png"), 6, 15, 14, 0.8)
local sprite_walk		= Sprite.new("ExploderWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 15, 15, 0.8)
local sprite_jump		= Sprite.new("ExploderJump",		path.combine(SPRITE_PATH, "jump.png"), 1, 24, 16)
local sprite_jump_peak	= Sprite.new("ExploderJumpPeak",	path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 24, 16)
local sprite_fall		= Sprite.new("ExploderFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 24, 16)
local sprite_death		= Sprite.new("ExploderDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 24, 33)
local sprite_shoot1		= Sprite.new("ExploderShoot1",		path.combine(SPRITE_PATH, "shoot1.png"), 20, 32, 55)

GM.elite_generate_palettes(sprite_palette)

local sound_spawn		= Sound.new("ExploderSpawn",		path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit			= Sound.new("ExploderHit",			path.combine(SOUND_PATH, "hit.ogg"))
local sound_death		= Sound.new("ExploderDeath",		path.combine(SOUND_PATH, "death.ogg"))
local sound_shoot1a		= Sound.new("ExploderShoot1a",		path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b		= Sound.new("ExploderShoot1b",		path.combine(SOUND_PATH, "skill1b.ogg"))

local exploder = Object.new("Exploder", Object.Parent.ENEMY_CLASSIC)
exploder:set_sprite(sprite_idle)
exploder:set_depth(11) -- depth of vanilla pEnemyClassic objects

-- create the monster log
local mlog = ssr_create_monster_log("exploder")
mlog.sprite_id = sprite_idle
mlog.portrait_id = sprite_portrait
mlog.sprite_offset_x = 44
mlog.sprite_offset_y = 48
mlog.stat_hp = 100
mlog.stat_damage = 17
mlog.stat_speed = 2.6

local primary = Skill.new("exploderZ")
local statePrimary = ActorState.new("exploderPrimary")

Callback.add(exploder.on_create, function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_jump = true
	actor.leap_max_distance = 3

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = sound_hit
	actor.sound_death = sound_death

	actor:enemy_stats_init(17, 100, 22, 18)
	actor.pHmax_base = 2.6

	actor.z_range = 28
	actor.monster_log_drop_id = mlog.value
	actor:set_default_skill(Skill.Slot.PRIMARY, primary)

	actor:init_actor_late()
end)

Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary)
end)

Callback.add(statePrimary.on_enter, function(actor, _) -- not gonna use data here because get_data should be faster
	local data = Instance.get_data(actor)
	data.exploded = 0
	actor.image_index = 0
	actor.interrupt_sound = actor:sound_play(sound_shoot1a, 1.0, (0.9 + math.random() * 0.2) * actor.attack_speed)
end)

Callback.add(statePrimary.on_step, function(actor, _)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1, 0.2)
	
	local data = Instance.get_data(actor)

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
Callback.add(Callback.POST_STEP, function()
	if not Instance.find(exploder) then return end -- exit early if no exploders are present
	
	for _, actor in ipairs(Instance.find_all(exploder)) do
		local data = Instance.get_data(actor)
		
		-- check that it's advanced to the next frame. this gives time for the attack's procs and game report ("Killed by" info) to work
		if data.exploded == 1 and actor.image_index >= 15 then
		
			-- manually create a corpse. plays the remainder of the explosion animation
			local body = Object.find("Body"):create(actor.x, actor.y)
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

local card = MonsterCard.new("exploder")
card.object_id = exploder.value
card.spawn_cost = 18
card.spawn_type = 0 --Monster_Card.SPAWN_TYPE.classic
card.can_be_blighted = false -- HELL no

if HOTLOADING then return end

local stages = {
	"dampCaverns",
	"skyMeadow",
	"hiveCluster",
	"riskOfRain",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	
	if stage then
		stage:add_monster(card)
	end
end
