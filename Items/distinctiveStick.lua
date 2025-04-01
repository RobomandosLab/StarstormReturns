local sprite_item = Resources.sprite_load(NAMESPACE, "DistinctiveStick", path.combine(PATH, "Sprites/Items/distinctiveStick.png"), 1, 16, 16)
local sprite_effect = Resources.sprite_load(NAMESPACE, "EfDistinctiveTree", path.combine(PATH, "Sprites/Items/Effects/distinctiveTree.png"), 1, 9, 48)

local RADIUS_BASE = 220
local RADIUS_STACK = 80

local distinctiveStick = Item.new(NAMESPACE, "distinctiveStick")
distinctiveStick:set_sprite(sprite_item)
distinctiveStick:set_tier(Item.TIER.common)
distinctiveStick:set_loot_tags(Item.LOOT_TAG.category_healing)

local objTree = Object.new(NAMESPACE, "EfDistinctiveTree")
objTree.obj_sprite = sprite_effect
objTree.obj_depth = 50

objTree:clear_callbacks()
objTree:onCreate(function(self)
	self.radius = RADIUS_BASE

	self:instance_sync()
end)
objTree:onStep(function(self)
	if gm._mod_net_isClient() then return end

	if Global._current_frame % 120 == 0 then
		local targets = List.wrap(self:find_characters_circle(self.x, self.y, self.radius, false, 1, true))

		for _, actor in ipairs(targets) do
			local amount = actor.maxhp * 0.022
			if actor.object_index == gm.constants.oP then
				local heal = GM.instance_create(self.x, self.y, gm.constants.oEfHeal2)
				heal.target = actor
				--heal.value = amount -- this doesn't work because RMT wrappers use the `value` key lol
				gm.variable_instance_set(heal.id, "value", amount)
			else
				-- spwaning healing orbs for non-players looks too noisy, so just heal them directly
				actor:heal(amount)
			end
		end
	end
end)
objTree:onDraw(function(self)
	-- time it so that peak brightness coincides with spawning heal
	local t = (Global._current_frame + 60) / (math.pi * 6)
	local a = 0.6 + math.sin(t) * 0.2
	local r = self.radius

	gm.draw_set_colour(Color.from_hex(0x82FF9F))
	for i=0, 5 do
		local tr = r - i / 10 * RADIUS_BASE
		gm.draw_set_alpha(a / (i+1))
		gm.draw_circle(self.x, self.y, tr, true)
	end
	gm.draw_set_alpha(1)
end)

objTree:onSerialize(function(self, buffer)
	buffer:write_uint(self.radius)
end)
objTree:onDeserialize(function(self, buffer)
	self.radius = buffer:read_uint()
end)
objTree:onDestroy(function(self)
	self:instance_destroy_sync()
end)

local trees_spawned_this_stage = false

local function update_trees(removal)
	if gm._mod_net_isClient() then return end

	local stack = 0
	for _, actor in ipairs(Instance.find_all(gm.constants.oP)) do
		stack = stack + actor:item_stack_count(distinctiveStick)
	end
	if removal then
		stack = stack - 1
	end

	if not trees_spawned_this_stage then
		for _, inst in ipairs(Instance.find_all(gm.constants.pTeleporter)) do
			objTree:create(inst.x + math.random(-80, 80), inst.y)
		end
		for _, inst in ipairs(Instance.find_all(gm.constants.oCommand)) do
			objTree:create(inst.x + math.random(-80, 80), inst.y)
		end
	end

	for _, inst in ipairs(Instance.find_all(objTree)) do
		if stack > 0 then
			inst.radius = RADIUS_BASE + RADIUS_STACK * (stack - 1)
			inst:instance_resync()
		else
			inst:destroy()
		end
	end

	trees_spawned_this_stage = stack > 0
end

distinctiveStick:clear_callbacks()
distinctiveStick:onAcquire(function(actor, stack)
	update_trees()
end)
distinctiveStick:onRemove(function(actor, stack)
	update_trees(true)
end)

Callback.add(Callback.TYPE.onStageStart, "SSDistinctiveTree", function()
	trees_spawned_this_stage = false
	update_trees()
end)
