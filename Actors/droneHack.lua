-- guess who it is thats right its azuline!!!!
-- i wanted to do shocking drone but battery is working on that so i guess hacker drone it is
-- ill comment on everything and so will battery so if you feel like you dont understand something you can go check out the shocker drone instead
-- custom drones are pretty damn complex
local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/DroneHack")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/DroneHack")

-- load sprites!!
local sprite_idle			= Resources.sprite_load(NAMESPACE, "DroneHackIdle",					path.combine(SPRITE_PATH, "idle.png"), 4, 10, 16)
local sprite_idle_broken	= Resources.sprite_load(NAMESPACE, "DroneHackIdleBroken",			path.combine(SPRITE_PATH, "idle_broken.png"), 4, 10, 16)
local sprite_idle_broken_cd	= Resources.sprite_load(NAMESPACE, "DroneHackIdleBrokenCooldown",	path.combine(SPRITE_PATH, "idle_broken_cooldown.png"), 4, 10, 16)
local sprite_idle_cd		= Resources.sprite_load(NAMESPACE, "DroneHackIdleCooldown",			path.combine(SPRITE_PATH, "idle_cooldown.png"), 4, 10, 16)
local sprite_shoot1			= Resources.sprite_load(NAMESPACE, "DroneHackShoot1",				path.combine(SPRITE_PATH, "shoot1.png"), 4, 10, 16)
local sprite_shoot1broken	= Resources.sprite_load(NAMESPACE, "DroneHackShoot1Broken",			path.combine(SPRITE_PATH, "shoot1broken.png"), 4, 10, 16)
local sprite_object			= Resources.sprite_load(NAMESPACE, "DroneHackObject",				path.combine(SPRITE_PATH, "object.png"), 1, 22, 40)

-- load sounds!!
local sound_shoot1			= Resources.sfx_load(NAMESPACE, "DroneHackShoot1",					path.combine(SOUND_PATH, "shoot1.ogg"))

local hackWhitelist = {
	gm.constants.pInteractableDrone,
	gm.constants.oChest4,
	gm.constants.oShop1,
	gm.constants.oShop2,
	gm.constants.oShopEquipment,
	gm.constants.oActivator,
}

-- interactable
local hack_interactable = Object.new(NAMESPACE, "DroneHackItem", Object.PARENT.interactableDrone)
local hack_interactable_id = hack_interactable.value
hack_interactable.obj_sprite = sprite_object
hack_interactable.obj_depth = 90 -- depth of vanilla drone interactables
hack_interactable:clear_callbacks()

-- the drone itself
local hack = Object.new(NAMESPACE, "DroneHack", Object.PARENT.drone)
local hack_id = hack.value
hack.obj_sprite = sprite_idle
hack.obj_depth = -202 -- depth of vanilla drones
hack:clear_callbacks()

hack:onCreate(function(actor)
	actor.sprite_idle = sprite_idle
	actor.sprite_idle_broken = sprite_idle_broken
	actor.sprite_shoot1 = sprite_shoot1
    actor.sprite_shoot1_broken = sprite_shoot1broken
	
	actor:drone_stats_init(150) -- drones apparently only have max health. thats all we really need anyway
	actor.interactable_child = hack_interactable -- the interactable that this guy spawns on death
	actor.drone_upgrade_type_id = nil  -- the drone that this guy gets upgraded into! currently none
	actor.recycle_tier = 1.0 -- makes the drone drop a white item when scrapped
	actor.x_range = 0 -- the drones range, usually not 0, but since this drone doesnt actually attack enemies, its 0
	actor.persistent = 1 -- makes the drone not dissapear when changing the stage
	
	actor:get_data().cooldown = 0 -- the drones' ability cooldown. custom variable
	actor:get_data().shooting = 0 -- gets incremented when the drone is using his ability, when above a certain amount, start the cooldown. custom variable
	actor:get_data().target = nil -- the interactable that the drone is hacking. custom variable
	actor:get_data().hackList = List.new() -- a list of hacked interactables. custom variable
	actor:get_data().reduceAmount = 0 -- the amount of gold the interactables cost gets reduced by every tick while the drone is firing. custom variable

	actor:init_actor_late()
end)

hack:onStep(function(actor)
	local data = actor:get_data()
	local master = actor.master -- the drones' owner
	local radius = 200 -- the radius in which we will be scanning for interactables
	
	if not Instance.exists(master) or master.dead then
		actor:destroy() -- no owner, no drone
        return
    end
	
	local nearInteractable = nil -- set this up here so we can change it later
	
	if data.cooldown <= 0 then  -- if the drone isnt on cooldown
		for _, interactableType in ipairs(hackWhitelist) do -- search for only the interactables from the whitelist
			
			local list = List.new() -- this is where were gonna be storing found interactables
			actor:collision_circle_list(actor.x, actor.y, radius, interactableType, false, false, list, true) -- get all interactables in a 200 pixel circle area of the current interactable type
			
			for _, interactable in ipairs(list) do
				if interactable and Instance.exists(interactable) then
					if not (data.hackList:contains(interactable) or interactable.active > 0 or interactable.cost <= 0 or interactable.cost_type ~= 0) then -- if the drone hasnt already hacked this interactable AND the interactable hasnt been activated AND the interactables cost isnt 0 AND the interactable doesnt cost health instead of money >>
						nearInteractable = interactable -- >> choose this interactable
					end
				end
			
				if nearInteractable and Instance.exists(nearInteractable) then break end -- if an interactable is chosen, stop searching and proceed further
			end
			
			if nearInteractable and Instance.exists(nearInteractable) then break end
		end
		
		if nearInteractable and Instance.exists(nearInteractable) then
			data.target = nearInteractable -- set the chosen interactable as our target
			data.shooting = 60 -- start hacking
			data.cooldown = math.max(1400 * 1 - actor.cdr, 61) -- set the cooldown
			actor:sound_play(sound_shoot1, 1, 1) -- play the sound
		end
		
		-- set the sprites to the normal idle ones
		actor.sprite_idle = sprite_idle
		actor.sprite_idle_broken = sprite_idle_broken
		
	else
		-- set the sprites to the cooldown ones
		actor.sprite_idle = sprite_idle_cd
		actor.sprite_idle_broken = sprite_idle_broken_cd
		
		-- reduce the cooldown
		data.cooldown = data.cooldown - 1
	end
	
	if data.shooting > 0 then -- if the drone is currently hacking
		data.shooting = data.shooting - 1 -- reduce the countdown
		if data.target and Instance.exists(data.target) then
			if data.target.x > actor.x then -- make the target face the interactable
				actor.image_xscale = 1
			else
				actor.image_xscale = -1
			end
			if data.shooting <= 10 then -- 10 ticks before the drone stops hacking
				data.hackList:add(data.target) -- add the target to the list of hacked interactables once youre almost done hacking it
			elseif data.shooting <= 30 and not data.hackList:contains(data.target) then -- 30 ticks before the drone stops hacking
				if data.shooting == 30 then
					data.reduceAmount = math.ceil(data.target.cost * 0.3 / 20 or 1) -- set the reduce amount to 30% of the actors cost divided by 20 (because there are 20 frames left before the countdown ends)
				end
				if data.target.cost > 0 then
					data.target.cost = math.max(gm.round(data.target.cost - data.reduceAmount), 1) -- if the cost is bigger than 0, reduce the cost by data.reduceAmount. the cost cannot be lower than 1$
					if gm._mod_net_isHost() then
						data.target:interactable_cache_strings() -- updates the cost properly, only run host side
					end
				end
			end
			
			-- make the drone move towards the interactable on the x axis, functionally identical to math.approach from rorml
			local xx = math.abs(data.target.x - actor.x)
			if actor.x < data.target.x then
				actor.x = math.min(actor.x + xx * 0.1, data.target.x)
			else
				actor.x = math.max(actor.x - xx * 0.1, data.target.x)
			end
			
			-- make the drone move towards the interactable on the y axis, functionally identical to math.approach from rorml
			local yy = math.abs(data.target.y - actor.y)
			if actor.y < data.target.y then
				actor.y = math.min(actor.y + yy * 0.1, data.target.y)
			else
				actor.y = math.max(actor.y - yy * 0.1, data.target.y)
			end
			
			-- set the sprites to the shooting ones
			actor.sprite_idle = sprite_shoot1
			actor.sprite_idle_broken = sprite_shoot1broken
		end
	else
		data.target = nil
		data.reduceAmount = 0
	end
	
	-- update the sprite to the broken one when the drone is below half health
	if actor.hp >= actor.maxhp / 2 then
		actor.sprite_index = actor.sprite_idle
	else
		actor.sprite_index = actor.sprite_idle_broken
	end
end)

hack:onDraw(function(actor)
	local data = actor:get_data()
	
	if data.shooting > 0 and data.target and Instance.exists(data.target) then -- if the drone is currently hacking away
		local rnd = math.random(-20, 20) / 100
		local height = gm.sprite_get_height(data.target.sprite_index) -- this allows us to get the sprite height of the hacked interactable
		gm.draw_set_colour(Color.from_hex(0x4DF2B8)) -- set the draw color
		gm.draw_set_alpha(0.2 + rnd) -- set the draw alpha, rnd is a random number and gets used for a flickering effect
		gm.draw_triangle(actor.x, actor.y, data.target.x, data.target.y - height, data.target.x, data.target.y, false) -- draw the main triangle thingy
		gm.draw_sprite_ext(data.target.sprite_index, data.target.image_index, data.target.x, data.target.y, data.target.image_xscale, data.target.image_yscale, data.target.image_angle, Color.from_hex(0x4DF2B8), 0.4 + rnd) -- make the interactable flash the same color as the triangle
		gm.draw_set_alpha(1) -- set the alpha back to 1 so we dont break anything
	end
end)

hack:onDestroy(function(actor)
	actor:get_data().hackList:destroy() -- destroy the list of hacked interactables
end)

hack_interactable:onCreate(function(self)
	self:interactable_init()
	self.child = hack -- the drone that this interactable spawns
	self:interactable_init_cost(self, 0, 110) -- set the cost. arg 1 = target, arg 2 = cost type, arg 3 = cost value
end)

local card = Interactable_Card.new(NAMESPACE, "DroneHackItem")
card.object_id = hack_interactable
card.spawn_with_sacrifice = true
card.spawn_cost = 130 -- the amount of director credits it costs
card.spawn_weight = 8 -- the weight most common vanilla drones use
card.default_spawn_rarity_override = 1

if HOTLOADING then return end

local stages = {
	"ror-dampCaverns",
	"ror-sunkenTombs",
	"ror-hiveCluster",
	"ror-magmaBarracks",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	stage:add_interactable(card)
end