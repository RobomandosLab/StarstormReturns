-- I AM GOING TO GO AHEAD AND PREFACE ALL THE DRONES IN THIS FAMILY WITH A MASSIVE DISCLAIMER:
-- CUSTOM DRONES ARE WEIRD AND MESSY. IF YOU HAVE A BIT OF NUANCE TO YOUR DRONES BEHAVIOR, OR A SEQUENCE IN MIND, THINGS WILL GET ROUGH.
-- I WILL DO MY ABSOLUTE BEST TO EXPLAIN THIS NIGHTMARE SCRIPT, BEAR WITH ME.

local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/DuplicatorDrone")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/DuplicatorDrone")

local sprite_idle            = Resources.sprite_load(NAMESPACE, "DupeDroneIdle", path.combine(SPRITE_PATH, "Idle.png"), 4, 7, 10)
local sprite_idle_broken     = Resources.sprite_load(NAMESPACE, "DupeDroneBrokenIdle", path.combine(SPRITE_PATH, "Idle_broken.png"), 4, 7, 10)
local sprite_idle_cd         = Resources.sprite_load(NAMESPACE, "DupeDroneIdleCD", path.combine(SPRITE_PATH, "Idle_cd.png"), 4, 7, 10)
local sprite_idle_broken_cd  = Resources.sprite_load(NAMESPACE, "DupeDroneBrokenIdleCD", path.combine(SPRITE_PATH, "Idle_broken_cd.png"), 4, 7, 10)
local sprite_activate        = Resources.sprite_load(NAMESPACE, "DupeDroneActivate", path.combine(SPRITE_PATH, "Shoot.png"), 25, 11, 13)
local sprite_interact        = Resources.sprite_load(NAMESPACE, "DupeDronePurchase", path.combine(SPRITE_PATH, "Object.png"), 1, 11, 20)


local fabricatorDrone = Object.new(NAMESPACE, "FabricatorDrone", Object.PARENT.drone)
fabricatorDrone.obj_depth = -202
fabricatorDrone.obj_sprite = sprite_idle

local fabricatorDronePickup = Object.new(NAMESPACE, "FabricatorDronePickup", Object.PARENT.interactableDrone)
fabricatorDronePickup.obj_depth = 90
fabricatorDronePickup.obj_sprite = sprite_interact


fabricatorDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_activate
    inst.sprite_shoot1_broken = sprite_activate
    inst:drone_stats_init(300)
    inst:init_actor_late()

    inst.x_range = 0
    inst.fire_frame = -1800 -- this ensures the drone will start ready to go
    inst.search_frame = Global._current_frame -- this is a standard thing i use to check cooldowns

    inst.item = nil -- variable to hold the item thats gonna be duped
    inst.item_id = nil -- this is to specifically store the id to dupe
    inst.duplicating = 0 -- this number acts as a sort of second state for the drone, telling it what part of the dupe sequence its in
    inst.dupe_step = 0 -- this is used while its locking on to an item
    inst.cooldown = 30 * 60 -- cooldown between dupes

    inst.recycle_tier = 0.0
    inst.drone_upgrade_type_id = Object.find(NAMESPACE, "DuplicatorDrone").value
    inst.interactable_child = fabricatorDronePickup.value 

    inst.persistent = 1
end)

fabricatorDrone:onStep(function( inst )
	local master = inst.master
    
    if not Instance.exists(master) then return end
    if master.dead then inst:destroy() return end

    if Global._current_frame - inst.fire_frame >= inst.cooldown then -- if the drone is off cooldown
        if inst.item and inst.duplicating == 0 then -- if theres an available item and the drone isnt duping, start duping
            inst.duplicating = 1
        end

        -- this part is just for sprites
        inst.sprite_idle = sprite_idle 
        inst.sprite_idle_broken = sprite_idle_broken
    else
        inst.sprite_idle = sprite_idle_cd
        inst.sprite_idle_broken = sprite_idle_broken_cd
    end

    -- this is the search loop, it runs every 2 seconds 
    -- if the drone isnt in the middle of duping something and is off cooldown it looks for the nearest item
    if Global._current_frame - inst.search_frame >= 2 * 60 and Global._current_frame - inst.fire_frame >= inst.cooldown and inst.duplicating == 0 then
        local pickups = Instance.find_all(gm.constants.pPickupItem)
        local nearest = nil
        local sdist = nil

        for _, pickup in ipairs(pickups) do
            local dist = gm.point_distance(master.x, master.y, pickup.x, pickup.y)

            if dist <= 150 and pickup.item_stack_kind == Item.STACK_KIND.normal then -- if an item is sufficiently close by
                if nearest then
                    if dist < sdist then -- this looks for specifically the closest nearby item
                        nearest = pickup
                        sdist = dist
                    end
                else
                    nearest = pickup
                    sdist = gm.point_distance(master.x, master.y, nearest.x, nearest.y)
                end
            end
        end

        if nearest then -- updates the drones target item appropriately
            inst.item = nearest
        else
            inst.item = nil
        end
    end

    -- this is the transitionary state that starts the dupe animation and locks in the dupe itself
    if inst.duplicating == 2 then 
        if Instance.exists(inst.item) then
            inst.image_index = 0
            inst.sprite_index = inst.sprite_shoot1
            inst.item_id = inst.item.item_id -- this stores the id in case you pick up the item after going to dupe it
            inst.duplicating = 3
        else
            inst.duplicating = 0
            inst.item = nil
            inst.item_id = nil
        end
    end

    -- this is just to sync the dupe with the drones animation because it looks cool
    if inst.sprite_index == inst.sprite_shoot1 or inst.sprite_index == inst.sprite_shoot1_broken then
        if inst.image_index >= 18 and inst.duplicating == 3 then
            local item = Item.wrap(inst.item_id) -- get item
            item:create(inst.x, inst.y, inst.master).item_stack_kind = Item.STACK_KIND.temporary_blue -- spawn item

            inst.duplicating = 0
            inst.item = nil
            inst.item_id = nil
            inst.fire_frame = Global._current_frame
        end
    end
end)

fabricatorDrone:onDraw(function( inst )
	if inst.duplicating == 1 then
        if not Instance.exists(inst.item) then -- exit if the pickup disappears
            inst.duplicating = 2
            inst.dupe_step = 0
        end
        
        if inst.dupe_step >= 200 then -- go to next stage if 200 frames have passed
            inst.duplicating = 2
            inst.dupe_step = 0
        end

        if gm.point_distance(inst.master.x, inst.master.y, inst.item.x, inst.item.y) >= 300 then -- if you walk away, stop duping
            inst.duplicating = 0
            inst.dupe_step = 0
            inst.item = nil
            return
        end

        -- this is just draw code for the effect
        gm.draw_set_alpha(0.5)
        gm.gpu_set_blendmode(1)

        gm.draw_set_colour(Color.TEXT_YELLOW)
		gm.draw_line_width(inst.x, inst.y, inst.item.x, inst.item.y, 5 + math.random() * 2)
		gm.draw_circle(inst.item.x, inst.item.y, 4 + math.random() * 8, false)
		gm.draw_circle(inst.x, inst.y, 2 + math.random() * 4, false)

		gm.draw_set_colour(Color.WHITE)
		gm.draw_line_width(inst.x, inst.y, inst.item.x, inst.item.y, 2)
		gm.draw_circle(inst.item.x, inst.item.y, 8, true)
		gm.draw_circle(inst.x, inst.y, 4, true)

        gm.draw_set_alpha(1)
        gm.gpu_set_blendmode(0)

        inst.dupe_step = inst.dupe_step + 1
    end
end)


fabricatorDronePickup:onCreate(function( inst )
    inst:interactable_init(true)
    inst.active = 0
    inst.value.value = 60
    inst.interact_scroll_index = 3
    inst.child = fabricatorDrone.value -- what the interactable spawns
    inst:interactable_init_cost(inst.value, 0, 50) -- cost setup
    inst:interactable_init_name()
end)

local drone_card = Interactable_Card.new(NAMESPACE, "fabricatorDronePickup")
drone_card.object_id = fabricatorDronePickup.value
drone_card.spawn_with_sacrifice = true
drone_card.spawn_cost = 75
drone_card.spawn_weight = 5
drone_card.default_spawn_rarity_override = 1

local stages_loaded = 0
Callback.add(Callback.TYPE.onGameStart, "SSRFabricatorDroneAddStages", function( )
	if stages_loaded == 0 then
        stages_loaded = 1

        local stages = Stage.find_all()
        for _, stage in ipairs(stages) do
            stage:add_interactable(drone_card)
        end
    end
end)