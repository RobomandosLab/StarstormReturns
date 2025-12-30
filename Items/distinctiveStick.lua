local sprite_item = Sprite.new("DistinctiveStick", path.combine(PATH, "Sprites/Items/distinctiveStick.png"), 1, 16, 16)
local sprite_effect = Sprite.new("EfDistinctiveTree", path.combine(PATH, "Sprites/Items/Effects/distinctiveTree.png"), 1, 9, 48)

local RADIUS_BASE = 220
local RADIUS_STACK = 80

local distinctiveStick = Item.new("distinctiveStick")
distinctiveStick:set_sprite(sprite_item)
distinctiveStick:set_tier(ItemTier.COMMON)
distinctiveStick.loot_tags = Item.LootTag.CATEGORY_HEALING

ItemLog.new_from_item(distinctiveStick)

local efTree = Object.new("EfDistinctiveTree")
efTree:set_sprite(sprite_effect)
efTree:set_depth(50)

Callback.add(efTree.on_create, function(self)
	self.radius = RADIUS_BASE

	self:instance_sync()
end)

local function update_trees(removal)
	if Net.client then return end

	local stack = 0
	
	for _, actor in ipairs(distinctiveStick:get_holding_actors()) do
		if Instance.exists(actor) then
			stack = stack + actor:item_count(distinctiveStick)
		end
	end
	
	if removal then
		stack = stack - 1
	end

	if Instance.count(efTree) == 0 then
		for _, inst in ipairs(Instance.find_all(gm.constants.pTeleporter)) do
			efTree:create(inst.x + math.random(-80, 80), inst.y)
		end
		
		for _, inst in ipairs(Instance.find_all(gm.constants.oCommand)) do
			efTree:create(inst.x + math.random(-80, 80), inst.y)
		end
	end

	for _, inst in ipairs(Instance.find_all(efTree)) do
		if stack > 0 then
			inst.radius = RADIUS_BASE + RADIUS_STACK * (stack - 1)
			inst:instance_resync()
		else
			inst:destroy()
		end
	end
end

Callback.add(distinctiveStick.on_acquired, function(actor, stack)
	update_trees()
end)

Callback.add(distinctiveStick.on_removed, function(actor, stack)
	update_trees(true)
end)

Callback.add(Callback.ON_STAGE_START, function()
	update_trees()
end)

Callback.add(efTree.on_step, function(self)
	if Net.client then return end

	if Global._current_frame % 120 == 0 then
		local targets = self:get_collisions_circle(gm.constants.pActor, self.radius, self.x, self.y)
		
		for _, actor in ipairs(targets) do
			if actor.team == 1 then
				local amount = actor.maxhp * 0.022
				
				if actor.object_index == gm.constants.oP then
					local heal = Object.find("EfHeal2"):create(self.x, self.y)
					heal.target = actor
					heal.value.value = amount
				else
					-- spwaning healing orbs for non-players looks too noisy, so just heal them directly
					actor:heal(amount)
				end
			end
		end
	end
end)

Callback.add(efTree.on_draw, function(self)
	-- time it so that peak brightness coincides with spawning heal
	local timer = (Global._current_frame / 60) * math.pi
	local alpha = 0.6 + math.cos(timer) * 0.2
	local radius = self.radius

	gm.draw_set_colour(Color.from_hex(0x82FF9F))
	
	for i = 0, 5 do
		local circle_radius = radius - i / 10 * RADIUS_BASE
		gm.draw_set_alpha(alpha / (i + 1))
		gm.draw_circle(self.x, self.y, circle_radius, true)
	end
	
	gm.draw_set_alpha(1)
end)

Callback.add(efTree.on_destroy, function(self)
	self:instance_destroy_sync()
end)

-- networking
local serializer = function(self, buffer)
	buffer:write_uint(self.radius)
end

local deserializer = function(self, buffer)
	self.radius = buffer:read_uint()
end

Object.add_serializers(efTree, serializer, deserializer)