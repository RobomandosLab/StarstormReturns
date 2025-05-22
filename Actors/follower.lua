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
local sprite_shot_mask	= Resources.sprite_load(NAMESPACE, "LampShotMask",		path.combine(SPRITE_PATH, "projectileMask.png"), 1, 3, 3)

local sprite_buff		= Resources.sprite_load(NAMESPACE, "BuffLamp",			path.combine(PATH, "Sprites/Buffs/lamp.png"), 1, 13, 13)

gm.elite_generate_palettes(sprite_palette)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "FollowerSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
--local sound_hit			= Resources.sfx_load(NAMESPACE, "FollowerHit",		path.combine(SOUND_PATH, "hit.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "FollowerDeath",	path.combine(SOUND_PATH, "death.ogg"))
local sound_shoot		= Resources.sfx_load(NAMESPACE, "FollowerShoot",	path.combine(SOUND_PATH, "shoot.ogg"))

local particleSpark = Particle.find("ror", "Spark")
local particleTrail = Particle.new(NAMESPACE, "LampShotTrail")
particleTrail:set_sprite(gm.constants.sPixel, true, true, 0)
particleTrail:set_life(15, 25)
particleTrail:set_blend(true)

local follower = Object.new(NAMESPACE, "Follower", Object.PARENT.enemyClassic)
local follower_id = follower.value

follower.obj_sprite = sprite_idle
follower.obj_depth = 11 -- depth of vanilla pEnemyClassic objects

local objLampShot = Object.new(NAMESPACE, "LampShot")
objLampShot.obj_depth = -10 -- depth of most enemy projectiles

local EFFECT_COLOR = 0x9EE4F7

local skillPrimary = Skill.new(NAMESPACE, "followerPrimary")
local statePrimary = State.new(NAMESPACE, "followerPrimary")

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

	actor.z_range = 600
	actor:set_default_skill(Skill.SLOT.primary, skillPrimary)

	actor:init_actor_late()
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

	actor.interrupt_sound = actor:sound_play(sound_shoot, 1.0, (0.9 + math.random() * 0.2))
end)
statePrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1, 0.2)

	if actor.image_index >= 8 + data.fired * 2 and data.fired < 2 then
		actor:sound_play(gm.constants.wChainLightning2, 0.8, 0.7 + data.fired * 0.2 + math.random() * 0.2)

		local s = objLampShot:create(actor.x - 13 * actor.image_xscale, actor.y - 44)
		s.target_hspeed = 4 * actor.image_xscale
		s.parent = actor
		s.team = actor.team

		if actor.elite_type ~= -1 then
			s.image_blend = actor.image_blend -- projectile inherits elite's colour
		end

		data.fired = data.fired + 1
	end

	actor:skill_util_exit_state_on_anim_end()
end)

objLampShot:clear_callbacks()
objLampShot:onCreate(function(self)
	self.parent = -4
	self.target_hspeed = 0
	self.team = 2
	self.image_blend = EFFECT_COLOR

	self.attack_speed = 1

	self.mask_index = sprite_shot_mask

	self.timer = 0
end)
objLampShot:onStep(function(self)
	-- disappears when its parent is gone
	if not Instance.exists(self.parent) then
		self:destroy()
		return
	end

	-- handle timestop!
	local data = self:get_data()
	if Global.time_stop > 0 then
		if not data.stopped then
			data.stopped = true
			data.hspeed = self.hspeed
			data.vspeed = self.vspeed
			self.hspeed = 0
			self.vspeed = 0
		end
		return
	else
		if data.stopped then
			data.stopped = false
			self.hspeed = data.hspeed
			self.vspeed = data.vspeed
		end
	end

	if math.random() < 0.2 then
		particleTrail:create_colour(self.x + math.random(-5, 5), self.y + math.random(-5, 5), self.image_blend, 1)
	end

	-- accelerate towards desired horizontal speed
	if math.abs(self.hspeed) < math.abs(self.target_hspeed) then
		self.hspeed = self.hspeed + gm.sign(self.target_hspeed) * 0.1
	end

	self.vspeed = math.sin(self.timer * 0.1) * 2.5

	self.timer = self.timer + 1
	if self.timer > 60 * 3 then
		self:destroy()
		return
	end

	local actors = self:get_collisions(gm.constants.pActorCollisionBase)

	for _, actor in ipairs(actors) do
		if self:attack_collision_canhit(actor) then
			self:destroy() -- onDestroy handles firing attack
			return
		end
	end
end)
objLampShot:onDestroy(function(self)
	if not Instance.exists(self.parent) then return end

	self.parent:fire_explosion_local(self.x, self.y, 20, 20, 0.5, sprite_spark)
	particleSpark:create(self.x, self.y, 3)
end)
objLampShot:onDraw(function(self)
	if self.image_blend == 0 then
		-- blighted elites have a blend of 0 -- black
		-- with additive blending, this would make the projectile invisible, so handle it separately
		gm.draw_set_colour(0)
		gm.draw_set_alpha(0.25)
		gm.draw_circle(self.x, self.y, 16 + math.random(4), false)
		gm.draw_set_alpha(1)
		gm.draw_circle(self.x, self.y, 4, false)
	else
		gm.draw_set_colour(self.image_blend)

		gm.gpu_set_blendmode(1)
		gm.draw_set_alpha(0.1)
		gm.draw_circle(self.x, self.y, 16 + math.random(4), false)
		gm.draw_set_alpha(1)
		gm.draw_circle(self.x, self.y, 4, false)
		gm.gpu_set_blendmode(0)
	end
	--gm.draw_set_alpha(1)
end)

-- figure out what to do with this later
--[[
local buffLamp = Buff.new(NAMESPACE, "lamp")

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
]]--

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
