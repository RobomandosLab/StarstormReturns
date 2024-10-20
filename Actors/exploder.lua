local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Exploder")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Exploder")

local sprite_mask = Resources.sprite_load(NAMESPACE, "ExploderMask", path.combine(SPRITE_PATH, "mask.png"), 1, 14, 12)
local sprite_palette = Resources.sprite_load(NAMESPACE, "ExploderPalette", path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn = Resources.sprite_load(NAMESPACE, "ExploderSpawn", path.combine(SPRITE_PATH, "exploderSpawn.png"), 5, 18, 24)
local sprite_idle = Resources.sprite_load(NAMESPACE, "ExploderIdle", path.combine(SPRITE_PATH, "exploderIdle.png"), 5, 50, 38)
local sprite_walk = Resources.sprite_load(NAMESPACE, "ExploderWalk", path.combine(SPRITE_PATH, "exploderWalk.png"), 6, 50, 38)
local sprite_jump = Resources.sprite_load(NAMESPACE, "ExploderJump", path.combine(SPRITE_PATH, "exploderJump.png"), 1, 16, 20)
local sprite_death = Resources.sprite_load(NAMESPACE, "ExploderDeath", path.combine(SPRITE_PATH, "exploderDeath.png"), 7, 40, 50)
local sprite_shoot1 = Resources.sprite_load(NAMESPACE, "ExploderShoot1", path.combine(SPRITE_PATH, "exploderShoot1.png"), 20, 40, 50)
local sprite_impact = Resources.sprite_load(NAMESPACE, "ExploderImpact", path.combine(SPRITE_PATH, "impact.png"), 6, 18, 24)

GM.elite_generate_palettes(sprite_palette)

local sound_spawn = Resources.sfx_load(NAMESPACE, "ExploderSpawn", path.combine(SOUND_PATH, "spawn.ogg"))
local sound_death = Resources.sfx_load(NAMESPACE, "Exploderdeath", path.combine(SOUND_PATH, "death.ogg"))
local sound_shoot1a = Resources.sfx_load(NAMESPACE, "ExploderShoot1a", path.combine(SOUND_PATH, "skill1a.ogg"))
local sound_shoot1b = Resources.sfx_load(NAMESPACE, "ExploderShoot1b", path.combine(SOUND_PATH, "skill1b.ogg"))

local exploder = Object.new(NAMESPACE, "Exploder", Object.PARENT.enemyClassic)
local exploder_id = exploder.value
exploder.obj_sprite = sprite_idle

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
	actor:actor_animation_set(sprite_shoot1, 0.25)

	if data.exploded == 0 and actor.image_index >= 15 then
		data.exploded = 1

		GM.sound_play_at(sound_shoot1b, 1.0, (0.9 + math.random() * 0.2) * actor.attack_speed, actor.x, actor.y)

		-- TODO: destroy the actor at *this* point instead of when the animation ends, replacing it with the explosion
		actor:fire_explosion(actor.x, actor.y - 16, 120, 56, 2, nil, sprite_impact)
	end
end)
stateExploderPrimary:onGetInterruptPriority(function(actor, data)
	if data.exploded == 1 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.frozen -- yuck!
	end
end)

-- destroying an actor anywhere in its state code causes an error. do this in a separate pass
Callback.add("postStep", "SSDestroyExploders", function()
	local exploders = Instance.find_all(exploder)
	for _, actor in ipairs(exploders) do
		if actor.actor_state_current_data_table.exploded == 1 and actor.image_index >= 18 then
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
