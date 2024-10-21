local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Exploder")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Exploder")

local sprite_mask = Resources.sprite_load(NAMESPACE, "ExploderMask", path.combine(SPRITE_PATH, "mask.png"), 1, 15, 13)
local sprite_palette = Resources.sprite_load(NAMESPACE, "ExploderPalette", path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn = Resources.sprite_load(NAMESPACE, "ExploderSpawn", path.combine(SPRITE_PATH, "spawn.png"), 5, 21, 31)
local sprite_idle = Resources.sprite_load(NAMESPACE, "ExploderIdle", path.combine(SPRITE_PATH, "idle.png"), 6, 15, 14)
local sprite_walk = Resources.sprite_load(NAMESPACE, "ExploderWalk", path.combine(SPRITE_PATH, "walk.png"), 8, 15, 15)
local sprite_jump = Resources.sprite_load(NAMESPACE, "ExploderJump", path.combine(SPRITE_PATH, "jump.png"), 1, 18, 14)
local sprite_death = Resources.sprite_load(NAMESPACE, "ExploderDeath", path.combine(SPRITE_PATH, "death.png"), 7, 32, 55, nil, -16, -16, 16, 10)
-- attack animation
local sprite_shoot1a = Resources.sprite_load(NAMESPACE, "ExploderShoot1a", path.combine(SPRITE_PATH, "shoot1a.png"), 15, 32, 55)
local sprite_shoot1b = Resources.sprite_load(NAMESPACE, "ExploderShoot1b", path.combine(SPRITE_PATH, "shoot1b.png"), 5, 32, 55, nil, -16, -16, 16, 10)

GM.elite_generate_palettes(sprite_palette)

local sound_spawn = Resources.sfx_load(NAMESPACE, "ExploderSpawn", path.combine(SOUND_PATH, "spawn.ogg"))
local sound_death = Resources.sfx_load(NAMESPACE, "Exploderdeath", path.combine(SOUND_PATH, "death.ogg"))
local sound_shoot1a = Resources.sfx_load(NAMESPACE, "ExploderShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b = Resources.sfx_load(NAMESPACE, "ExploderShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))

local exploder = Object.new(NAMESPACE, "Exploder", Object.PARENT.enemyClassic)
local exploder_id = exploder.value
exploder.obj_sprite = sprite_idle
exploder.obj_depth = 1 -- depth used by offical enemies, makes players and their vfx always appear above

local exploderPrimary = Skill.new(NAMESPACE, "exploderZ")

exploder:clear_callbacks()
exploder:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump
	actor.sprite_fall = sprite_jump
	actor.sprite_death = sprite_death

	actor.can_jump = true

	GM._mod_instance_set_mask(actor, sprite_mask)

	actor.sound_spawn = sound_spawn
	actor.sound_hit = -1
	actor.sound_death = sound_death

	actor:enemy_stats_init(17, 100, 22, 18)
	actor.pHmax = 2.6

	actor.z_range = 28
	actor:set_default_skill(Skill.SLOT.primary, exploderPrimary)

	actor:init_actor_late()
end)

local stateExploderPrimary = State.new(NAMESPACE, "exploderPrimary")
stateExploderPrimary:clear_callbacks()
stateExploderPrimary:onEnter(function(actor, data)
	actor.image_index = 0
	data.exploded = 0

	GM.sound_play_at(sound_shoot1a, 1.0, (0.9 + math.random() * 0.2) * actor.attack_speed, actor.x, actor.y)
end)
stateExploderPrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1a, 0.25)

	if data.exploded == 0 and actor.image_index >= 14 then
		data.exploded = 1

		GM.sound_play_at(sound_shoot1b, 1.0, (0.9 + math.random() * 0.2) * actor.attack_speed, actor.x, actor.y)
		GM._mod_game_shakeScreen_global(2)

		-- TODO: local explosion attacks exist for making enemy attacks fairer on high ping ... but there's not even _mod_ functions for them..
		if actor:is_authority() then
			actor:fire_explosion(actor.x, actor.y - 16, 120, 56, 2)
		end
	end
end)

-- destroying an actor anywhere in its state code causes an error. do this in a separate pass
Callback.add("postStep", "SSDestroyExploders", function()
	local exploders = Instance.find_all(exploder)
	for _, actor in ipairs(exploders) do
		if actor.actor_state_current_data_table.exploded == 1 then
			-- manually create a corpse. plays the remainder of the explosion animation
			local body = GM.instance_create(actor.x, actor.y, gm.constants.oBody)
			body.sprite_index = sprite_shoot1b
			body.image_xscale = actor.image_xscale
			body.image_speed = 0.25 * actor.attack_speed
			body.image_blend = actor.image_blend
			body.sprite_palette = actor.sprite_palette
			body.elite_type = actor.elite_type

			actor:destroy()
		end
	end
end)

exploderPrimary:onActivate(function(actor)
	actor:enter_state(stateExploderPrimary)
end)

local monsterCardExploder = Monster_Card.new(NAMESPACE, "exploder")
monsterCardExploder.object_id = exploder_id
monsterCardExploder.spawn_cost = 18
monsterCardExploder.spawn_type = 0 -- MONSTER_CARD_SPAWN_TYPE.classic

-- TODO: evaluate a better approach for populating stages..
local stages = {
	"ror-dampCaverns",
	"ror-magmaBarracks",
	"ror-hiveCluster",
	"ror-riskOfRain",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	stage:add_monster(monsterCardExploder)
end

-- for testing purposes hehe ,,
--[[
for i, _ in ipairs(Class.STAGE) do
	local stage = Stage.wrap(i-1)
	stage:clear_monsters()
	stage:add_monster(monsterCardExploder)
end
]]--
