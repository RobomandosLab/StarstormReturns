local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/DuplicatorDrone")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/DuplicatorDrone")

local sprite_idle            = Resources.sprite_load(NAMESPACE, "DupeDroneIdle", path.combine(SPRITE_PATH, "Idle.png"), 4, 7, 10)
local sprite_idle_broken     = Resources.sprite_load(NAMESPACE, "DupeDroneBrokenIdle", path.combine(SPRITE_PATH, "Idle_broken.png"), 4, 7, 10)
local sprite_idle_cd         = Resources.sprite_load(NAMESPACE, "DupeDroneIdleCD", path.combine(SPRITE_PATH, "Idle_cd.png"), 4, 7, 10)
local sprite_idle_broken_cd  = Resources.sprite_load(NAMESPACE, "DupeDroneBrokenIdleCD", path.combine(SPRITE_PATH, "Idle_broken_cd.png"), 4, 7, 10)
local sprite_activate        = Resources.sprite_load(NAMESPACE, "DupeDroneActivate", path.combine(SPRITE_PATH, "Shoot.png"), 25, 11, 13)
local sprite_interact        = Resources.sprite_load(NAMESPACE, "DupeDronePurchase", path.combine(SPRITE_PATH, "Object.png"), 1, 11, 20)


local duplicatorDrone = Object.new(NAMESPACE, "DuplicatorDrone", Object.PARENT.drone)
duplicatorDrone.obj_depth = -202
duplicatorDrone.obj_sprite = sprite_idle

local duplicatorDronePickup = Object.new(NAMESPACE, "DuplicatorDronePickup", Object.PARENT.interactableDrone)
duplicatorDronePickup.obj_depth = 90
duplicatorDronePickup.obj_sprite = sprite_interact


duplicatorDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_activate
    inst.sprite_shoot1_broken = sprite_activate
    inst:drone_stats_init(500)
    inst:init_actor_late()

    inst.x_range = 0
    inst.fire_frame = -3600 -- this ensures the drone will start ready to go
    inst.search_frame = Global._current_frame
    inst.item = nil

    inst.recycle_tier = 1.0
    inst.drone_upgrade_type_id = Object.find(NAMESPACE, "GildedDuplicatorDrone").value
    inst.interactable_child = duplicatorDronePickup.value 

    inst.persistent = 1
    inst:instance_sync()
end)

duplicatorDrone:onStep(function( inst )
	local master = inst.master
    
    if not Instance.exists(master) then return end
    if master.dead then inst:destroy() return end

    if Global._current_frame - inst.fire_frame >= 60 * 60 then
        if inst.item then
            local item = Item.wrap(inst.item.item_id)
            item:create(inst.x, inst.y, inst.master)

            inst.item = nil
            inst.fire_frame = Global._current_frame
        end

        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle or sprite_idle_broken
    else
        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle_cd or sprite_idle_broken_cd
    end

    if Global._current_frame - inst.search_frame >= 2 * 60 then 
        local pickups = Instance.find_all(gm.constants.pPickupItem)
        local nearest = nil
        local sdist = nil

        for _, pickup in ipairs(pickups) do
            local dist = gm.point_distance(master.x, master.y, pickup.x, pickup.y)

            if dist <= 150 then
                if nearest then
                    if dist < sdist then
                        nearest = pickup
                        sdist = dist
                    end
                else
                    nearest = pickup
                    sdist = gm.point_distance(master.x, master.y, nearest.x, nearest.y)
                end
            end
        end

        if nearest then
            inst.item = nearest
        else
            inst.item = nil
        end
    end
end)


duplicatorDronePickup:onCreate(function( inst )
    inst:interactable_init(true)
    inst.active = 0
    inst.value.value = 60
    inst.interact_scroll_index = 3
    inst.child = duplicatorDrone.value -- what the interactable spawns
    inst:interactable_init_cost(inst.value, 0, 160) -- cost setup
    inst:interactable_init_name()
end)

local drone_card = Interactable_Card.new(NAMESPACE, "duplicatorDronePickup")
drone_card.object_id = duplicatorDronePickup.value
drone_card.spawn_with_sacrifice = true
drone_card.spawn_cost = 120
drone_card.spawn_weight = 4
drone_card.default_spawn_rarity_override = 1

local stages = Stage.find_all()
for _, stage in ipairs(stages) do
    stage:add_interactable(drone_card)
end