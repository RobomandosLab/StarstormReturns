local sprite = Sprite.new("ChirrsmasPresent", path.combine(PATH, "Sprites/Interactables/ChirrsmasPresent/present.png"), 11, 41, 112)

local firework = Object.new("ChirrsmasPresentFirework")
firework:set_sprite(gm.constants.sEFFirework)
firework:set_depth(45)

Callback.add(firework.on_create, function(self)
	local dir = 90 + math.random(-10, 10)
	self.direction = dir
	self.speed = 6
	self.image_index = math.random(0, 3)
	self.image_speed = 0
	self.image_angle = dir
	self.image_xscale = 0.5
	self.image_yscale = 0.5
	self.y = self.y - 32
	Instance.get_data(self).quality = Global.__pref_graphics_quality
	
	self:sound_play(gm.constants.wMissileLaunch, 0.6, 1.1 + math.random(2) * 0.1)
end)

Callback.add(firework.on_step, function(self)
	self.speed = self.speed - 0.1
	
	if Instance.get_data(self).quality >= 2 then
		Particle.find("FireworkSmoke"):set_orientation(self.direction, self.direction, 0, 0, false)
		Particle.find("FireworkSmoke"):create(self.x - gm.lengthdir_x(16, self.direction), self.y - gm.lengthdir_y(16, self.direction), 1, Particle.System.BELOW)
	end
	
	if self.speed <= 0 then
		local color = gm.choose(11009922, 8577791, 16646056, 15438998)
		for i = 0, 6 do
			local burst = Object.find("EfFireworkBurst"):create(self.x, self.y)
			burst.color = color
		end
		self:sound_play(gm.constants.wBanditShoot4_2, 0.6, 1.1 + math.random(2) * 0.1)
		self:destroy()
	end
end)

local present = Object.new("ChirrsmasPresent", Object.Parent.INTERACTABLE)
present:set_sprite(sprite)
present:set_depth(90)

Callback.add(present.on_create, function(self)
	self:interactable_init()
	self.mask_index = gm.constants.sChest1
	self:interactable_init_name()
end)

Callback.add(present.on_step, function(self)
	local data = Instance.get_data(self)
	
	if data.open_delay then
		if data.open_delay > 0 then
			data.open_delay = data.open_delay - 1
		else
			data.open_delay = nil
		end
	end
	
	if data.missile_timer then
		if data.missile_timer > 0 then
			data.missile_timer = data.missile_timer - 1
		else
			data.missile_timer = nil
		end
	end
	
	if self.active == 1 then
		self:sound_play(gm.constants.wChest1, 1, 1)
		self:sound_play(gm.constants.wSnowglobe, 0.5, 1)
		self.active = 2
		self:screen_shake(1)
		self.image_speed = 0.2
		data.open_delay = 25
		data.missile_timer = 45 * 3 - 1
	elseif self.active == 2 and data.open_delay == 0 then
		local pickup = gm.treasure_weights_roll_pickup(29) -- gonna use drifter's roll item function because it includes all item tiers and rolls reds pretty commonly. 29 corresponds to drifter's loot pool struct index
		local item = Item.wrap(gm.object_to_item(pickup)) -- treasure_weights_roll_pickup returns an object instead of an item so we use object_to_item to get the item

		local inst = item:create(self.x, self.y - 32)
		inst.item_stack_kind = Item.StackKind.TEMPORARY_BLUE
		inst.spawn_x = inst.x + math.random(-16, 16)
	end
	
	if data.missile_timer and data.missile_timer % 45 == 0 then
		firework:create(self.x, self.y)
	end
end)

if HOTLOADING then return end
if not ssr_chirrsmas_active then return end -- christmas lasts from december 15th to january 15th
if Settings.chirrsmas == 2 then return end -- if chirrsmas is disabled in the config then we dont do anything

local card = InteractableCard.new("chirrsmasPresent")
card.object_id = present
card.spawn_with_sacrifice = true
card.spawn_cost = 7
card.spawn_weight = 8

for i = 1, 5 do
	local tier = List.wrap(gm._mod_stage_get_pool_list(i))
	for _, stage in ipairs(tier) do
		Stage.wrap(stage):add_interactable(card)
	end
end