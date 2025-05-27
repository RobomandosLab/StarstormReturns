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
shockDrone.obj_sprite = sprite_idle

local thunderDrone = Object.new(NAMESPACE, "ThunderDrone", Object.PARENT.drone)
thunderDrone.obj_sprite = sprite_idle

local gildedThunderDrone = Object.new(NAMESPACE, "GildedThunderDrone", Object.PARENT.drone)
gildedThunderDrone.obj_sprite = sprite_idle

local shockDronePickup = Object.new(NAMESPACE, "ShockDronePickup", Object.PARENT.interactableDrone) -- item
shockDronePickup.obj_sprite = sprite_interact

local thunderDronePickup = Object.new(NAMESPACE, "ThunderDronePickup", Object.PARENT.interactableDrone)
thunderDronePickup.obj_sprite = sprite_interact


-------- Shock Drone
shockDrone:onCreate(function( inst ) -- this is setup for the drone object itself
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_attack
    inst.sprite_shoot1_broken = sprite_attack_broken
    inst:drone_stats_init(400) -- this sets the base health value used by the drone (drones only need their health set)
    inst:init_actor_late()

    inst.x_range = 600 -- this just dictates when the drone is able to see an enemy
    inst.x_range_min = 40
    inst.fire_frame = Global._current_frame -- i made this variable to track when the drone last fired

    inst.recycle_tier = 1.0 -- this controls what type of reward the recycler gives
    inst.drone_upgrade_type_id = thunderDrone.value -- this is the drone you want it to turn into upon being upgraded
    inst.interactable_child = shockDronePickup.value -- this is the interactable you want to give you the drone

    gm._mod_instance_set_mask(inst.value, gm.constants.sPMask)

    inst.persistent = 1
    inst:instance_sync()
end)

shockDrone:onStep(function( inst )
	local master = inst.master

    if not Instance.exists(master) then
        return
    end

    if master.dead then
        inst.hp = -1
        inst:actor_death(true)
        return
    end

    if inst.state == 1 then -- this handles behavior that occurs when the drone locks onto an enemy, since this drone uses custom targetting
        if not Instance.exists(inst.target) then return end
        if not Instance.exists(master) then return end
        
        -- this is the movement function to make the shock drone lock on to the enemy's position
        inst.x = GM.lerp(inst.x, inst.target.x + inst.xx, inst.chase_motion_lerp * 0.25 * (inst.drone_move_rate / (1/9)))
        inst.y = GM.lerp(inst.y, inst.target.y - 25 + inst.yy, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate / (1/9)))
        inst.chase_motion_lerp = math.min(1, inst.chase_motion_lerp + 0.1)

        -- this puts the drones attack on a cooldown based on its attack speed
        if Global._current_frame - inst.fire_frame >= math.max(1, 100/inst.attack_speed) and math.abs(inst.x - inst.target.x) < 40 and math.abs(inst.y - inst.target.y) < 40 then
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
    end

    -- code to reset the drone back to its appropriate idle animation once the attack animation is about done
    -- ideally theres a better way to do this but i dont know it sooooooooo
    if (inst.sprite_index == sprite_attack or inst.sprite_index == sprite_attack_broken) and inst.image_index >= 4.8 then
        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle or sprite_idle_broken
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

local shock_drone_card = Interactable_Card.new(NAMESPACE, "shockDronePickup")
shock_drone_card.object_id = shockDronePickup.value
shock_drone_card.spawn_with_sacrifice = true
shock_drone_card.spawn_cost = 120
shock_drone_card.spawn_weight = 6
shock_drone_card.default_spawn_rarity_override = 1


-------- Thunder Drone
thunderDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_attack
    inst.sprite_shoot1_broken = sprite_attack_broken
    inst:drone_stats_init(800)
    inst:init_actor_late()

    inst.x_range = 600
    inst.x_range_min = 40
    inst.fire_frame = Global._current_frame
    inst.charging = 0
    inst.charge_step = 0

    inst.recycle_tier = 2.0
    inst.drone_upgrade_type_id = gildedThunderDrone.value
    inst.interactable_child = thunderDronePickup.value 

    gm._mod_instance_set_mask(inst.value, gm.constants.sPMask)

    inst.persistent = 1
    inst:instance_sync()
end)

thunderDrone:onStep(function( inst )
	local master = inst.master

    if not Instance.exists(master) then
        return
    end

    if master.dead then
        inst.hp = -1
        inst:actor_death(true)
        return
    end

    if inst.state == 1 then
        if not Instance.exists(inst.target) then return end
        if not Instance.exists(master) then return end
        
        inst.x = GM.lerp(inst.x, inst.target.x, inst.chase_motion_lerp * 0.25 * (inst.drone_move_rate / (1/9)))
        inst.y = GM.lerp(inst.y, inst.target.y - 150, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate / (1/9)))
        inst.chase_motion_lerp = math.min(1, inst.chase_motion_lerp + 0.1)

        if Global._current_frame - inst.fire_frame >= math.max(1, 100/inst.attack_speed) and math.abs(inst.x - inst.target.x) < 15 and math.abs(inst.y - inst.target.y) < 175 and inst.charging == 0 then
            inst.charging = 1
        end
    end

    if (inst.sprite_index == sprite_attack or inst.sprite_index == sprite_attack_broken) and inst.image_index >= 4.8 then
        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle or sprite_idle_broken
        inst.image_index = 0
    end

    if inst.charge_step >= 200 then
        inst.charging = 0
        inst.charge_step = 0
        inst.fire_frame = Global._current_frame
        inst.state = 0

        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_attack or sprite_attack_broken -- sets to the appropriate attack sprite
        inst.image_index = 0
        inst:sound_play(gm.constants.wLightning, 1.5, 0.9 + math.random() * 0.8)

        local lightning = gm.instance_create(inst.x, inst.y, gm.constants.oChainLightning)
		lightning.parent = inst.value
		lightning.team = inst.team
		lightning.damage = inst.damage * 6
	    lightning.bounce = 3
        lightning.x = inst.target.x
        lightning.y = inst.target.y

        if inst:is_authority() then
            local attack = inst:fire_explosion(inst.target.x, inst.target.y, 100, 300, 15, gm.constants.sLightning)
            attack.attack_info.__ssr_thunder_snare = 3 * 60
        end
    end
end)

thunderDrone:onDraw(function( inst )
	if inst.charging == 1 and inst.state == 1 and Instance.exists(inst.target) then
        inst.charge_step = inst.charge_step + 1

        local ratio = (inst.charge_step / 200)
        local beam_variance = math.random() * ratio
        gm.gpu_set_blendmode(1)

        gm.draw_set_alpha(ratio)
        gm.draw_set_colour(Color.from_rgb(110, 129, 195))
        gm.draw_rectangle(inst.x - 4 * beam_variance, inst.y + 12, inst.x + 4 * beam_variance, inst.target.y, false)
        gm.draw_circle(inst.x, inst.y + 12, 8 + math.random() * 2, false)
        gm.draw_circle(inst.x, inst.target.y, 8 + math.random() * 2, false)

        gm.draw_set_alpha(ratio * .5)
        gm.draw_set_colour(Color.WHITE)
        gm.draw_rectangle(inst.x - 2 * beam_variance, inst.y + 12, inst.x + 2 * beam_variance, inst.target.y, false)
        gm.draw_circle(inst.x, inst.y + 12, 6 + math.random() * 2, false)
        gm.draw_circle(inst.x, inst.target.y, 6 + math.random() * 2, false)

        gm.draw_set_alpha(1)
        gm.gpu_set_blendmode(0)
    elseif inst.charging == 1 then
        inst.charge_step = 0
        inst.charging = 0
        inst.fire_frame = Global._current_frame
    end
end)

thunderDronePickup:onCreate(function( inst )
    inst:interactable_init(true)
    inst.active = 0
    inst.value.value = 60
    inst.interact_scroll_index = 3
    inst.child = thunderDrone.value -- what the interactable spawns
    inst:interactable_init_cost(inst.value, 0, 210) -- cost setup
    inst:interactable_init_name()
end)

local thunder_drone_card = Interactable_Card.new(NAMESPACE, "thunderDronePickup")
thunder_drone_card.object_id = thunderDronePickup.value
thunder_drone_card.spawn_with_sacrifice = true
thunder_drone_card.spawn_cost = 160
thunder_drone_card.spawn_weight = 2
thunder_drone_card.default_spawn_rarity_override = 1


-------- Gilded Thunder Drone
gildedThunderDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_attack
    inst.sprite_shoot1_broken = sprite_attack_broken
    inst:drone_stats_init(1600)
    inst:init_actor_late()

    inst.x_range = 600
    inst.x_range_min = 40
    inst.fire_frame = Global._current_frame
    inst.charging = 0
    inst.charge_step = 0

    inst.recycle_tier = 3.0

    gm._mod_instance_set_mask(inst.value, gm.constants.sPMask)

    inst.persistent = 1
    inst:instance_sync()
end)

gildedThunderDrone:onStep(function( inst )
	local master = inst.master

    if not Instance.exists(master) then
        return
    end

    if master.dead then
        inst.hp = -1
        inst:actor_death(true)
        return
    end

    if inst.state == 1 then
        if not Instance.exists(inst.target) then return end
        if not Instance.exists(master) then return end
        
        inst.x = GM.lerp(inst.x, inst.target.x, inst.chase_motion_lerp * 0.25 * (inst.drone_move_rate / (1/9)))
        inst.y = GM.lerp(inst.y, inst.target.y - 150, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate / (1/9)))
        inst.chase_motion_lerp = math.min(1, inst.chase_motion_lerp + 0.1)

        if Global._current_frame - inst.fire_frame >= math.max(1, 50/inst.attack_speed) and math.abs(inst.x - inst.target.x) < 15 and math.abs(inst.y - inst.target.y) < 175 and inst.charging == 0 then
            inst.charging = 1
        end
    end

    if (inst.sprite_index == sprite_attack or inst.sprite_index == sprite_attack_broken) and inst.image_index >= 4.8 then
        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle or sprite_idle_broken
        inst.image_index = 0
    end

    if inst.charge_step >= 100 then
        inst.charging = 0
        inst.charge_step = 0
        inst.fire_frame = Global._current_frame
        inst.state = 0

        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_attack or sprite_attack_broken -- sets to the appropriate attack sprite
        inst.image_index = 0
        inst:sound_play(gm.constants.wLightning, 1.5, 0.9 + math.random() * 0.8)

        local lightning = gm.instance_create(inst.x, inst.y, gm.constants.oChainLightning)
		lightning.parent = inst.value
		lightning.team = inst.team
		lightning.damage = inst.damage * 10
	    lightning.bounce = 3
        lightning.x = inst.target.x
        lightning.y = inst.target.y

        if inst:is_authority() then
            local attack = inst:fire_explosion(inst.target.x, inst.target.y, 150, 300, 30, gm.constants.sLightning)
            attack.attack_info.__ssr_thunder_snare = 6 * 60
        end
    end
end)

gildedThunderDrone:onDraw(function( inst )
	if inst.charging == 1 and inst.state == 1 and Instance.exists(inst.target) then
        inst.charge_step = inst.charge_step + 1

        local ratio = (inst.charge_step / 100)
        local beam_variance = math.random() * ratio
        gm.gpu_set_blendmode(1)

        gm.draw_set_alpha(ratio)
        gm.draw_set_colour(Color.from_rgb(110, 129, 195))
        gm.draw_rectangle(inst.x - 4 * beam_variance, inst.y + 12, inst.x + 4 * beam_variance, inst.target.y, false)
        gm.draw_circle(inst.x, inst.y + 12, 8 + math.random() * 2, false)
        gm.draw_circle(inst.x, inst.target.y, 8 + math.random() * 2, false)

        gm.draw_set_alpha(ratio * .5)
        gm.draw_set_colour(Color.WHITE)
        gm.draw_rectangle(inst.x - 2 * beam_variance, inst.y + 12, inst.x + 2 * beam_variance, inst.target.y, false)
        gm.draw_circle(inst.x, inst.y + 12, 6 + math.random() * 2, false)
        gm.draw_circle(inst.x, inst.target.y, 6 + math.random() * 2, false)

        gm.draw_set_alpha(1)
        gm.gpu_set_blendmode(0)
    elseif inst.charging == 1 then
        inst.charge_step = 0
        inst.charging = 0
        inst.fire_frame = Global._current_frame
    end
end)


-------- Final drone setup
local snare = Buff.find("ror", "snare")
Callback.add(Callback.TYPE.onAttackHit, "SSThunderDroneHit", function( hit_info )
	local attack_tag = hit_info.__ssr_thunder_snare

    if attack_tag then
        hit_info.target:buff_apply(snare, attack_tag, 1)
    end
end)

local stages = Stage.find_all()
for _, stage in ipairs(stages) do
    stage:add_interactable(drone_card)
end
