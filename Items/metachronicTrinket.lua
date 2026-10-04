--tinket
--due for a fuller rework later
local sprite_item = Sprite.new("MetaTrinket", path.combine(PATH, "Sprites/Items/metachronicTrinket.png"), 1, 17, 18)
local sprite_ef = Sprite.new("MetaTrinketEF", path.combine(PATH, "Sprites/Items/Effects/trinket.png"), 1, 7, 5)
local sprite_item_used = Sprite.new("MetaTrinketBroken", path.combine(PATH, "Sprites/Items/metachronicTrinketUsed.png"), 1, 17, 18)

local trinket = Item.new("metaTrinket")
trinket:set_sprite(sprite_item)
trinket:set_tier(ItemTier.UNCOMMON)
trinket.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(trinket)

local broken = Item.new("metaBroken")
broken:set_sprite(sprite_item_used)
broken:toggle_loot(false)
broken.loot_tags = Item.LootTag.ITEM_BLACKLIST_VENDOR + Item.LootTag.ITEM_BLACKLIST_INFUSER

local obj = Object.new("efTrinket")
obj:set_sprite(sprite_ef)
obj:set_depth(89) --1 lower than the teleporter so it draws above it

--trinket display
Callback.add(obj.on_create, function(self)
	if not self.parent then
		self.parent = -4
	end
	self.doFloat = false

end)

Callback.add(obj.on_step, function(self)
	if not self.parent then return end
	
	local pData = Instance.get_data(self.parent)
	
	if self.image_alpha < 1 then
		self.image_alpha = self.image_alpha + 0.1
	end
	
	--destroy if its parent has nil data and it's not at a teleporter
	if not pData.trinketObj and not self.foundTP then
		Sound.wrap(gm.constants.wFrozen):play(self.x, self.y, 3, 0.6 + math.random() * 0.2)
		Sound.wrap(gm.constants.wBossFinalDeathWarp):play(self.x, self.y, 0.7, 1.6 + math.random() * 0.4)
		
		pData.metaTP = nil
		
		self:destroy()
	end
	
	--get teleporter
	local tp = pData.metaTP
	
	local targetX = -4
	local targetY = -4
	
	if not (tp and tp.active == 1) then
		--idle/with player
		if self.foundTP then
			self.foundTP = nil
		end
		self.doFloat = true
		targetX = self.parent.x + (38 * self.parent.image_xscale)
		targetY = self.parent.y - 27

		if self.parent.pHspeed > 0 then
			self.image_angle = math.max(-50, self.image_angle - self.parent.pHspeed)
		elseif self.parent.pHspeed < 0 then
			self.image_angle = math.min(50, self.image_angle - self.parent.pHspeed)
			
		else
			if self.image_angle ~= 0 then
				self.image_angle = math.lerp(self.image_angle, 0, 0.1)
			end
		end
		
		if math.distance(self.x, self.y, targetX, targetY) > 3 then
			self.x = math.lerp(self.x, targetX, 0.2)
			self.y = math.lerp(self.y, targetY, 0.2)
		end
		
	else
		if self.image_angle ~= 0 then
			self.image_angle = math.lerp(self.image_angle, 0, 0.1)
		end
		
		--no floaters
		self.doFloat = false
		
		if tp:get_object_index() == gm.constants.oTeleporter then
			targetX = tp.x
			targetY = tp.y - 29
		end
		if tp:get_object_index() == gm.constants.oTeleporterEpic then
			targetX = tp.x - 2
			targetY = tp.y - 62
		end
		
		--move object towards tp
		if not self.foundTP then
			if self.x ~= targetX then
				self.x = math.lerp(self.x, targetX, 0.1)
			end
			
			if self.y ~= targetY then
				self.y = math.lerp(self.y, targetY, 0.1)
			end
			
			if math.distance(self.x, self.y, targetX, targetY) <= 1 then
				self.foundTP = true
			end
		end
	
		--idle shaking
		if self.foundTP then
			-- print("harlemshake")
			local rate = 0
			if tp:get_object_index() == gm.constants.oTeleporter then
				rate = 0.7 --star 2 refrense
			elseif tp:get_object_index() == gm.constants.oTeleporterEpic then
				rate = 2.4
			end
			--gm.random bc its not allergic to decimals like math.random
			self.x = targetX + gm.choose(gm.random(rate), gm.random(rate * -1))
			self.y = targetY + gm.choose(gm.random(rate), gm.random(rate * -1))
		end
		
	end
	
	--idle floating
	if self.doFloat then
		self.y = self.y + math.sin(Global._current_frame * 0.04) * 0.23
	end
end)

--setup
Callback.add(trinket.on_acquired, function(actor, stack)
	local data = Instance.get_data(actor)
	if not data.trinketObj then
		local tinket = obj:create(actor.x, actor.y)
		tinket.parent = actor
		data.trinketObj = tinket
	end
	
end)

--cleanup
Callback.add(trinket.on_removed, function(actor, stack)
	-- if stack > 1 then return end
	local data = Instance.get_data(actor)
	
	--set as negative funnynumber when the item breaking is triggered, let the object break at 1 trinket stack when this happens
	if data.trinketObj == -67 then data.trinketObj = nil return end
	
	--otherwise if it's removed like a temp item or via mimic, poof it away silently
	if data.trinketObj then
		if not data.trinketObj.foundTP then --only destroy it when its not charging tp
			Instance.destroy(data.trinketObj)
		end
		data.trinketObj = nil
	end
	
end)

--restore trinket, for if you have multiple stacks and also needed for going between stages for some reason
Callback.add(Callback.ON_PLAYER_STEP, function()
	for _, player in ipairs(trinket:get_holding_actors()) do
		
		local data = Instance.get_data(player)
		
		if data.trinketObj == -67 then return end
		
		if not data.trinketObj then
			local tinket = obj:create(player.x, player.y)
			tinket.parent = player
			tinket.image_alpha = -2
			data.trinketObj = tinket
		end
		
		if not data.trinketObj.parent then
			Instance.destroy(data.trinketObj)
			data.trinketObj = nil
		end
	end

end)

--queue tp time reduction
Callback.add(Callback.ON_INTERACTABLE_ACTIVATE, function(int, actor)
	local stack = actor:item_count(trinket)
	if stack <= 0 then return end
	
	if int.active == 1 then
		if gm.object_is(int:get_object_index(), gm.constants.pTeleporter) then
			local pData = Instance.get_data(actor)
			if not pData.metaTP then
				pData.metaTP = int
			end
			
			local tData = Instance.get_data(int)
			tData.meta = math.max(15 * 60, int.maxtime - ((15 * stack) * 60))
			-- tData.snd = -1
			tData.delay = 0
			tData.maxDelay = 16
		end
	end
end)

--tp time reduction 
Hook.add_post("gml_Object_pTeleporter_Step_2", function(self, other, result, args)
	
	local data = Instance.get_data(self)
	if not data.meta then return end
	
	--would need a better sound to loop or a custom sound, stopwatch sound is stopped automatically by the game
	
	-- if self.time == 61 then
		-- if data.snd == -1 then
			-- data.snd = GM.sound_loop(gm.constants.wTeleporter_AmbienceLoopable, 1)
		-- end
	-- end
	
	if self.time >= 60 and self.maxtime > data.meta then
		self.image_blend = Color.LIME --most ideally the tp would have unique charge sprites but for now im lazy
		data.delay = data.delay - 1
		if data.delay <= 0 then
			self.maxtime = self.maxtime - 60
			data.maxDelay = data.maxDelay - 1
			data.delay = math.max(5, data.maxDelay)
		end
		
	elseif self.maxtime == data.meta and data.meta then
		-- if GM.audio_is_playing(data.snd) then
			-- GM._mod_sound_stop(data.snd)
		-- end
		data.meta = nil
	end

end)

--breaking
Callback.add(Callback.ON_DAMAGED_PROC, function(actor, hit_info)

	if Net.client then return end
	
	if actor:item_count(trinket) <= 0 then return end
	
	local data = Instance.get_data(actor)
	
	local tp = data.metaTP
	
	if tp and tp.active > 0 then return end --don't allow breaking if tp was activated
	
	if actor.hp < actor.maxhp * 0.41 then
	
		--allow the trinket to do its normal breaking stuff instead of defaulting to non-break removaL
		
		
		--item counts
		local normal = actor:item_count(trinket, Item.StackKind.NORMAL)
        local temp = actor:item_count(trinket, Item.StackKind.TEMPORARY_BLUE)
		local temp2 = actor:item_count(trinket, Item.StackKind.TEMPORARY_RED)
		
		--item removal and distribution based on stack type
		if normal > 0 and not (temp > 0 or temp2 > 0) then
			actor:item_give(broken, 1, Item.StackKind.NORMAL)
			data.trinketObj = -67
			actor:item_take(trinket, 1, Item.StackKind.NORMAL)
        end
		
        if temp > 0 and not temp2 > 0 then
			actor:item_give(broken, 1, Item.StackKind.TEMPORARY_BLUE)
			data.trinketObj = -67
			actor:item_take(trinket, 1, Item.StackKind.TEMPORARY_BLUE)
        end
		
		if temp2 > 0 then
			actor:item_give(broken, 1, Item.StackKind.TEMPORARY_RED)
			data.trinketObj = -67
			actor:item_take(trinket, 1, Item.StackKind.TEMPORARY_RED)
        end
	end
	
end)

--broken tinket temp item duration bonus
Hook.add_post(gm.constants["actor_get_blue_temp_item_duration"], function(self, other, result, args)
    local actor = Instance.wrap(args[1].value)
    local stack = actor:item_count(broken)
	
	if stack <= 0 then return end
    result.value = result.value + ((4 * stack) * 60)
	
end)

--fix my broken tinket !!!
Callback.add(Callback.ON_STAGE_START, function()
	for _, actor in ipairs(broken:get_holding_actors()) do
	
		if Instance.get_data(actor).metaTP then Instance.get_data(actor).metaTP = nil end

		local normal = actor:item_count(broken, Item.StackKind.NORMAL)
		local temp = actor:item_count(broken, Item.StackKind.TEMPORARY_BLUE)
		local temp2 = actor:item_count(trinket, Item.StackKind.TEMPORARY_RED)
		
		if normal > 0 then
			actor:item_give(trinket, normal, Item.StackKind.NORMAL)
			actor:item_take(broken, normal, Item.StackKind.NORMAL)
		end
		
		if temp > 0 then
			actor:item_give(trinket, temp, Item.StackKind.TEMPORARY_BLUE)
			actor:item_take(broken, temp, Item.StackKind.TEMPORARY_BLUE)
		end
		
		if temp2 > 0 then
			actor:item_give(trinket, temp, Item.StackKind.TEMPORARY_RED)
			actor:item_take(broken, temp, Item.StackKind.TEMPORARY_RED)
		end
	end
	
	for _, actor in ipairs(trinket:get_holding_actors()) do
	
		if Instance.get_data(actor).metaTP then Instance.get_data(actor).metaTP = nil end
	
	end
end)

--lang
	-- metaTrinket = {
			-- name = "Metachronic Trinket",
			-- pickup = "Teleporters charge faster. Breaks when damaged below half heatlh.",
			-- description = "Reduces <b>Teleporter charge time</c> by <y>10</c> <c_stack>(-10 per stack)</c> <y>seconds.</c> <r>This item breaks when falling under 50% health.</c>",
			-- destination = "P2592323,\nSagooj,\nEarth",
			-- date = "11/11/2056",
			-- story = "'Time is the most valuable resource in the universe', my mother used to say. But the more time I spend with this, the more I realize how wrong she was, and how naive I've been.\nMaybe nothing is what we think it is. Our quest for knowledge could be in vain, but there's one thing I can tell you: \nTime echoes your name.",
			-- priority = "<g>Priority</c>"
		-- },
	
	-- metaBroken = {
			-- name = "Fractured Trinket",
			-- pickup = "Slightly increased temporary item duration. Regenerates next stage.",
			-- description = "Extends the duration of <b>Temporary Items</c> by <y>4</c> <c_stack>(+4 per stack)</c> <y>seconds.</c> Becomes as <y>Metachronic Trinket</c> at the start of the next stage.",
			-- destination = "P2592323,\nSagooj,\nEarth",
			-- date = "11/11/2056",
			-- story = "'Time is the most valuable resource in the universe', my mother used to say. But the more time I spend with this, the more I realize how wrong she was, and how naive I've been.\nMaybe nothing is what we think it is. Our quest for knowledge could be in vain, but there's one thing I can tell you: \nTime echoes your name.",
			-- priority = "<g>Priority</c>"
		-- }