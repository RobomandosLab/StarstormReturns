local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/DuplicatorDrone")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/DuplicatorDrone")

local sprite_idle            = Resources.sprite_load(NAMESPACE, "DupeDroneIdle", path.combine(SPRITE_PATH, "Idle.png"), 4, 7, 10)
local sprite_idle_broken     = Resources.sprite_load(NAMESPACE, "DupeDroneBrokenIdle", path.combine(SPRITE_PATH, "Idle_broken.png"), 4, 7, 10)
local sprite_idle_cd         = Resources.sprite_load(NAMESPACE, "DupeDroneIdleCD", path.combine(SPRITE_PATH, "Idle_cd.png"), 4, 7, 10)
local sprite_idle_broken_cd  = Resources.sprite_load(NAMESPACE, "DupeDroneBrokenIdleCD", path.combine(SPRITE_PATH, "Idle_broken_cd.png"), 4, 7, 10)
local sprite_activate        = Resources.sprite_load(NAMESPACE, "DupeDroneActivate", path.combine(SPRITE_PATH, "Shoot.png"), 25, 11, 13)
local sprite_interact        = Resources.sprite_load(NAMESPACE, "DupeDronePurchase", path.combine(SPRITE_PATH, "Object.png"), 1, 11, 20)


local gildedDuplicatorDrone = Object.new(NAMESPACE, "GildedDuplicatorDrone", Object.PARENT.drone)
gildedDuplicatorDrone.obj_depth = -202
gildedDuplicatorDrone.obj_sprite = sprite_idle


gildedDuplicatorDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_activate
    inst.sprite_shoot1_broken = sprite_activate
    inst:drone_stats_init(1500)
    inst:init_actor_late()

    inst.x_range = 0
    inst.fire_frame = -1800 -- this ensures the drone will start ready to go
    inst.search_frame = Global._current_frame
    inst.item = nil

    inst.recycle_tier = 2.0

    inst.persistent = 1
    inst:instance_sync()
end)

gildedDuplicatorDrone:onStep(function( inst )
	local master = inst.master
    
    if not Instance.exists(master) then return end
    if master.dead then inst:destroy() return end

    if Global._current_frame - inst.fire_frame >= 30 * 60 then
        if inst.item then
            local item = Item.wrap(inst.item.item_id)
            item:create(inst.x, inst.y, inst.master)
            item:create(inst.x, inst.y, inst.master)
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