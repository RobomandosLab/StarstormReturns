local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/ShockDrone")

local sprite_idle            = Resources.sprite_load(NAMESPACE, "ShockDroneIdle", path.combine(SPRITE_PATH, "ShockDroneIdle.png"), 8, 12, 20)
local sprite_idle_broken     = Resources.sprite_load(NAMESPACE, "ShockDroneBrokenIdle", path.combine(SPRITE_PATH, "ShockDroneBrokeIdle.png"), 8, 12, 20)
local sprite_attack          = Resources.sprite_load(NAMESPACE, "ShockDroneAttack", path.combine(SPRITE_PATH, "ShockDroneAttack.png"), 5, 12, 20)
local sprite_attack_broken   = Resources.sprite_load(NAMESPACE, "ShockDroneBrokenAttack", path.combine(SPRITE_PATH, "ShockDroneBrokeAttack.png"), 5, 12, 20)
local sprite_interact        = Resources.sprite_load(NAMESPACE, "ShockDronePurchase", path.combine(SPRITE_PATH, "ShockDronePickUp.png"), 1, 23, 40)


local shockDrone = Object.new(NAMESPACE, "ShockDrone", Object.PARENT.drone)

local shockDronePickup = Object.new(NAMESPACE, "ShockDronePickup", Object.PARENT.interactableDrone)
shockDronePickup.obj_sprite = sprite_interact


shockDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_attack
    inst.sprite_shoot1_broken = sprite_attack_broken
    inst:drone_stats_init(200)
    inst:init_actor_late()

    inst.x_range = 600
    inst.x_range_min = 40
    inst.fire_frame = Global._current_frame

    inst.y_offset = 0
    inst.cache_skill_pickup_id = -4
    inst.interactable_child = shockDronePickup.value

    gm._mod_instance_set_mask(inst.value, gm.constants.sPMask)

    inst.persistent = 1
    inst:instance_sync()

    Helper.log_struct(inst)
end)

shockDrone:onStep(function( inst )
	local master = inst.master

    if not Instance.exists(master) then
        return
    end

    if master.dead then
        inst.hp = -10
        inst:actor_death(true)
        return
    end

    if inst.state == 1 then
        if not Instance.exists(inst.target) then return end
        if not Instance.exists(master) then return end
        
        inst.x = GM.lerp(inst.x, inst.target.x + inst.xx, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate / (1/9)))
        inst.y = GM.lerp(inst.y, inst.target.y - 25 + inst.yy, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate / (1/9)))
        inst.chase_motion_lerp = math.min(1, inst.chase_motion_lerp + 0.1)

        if Global._current_frame - inst.fire_frame >= 100 and math.abs(inst.x - inst.target.x) < 40 then
            inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_attack or sprite_attack_broken
            inst.image_index = 0
            inst:sound_play(gm.constants.wChainLightning2, 0.5, 0.9 + math.random() * 0.8)

            local lightning = gm.instance_create(inst.x, inst.y, gm.constants.oChainLightning)
		    lightning.parent = inst.value
		    lightning.team = inst.team
		    lightning.damage = inst.damage * 2.5
	        lightning.bounce = 3

            if inst:is_authority() and Instance.exists(inst.target) then
			    local attack = inst:fire_direct(inst.target.parent, 0.2)
			    attack.attack_info.stun = 1.5
            end

            inst.fire_frame = Global._current_frame
        end
    end

    if (inst.sprite_index == sprite_attack or inst.sprite_index == sprite_attack_broken) and inst.image_index >= 4.8 then
        inst.sprite_index = inst.hp/inst.maxhp >= 0.5 and sprite_idle or sprite_idle_broken
        inst.image_index = 0
    end
end)


shockDronePickup:onCreate(function( inst )
    inst:interactable_init(true)
    inst.active = 0
    inst.value.value = 60
    inst.image_speed = 0
    inst.interact_scroll_index = 3
    inst.child = shockDrone.value
    inst:interactable_init_cost(inst.value, 0, 40)
    inst:interactable_init_name()
end)

local drone_card = Interactable_Card.new(NAMESPACE, "shockDronePickup")
drone_card.object_id = shockDronePickup.value
drone_card.spawn_with_sacrifice = true
drone_card.spawn_cost = 80
drone_card.spawn_weight = 6
drone_card.default_spawn_rarity_override = 1

local stages = Stage.find_all()
for _, stage in ipairs(stages) do
    stage:add_interactable(drone_card)
end
