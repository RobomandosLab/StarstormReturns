local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/ShockDrone")

local sprite_idle            = Resources.sprite_load(NAMESPACE, "ShockDroneIdle", path.combine(SPRITE_PATH, "ShockDroneIdle.png"), 8, 12, 20)
local sprite_idle_broken     = Resources.sprite_load(NAMESPACE, "ShockDroneBrokenIdle", path.combine(SPRITE_PATH, "ShockDroneBrokeIdle.png"), 8, 12, 20)
local sprite_attack          = Resources.sprite_load(NAMESPACE, "ShockDroneAttack", path.combine(SPRITE_PATH, "ShockDroneAttack.png"), 5, 12, 20)
local sprite_attack_broken   = Resources.sprite_load(NAMESPACE, "ShockDroneBrokenAttack", path.combine(SPRITE_PATH, "ShockDroneBrokeAttack.png"), 5, 12, 20)
local sprite_interact        = Resources.sprite_load(NAMESPACE, "ShockDronePurchase", path.combine(SPRITE_PATH, "ShockDronePickUp.png"), 1, 23, 40)


local thunderDrone = Object.new(NAMESPACE, "ThunderDrone", Object.PARENT.drone)
thunderDrone.obj_depth = -202
thunderDrone.obj_sprite = sprite_idle

local thunderDronePickup = Object.new(NAMESPACE, "ThunderDronePickup", Object.PARENT.interactableDrone)
thunderDronePickup.obj_depth = 90
thunderDronePickup.obj_sprite = sprite_interact


-------- Thunder Drone
thunderDrone:onCreate(function( inst )
    inst.sprite_idle = sprite_idle
    inst.sprite_idle_broken = sprite_idle_broken
    inst.sprite_shoot1 = sprite_attack
    inst.sprite_shoot1_broken = sprite_attack_broken
    inst:drone_stats_init(600)
    inst:init_actor_late()

    inst.x_range = 600
    inst.fire_frame = Global._current_frame

    inst.returning = 0
    inst.return_frame = Global._current_frame

    inst.charging = 0
    inst.charge_step = 0

    inst.recycle_tier = 2.0
    inst.drone_upgrade_type_id = Object.find(NAMESPACE, "GildedThunderDrone").value
    inst.interactable_child = thunderDronePickup.value 

    inst.persistent = 1
end)

thunderDrone:onStep(function( inst )
	local master = inst.master

    if not Instance.exists(master) then return end 
    if master.dead then inst:destroy() return end

    if inst.state == 1 and inst.returning == 0 then
        if not Instance.exists(inst.target) then return end
        if not Instance.exists(master) then return end
        
        inst.x = GM.lerp(inst.x, inst.target.x, inst.chase_motion_lerp * 0.25 * (inst.drone_move_rate * 9))
        inst.y = GM.lerp(inst.y, inst.target.y - 150, inst.chase_motion_lerp * 0.1 * (inst.drone_move_rate * 9))
        inst.chase_motion_lerp = math.min(1, inst.chase_motion_lerp + 0.1)

        if Global._current_frame - inst.fire_frame >= math.max(1, 100/inst.attack_speed) and math.abs(inst.x - inst.target.x) < 15 and math.abs(inst.y - inst.target.y) < 175 and inst.charging == 0 then
            inst.charging = 1
        end

        local dist = gm.point_distance(inst.x, inst.y, master.x, master.y)

        if dist > 800 then
            inst.returning = 1
            inst.return_frame = Global._current_frame

            inst.target = nil
            inst.x_range = 0
            GM.actor_set_state_networked(inst, -1)
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

    if inst.returning == 1 then
        if Global._current_frame - inst.return_frame >= 2 * 60 then
            inst.returning = 0
            inst.x_range = 600
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

local drone_card = Interactable_Card.new(NAMESPACE, "thunderDronePickup")
drone_card.object_id = thunderDronePickup.value
drone_card.spawn_with_sacrifice = true
drone_card.spawn_cost = 160
drone_card.spawn_weight = 2
drone_card.default_spawn_rarity_override = 1


local snare = Buff.find("ror", "snare")
Callback.add(Callback.TYPE.onAttackHit, "SSThunderDroneHit", function( hit_info )
	local attack_tag = hit_info.__ssr_thunder_snare

    if attack_tag then
        hit_info.target:buff_apply(snare, attack_tag, 1)
    end
end)

local stages_loaded = 0
Callback.add(Callback.TYPE.onGameStart, "SSRThunderDroneAddStages", function( )
	if stages_loaded == 0 then
        stages_loaded = 1

        local loop_stages = {
            "ror-sunkenTombs",
            "ror-magmaBarracks"
        }

        for _, s in ipairs(loop_stages) do
            local stage = Stage.find(s)
            stage:add_interactable_loop(drone_card)
        end
    end
end)