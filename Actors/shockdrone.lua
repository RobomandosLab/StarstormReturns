-- drone code in rorr is VERY similar to drone code in ror1, if you have experience with that you shouldnt have too much trouble with this

-- DRONE INFO IVE FOUND:
-- All drones have a default_spawn_rarity_override
-- Drones 1 - 7 have a spawn weight of 8. Drones 8 - 10 have a spawn weight of 2, and golem drones have a spawn weight of 1.
-- Drone credit costs range from 75 (gunner drone) to a massive 180 (one of the super upgraded ones) depending on the rarity. Gold drones dont have spawns obv.

-- Drone recycler tiers work like this:
-- 0 - white item
-- 1 - green item
-- 2 - red item
-- 3 - three red items
-- 4 - yellow item
-- 5 - three yellow items


-- sprites as per usual
local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/ShockDrone")

local sprite_idle            = Resources.sprite_load(NAMESPACE, "ShockDroneIdle", path.combine(SPRITE_PATH, "ShockDroneIdle.png"), 8, 12, 20)
local sprite_idle_broken     = Resources.sprite_load(NAMESPACE, "ShockDroneBrokenIdle", path.combine(SPRITE_PATH, "ShockDroneBrokeIdle.png"), 8, 12, 20)
local sprite_attack          = Resources.sprite_load(NAMESPACE, "ShockDroneAttack", path.combine(SPRITE_PATH, "ShockDroneAttack.png"), 5, 12, 20)
local sprite_attack_broken   = Resources.sprite_load(NAMESPACE, "ShockDroneBrokenAttack", path.combine(SPRITE_PATH, "ShockDroneBrokeAttack.png"), 5, 12, 20)
local sprite_interact        = Resources.sprite_load(NAMESPACE, "ShockDronePurchase", path.combine(SPRITE_PATH, "ShockDronePickUp.png"), 1, 23, 40)


-- for drones you want to be purchaseable, make sure to create a drone object, and an object for the drones purchaseable state
local shockDrone = Object.new(NAMESPACE, "ShockDrone", Object.PARENT.drone) -- drone
shockDrone.obj_depth = -202 -- vanilla drone object depth
shockDrone.obj_sprite = sprite_idle

local shockDronePickup = Object.new(NAMESPACE, "ShockDronePickup", Object.PARENT.interactableDrone) -- item
shockDronePickup.obj_depth = 90 -- vanilla drone item object depth
shockDronePickup.obj_sprite = sprite_interact


-------- Shock Drone
shockDrone:onCreate(function( inst ) -- this is setup for the drone object itself
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_attack
    inst.sprite_shoot1_broken = sprite_attack_broken
    inst:drone_stats_init(350) -- this sets the base health value used by the drone (drones only need their health set)
    inst:init_actor_late()

    inst.x_range = 600 -- this just dictates when the drone is able to see an enemy
    inst.fire_frame = Global._current_frame -- i made this variable to track when the drone last fired

    inst.returning = 0
    inst.return_frame = Global._current_frame

    inst.recycle_tier = 1.0 -- this controls what type of reward the recycler gives
    inst.drone_upgrade_type_id = Object.find(NAMESPACE, "ThunderDrone").value -- this is the drone you want it to turn into upon being upgraded
    inst.interactable_child = shockDronePickup.value -- this is the interactable you want to give you the drone

    inst.persistent = 1 -- drone doesnt despawn
end)

shockDrone:onStep(function( inst )
	local master = inst.master

    if not Instance.exists(master) then return end 
    if master.dead then inst:destroy() return end -- kills drone if owner dies

    if inst.state == 1 and inst.returning == 0 then -- this handles behavior that occurs when the drone locks onto an enemy, since this drone uses custom targetting
        if not Instance.exists(inst.target) then return end
        if not Instance.exists(master) then return end
        
        -- this is the movement function to make the shock drone lock on to the enemy's position
        -- it is altered from a sample of movement code used in the actual drone targetting function for vanilla rorr
        -- feel free to use whatever targetting you want for a drone in this state, as it freezes unless you tell it to move
        inst.x = GM.lerp(inst.x, inst.target.x + inst.xx, inst.chase_motion_lerp * 0.25 * (inst.drone_move_rate * 9))
        inst.y = GM.lerp(inst.y, inst.target.y - 25 + inst.yy, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate * 9))
        inst.chase_motion_lerp = math.min(1, inst.chase_motion_lerp + 0.1)

        -- this puts the drones attack on a cooldown based on its attack speed
        if Global._current_frame - inst.fire_frame >= math.max(1, 100/inst.attack_speed) and math.abs(inst.x - inst.target.x) < 60 and math.abs(inst.y - inst.target.y) < 60 then
            -- actual contents of the attack
            inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_attack or sprite_attack_broken -- sets to the appropriate attack sprite
            inst.image_index = 0
            inst:sound_play(gm.constants.wChainLightning2, 0.5, 0.9 + math.random() * 0.8)

            local lightning = gm.instance_create(inst.x, inst.y, gm.constants.oChainLightning)
		    lightning.parent = inst.value
		    lightning.team = inst.team
		    lightning.damage = inst.damage * 3
	        lightning.bounce = 3

            if inst:is_authority() and Instance.exists(inst.target) then
			    local attack = inst:fire_direct(inst.target.parent, 2)
			    attack.attack_info.stun = 1.5
            end

            inst.fire_frame = Global._current_frame -- setting the fire frame to put the attakc back on cooldown
        end


        -- this is a bit of code that allows the drone to return to its owner if the owner gets too far away
        local dist = gm.point_distance(inst.x, inst.y, master.x, master.y)

        if dist > 800 then
            inst.returning = 1
            inst.return_frame = Global._current_frame

            inst.target = nil
            inst.x_range = 0
            GM.actor_set_state_networked(inst, -1)
        end
    end

    -- code to make the drone stop returning
    if inst.returning == 1 then
        if Global._current_frame - inst.return_frame >= 2 * 60 then
            inst.returning = 0
            inst.x_range = 600
        end
    end

    -- code to reset the drone back to its appropriate idle animation once the attack animation is about done
    -- ideally theres a better way to do this but i dont know it sooooooooo
    if (inst.sprite_index == sprite_attack or inst.sprite_index == sprite_attack_broken) and inst.image_index >= 4.8 then
        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle or sprite_idle_broken -- sets appropriate idle
        inst.image_index = 0
    end
end)


shockDronePickup:onCreate(function( inst )
    inst:interactable_init(true)
    inst.active = 0
    inst.value.value = 60
    inst.interact_scroll_index = 3
    inst.child = shockDrone.value -- what the interactable spawns
    inst:interactable_init_cost(inst.value, 0, 80) -- cost setup
    inst:interactable_init_name()
end)

local drone_card = Interactable_Card.new(NAMESPACE, "shockDronePickup")
drone_card.object_id = shockDronePickup.value
drone_card.spawn_with_sacrifice = true
drone_card.spawn_cost = 90 -- credits needed to spawn it
drone_card.spawn_weight = 6 -- i dont fully understand this value but it functions sorta like rarity to my understanding
drone_card.default_spawn_rarity_override = 1 -- all the vanilla drones use this value

local stages_loaded = 0
Callback.add(Callback.TYPE.onGameStart, "SSRShockDroneAddStages", function( ) -- adding stages on the first game start so that way modded stages work
	if stages_loaded == 0 then
        stages_loaded = 1

        local stages = {
            "ror-skyMeadow",
            "ror-ancientValley",
            "ror-dampCaverns",
            "ssr-torridOutlands"
        }

        local loop_stages = {
            "ror-desolateForest",
            "ror-driedLake"
        }


        for _, s in ipairs(stages) do
            local stage = Stage.find(s)
            stage:add_interactable(drone_card)
        end

        for _, s in ipairs(loop_stages) do
            local stage = Stage.find(s)
            stage:add_interactable_loop(drone_card)
        end
    end
end)