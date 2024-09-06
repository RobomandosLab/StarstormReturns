if already_init then
    return survivor_setup
end
already_init = true

survivor_setup = {}

-- for interacting with global arrays as classes
local function gm_array_class(name, fields)
    local mt = {
        __index = function(t, k)
            local f = fields[k]
            if f then
                local v = gm.array_get(t.arr, f.idx)
                if f.typ then
                    return v
                elseif f.decode then
                    return f.decode(v)
                end
                return v
            end
            return nil
        end,
        __newindex = function(t, k, v)
            local f = fields[k]
            if f then
                if f.readonly then
                    error("field " .. k .. " is read-only")
                else
                    return gm.array_set(t.arr, f.idx, v)
                end
            else
                error("setting unknown field " .. k)
            end
        end
    }
    return function(id)
        local class_arr = gm.variable_global_get(name)
        local arr = gm.array_get(class_arr, id)
        return setmetatable({id = id, arr = arr}, mt)
    end
end

survivor_setup.Skill = gm_array_class("class_skill", {
    namespace  = {idx=0},
    identifier = {idx=1},

    token_name = {idx=2},
    token_description = {idx=3},

    sprite     = {idx=4},
    subimage   = {idx=5},

    cooldown     = {idx=6},
    damage   = {idx=7},
    max_stock   = {idx=8},
    start_with_stock   = {idx=9},
    auto_restock   = {idx=10},
    required_stock   = {idx=11},
    require_key_press   = {idx=12},
    allow_buffered_input   = {idx=13},
    use_delay   = {idx=14},
    animation   = {idx=15},
    is_utility   = {idx=16},
    is_primary   = {idx=17},
    required_interrupt_priority   = {idx=18},
    hold_facing_direction   = {idx=19},
    override_strafe_direction   = {idx=20},
    ignore_aim_direction   = {idx=21},
    disable_aim_stall   = {idx=22},
    does_change_activity_state   = {idx=23},
    
    on_can_activate   = {idx=24},
    on_activate   = {idx=25},
    on_step   = {idx=26},
    on_equipped   = {idx=27},
    on_unequipped   = {idx=28},
    
    upgrade_skill   = {idx=29},
})

local skill_family_mt = {
    __index = function(t,k)
        if type(k) == "number" then
            if k >= 0 and k < gm.array_length(t.elements) then
                -- the actual value in the array is a 'skill loadout unlockable' object, so get the skill id from it
                return survivor_setup.Skill(gm.variable_struct_get(gm.array_get(t.elements, k), "skill_id"))
            end
        end
        return nil
    end
}

local function wrap_skill_family(struct_loadout_family)
    -- too lazy to write a proper wrapper right now sorry
    local elements = gm.variable_struct_get(struct_loadout_family, "elements")
    return setmetatable({struct=struct_loadout_family, elements=elements}, skill_family_mt)
end

survivor_setup.Survivor = gm_array_class("class_survivor", {
    namespace  = {idx=0},
    identifier = {idx=1},

    token_name = {idx=2},
    token_name_upper = {idx=3},
    token_description = {idx=4},
    token_end_quote = {idx=5},
    
    skill_family_z = {idx=6,decode=wrap_skill_family},
    skill_family_x = {idx=7,decode=wrap_skill_family},
    skill_family_c = {idx=8,decode=wrap_skill_family},
    skill_family_v = {idx=9,decode=wrap_skill_family},
    skin_family = {idx=10,decode=nil},
    all_loadout_families = {idx=11,decode=nil},
    all_skill_families = {idx=12,decode=nil},

    sprite_loadout        = {idx=13},
    sprite_title          = {idx=14},
    sprite_idle           = {idx=15},
    sprite_portrait       = {idx=16},
    sprite_portrait_small = {idx=17},
    sprite_palette = {idx=18},
    sprite_portrait_palette = {idx=19},
    sprite_loadout_palette = {idx=20},
    sprite_credits = {idx=21},
    primary_color         = {idx=22},
    select_sound_id         = {idx=23},

    log_id         = {idx=24},

    achievement_id         = {idx=25},

    on_init         = {idx=29},
    on_step         = {idx=30},
    on_remove         = {idx=31},

    is_secret         = {idx=32},

    cape_offset         = {idx=33},
})

return survivor_setup