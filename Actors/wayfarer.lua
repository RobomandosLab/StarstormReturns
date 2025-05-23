local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Wayfarer")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Wayfarer")

local EFFECT_COLOR = 0x9EE4F7

local sprite_mask		= Resources.sprite_load(NAMESPACE, "WayfarerMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 30, 86)
local sprite_palette	= Resources.sprite_load(NAMESPACE, "WayfarerPalette",	path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn		= Resources.sprite_load(NAMESPACE, "WayfarerSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 7, 60, 140)
local sprite_idle		= Resources.sprite_load(NAMESPACE, "WayfarerIdle",		path.combine(SPRITE_PATH, "idle.png"), 7, 60, 140)
local sprite_walk		= Resources.sprite_load(NAMESPACE, "WayfarerWalk",		path.combine(SPRITE_PATH, "walk.png"), 7, 60, 122)
local sprite_death		= Resources.sprite_load(NAMESPACE, "WayfarerDeath",		path.combine(SPRITE_PATH, "death.png"), 15, 60, 140)

local sprite_shoot1		= Resources.sprite_load(NAMESPACE, "WayfarerShoot1",	path.combine(SPRITE_PATH, "shoot1.png"), 15, 60, 140)
local sprite_shoot2		= Resources.sprite_load(NAMESPACE, "WayfarerShoot2",	path.combine(SPRITE_PATH, "shoot2.png"), 9, 60, 140)

local sprite_buff		= Resources.sprite_load(NAMESPACE, "BuffLamp",			path.combine(PATH, "Sprites/Buffs/lamp.png"), 1, 13, 13)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "WayfarerSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
local sound_shoot1		= Resources.sfx_load(NAMESPACE, "WayfarerShoot1",	path.combine(SOUND_PATH, "shoot1.ogg"))
local sound_shoot2a		= Resources.sfx_load(NAMESPACE, "WayfarerShoot2a",	path.combine(SOUND_PATH, "shoot2a.ogg"))
local sound_shoot2b		= Resources.sfx_load(NAMESPACE, "WayfarerShoot2b",	path.combine(SOUND_PATH, "shoot2b.ogg"))
local sound_shoot3		= Resources.sfx_load(NAMESPACE, "WayfarerShoot3",	path.combine(SOUND_PATH, "shoot3.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "WayfarerDeath",	path.combine(SOUND_PATH, "death.ogg"))

local wayfarer = Object.new(NAMESPACE, "Wayfarer", Object.PARENT.bossClassic)
wayfarer.obj_sprite = sprite_idle
wayfarer.obj_depth = 10 -- depth of vanilla pBossClassic objects

local buffLamp = Buff.new(NAMESPACE, "lamp")

local skillZ	= Skill.new(NAMESPACE, "wayfarerZ")
local skillX	= Skill.new(NAMESPACE, "wayfarerX")
local skillC	= Skill.new(NAMESPACE, "wayfarerC")
local skillV	= Skill.new(NAMESPACE, "wayfarerV")

local stateZ	= State.new(NAMESPACE, "wayfarerZ")
local stateX	= State.new(NAMESPACE, "wayfarerX")
local stateC	= State.new(NAMESPACE, "wayfarerC")
local stateV	= State.new(NAMESPACE, "wayfarerV")

wayfarer:clear_callbacks()
wayfarer:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_idle
	actor.sprite_jump_peak = sprite_idle
	actor.sprite_fall = sprite_idle
	actor.sprite_death = sprite_death

	actor.can_jump = true

	actor.body_shake_frame = 13

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wImpHit
	actor.sound_hit_pitch = 0.5
	actor.sound_death = sound_death

	actor:enemy_stats_init(25, 950, 100, 40)
	actor.pHmax_base = 1.8
	actor.pVmax_base = 6

	actor.z_range = 150
	actor:set_default_skill(Skill.SLOT.primary, skillZ)
	actor.c_range = 1800
	actor:set_default_skill(Skill.SLOT.utility, skillC)
	actor.v_range = 1800
	actor:set_default_skill(Skill.SLOT.special, skillV)

	actor:init_actor_late()
end)

-- primary
-- basic melee
skillZ.cooldown = 3 * 60

skillZ:clear_callbacks()
skillZ:onActivate(function(actor)
	actor:enter_state(stateZ)
end)

stateZ:clear_callbacks()
stateZ:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0

	actor:sound_play(sound_shoot1, 0.6, 0.9 + math.random() * 0.2)
end)
stateZ:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1, 0.2)

	if actor.image_index >= 10 and data.fired == 0 then
		actor:screen_shake(7)
		actor:sound_play(gm.constants.wBoss1Shoot1, 0.7, 1.2)
		actor:sound_play(gm.constants.wBossSkill2, 0.7, 0.8)

		actor:fire_explosion_local(actor.x, actor.y, 100, 100, 1.75)

		data.fired = 1
	end

	actor:skill_util_exit_state_on_anim_end()
end)

-- secondary
-- go invisible and teleport near the target

skillX.cooldown = 16 * 60
skillX.start_with_stock = false -- make it unable to go invisible right when it's spawned

-- utility
-- buff surrounding allies

skillC.cooldown = 9 * 60

skillC:clear_callbacks()
skillC:onActivate(function(actor)
	actor:enter_state(stateC)
end)

stateC:clear_callbacks()
stateC:onEnter(function(actor, data)
	actor.image_index = 0
	data.circled = 0
	data.buffed = 0

	actor:sound_play(sound_shoot3, 0.6, 0.9 + math.random() * 0.2)
end)
stateC:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot2, 0.2)

	if actor.image_index >= 6 and data.circled == 0 then
		local ef = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle)
		ef.radius = 200
		ef.rate = 30

		data.circled = 1
	end
	if actor.image_index >= 7 and data.buffed == 0 then
		local allies = List.wrap(actor:find_characters_circle(actor.x, actor.y, 300, true, actor.team, true))

		for i, ally in ipairs(allies) do
			if ally.id ~= actor.id then
				ally:buff_apply(buffLamp, 8 * 60)
			end
		end

		data.buffed = 1
	end

	actor:skill_util_exit_state_on_anim_end()
end)

-- special
-- summon followers
skillV.cooldown = 12 * 60

skillV:clear_callbacks()
skillV:onActivate(function(actor)
	if gm._mod_net_isHost() then
		local follower = Object.find(NAMESPACE, "Follower")

		for i=1, 3 do
			follower:create(actor.x + math.random(-80, 80), actor.y):move_contact_solid(270, -1)
		end
	end
end)

stateV:clear_callbacks()

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

	gm.draw_set_alpha(0.06 * fade)
	gm.draw_set_colour(EFFECT_COLOR)
	gm.gpu_set_blendmode(1)
	for i=1, 3 do
		gm.draw_circle(actor.ghost_x, actor.ghost_y, radius * i + math.random(4), false)
	end
	gm.gpu_set_blendmode(0)
	gm.draw_set_alpha(1)
end)

local monsterCard = Monster_Card.new(NAMESPACE, "wayfarer")
monsterCard.object_id = wayfarer.value
monsterCard.spawn_cost = 640
monsterCard.spawn_type = Monster_Card.SPAWN_TYPE.classic
monsterCard.is_boss = true
