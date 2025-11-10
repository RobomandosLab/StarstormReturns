local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Mimic")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Mimic")

-- assets
local sprite_mask			= Sprite.new("MimicMask",			path.combine(SPRITE_PATH, "mask.png"), 1, 21, 24)
local sprite_palette		= Sprite.new("MimicPalette",		path.combine(SPRITE_PATH, "palette.png"))

local sprite_idle			= Sprite.new("MimicIdle",			path.combine(SPRITE_PATH, "idle.png"), 2, 30, 35)
local sprite_idle2			= Sprite.new("MimicIdle2",			path.combine(SPRITE_PATH, "idle2.png"), 2, 30, 45)
local sprite_walk			= Sprite.new("MimicWalk",			path.combine(SPRITE_PATH, "walk.png"), 8, 30, 35)
local sprite_walk2			= Sprite.new("MimicWalk2",			path.combine(SPRITE_PATH, "walk2.png"), 6, 30, 35)
local sprite_jump			= Sprite.new("MimicJump",			path.combine(SPRITE_PATH, "jump.png"), 1, 19, 28)
local sprite_jump_peak		= Sprite.new("MimicJumpPeak",		path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 19, 28)
local sprite_fall			= Sprite.new("MimicFall",			path.combine(SPRITE_PATH, "fall.png"), 1, 19, 28)
local sprite_death			= Sprite.new("MimicDeath",			path.combine(SPRITE_PATH, "death.png"), 10, 55, 93)
local sprite_shoot1a		= Sprite.new("MimicShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 10, 30, 45)
local sprite_shoot1b		= Sprite.new("MimicShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 4, 30, 45)
local sprite_shoot1c		= Sprite.new("MimicShoot1c",		path.combine(SPRITE_PATH, "shoot1c.png"), 6, 30, 45)
local sprite_portrait		= Sprite.new("MimicPortrait",		path.combine(SPRITE_PATH, "portrait.png"))

local sprite_inactive_idle	= Sprite.new("MimicInactiveIdle",	path.combine(SPRITE_PATH, "inactiveIdle.png"), 14, 30, 38)
local sprite_activate		= Sprite.new("MimicActivate",		path.combine(SPRITE_PATH, "spawn.png"), 18, 30, 60)
local sprite_vacuum			= Sprite.new("MimicVacuumFX", 		path.combine(SPRITE_PATH, "vacuumParticle.png"), 4, 4, 4)

local sound_spawn			= Sound.new("MimicSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit				= Sound.new("MimicHit",				path.combine(SOUND_PATH, "hit.ogg"))
local sound_shoot			= Sound.new("MimicShoot",			path.combine(SOUND_PATH, "shoot.ogg"))
local sound_death			= Sound.new("MimicDeath",			path.combine(SOUND_PATH, "death.ogg"))

local SUCK_ANIMATION_SPEED = 0.3

local gold_sprites = {
	gm.constants.sEfGold1,
	gm.constants.sEfGold2,
	gm.constants.sEfGold3,
	gm.constants.sEfGold4,
	gm.constants.sEfGold5,
	gm.constants.sEfGold6,
	gm.constants.sEfGold7,
}

local efGoldSteal = Object.new("EfGoldSteal")
efGoldSteal:set_sprite(gm.constants.sEfGold1)
efGoldSteal:set_depth(-279)

local function select_item_to_steal(victim)
	local inventory = victim.inventory_item_order
	
	if #inventory > 0 then
		local chosen_id = inventory[math.random(#inventory)]
		local chosen_item = Item.wrap(chosen_id)
		return chosen_item
	end
	
	return nil
end

local function do_gold_steal(actor, victim)
	victim:sound_play(gm.constants.wGoldBomb, 0.5, 2.5)

	local amount = math.ceil(victim.gold)
	local dir = Math.direction(victim.x, victim.y, actor.x, actor.y)
	local log = math.ceil(math.log(amount, 5))

	-- kind of ugly but, whatever, good enough
	-- do some stuff to produce gold effects that grow in quantity and scale with how much has been stolen
	for i = 0, log do
		local effect = efGoldSteal:create(victim.x, victim.y)
		effect.target = actor
		effect.direction = dir
		effect.speed = math.random(7)
		effect.vspeed = -math.random(7)
		effect.sprite_index = gold_sprites[math.random(math.min(7, log))]
	end

	victim.gold = 0
	actor.gold = amount
	if victim.is_local then
		gm._mod_game_getHUD().gold = 0
	end

	if Net.online and Net.host then
		packetGoldSteal:send_to_all(actor, victim)
	end
end

local particleVacuum = Particle.new("Vacuum")
particleVacuum:set_sprite(sprite_vacuum, false, false, true)
particleVacuum:set_life(15, 20)
particleVacuum:set_speed(0, 0, 0.75, 0)

-- mimic
local mimic = Object.new("Mimic", Object.Parent.ENEMY_CLASSIC)
mimic:set_sprite(sprite_idle)
mimic:set_depth(10) 

-- these are just used to sync the mimic's gold when a player manages to activate a dormant one via purchase
-- i prefer this to adding yet another user packet lol
local serializer = function(actor, buffer)
	actor.gold = buffer:read_uint()
end

local deserializer = function(actor, buffer)
	actor.gold = buffer:read_uint()
end

Object.add_serializers(mimic, serializer, deserializer)

-- create the monster log
local mlog = ssr_create_monster_log("mimic")
mlog.sprite_id = sprite_walk
mlog.portrait_id = sprite_portrait
mlog.sprite_offset_x = 42
mlog.sprite_offset_y = 45
mlog.stat_hp = 200
mlog.stat_damage = 10
mlog.stat_speed = 2.6

local primary			= Skill.new("mimicZ")
local stateSuckStart	= ActorState.new("mimicSuckStart")
local stateSuck			= ActorState.new("mimicSuck")
local stateSuckEnd		= ActorState.new("mimicSuckEnd")

local packetSteal = Packet.new("SyncMimicSteal")

local item_serializer = function(buffer, actor, x, y, tier, item_count)
	buffer:write_instance(actor)
	buffer:write_short(x)
	buffer:write_short(y)
	buffer:write_byte(tier)
	buffer:write_ushort(item_count)
end

local item_deserializer = function(buffer)
	local actor = buffer:read_instance()
	local x, y = buffer:read_short(), buffer:read_short()
	local tier = buffer:read_byte()
	local item_count = buffer:read_ushort()

	local steal = Object.find("EfRoboBuddySteal"):create(x, y)
	steal.parent = actor
	steal.count = item_count
	steal.tier = tier
end

packetSteal:set_serializers(item_serializer, item_deserializer)

local packetGoldSteal = Packet.new("SyncMimicGoldSteal")

local gold_serializer = function(buffer, actor, victim)
	buffer:write_instance(actor)
	buffer:write_instance(victim)
end

local gold_deserializer = function(buffer)
	local actor = buffer:read_instance()
	local victim = buffer:read_instance()
	
	if not actor:exists() then return end
	if not victim:exists() then return end
	
	do_gold_steal(actor, victim)
end

packetGoldSteal:set_serializers(gold_serializer, gold_deserializer)

Callback.add(mimic.on_create, function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_jump = true
	actor.leap_max_distance = 3

	actor.mask_index = sprite_mask

	actor.sound_hit = sound_hit
	actor.sound_death = sound_death

	-- damage, health, knockback cap/threshold, gold/exp reward
	actor:enemy_stats_init(10, 200, 200, 0)
	actor.pHmax_base = 2.4 + math.min(0.2 * GM._mod_game_getDirector().enemy_buff, 3)

	actor.z_range = 200
	actor:set_default_skill(Skill.Slot.PRIMARY, primary)

	actor.monster_log_drop_id = mlog.value

	actor:init_actor_late()
end)

Callback.add(mimic.on_step, function(actor)
	if actor.stolen_item or actor.gold > 0 and not actor.fleeing then
		actor.fleeing = true
		actor:alarm_set(0, -1) -- disable the classic enemy ai -- not perfect but it does the job

		-- closed idle/walk sprites for the getaway
		actor.sprite_idle = sprite_idle2
		actor.sprite_walk = sprite_walk2
	end

	-- has to be here instead of at the start so the clients still get the unique getaway sprites
	if Net.client then return end

	if actor.fleeing and actor.actor_state_current_id == -1 then
		-- attempt to flee at all times
		if Instance.exists(actor.target) then
			local sync = false

			if actor.target.x > actor.x then
				if not Util.bool(actor.moveLeft) then sync = true end
				actor.moveLeft = true
				actor.moveRight = false
			else
				if not Util.bool(actor.moveRight) then sync = true end
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

Callback.add(mimic.on_destroy, function(actor)
	Particle.find("Spark"):create(actor.x, actor.y, 7)
	actor:screen_shake(4)

	if actor.gold > 0 then
		gm.drop_gold_and_exp(actor.x, actor.y, actor.gold, nil, true, false) -- last two args are 'drop gold', 'drop exp'
	end
end)

Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSuckStart)
end)

Callback.add(stateSuckStart.on_enter, function(actor, data)
	actor.image_index = 0
	data.noised = 0
end)

Callback.add(stateSuckStart.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1a, SUCK_ANIMATION_SPEED)

	if data.noised == 0 and actor.image_index >= 4 then
		data.noised = 1
		actor:sound_play(gm.constants.wDroneRecycler_Activate, 0.8, 1.0 + math.random() * 0.2)
	end

	if actor.image_index + actor.image_speed >= 10 then
		actor:set_state(stateSuck)
	end
end)

Callback.add(stateSuck.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.loops = 0
	data.noised = 0
	data.stealed = 0

	actor:screen_shake(3)
end)

Callback.add(stateSuck.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1b, SUCK_ANIMATION_SPEED)

	-- everything within here runs a few times during the mimic's attack
	if data.fired == 0 then
		data.fired = 1

		if data.noised == 0 then
			data.noised = 1
			actor:sound_play(sound_shoot, 1, 1)
		end

		-- attempt to steal stuff until something gives
		if data.stealed == 0 and Net.host then
			for _, victim in ipairs(actor:get_collisions_rectangle(gm.constants.pActor, actor.x, actor.y - 72, actor.x + 248 * actor.image_xscale, actor.y + 72)) do
				if victim.team ~= actor.team then
					local item = select_item_to_steal(victim)
					if item then
						data.stealed = 1

						local item_id = item.value
						local item_count = victim:item_count(item, Item.StackKind.ANY)

						-- robomando enemy itemsteal effect -- gives the item to the mimic once it reaches it
						local steal = Object.find("EfRoboBuddySteal"):create(victim.x, victim.y)
						steal.parent = actor
						steal.item_id = item_id
						steal.count = item_count
						steal.tier = item.tier

						victim:item_take(item, item_count, Item.StackKind.ANY)

						-- store the item in variables for easy access when it dies
						-- i'd use :get_data for this but that shit is hideously unreliable lol
						actor.stolen_item = item_id
						actor.stolen_item_count = item_count

						if Net.online then
							packetSteal:send_to_all(actor, steal.x, steal.y, item.tier, item_count)
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
	end

	if math.random() < 0.33 then
		local px = actor.x + (100 + math.random() * 120) * actor.image_xscale
		local py = actor.y - 60 + math.random() * 80
		local pdir = Math.direction(px, py, actor.x, actor.y)
		particleVacuum:set_direction(pdir - 3, pdir + 3, 0, 0)
		particleVacuum:create(px, py, 1)
	end

	-- image_index wraps around when the animation loops, so extrapolate if it would loop next frame
	if actor.image_index + actor.image_speed >= 4 then
		actor.image_index = actor.image_index - 4
		data.loops = data.loops + 1

		data.fired = 0
	end
	
	if data.loops > 3 then
		actor:set_state(stateSuckEnd)
	end
end)

Callback.add(stateSuckEnd.on_enter, function(actor, data)
	actor.image_index = 0
	actor:screen_shake(5)

	data.fired = 0
end)

Callback.add(stateSuckEnd.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1c, SUCK_ANIMATION_SPEED)

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wChest0, 1, 0.8)

		-- cheeky attack when it visually "bites down" to give it a chance to proc on-hits
		actor:fire_explosion_local(actor.x + 24 * actor.image_xscale, actor.y, 60, 30, 1)
	end

	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(Callback.ON_DEATH, function(actor, out_of_bounds)
	if not actor:get_object_index() == mimic.value or out_of_bounds then return end
	
	if actor.stolen_item then
		local item = Item.wrap(actor.stolen_item)
		-- some items don't have corresponding objects, such as used dios or time keeper's secret
		if item.object_id ~= -1 then
			for i = 1, actor.stolen_item_count do
				item:create(actor.x, actor.y)
			end
		end
	end
end)

-- visual effect used for gold stealing. doesn't affect anything, just provides visual of coins similar to oEfGold
Callback.add(efGoldSteal.on_create, function(self)
	self.image_speed = 0.25
	self.target = -4
	self.gravity = 0.4
	self.go = 0
end)

Callback.add(efGoldSteal.on_step, function(self)
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
		local dir = Math.direction(self.x, self.y, tx, ty)

		self.direction = dir
		self.speed = math.min(self.speed + 0.5, 5)
	end

	if Math.distance(self.x, self.y, tx, ty) <= 20 + self.speed then
		self:sound_play(gm.constants.wCoin, 1, 1)
		Particle.find("GoldSparkleBig"):create(self.x, self.y, 1)
		self:destroy()
	end
end)

-- object for when mimic is idle in the world, waiting for a victim
-- it's actually interactable, and can be purchased, which spawns the mimic with gold :3
local mimicInactive = Object.new("MimicInactive", Object.Parent.INTERACTABLE)
mimicInactive:set_sprite(sprite_inactive_idle)
mimicInactive:set_depth(90)

Callback.add(mimicInactive.on_create, function(self)
	GM.interactable_init_cost(self, 0, 50)
end)

Callback.add(mimicInactive.on_step, function(self)
	-- pInteractable automatically stops animation when it ends -- this code uses that to its advantage
	if self.active == 0 then
		-- occasional idle fidget
		if self.image_speed == 0 and math.random() < 0.004 then
			self.image_speed = 0.2
			self.image_index = 0
		end

		-- anyone nearby?
		if Net.host and math.random() < 0.01 then
			local target = self:collision_rectangle(self.x - 140, self.y - 90, self.x + 140, self.y + 32, gm.constants.oP, false, false)

			if target ~= -4 and Util.bool(target.is_targettable) then
				self.active = 1

				-- send a built-in set_active packet
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
			if Net.host then
				local actor = mimic:create(self.x, self.y - 25)

				-- if there's a valid activator, that means a player managed to activate it by purchase
				if self.activator ~= -4 then
					-- give mimic the gold that the player paid
					actor.gold = self.cost
					actor:instance_resync() -- force gold to get synced through instance serialization... ugly but works
				end

				self:instance_destroy_sync() -- tell clients to destroy this object, doesn't actually destroy it on the host
				self:destroy()
			end
		end
	end
end)

Callback.add(Callback.ON_STAGE_START, function()
	if Net.client then return end -- host handles spawning
	if Global.__gamemode_current >= 2 then return end -- don't spawn mimics in trials or tutorial..

	-- try spawning up to 3 mimics, though more than 1 is extremely unlikely
	for i = 0, 3 do
		if math.random() <= 0.1 then
			-- function used by the game's director when spawninginteractables.
			gm._mod_game_getDirector():mapobject_spawn(mimicInactive.value, 1) -- second arg is required tile space
		else
			break
		end
	end
end)
