local sprite_egg = Resources.sprite_load(NAMESPACE, "JudderingEgg", path.combine(PATH, "Sprites/Items/judderingEgg.png"), 1, 17, 18)
local sprite_wurm = Resources.sprite_load(NAMESPACE, "BabyWurm", path.combine(PATH, "Sprites/Items/Effects/babyWurm.png"), 5, 5, 13)

local judderingEgg = Item.new(NAMESPACE, "judderingEgg")
judderingEgg:set_sprite(sprite_egg)
judderingEgg:set_tier(Item.TIER.rare)
judderingEgg:set_loot_tags(Item.LOOT_TAG.category_damage, Item.LOOT_TAG.item_blacklist_engi_turrets)

local WURM_SEGMENT_COUNT = 7
local WURM_SEGMENT_LENGTH = 25
local WURM_ATTACK_RANGE = 600
local WURM_ATTACK_SHOTS = 18
local WURM_ATTACK_INTERVAL = 5
local WURM_ATTACK_COOLDOWN = 60 * 3.5
local WURM_FOLLOW_RADIUS = 128
local WURM_FOLLOW_MARGIN = 80

local function create_wurm(x, y, owner)
	local wurm = {
		parent = owner,
		segments = {},
		cooldown = 60,
		speed = 2,
		firing = false,
		shots = 0,
		target = Instance.wrap_invalid(),
		laser_x = -1,
		laser_y = -1,
	}

	local angle = math.random() * math.pi * 2

	for i=1, WURM_SEGMENT_COUNT do
		wurm.segments[i] = {
			x = x,
			y = y,
			direction = math.deg(angle),
		}
	end

	return wurm
end
local function find_target(wurm)
	local candidate = wurm.parent:find_target_nearest()

	if Instance.exists(candidate) and gm.point_distance(wurm.parent.x, wurm.parent.y, candidate.x, candidate.y) < WURM_ATTACK_RANGE then
		return candidate.parent
	end
	return Instance.wrap_invalid()
end

local wurm_owners = {}

judderingEgg:clear_callbacks()
judderingEgg:onAcquire(function(actor, stack)
	local data = actor:get_data()

	if not data.wurm_pets then
		data.wurm_pets = {}
		wurm_owners[actor.id] = true
	end

	data.wurm_pets[stack] = create_wurm(actor.x, actor.y, actor)
end)
judderingEgg:onRemove(function(actor, stack)
	local data = actor:get_data()
	if not data.wurm_pets then return end

	data.wurm_pets[stack] = nil
	if stack == 1 then
		-- last wurm removed. clean up.
		data.wurm_pets = nil
		wurm_owners[actor.id] = nil
	end
end)
judderingEgg:onPreStep(function(actor, stack)
	local data = actor:get_data()
	if not wurm_owners[actor.id] then
		wurm_owners[actor.id] = true
	end
end)

local sparkParticle = Particle.find("ror", "Spark")
local packetSyncWurm = Packet.new()

-- use a global callback instead of an item callback, so that the wurm can still exist while the player is dead.
Callback.add(Callback.TYPE.onStep, "SSJudderingEggStep", function()
	for id, _ in pairs(wurm_owners) do
		if not Instance.exists(id) then
			wurm_owners[id] = nil
		end
	end
	for id, _ in pairs(wurm_owners) do
		local actor = Instance.wrap(id)
		local stack = actor:item_stack_count(judderingEgg)

		local data = actor:get_data()
		local wurm_pets = data.wurm_pets
		if not wurm_pets then return end

		for i, wurm in ipairs(wurm_pets) do
			local head = wurm.segments[1]

			-- WURM MOTION
			-- the baby wurm's motion is based around following a target position, while avoiding being too close to it
			-- all of this happens client-side and doesn't matter for its gameplay mechanics, so none of this is networked

			local target_x = actor.x
			local target_y = actor.y

			-- prevent multiple wurms from overlapping while following their owner, by shifting their target positions slightly
			if not wurm.firing and stack > 1 then
				target_x = target_x - math.sin((i * math.pi * 2) / stack) * WURM_FOLLOW_RADIUS*0.4
				target_y = target_y - math.cos((i * math.pi * 2) / stack) * WURM_FOLLOW_RADIUS*0.4
			end

			if wurm.firing and Instance.exists(wurm.target) then
				target_x = wurm.target.x
				target_y = wurm.target.y
			end

			-- as the wurm approaches WURM_FOLLOW_RADIUS distance to the target, it will begin to turn up to 90 degrees to steer clear of the target.
			-- this gives it a circling motion, both when following its owner and when pursuing an enemy.
			local dist = gm.point_distance(head.x, head.y, target_x, target_y)

			local target_speed = 8
			local target_direction = gm.point_direction(head.x, head.y, target_x, target_y)
			if dist < WURM_FOLLOW_RADIUS + WURM_FOLLOW_MARGIN then
				-- calculate direction to steer away from the target position
				-- this is 1.0 at WURM_FOLLOW_RADIUS, and linearly tapers off to 0.0 at WURM_FOLLOW_RADIUS + WURM_FOLLOW_MARGIN
				local steer_factor = 1 - ((dist - WURM_FOLLOW_RADIUS) / WURM_FOLLOW_MARGIN)

				steer_factor = math.max(0, math.min(1, steer_factor))
				steer_direction = gm.sign(gm.angle_difference(head.direction, target_direction))

				target_speed = math.max(1, steer_factor * 3)

				target_direction = target_direction + steer_direction * 90 * steer_factor
			end

			local turn_coefficient = 0.1
			if wurm.firing then
				turn_coefficient = 0.5
			end

			head.direction = head.direction - gm.angle_difference(head.direction, target_direction) * turn_coefficient
			head.direction = head.direction - 1 + math.random() * 2

			-- using lerp smoothing is kinda iffy but ehhh good enough?
			wurm.speed = gm.lerp(wurm.speed, target_speed, 0.01)
			head.x = head.x + gm.lengthdir_x(wurm.speed, head.direction)
			head.y = head.y + gm.lengthdir_y(wurm.speed, head.direction)

			-- update body segment positions
			for i=2, #wurm.segments do
				local seg = wurm.segments[i]
				local seg_prev = wurm.segments[i-1]
				seg.direction = gm.point_direction(seg.x, seg.y, seg_prev.x, seg_prev.y)
				seg.x = seg_prev.x - gm.lengthdir_x(WURM_SEGMENT_LENGTH, seg.direction)
				seg.y = seg_prev.y - gm.lengthdir_y(WURM_SEGMENT_LENGTH, seg.direction)
			end

			--- WURM ATTACK
			-- every interval, the wurm looks for a valid target.
			-- if it finds one, it will lock onto it and fire until it either runs out of shots or the target dies
			-- if the current target is gone for any reason (died, ceased to exist, etc.), the wurm tries to find a new target
			-- if the wurm runs out of shots, or can't find a new target while firing, it will stop and set its next interval to WURM_ATTACK_COOLDOWN

			--- NETWORKING
			-- the host handles target acquisition, firing the attack, and managing shot count.
			-- when the target changes, including there being no target before or after, the host sends a packet to sync the wurm's state on clients
			-- the client just does the wurm's attacking fx, and nothing else.

			wurm.cooldown = wurm.cooldown - 1
			if wurm.cooldown < 0 then
				local sync = false -- only matters on the host

				if gm._mod_net_isHost() then
					-- host handles targetting
					if not wurm.firing then
						wurm.target = find_target(wurm)
						if wurm.target:exists() then
							wurm.firing = true
							wurm.shots = WURM_ATTACK_SHOTS
							wurm.cooldown = 0

							sync = true

							gm.sound_play_at(gm.constants.wWurmLaser, 0.8, 1.075 + math.random() * 0.1, head.x, head.y)
						else
							wurm.cooldown = 15 + math.random(15)
						end
					elseif not wurm.target:exists() then
						wurm.target = find_target(wurm)
						if not wurm.target:exists() then
							wurm.firing = false
							wurm.target = Instance.wrap_invalid()
							wurm.shots = 0
							wurm.cooldown = WURM_ATTACK_COOLDOWN
						end
						sync = true
					end
				end

				if wurm.firing and Instance.exists(wurm.target) then
					sparkParticle:create(wurm.target.x, wurm.target.y, 3)

					wurm.target:sound_play(gm.constants.wChainLightning, 1, 0.8 + math.random() * 0.2)
					wurm.target:sound_play(gm.constants.wGiantJellyExplosion, 0.5, 0.8 + math.random() * 0.2)
					wurm.target:screen_shake(1)

					wurm.cooldown = WURM_ATTACK_INTERVAL

					if gm._mod_net_isHost() then
						actor:fire_explosion(wurm.target.x, wurm.target.y, 32, 32, 0.8, nil, nil, false)

						wurm.shots = wurm.shots - 1
						if wurm.shots <= 0 then
							wurm.firing = false
							wurm.target = Instance.wrap_invalid()
							wurm.shots = 0
							wurm.cooldown = WURM_ATTACK_COOLDOWN

							sync = true
						end
					end
				end

				if gm._mod_net_isHost() and gm._mod_net_isOnline() and sync then
					local msg = packetSyncWurm:message_begin()

					msg:write_instance(actor) -- wurm owner
					msg:write_uint(i - 1) -- wurm index
					msg:write_instance(wurm.target) -- if the target is invalid, the wurm is inferred to not be firing

					msg:send_to_all()
				end
			end
		end
	end
end)

-- this is kind of horrible but it works well enough
packetSyncWurm:onReceived(function(msg)
	local actor = msg:read_instance()
	local index = msg:read_uint() + 1
	local target = msg:read_instance()

	if not actor:exists() then return end

	local wurm_pets = actor:get_data().wurm_pets
	if not wurm_pets then return end

	local wurm = wurm_pets[index]
	if wurm then
		local previous_firing = wurm.firing

		wurm.firing = Instance.exists(target)
		wurm.target = target

		if wurm.firing and not previous_firing then
			local head = wurm.segments[1]
			gm.sound_play_at(gm.constants.wWurmLaser, 0.8, 1.075 + math.random() * 0.1, head.x, head.y)
		end
	end
end)

-- draw wurms with a global callback, so that they appear even if their player is invisible for any reason (teleporting, dead, etc.)
Callback.add(Callback.TYPE.onDraw, "SSJudderingEggDraw", function()
	for id, _ in pairs(wurm_owners) do
		if not Instance.exists(id) then
			wurm_owners[id] = nil
		end
	end
	for id, _ in pairs(wurm_owners) do
		local actor = Instance.wrap(id)

		local wurm_pets = actor:get_data().wurm_pets
		if not wurm_pets then return end

		-- draw laser first
		for _, wurm in ipairs(wurm_pets) do
			if wurm.firing then
				local head = wurm.segments[1]

				-- if the target ceases existing while the wurm is firing, the laser remains at the last valid position
				-- only really comes into play on clients.
				if Instance.exists(wurm.target) then
					wurm.laser_x = wurm.target.x
					wurm.laser_y = wurm.target.y
				end

				local x1, y1, x2, y2
				x1 = head.x + gm.lengthdir_x(16, head.direction)
				y1 = head.y + gm.lengthdir_y(16, head.direction)
				x2 = wurm.laser_x + gm.random_range(-2, 2)
				y2 = wurm.laser_y + gm.random_range(-2, 2)

				gm.draw_set_alpha(0.5)

				gm.draw_set_colour(Color.RED)
				gm.draw_line_width(x1, y1, x2, y2, 5 + math.random() * 2)
				gm.draw_circle(x2, y2, 4 + math.random() * 8, false)

				gm.draw_set_colour(Color.WHITE)
				gm.draw_line_width(x1, y1, x2, y2, 2)
				gm.draw_circle(x2, y2, 8, true)

				gm.draw_lightning(x1, y1, x2, y2, 255)
				gm.draw_lightning(x1, y1, x2, y2, 255)

				gm.draw_set_alpha(1)
			end
		end
		-- draw body
		for _, wurm in ipairs(wurm_pets) do
			for i=0, #wurm.segments-1 do
				-- segments are drawn in reverse order (tail to head)
				local real_index = #wurm.segments - i
				local segment = wurm.segments[real_index]

				local subimage = 3
				if real_index == 1 then
					if wurm.firing then
						subimage = 1
					else
						subimage = 0
					end
				elseif real_index == 2 then
					subimage = 2
				elseif real_index == #wurm.segments then
					subimage = 4
				end
				gm.draw_sprite_ext(sprite_wurm, subimage, segment.x, segment.y, 1, 1, segment.direction, Color.WHITE, 1)
			end
		end
	end
end)

judderingEgg:onStageStart(function(actor, stack)
	local wurm_pets = actor:get_data().wurm_pets
	if not wurm_pets then return end

	for _, wurm in ipairs(wurm_pets) do
		wurm.firing = false

		local head = wurm.segments[1]
		local angle = math.random() * math.pi * 2
		head.x = actor.x + math.sin(angle) * WURM_FOLLOW_RADIUS
		head.y = actor.y + math.cos(angle) * WURM_FOLLOW_RADIUS
	end
end)
