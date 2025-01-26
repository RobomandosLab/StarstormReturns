local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Follower")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Follower")

local sprite_mask		= Resources.sprite_load(NAMESPACE, "FollowerMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 10, 26)
local sprite_palette	= Resources.sprite_load(NAMESPACE, "FollowerPalette",	path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn		= Resources.sprite_load(NAMESPACE, "FollowerSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 9, 21, 59)
local sprite_idle		= Resources.sprite_load(NAMESPACE, "FollowerIdle",		path.combine(SPRITE_PATH, "idle.png"), 5, 14, 44)
local sprite_walk		= Resources.sprite_load(NAMESPACE, "FollowerWalk",		path.combine(SPRITE_PATH, "walk.png"), 11, 13, 44)
local sprite_jump		= Resources.sprite_load(NAMESPACE, "FollowerJump",		path.combine(SPRITE_PATH, "jump.png"), 1, 14, 39)
local sprite_jump_peak	= sprite_jump--Resources.sprite_load(NAMESPACE, "FollowerJumpPeak",	path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 24, 16)
local sprite_fall		= sprite_jump--Resources.sprite_load(NAMESPACE, "FollowerFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 24, 16)
local sprite_death		= Resources.sprite_load(NAMESPACE, "FollowerDeath",		path.combine(SPRITE_PATH, "death.png"), 13, 40, 54)

local sprite_shoot1		= Resources.sprite_load(NAMESPACE, "FollowerShoot1",	path.combine(SPRITE_PATH, "shoot1.png"), 17, 38, 65)
local sprite_spark		= Resources.sprite_load(NAMESPACE, "FollowerSpark",		path.combine(SPRITE_PATH, "spark.png"), 4, 12, 12)

local sprite_buff		= Resources.sprite_load(NAMESPACE, "BuffLamp",			path.combine(PATH, "Sprites/Buffs/lamp.png"), 1, 13, 13)

gm.elite_generate_palettes(sprite_palette)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "FollowerSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
--local sound_hit			= Resources.sfx_load(NAMESPACE, "ExploderHit",		path.combine(SOUND_PATH, "hit.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "FollowerDeath",	path.combine(SOUND_PATH, "death.ogg"))
local sound_shoot		= Resources.sfx_load(NAMESPACE, "FollowerShoot",	path.combine(SOUND_PATH, "shoot.ogg"))

local particleSpark = Particle.find("ror", "Spark")

local follower = Object.new(NAMESPACE, "Follower", Object.PARENT.enemyClassic)
local follower_id = follower.value

follower.obj_sprite = sprite_idle
follower.obj_depth = 11 -- depth of vanilla pEnemyClassic objects

local efFollowerAttack = Object.new(NAMESPACE, "EfFollowerAttack")
local efFollowerTelegraph = Object.new(NAMESPACE, "EfFollowerTelegraph")
efFollowerAttack.obj_depth = 9
efFollowerTelegraph.obj_depth = 10

local EFFECT_COLOR = 0x9EE4F7
local FOLLOWER_ALLY_SEARCH_RADIUS = 750
local FOLLOWER_ALLY_SEARCH_GIVE_UP_THRESHOLD = 20

local skillPrimary = Skill.new(NAMESPACE, "followerPrimary")
local statePrimary = State.new(NAMESPACE, "followerPrimary")
local buffLamp = Buff.new(NAMESPACE, "lamp")

local _current_ally_check_frame_offset = 0

follower:clear_callbacks()
follower:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_drop = false
	actor.can_jump = false

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wImpHit
	actor.sound_hit_pitch = 2
	actor.sound_death = sound_death

	actor:enemy_stats_init(10, 120, 8, 14)
	actor.pHmax_base = 1.7

	actor.ai_max_distance_y = 500
	actor.y_range = 500
	actor.z_range = 500
	actor:set_default_skill(Skill.SLOT.primary, skillPrimary)

	actor.ally_check_frame_offset = _current_ally_check_frame_offset
	_current_ally_check_frame_offset = _current_ally_check_frame_offset + 1

	actor:init_actor_late()
end)
follower:onStep(function(actor)
	if not actor:is_authority() then return end
	if Global.time_stop ~= 0 then return end
	if actor.actor_state_current_id ~= -1 then return end
	if (Global._current_frame + actor.ally_check_frame_offset) % 30 ~= 0 then return end

	local should_find_ally = false
	local target = actor.target

	if not Instance:exists(target) or target.parent.team ~= actor.team then
		should_find_ally = true
	end

	if should_find_ally then
		local allies = List.wrap(actor:find_characters_circle(actor.x, actor.y, FOLLOWER_ALLY_SEARCH_RADIUS, true, actor.team, true))
		local current_candidate
		local current_distance = math.huge

		-- only search through 20 potential allies, as otherwise it gets exceedingly slow
		for i=1, math.min(#allies, FOLLOWER_ALLY_SEARCH_GIVE_UP_THRESHOLD) do
			local candidate = allies[i]
			local viable = true
			-- theoretically faster, doesn't seem to make a big difference though?
			--local dx, dy = actor.x - candidate.x, actor.y - candidate.y
			--local distance = dx*dx + dy*dy
			local distance = gm.point_distance(actor.x, actor.y, candidate.x, candidate.y)
			if candidate:get_object_index_self() == follower_id then
				viable = false
			elseif candidate:buff_stack_count(buffLamp) > 0 then
				viable = false
			end
			if viable and current_distance > distance then
				current_candidate = candidate.target_marker
				current_distance = distance
			end
		end
		if current_candidate then
			actor.target = current_candidate
		end
	end
end)

skillPrimary.cooldown = 6 * 60
skillPrimary.damage = 0.75

skillPrimary:clear_callbacks()
skillPrimary:onActivate(function(actor)
	actor:enter_state(statePrimary)
end)

statePrimary:clear_callbacks()
statePrimary:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.telegraphed = 0

	data.attack_x = actor.x
	data.attack_y = actor.y

	-- `target` is an oActorTargetPlayer/oActorTargetEnemy object here, NOT the actor instance itself
	local target = actor.target
	if Instance.exists(target) then
		local direction = math.random(360)
		local distance = math.random(45)

		data.attack_x = target.x + gm.lengthdir_x(distance, direction)
		data.attack_y = target.y + gm.lengthdir_y(distance, direction)
	end
	actor.interrupt_sound = actor:sound_play(sound_shoot, 1.0, (0.9 + math.random() * 0.2))
end)
statePrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1, 0.2)

	local target = actor.target
	if Instance.exists(target) and target.parent.team == actor.team then
		data.attack_x = target.x
		data.attack_y = target.y
	end

	if data.telegraphed == 0 then
		local ef = efFollowerTelegraph:create(data.attack_x, data.attack_y)
		data.telegraphed = 1
	end

	if actor.image_index >= 8 + data.fired * 2 and data.fired < 2 then
		if gm._mod_net_isHost() then
			local end_x, end_y = data.attack_x, data.attack_y

			actor:fire_explosion(end_x, end_y, 20, 20, actor:skill_get_damage(skillPrimary), sprite_spark)

			if Instance.exists(target) and target.parent.team == actor.team then
				target.parent:buff_apply(buffLamp, 4 * 60)
				GM.actor_heal_networked(target.parent, actor.damage, false)
			end

			local ef = efFollowerAttack:create(actor.x - 10 * actor.image_xscale, actor.y-44)
			ef.end_x = end_x
			ef.end_y = end_y
		end

		actor:sound_play(gm.constants.wChainLightning2, 0.8, 0.7 + data.fired * 0.2 + math.random() * 0.2)

		data.fired = data.fired + 1
	end

	actor:skill_util_exit_state_on_anim_end()
end)

efFollowerAttack:clear_callbacks()
efFollowerAttack:onCreate(function(self)
	self.end_x = self.x
	self.end_y = self.y

	self.lifetime = 18
	self.sparked = 0

	self:instance_sync()
end)
efFollowerAttack:onStep(function(self)
	if self.sparked == 0 then
		particleSpark:create(self.end_x, self.end_y, 4)
		self.sparked = 1
	end

	self.lifetime = self.lifetime - 1
	if self.lifetime <= 0 then
		self:destroy()
	end
end)
efFollowerAttack:onDraw(function(self)
	local alpha = self.lifetime / 18
	gm.draw_set_alpha(alpha)
	gm.draw_set_colour(EFFECT_COLOR)
	gm.draw_lightning(self.x, self.y, self.end_x, self.end_y, EFFECT_COLOR)

	gm.draw_set_alpha(alpha * 0.2)
	for i=1, 3 do
		gm.draw_circle(self.end_x, self.end_y, 18 * i + math.random(4), false)
	end
	gm.draw_set_alpha(1)
end)
efFollowerAttack:onSerialize(function(self, msg)
	msg:write_short(self.end_x)
	msg:write_short(self.end_y)
end)
efFollowerAttack:onDeserialize(function(self, msg)
	self.end_x = msg:read_short()
	self.end_y = msg:read_short()
end)

efFollowerTelegraph:clear_callbacks()
efFollowerTelegraph:onCreate(function(self)
	self.lifetime = 45
	self.radius = 0
end)
efFollowerTelegraph:onStep(function(self)
	self.lifetime = self.lifetime - 1
	if self.lifetime <= 0 then
		self:destroy()
	end

	self.radius = self.radius + 0.2
	if self.radius > 4 then
		self.radius = 0
	end
end)
efFollowerTelegraph:onDraw(function(self)
	gm.draw_missile_indicator(self.x, self.y, self.radius * 3)
end)

buffLamp.icon_sprite = sprite_buff
buffLamp:clear_callbacks()
buffLamp:onApply(function(actor, stack)
	if stack == 1 then
		local data = actor:get_data()
		data._preserve_can_jump = actor.can_jump
		data._preserve_can_drop = actor.can_drop
		actor.can_jump = true
		actor.can_drop = true

		if actor.leap_max_distance then
			data._preserve_leap_max_distance = actor.leap_max_distance
			actor.leap_max_distance = actor.leap_max_distance + 2
		end
	end
end)
buffLamp:onRemove(function(actor, stack)
	if stack == 1 then
		local data = actor:get_data()
		actor.can_jump = data._preserve_can_jump
		actor.can_drop = data._preserve_can_drop
		data._preserve_can_jump = nil
		data._preserve_can_drop = nil

		if data._preserve_leap_max_distance then
			actor.leap_max_distance = data._preserve_leap_max_distance
			data._preserve_leap_max_distance = nil
		end
	end
end)
buffLamp:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax + 0.6 * stack
end)
buffLamp:onPostDraw(function(actor, stack)
	local radius = 0.3 * math.max(gm.sprite_get_width(actor.sprite_idle), gm.sprite_get_height(actor.sprite_idle))

	local fade = math.min(1, GM.get_buff_time(actor, buffLamp) / 60)

	gm.draw_set_alpha(0.12 * fade)
	gm.draw_set_colour(EFFECT_COLOR)
	for i=1, 3 do
		gm.draw_circle(actor.ghost_x, actor.ghost_y, radius * i + math.random(4), false)
	end
	gm.draw_set_alpha(1)
end)

local monsterCard = Monster_Card.new(NAMESPACE, "follower")
monsterCard.object_id = follower_id
monsterCard.spawn_cost = 28
monsterCard.spawn_type = Monster_Card.SPAWN_TYPE.classic

if HOTLOADING then return end

-- TODO: evaluate a better approach for populating stages..?
local stages = {
	NAMESPACE.."-whistlingBasin",
}
local stages_loop = {
	"ror-dampCaverns",
	"ror-skyMeadow",
}
for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	stage:add_monster(monsterCard)
end
for _, s in ipairs(stages_loop) do
	local stage = Stage.find(s)
	stage:add_monster_loop(monsterCard)
end

for _, stage in ipairs(Stage.find_all()) do
	stage:add_monster(monsterCard)
end
