local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Mimic")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Mimic")

local sprite_mask		= Resources.sprite_load(NAMESPACE, "MimicMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 21, 24)
--local sprite_palette	= Resources.sprite_load(NAMESPACE, "MimicPalette",	path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn		= Resources.sprite_load(NAMESPACE, "MimicSpawn",	path.combine(SPRITE_PATH, "spawn.png"), 18, 30, 35)
local sprite_idle		= Resources.sprite_load(NAMESPACE, "MimicIdle",		path.combine(SPRITE_PATH, "idle.png"), 2, 30, 35)
local sprite_idle2		= Resources.sprite_load(NAMESPACE, "MimicIdle2",	path.combine(SPRITE_PATH, "idle2.png"), 2, 30, 45)
local sprite_walk		= Resources.sprite_load(NAMESPACE, "MimicWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 30, 35)
local sprite_walk2		= Resources.sprite_load(NAMESPACE, "MimicWalk2",	path.combine(SPRITE_PATH, "walk2.png"), 6, 30, 35)
local sprite_jump		= Resources.sprite_load(NAMESPACE, "MimicJump",		path.combine(SPRITE_PATH, "fall.png"), 1, 30, 35)
local sprite_jump_peak	= Resources.sprite_load(NAMESPACE, "MimicJumpPeak",	path.combine(SPRITE_PATH, "fall.png"), 1, 30, 35)
local sprite_fall		= Resources.sprite_load(NAMESPACE, "MimicFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 30, 35)
local sprite_death		= Resources.sprite_load(NAMESPACE, "MimicDeath",	path.combine(SPRITE_PATH, "death.png"), 10, 55, 93)
local sprite_shoot1a	= Resources.sprite_load(NAMESPACE, "MimicShoot1a",	path.combine(SPRITE_PATH, "shoot1a.png"), 10, 30, 45)
local sprite_shoot1b	= Resources.sprite_load(NAMESPACE, "MimicShoot1b",	path.combine(SPRITE_PATH, "shoot1b.png"), 4, 30, 45)
local sprite_shoot1c	= Resources.sprite_load(NAMESPACE, "MimicShoot1c",	path.combine(SPRITE_PATH, "shoot1c.png"), 6, 30, 45)

local sprite_inactive_idle = Resources.sprite_load(NAMESPACE, "MimicInactiveIdle",	path.combine(SPRITE_PATH, "inactiveIdle.png"), 14, 30, 38)
local sprite_vacuum		= Resources.sprite_load(NAMESPACE, "MimicVacuumFX", path.combine(SPRITE_PATH, "vacuumParticle.png"), 4, 4, 4)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "MimicSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit			= Resources.sfx_load(NAMESPACE, "MimicHit",		path.combine(SOUND_PATH, "hit.ogg"))
local sound_shoot		= Resources.sfx_load(NAMESPACE, "MimicShoot",	path.combine(SOUND_PATH, "shoot.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "MimicDeath",	path.combine(SOUND_PATH, "death.ogg"))

local mimic = Object.new(NAMESPACE, "Mimic", Object.PARENT.enemyClassic)
local mimic_id = mimic.value

mimic.obj_sprite = sprite_idle
mimic.obj_depth = 11 -- makes players and their vfx always appear above

local particleVacuum = Particle.new(NAMESPACE, "Vacuum")
particleVacuum:set_sprite(sprite_vacuum, false, false, true)
particleVacuum:set_life(10, 15)
particleVacuum:set_speed(7, 7, -0.1, 0)

local mimicPrimary = Skill.new(NAMESPACE, "mimicZ")
local stateMimicPrimary = State.new(NAMESPACE, "mimicPrimary")

mimic:clear_callbacks()
mimic:onCreate(function(actor)
	--actor.sprite_palette = sprite_palette
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

	actor:enemy_stats_init(10, 200, 200, 0)
	actor.pHmax_base = 2.6

	actor.z_range = 200
	actor:set_default_skill(Skill.SLOT.primary, mimicPrimary)

	actor:init_actor_late()
end)
mimic:onStep(function(actor)
	if actor.actor_state_current_id == -1 and actor.stolen_item and Instance.exists(actor.target) then
		if actor.target.x > actor.x then
			actor.moveLeft = true
			actor.moveRight = false
		else
			actor.moveLeft = false
			actor.moveRight = true
		end

		if math.random() < 0.05 then
			actor.moveUp = true
		end
	end
end)

mimicPrimary:clear_callbacks()
mimicPrimary:onActivate(function(actor)
	actor:enter_state(stateMimicPrimary)
end)

stateMimicPrimary:clear_callbacks()
stateMimicPrimary:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.image_index_previous = 0
	data.substate = 0
	data.loops = 0
	actor:actor_animation_set(sprite_shoot1a, 0.25)
end)

stateMimicPrimary:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()

	if data.substate == 0 then
		if actor.image_index < data.image_index_previous then
			actor:sound_play(sound_shoot, 0.8, 0.9 + math.random() * 0.2)

			data.substate = 1
			actor.image_index = 0
			actor:actor_animation_set(sprite_shoot1b, 0.25)
		end
	elseif data.substate == 1 then
		if math.random() < 0.33 then
			local px = actor.x + (100 + math.random() * 120) * actor.image_xscale
			local py = actor.y - 60 + math.random() * 80
			local pdir = gm.point_direction(px, py, actor.x, actor.y)
			local pspeed = gm.point_distance(px, py, actor.x, actor.y) / 20
			particleVacuum:set_direction(pdir-3, pdir+3, 0, 0)
			particleVacuum:set_speed(pspeed, pspeed, 0.5, 0)
			particleVacuum:create(px, py, 1)
		end

		if data.fired == 0 then
			data.fired = 1
			if Instance.exists(actor.target) and Instance.exists(actor.target.parent) then
				local steal_victim = actor.target.parent
				local target_items = steal_victim.inventory_item_order
				if #target_items > 0 then
					local chosen_id = target_items[math.random(#target_items)]
					local chosen_item = Item.wrap(chosen_id)
					local chosen_count = steal_victim:item_stack_count(chosen_item)
					local chosen_count_normal = steal_victim:item_stack_count(chosen_item, Item.STACK_KIND.normal)

					actor.stolen_item = chosen_id
					actor.stolen_count = chosen_count_normal

					-- TODO: look into using robomando's itemsteal RPC function directly.
					local steal = GM.instance_create(actor.target.x, actor.target.y, gm.constants.oEfRoboBuddySteal)
					steal.parent = actor
					steal.item_id = chosen_id
					steal.count = chosen_count
					steal.tier = chosen_item.tier

					steal_victim:item_remove(chosen_item, chosen_count, Item.STACK_KIND.any)
				else
					-- TODO: gold stealing ???
				end
			end
		end

		if actor.image_index < data.image_index_previous then
			data.loops = data.loops + 1
		end
		if data.loops > 2 or #actor.inventory_item_order > 0 then
			data.substate = 2
			actor.image_index = 0
			actor:actor_animation_set(sprite_shoot1c, 0.25)
		end
	elseif data.substate == 2 then
		if actor.image_index < data.image_index_previous then
			if #actor.inventory_item_order > 0 then
				actor.sprite_idle = sprite_idle2
				actor.sprite_walk = sprite_walk2
				actor:set_default_skill(Skill.SLOT.primary, 0)
			end

			actor:skill_util_reset_activity_state()
		end
	end
	data.image_index_previous = actor.image_index
end)

Callback.add(Callback.TYPE.onDeath, "SSMimicDropItem", function(actor, out_of_bounds)
	if GM.get_object_index(actor) == mimic_id and not out_of_bounds then
		if actor.stolen_item then
			for i=1, actor.stolen_count do
				local item = Item.wrap(actor.stolen_item)
				-- some items don't have corresponding objects, such as used dios or time keeper's secret
				if item.object_id ~= -1 then
					item:create(actor.x, actor.y)
				end
			end
		end
	end
end)

local mimicInactive = Object.new(NAMESPACE, "MimicInactive", Object.PARENT.mapObjects)
local mimicInactive_id = mimicInactive.value

mimicInactive.obj_sprite = sprite_inactive_idle
mimicInactive.obj_depth = 90

mimicInactive:clear_callbacks()
mimicInactive:onCreate(function(self)
	self.image_speed = 0.0

	self:interactable_init() -- just to setup vars that interactable_draw_cost depends on
	self:interactable_init_cost(self, 0, 50)

	self:interactable_sync()
end)
mimicInactive:onDestroy(function(self)
	self:instance_destroy_sync()
end)

mimicInactive:onStep(function(self)
	if self.image_index == 0 and math.random() < 0.002 then
		self.image_speed = 0.2
	elseif self.image_index > self.image_number - 1 then
		self.image_index = 0
		self.image_speed = 0
	end
	if gm._mod_net_isHost() and self:collision_rectangle(self.x - 64, self.y - 32, self.x + 64, self.y + 32, gm.constants.oP, false, false) ~= -4 then
		local actor = mimic:create(self.x, self.y-25)
		self:destroy()
	end
end)
mimicInactive:onDraw(function(self)
	self:interactable_draw_cost()
end)

Callback.add(Callback.TYPE.onDirectorPopulateSpawnArrays, "SSMimicSpawn", function()
	if gm._mod_net_isClient() then return end -- host handles and networks mimic spawns
	if gm.variable_global_get("__gamemode_current") >= 2 then return end -- don't spawn mimics in trials or tutorial..

	-- TEMP: spawn rate jacked up for testing purposes, should be 0.05 / 5%
	if math.random() <= 1.0 then
		gm.mapobject_spawn(mimicInactive_id, 1)
	end
end)
