local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Mimic")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Mimic")

-- assets
local sprite_mask		= Resources.sprite_load(NAMESPACE, "MimicMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 21, 24)
local sprite_palette	= Resources.sprite_load(NAMESPACE, "MimicPalette",	path.combine(SPRITE_PATH, "palette.png"))
gm.elite_generate_palettes(sprite_palette)
local sprite_idle		= Resources.sprite_load(NAMESPACE, "MimicIdle",		path.combine(SPRITE_PATH, "idle.png"), 2, 30, 35)
local sprite_idle2		= Resources.sprite_load(NAMESPACE, "MimicIdle2",	path.combine(SPRITE_PATH, "idle2.png"), 2, 30, 45)
local sprite_walk		= Resources.sprite_load(NAMESPACE, "MimicWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 30, 35)
local sprite_walk2		= Resources.sprite_load(NAMESPACE, "MimicWalk2",	path.combine(SPRITE_PATH, "walk2.png"), 6, 30, 35)
local sprite_jump		= Resources.sprite_load(NAMESPACE, "MimicJump",		path.combine(SPRITE_PATH, "jump.png"), 1, 19, 28)
local sprite_jump_peak	= Resources.sprite_load(NAMESPACE, "MimicJumpPeak",	path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 19, 28)
local sprite_fall		= Resources.sprite_load(NAMESPACE, "MimicFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 19, 28)
local sprite_death		= Resources.sprite_load(NAMESPACE, "MimicDeath",	path.combine(SPRITE_PATH, "death.png"), 10, 55, 93)
local sprite_shoot1a	= Resources.sprite_load(NAMESPACE, "MimicShoot1a",	path.combine(SPRITE_PATH, "shoot1a.png"), 10, 30, 45)
local sprite_shoot1b	= Resources.sprite_load(NAMESPACE, "MimicShoot1b",	path.combine(SPRITE_PATH, "shoot1b.png"), 4, 30, 45)
local sprite_shoot1c	= Resources.sprite_load(NAMESPACE, "MimicShoot1c",	path.combine(SPRITE_PATH, "shoot1c.png"), 6, 30, 45)
--local sprite_portrait	= Resources.sprite_load(NAMESPACE, "MimicPortrait",	path.combine(SPRITE_PATH, "portrait.png"))

local sprite_inactive_idle = Resources.sprite_load(NAMESPACE, "MimicInactiveIdle",	path.combine(SPRITE_PATH, "inactiveIdle.png"), 14, 30, 38)
local sprite_activate	= Resources.sprite_load(NAMESPACE, "MimicActivate",	path.combine(SPRITE_PATH, "spawn.png"), 18, 30, 60)
local sprite_vacuum		= Resources.sprite_load(NAMESPACE, "MimicVacuumFX", path.combine(SPRITE_PATH, "vacuumParticle.png"), 4, 4, 4)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "MimicSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit			= Resources.sfx_load(NAMESPACE, "MimicHit",		path.combine(SOUND_PATH, "hit.ogg"))
local sound_shoot		= Resources.sfx_load(NAMESPACE, "MimicShoot",	path.combine(SOUND_PATH, "shoot.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "MimicDeath",	path.combine(SOUND_PATH, "death.ogg"))

local particleVacuum = Particle.new(NAMESPACE, "Vacuum")
particleVacuum:set_sprite(sprite_vacuum, false, false, true)
particleVacuum:set_life(15, 20)
particleVacuum:set_speed(0, 0, 0.75, 0)

-- mimic
local mimic = Object.new(NAMESPACE, "Mimic", Object.PARENT.enemyClassic)
local mimic_id = mimic.value

mimic.obj_sprite = sprite_idle
mimic.obj_depth = 10

local efGoldSteal = Object.new(NAMESPACE, "EfGoldSteal")
efGoldSteal.obj_sprite = gm.constants.sEfGold1
efGoldSteal.obj_depth = -279

local gold_sprites = {
	gm.constants.sEfGold1,
	gm.constants.sEfGold2,
	gm.constants.sEfGold3,
	gm.constants.sEfGold4,
	gm.constants.sEfGold5,
	gm.constants.sEfGold6,
	gm.constants.sEfGold7,
}

local mimicPrimary			= Skill.new(NAMESPACE, "mimicZ")
local stateMimicSuckStart	= State.new(NAMESPACE, "mimicSuckStart")
local stateMimicSuck		= State.new(NAMESPACE, "mimicSuck")
local stateMimicSuckEnd		= State.new(NAMESPACE, "mimicSuckEnd")

local packetMimicSteal = Packet.new()
local packetMimicGoldSteal = Packet.new()

mimic:clear_callbacks()
mimic:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	--actor.sprite_spawn = sprite_spawn -- handled by MimicInactive object
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_jump = true
	actor.leap_max_distance = 3

	actor.mask_index = sprite_mask

	--actor.sound_spawn = sound_spawn
	actor.sound_hit = sound_hit
	actor.sound_death = sound_death

	actor:enemy_stats_init(10, 200, 200, 0)
	actor.pHmax_base = 2.4 + math.min(0.2 * GM._mod_game_getDirector().enemy_buff, 3)

	actor.z_range = 200
	actor:set_default_skill(Skill.SLOT.primary, mimicPrimary)

	-- monster logs are really scuffed in RMT right now..
	--actor.monster_log_drop_id = log.value

	actor:init_actor_late()
end)
mimic:onStep(function(actor)
	if actor.stolen_item or actor.gold > 0 and not actor.fleeing then
		actor.fleeing = true
		actor:alarm_set(0, -1) -- disable the classic enemy ai -- not perfect but it does the job

		actor.sprite_idle = sprite_idle2
		actor.sprite_walk = sprite_walk2
	end

	if gm._mod_net_isClient() then return end

	if actor.fleeing and actor.actor_state_current_id == -1 then
		if Instance.exists(actor.target) then
			local sync = false

			if actor.target.x > actor.x then
				if not gm.bool(actor.moveLeft) then sync = true end
				actor.moveLeft = true
				actor.moveRight = false
			else
				if not gm.bool(actor.moveRight) then sync = true end
				actor.moveLeft = false
				actor.moveRight = true
			end

			if math.random() < 0.05 then
				actor.moveUp = true
				sync = true
			end

			if sync then
				-- inform clients when mimic's movement inputs change
				actor:net_send_instance_message(0) -- actor_position_info
			end
		else
			actor.target = gm.instance_nearest(actor.x, actor.y, gm.constants.oP)
		end
	end
end)
mimic:onDestroy(function(actor)
	Particle.find("ror", "Spark"):create(actor.x, actor.y, 7)
	actor:screen_shake(4)

	if actor.gold > 0 then
		gm.drop_gold_and_exp(actor.x, actor.y, actor.gold, nil, true, false)
	end
end)

mimic:onSerialize(function(actor, buffer)
	buffer:write_uint(actor.gold)
end)
mimic:onDeserialize(function(actor, buffer)
	actor.gold = buffer:read_uint()
end)

mimicPrimary:clear_callbacks()
mimicPrimary:onActivate(function(actor)
	actor:enter_state(stateMimicSuckStart)
end)

local SUCK_ANIMATION_SPEED = 0.3

local function select_item_to_steal(victim)
	local inventory = victim.inventory_item_order
	if #inventory > 0 then
		local chosen_id = inventory[math.random(#inventory)]
		local chosen_item = Item.wrap(chosen_id)
		return chosen_item
	end
	return nil
end
local function sync_steal_effects(actor, x, y, tier, item_count)
	if gm._mod_net_isClient() then error("sync_steal_effects called on client!") end
	local msg = packetMimicSteal:message_begin()
	msg:write_instance(actor)
	msg:write_ushort(x)
	msg:write_ushort(y)
	msg:write_byte(tier)
	msg:write_ushort(item_count)
	msg:send_to_all()
end
packetMimicSteal:onReceived(function(msg)
	local actor = msg:read_instance()
	local x, y = msg:read_ushort(), msg:read_ushort()
	local tier = msg:read_byte()
	local item_count = msg:read_ushort()

	local steal = GM.instance_create(x, y, gm.constants.oEfRoboBuddySteal)
	steal.parent = actor
	steal.count = item_count
	steal.tier = tier
end)
local function do_gold_steal(actor, victim)
	victim:sound_play(gm.constants.wGoldBomb, 0.5, 2.5)

	local amount = math.ceil(victim.gold)
	local dir = gm.point_direction(victim.x, victim.y, actor.x, actor.y)
	local log = math.ceil(math.log(amount, 5))

	-- kind of ugly but, whatever, good enough
	for i=0, log do
		local g = efGoldSteal:create(victim.x, victim.y)
		g.target = actor
		g.direction = dir
		g.speed = math.random(7)
		g.vspeed = -math.random(7)
		g.sprite_index = gold_sprites[math.random(math.min(7, log))]
	end

	victim.gold = 0
	actor.gold = amount
	if victim.is_local then
		local hud = gm._mod_game_getHUD()
		hud.gold = 0
	end

	if gm._mod_net_isOnline() and gm._mod_net_isHost() then
		local msg = packetMimicGoldSteal:message_begin()
		msg:write_instance(actor)
		msg:write_instance(victim)
		msg:send_to_all()
	end
end
packetMimicGoldSteal:onReceived(function(msg)
	local actor = msg:read_instance()
	local victim = msg:read_instance()
	if not actor:exists() then return end
	if not victim:exists() then return end
	do_gold_steal(actor, victim)
end)

stateMimicSuckStart:clear_callbacks()
stateMimicSuck:clear_callbacks()
stateMimicSuckEnd:clear_callbacks()

stateMimicSuckStart:onEnter(function(actor, data)
	actor.image_index = 0
	data.noised = 0
end)
stateMimicSuckStart:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1a, SUCK_ANIMATION_SPEED)

	if data.noised == 0 and actor.image_index >= 4 then
		data.noised = 1
		actor:sound_play(gm.constants.wDroneRecycler_Activate, 0.8, 1. + math.random() * 0.2)
	end

	if actor.image_index + actor.image_speed >= 10 then
		actor:enter_state(stateMimicSuck)
	end
end)

stateMimicSuck:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.loops = 0
	data.noised = 0
	data.stealed = 0

	actor:screen_shake(3)
end)
stateMimicSuck:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1b, SUCK_ANIMATION_SPEED)

	if data.fired == 0 then
		data.fired = 1

		if data.noised == 0 then
			data.noised = 1
			actor:sound_play(sound_shoot, 1, 1)
		end

		if data.stealed == 0 and gm._mod_net_isHost() then
			local x1, y1 = actor.x, actor.y - 72
			local x2, y2 = actor.x + 248 * actor.image_xscale, actor.y + 72

			local victims = List.wrap(actor:find_characters_rectangle(x1, y1, x2, y2, actor.team, false))

			for _, victim in ipairs(victims) do
				local item = select_item_to_steal(victim)
				if item then
					data.stealed = 1

					local item_id = item.value
					local item_count = victim:item_stack_count(item, Item.STACK_KIND.any)

					local steal = GM.instance_create(victim.x, victim.y, gm.constants.oEfRoboBuddySteal)
					steal.parent = actor
					steal.item_id = item_id
					steal.count = item_count
					steal.tier = item.tier

					victim:item_remove(item, item_count, Item.STACK_KIND.any)

					actor.stolen_item = item_id
					actor.stolen_item_count = item_count

					if gm._mod_net_isOnline() then
						sync_steal_effects(actor, steal.x, steal.y, item.tier, item_count)
					end
					break
				elseif victim.gold and victim.gold > 0 then
					data.stealed = 1

					do_gold_steal(actor, victim)
					break
				end
			end
		end
	end

	if math.random() < 0.33 then
		local px = actor.x + (100 + math.random() * 120) * actor.image_xscale
		local py = actor.y - 60 + math.random() * 80
		local pdir = gm.point_direction(px, py, actor.x, actor.y)
		--local pspeed = gm.point_distance(px, py, actor.x, actor.y) / 20
		particleVacuum:set_direction(pdir-3, pdir+3, 0, 0)
		--particleVacuum:set_speed(pspeed, pspeed, 0.5, 0)
		particleVacuum:create(px, py, 1)
	end

	if actor.image_index + actor.image_speed >= 4 then
		actor.image_index = actor.image_index - 4
		data.loops = data.loops + 1

		data.fired = 0
	end
	if data.loops > 3 then
		actor:enter_state(stateMimicSuckEnd)
	end
end)

stateMimicSuckEnd:onEnter(function(actor, data)
	actor.image_index = 0
	actor:screen_shake(5)

	data.fired = 0
end)
stateMimicSuckEnd:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1c, SUCK_ANIMATION_SPEED)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wChest0, 1, 0.8)

		actor:fire_explosion_local(actor.x + 24 * actor.image_xscale, actor.y, 60, 30, 1)
	end

	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(Callback.TYPE.onDeath, "SSMimicDropItem", function(actor, out_of_bounds)
	if GM.get_object_index(actor) == mimic_id and not out_of_bounds then
		if actor.stolen_item then
			for i=1, actor.stolen_item_count do
				local item = Item.wrap(actor.stolen_item)
				-- some items don't have corresponding objects, such as used dios or time keeper's secret
				if item.object_id ~= -1 then
					item:create(actor.x, actor.y)
				end
			end
		end
	end
end)

efGoldSteal:clear_callbacks()
efGoldSteal:onCreate(function(self)
	self.image_speed = 0.25
	self.target = -4
	self.gravity = 0.4
	self.go = 0
end)
efGoldSteal:onStep(function(self)
	if not Instance.exists(self.target) then self:destroy() return end

	local target = self.target
	local tx, ty = target.x, target.y

	if self.go == 0 then
		if self:is_colliding(gm.constants.pBlock) then
			self.go = 1
			self.speed = 0
			self.gravity = 0
		end
	else
		local dir = gm.point_direction(self.x, self.y, tx, ty)

		self.direction = dir
		self.speed = math.min(self.speed + 0.5, 5)
	end

	if gm.point_distance(self.x, self.y, tx, ty) <= 20 + self.speed then
		self:sound_play(gm.constants.wCoin, 1, 1)
		Particle.find("ror", "GoldSparkleBig"):create(self.x, self.y, 1)
		self:destroy()
	end
end)

-- object for when mimic is idle in the world, waiting for a victim
-- it's actually interactable, and can be purchased
local mimicInactive = Object.new(NAMESPACE, "MimicInactive", Object.PARENT.interactable)
local mimicInactive_id = mimicInactive.value

mimicInactive.obj_sprite = sprite_inactive_idle
mimicInactive.obj_depth = 90

mimicInactive:clear_callbacks()
mimicInactive:onCreate(function(self)
	self.image_speed = 0
	gm.interactable_init_cost(self.id, 0, 50)
end)

mimicInactive:onStep(function(self)
	-- pInteractable automatically stops animation when it ends -- this code uses that to its advantage
	if self.active == 0 then
		-- occasional idle fidget
		if self.image_speed == 0 and math.random() < 0.004 then
			self.image_speed = 0.2
			self.image_index = 0
		end

		if gm._mod_net_isHost() and math.random() < 0.03 then
			local target = self:collision_rectangle(self.x - 140, self.y - 90, self.x + 140, self.y + 32, gm.constants.oP, false, false)

			if target ~= -4 and gm.bool(target.is_targettable) then
				self.active = 1

				-- send a set_active packet
				gm.server_message_send(0, 79, self:get_object_index_self(), self.m_id, 1)
			end
		end
	end
	if self.active == 1 then
		-- self.active gets automatically set to 2 internally so this only runs for one frame
		self.sprite_index = sprite_activate
		self.image_index = 0
		self.image_speed = 0.2
		self:sound_play(sound_spawn, 1, 1)
		self:sound_play(gm.constants.wPickup, 1, 0.7)
	elseif self.active == 2 then
		if self.image_index >= 14 and not self.stompied then
			self.stompied = true
			self:screen_shake(5)
			self:sound_play(gm.constants.wClayDeath, 0.7, 1.35)
		end

		if self.image_speed == 0 then
			if gm._mod_net_isHost() then
				local actor = mimic:create(self.x, self.y-25)

				-- if there's a valid activator, that means a player managed to activate it by purchase
				if self.activator ~= -4 then
					-- give mimic the gold that the player paid
					actor.gold = self.cost
					actor:instance_resync() -- force gold to get synced through instance serialization... ugly but works
				end

				self:instance_destroy_sync() -- tell clients to remove this object
				self:destroy()
			end
		end
	end
end)

Callback.add(Callback.TYPE.onStageStart, "SSMimicSpawn", function()
	if gm._mod_net_isClient() then return end -- host handles
	if gm.variable_global_get("__gamemode_current") >= 2 then return end -- don't spawn mimics in trials or tutorial..

	-- try spawning up to 3 mimics, though more than 1 is extremely unlikely
	for i=1, 3 do
		if math.random() <= 0.05 then
			gm.mapobject_spawn(mimicInactive_id, 1)
		else
			break
		end
	end
end)
