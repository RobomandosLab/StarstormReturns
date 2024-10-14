-- -- executioner
-- log.info("[STARSTORM RETURNS] : Loading ".._ENV["!guid"]..".")

-- EXESPRITEPATH = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites\\Executioner")

-- -- define sprites
-- -- to-do: do these paths NEED to be saved separate? can they not be loaded directly into the sprites? test that.
-- local portrait_path = path.combine(EXESPRITEPATH, "portraitSmall.png")
-- local portraitsmall_path = path.combine(EXESPRITEPATH, "portrait.png")

-- local skills_path = path.combine(EXESPRITEPATH, "skillsLoadout.png")
-- local loadout_path = path.combine(EXESPRITEPATH, "select.png")
-- local idle_path = path.combine(EXESPRITEPATH, "idle.png")
-- local walk_path = path.combine(EXESPRITEPATH, "walk.png")
-- local death_path = path.combine(EXESPRITEPATH, "death.png")
-- local jump_path = path.combine(EXESPRITEPATH, "jump.png")
-- local climb_path = path.combine(EXESPRITEPATH, "climb.png")
-- local hit_path = path.combine(EXESPRITEPATH, "decoy.png")

-- local shoot1_path = path.combine(EXESPRITEPATH, "shoot1.png")

-- local portrait_sprite = gm.sprite_add(portrait_path, 1, false, false, 0, 0)
-- local portraitsmall_sprite = gm.sprite_add(portraitsmall_path, 1, false, false, 0, 0)

-- local palette_path = path.combine(EXESPRITEPATH, "palette.png")

-- local skills_sprite = gm.sprite_add(skills_path, 4, false, false, 0, 0)
-- local loadout_sprite = gm.sprite_add(loadout_path, 17, false, false, 28, 5)
-- local idle_sprite = gm.sprite_add(idle_path, 1, false, false, 13, 16)
-- local walk_sprite = gm.sprite_add(walk_path, 8, false, false, 13, 16)
-- local death_sprite = gm.sprite_add(death_path, 5, false, false, 13, 16)
-- local jump_sprite = gm.sprite_add(jump_path, 1, false, false, 13, 16)
-- local climb_sprite = gm.sprite_add(climb_path, 2, false, false, 13, 16)
-- local hit_sprite = gm.sprite_add(hit_path, 1, false, false, 13, 16)

-- local shoot1_sprite = gm.sprite_add(shoot1_path, 4, false, false, 13, 16)

-- local palette_sprite = gm.sprite_add(palette_path, 1, false, false, 0, 0)

-- local executioner_id = -1
-- local executioner = nil

-- -- survivor setup
-- local function create_survivor()
--     executioner_id = gm.survivor_create("swuff", "executioner")
--     executioner = survivor_setup.Survivor(executioner_id)
--     local commando_survivor_id = 0
--     local vanilla_survivor = survivor_setup.Survivor(commando_survivor_id)

--     --executioner.token_name = "Executioner"
--     --executioner.token_name_upper = "EXECUTIONER"
--     --executioner.token_description = "The <y>Executioner<w> kills <y>aliens<w> and doesn't afraid of <y>anything<w>."
--     --executioner.token_end_quote = "..and so he left, bloodlust unfulfilled."

--     executioner.sprite_loadout = loadout_sprite
--     executioner.sprite_title = walk_sprite
--     executioner.sprite_idle = idle_sprite
--     executioner.sprite_portrait = portrait_sprite
--     executioner.sprite_portrait_small = portraitsmall_sprite
--     executioner.sprite_palette = palette_sprite
--     executioner.sprite_portrait_palette = palette_sprite
--     executioner.sprite_loadout_palette = palette_sprite
--     executioner.sprite_credits = walk_sprite
--     executioner.primary_color = gm.make_colour_rgb(175, 113, 126)
	
-- 	executioner.on_init = vanilla_survivor.on_init
--     executioner.on_step = vanilla_survivor.on_step
--     executioner.on_remove = vanilla_survivor.on_remove

--     executioner.cape_offset = vanilla_survivor.cape_offset

-- -- primary skill

--     local skill_primary = executioner.skill_family_z[0]
    
--     skill_primary.token_name = "Service Pistol"
--     skill_primary.token_description = "Shoot enemies for <y>100%<w> damage."

--     skill_primary.sprite = skills_sprite
--     skill_primary.subimage = 0

--     skill_primary.cooldown = 0
--     skill_primary.damage = 1.0
--     skill_primary.required_stock = 0
--     skill_primary.require_key_press = false
--     skill_primary.use_delay = 0
--     skill_primary.is_primary = true

--     skill_primary.does_change_activity_state = true
--     skill_primary.on_can_activate = vanilla_survivor.skill_family_z[0].on_can_activate
--     skill_primary.on_activate = vanilla_survivor.skill_family_z[0].on_activate

-- -- secondary skill

--     local skill_secondary = executioner.skill_family_x[0]

--     skill_secondary.token_name = "Ion Burst"
--     skill_secondary.token_description = "Bang bang bang bang"

--     skill_secondary.sprite = skills_sprite
--     skill_secondary.subimage = 1

--     skill_secondary.cooldown = -1
--     skill_secondary.damage = 2.4
--     skill_secondary.required_stock = 1
--     skill_secondary.require_key_press = false
--     skill_secondary.max_stock = 10
--     skill_secondary.auto_restock = false
--     skill_secondary.start_with_stock = 0
--     skill_secondary.use_delay = 0

--     skill_secondary.does_change_activity_state = true

--     skill_secondary.on_can_activate = vanilla_survivor.skill_family_x[0].on_can_activate
--     skill_secondary.on_activate = vanilla_survivor.skill_family_x[0].on_activate
    
-- -- utility skill

--     local skill_utility = executioner.skill_family_c[0]

--     skill_utility.token_name = "Crowd Dispersion"
--     skill_utility.token_description = "SCARY"
--     skill_utility.sprite = skills_sprite
--     skill_utility.subimage = 2

--     skill_utility.cooldown = 240
--     skill_utility.max_stock = 4
--     skill_utility.start_with_stock = 4
--     skill_utility.auto_restock = true
--     skill_utility.required_stock = 1
--     skill_utility.require_key_press = true
--     skill_utility.use_delay = 30
--     skill_utility.is_utility = true
    
--     skill_utility.on_can_activate = vanilla_survivor.skill_family_c[0].on_can_activate
--     skill_utility.on_activate = vanilla_survivor.skill_family_c[0].on_activate
    
-- -- special skill
	
--     local skill_special = executioner.skill_family_v[0]

--     skill_special.token_name = "Execution"
--     skill_special.token_description = "DIE DIE DIE"

--     skill_special.sprite = skills_sprite
--     skill_special.subimage = 3

--     skill_special.cooldown = 480
--     skill_special.required_stock = 1
--     skill_special.require_key_press = true
--     skill_special.use_delay = 0

--     skill_special.does_change_activity_state = true
    
--     skill_special.on_can_activate = vanilla_survivor.skill_family_v[0].on_can_activate
--     skill_special.on_activate = vanilla_survivor.skill_family_v[0].on_activate
-- end

-- -- feed movement sprites to body

-- local function setup_sprites(self)
--     local survivors = gm.variable_global_get("class_survivor")

--     if not survivors or self.class ~= executioner_id then return end

--     self.sprite_idle = idle_sprite
--     self.sprite_walk = walk_sprite
--     self.sprite_jump = jump_sprite
--     self.sprite_jump_peak = jump_sprite
--     self.sprite_fall = jump_sprite
--     self.sprite_climb = climb_sprite
--     self.sprite_death = death_sprite
--     self.sprite_decoy = hit_sprite
-- end

-- -- primary skill state
-- -- to-do: how the FUCK does this work? i think there must be a better system akin to entitystates rather than hooking when the buttons pressed and acting 'appropriately'.

-- local function skill_primary_on_activation(self, actor_skill, skill_index)
--     if self.class ~= executioner_id then return end -- hate this

--     gm._mod_actor_setActivity(self, 92, 1, true, nil)
--     self.image_speed = 0.2

--     if self.pVspeed == 0.0 then self.pHspeed = self.pHspeed * 0.2 end

--     gm._mod_sprite_set_speed(shoot1_sprite, 1)
--     gm._mod_instance_set_sprite(self, shoot1_sprite)

--     local direction = gm.actor_get_facing_direction(self)
--     local orig_x = self.x - 1.8
--     local orig_y = self.y

--     gm._mod_attack_fire_bullet(
--         self,
--         orig_x,
--         orig_y,
--         65,
--         direction,
--         self.skills[1].active_skill.damage,
--         gm.constants.sSparks1,
--         false,
--         true
--     )
-- end

-- -- secondary skill state
-- -- non-primary skills are duplicates for time being

-- local function skill_secondary_on_activation(self, actor_skill, skill_index)
--     if self.class ~= executioner_id then return end -- hate this

--     gm._mod_actor_setActivity(self, 92, 1, true, nil)
--     self.image_speed = 0.2

--     if self.pVspeed == 0.0 then self.pHspeed = self.pHspeed * 0.2 end

--     gm._mod_sprite_set_speed(shoot1_sprite, 1)
--     gm._mod_instance_set_sprite(self, shoot1_sprite)

--     local direction = gm.actor_get_facing_direction(self)
--     local orig_x = self.x - 1.8
--     local orig_y = self.y

--     gm._mod_attack_fire_bullet(
--         self,
--         orig_x,
--         orig_y,
--         65,
--         direction,
--         self.skills[1].active_skill.damage,
--         gm.constants.sSparks1,
--         false,
--         true
--     )
-- end

-- -- utility skill state

-- local function skill_utility_on_activation(self, actor_skill, skill_index)
--     if self.class ~= executioner_id then return end -- hate this

--     gm._mod_actor_setActivity(self, 92, 1, true, nil)
--     self.image_speed = 0.2

--     if self.pVspeed == 0.0 then self.pHspeed = self.pHspeed * 0.2 end

--     gm._mod_sprite_set_speed(shoot1_sprite, 1)
--     gm._mod_instance_set_sprite(self, shoot1_sprite)

--     local direction = gm.actor_get_facing_direction(self)
--     local orig_x = self.x - 1.8
--     local orig_y = self.y

--     gm._mod_attack_fire_bullet(
--         self,
--         orig_x,
--         orig_y,
--         65,
--         direction,
--         self.skills[1].active_skill.damage,
--         gm.constants.sSparks1,
--         false,
--         true
--     )
-- end

-- -- special skill state

-- local function skill_special_on_activation(self, actor_skill, skill_index)
--     if self.class ~= executioner_id then return end -- hate this

--     gm._mod_actor_setActivity(self, 92, 1, true, nil)
--     self.image_speed = 0.2

--     if self.pVspeed == 0.0 then self.pHspeed = self.pHspeed * 0.2 end

--     gm._mod_sprite_set_speed(shoot1_sprite, 1)
--     gm._mod_instance_set_sprite(self, shoot1_sprite)

--     local direction = gm.actor_get_facing_direction(self)
--     local orig_x = self.x - 1.8
--     local orig_y = self.y

--     gm._mod_attack_fire_bullet(
--         self,
--         orig_x,
--         orig_y,
--         65,
--         direction,
--         self.skills[1].active_skill.damage,
--         gm.constants.sSparks1,
--         false,
--         true
--     )
-- end

-- -- there's no way this can be good, but candyman said it's ok.
-- -- iterates through every callback and gets the required ones based on name ig.

-- local callback_names = gm.variable_global_get("callback_names")
-- local on_player_init_callback_id = 0
-- local on_player_step_callback_id = 0
-- for i = 1, #callback_names do
--     local callback_name = callback_names[i]
--     if callback_name:match("onPlayerInit") then
--         on_player_init_callback_id = i - 1
--     end

--     if callback_name:match("onPlayerStep") then
--         on_player_step_callback_id = i - 1
--     end
-- end

-- local pre_hooks = {}
-- gm.pre_script_hook(gm.constants.callback_execute, function(self, other, result, args)
--     if self.class ~= executioner_id then return end

--     local callback_id = args[1].value
--     if pre_hooks[callback_id] then
--         return pre_hooks[callback_id](self, other, result, args)
--     end

--     return true
-- end)

-- local post_hooks = {}
-- gm.post_script_hook(gm.constants.callback_execute, function(self, other, result, args)
--     if self.class ~= executioner_id then return end

--     local callback_id = args[1].value
--     if post_hooks[callback_id] then
--         post_hooks[callback_id](self, other, result, args)
--     end
-- end)

-- post_hooks[on_player_init_callback_id] = function(self, other, result, args)
--     setup_sprites(self)

--     setup_skills_callbacks()
-- end

-- local function setup_skills_callbacks()
--     local primary = executioner.skill_family_z[0]
--     local secondary = executioner.skill_family_x[0]
--     local utility = executioner.skill_family_c[0]
--     local special = executioner.skill_family_v[0]

--     if not pre_hooks[primary.on_activate] then
--         pre_hooks[primary.on_activate] = function(self, other, result, args)
--             skill_primary_on_activation(self)
--             return false
--         end
--     end

--     if not pre_hooks[secondary.on_activate] then
--         pre_hooks[secondary.on_activate] = function(self, other, result, args)
--             skill_secondary_on_activation(self)
--             return false
--         end
--     end

--     if not pre_hooks[utility.on_activate] then
--         pre_hooks[utility.on_activate] = function(self, other, result, args)
--             skill_utility_on_activation(self)
--             return false
--         end
--     end

--     if not pre_hooks[special.on_activate] then
--         pre_hooks[special.on_activate] = function(self, other, result, args)
--             skill_special_on_activation(self)
--             return false
--         end
--     end
-- end


-- local hooks = {}
-- hooks["gml_Object_oStartMenu_Step_2"] = function()
--     hooks["gml_Object_oStartMenu_Step_2"] = nil

--     create_survivor()
-- end

-- gm.pre_code_execute(function(self, other, code, result, flags)
--     if hooks[code.name] then
--         hooks[code.name](self)
--     end
-- end)