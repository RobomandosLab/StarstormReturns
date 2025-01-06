-- hey hey its me azuline
-- again
-- or maybe not again, maybe this is the first starstorm returns file youre checking
-- anyways, this is cyborg
-- i consider him an intermediate character
-- hes not that complex but hes not exactly simple by any means
-- because of this i wont be explaining literally everything, just the things that might leave you confused
-- TODO network the fuck out of this character none of this probably works in multiplayer lmao
local SPRITE_PATH = path.combine(PATH, "Sprites/Survivors/Cyborg")
local SOUND_PATH = path.combine(PATH, "Sounds/Survivors/Cyborg")

local cyborg = Survivor.new(NAMESPACE, "cyborg")
local cyborg_id = cyborg.value

local sprites = {
    idle = Resources.sprite_load(NAMESPACE, "cyborg_idle", path.combine(SPRITE_PATH, "idle.png"), 1, 8, 14),
    walk = Resources.sprite_load(NAMESPACE, "cyborg_walk", path.combine(SPRITE_PATH, "walk.png"), 4, 10, 16),
    jump = Resources.sprite_load(NAMESPACE, "cyborg_jump", path.combine(SPRITE_PATH, "jump.png"), 1, 10, 12),
	jump_peak = Resources.sprite_load(NAMESPACE, "cyborg_jump", path.combine(SPRITE_PATH, "jump.png"), 1, 10, 12),
	fall = Resources.sprite_load(NAMESPACE, "cyborg_jump", path.combine(SPRITE_PATH, "jump.png"), 1, 10, 12),
    climb = Resources.sprite_load(NAMESPACE, "cyborg_climb", path.combine(SPRITE_PATH, "climb.png"), 2, 8, 14),
    death = Resources.sprite_load(NAMESPACE, "cyborg_death", path.combine(SPRITE_PATH, "death.png"), 5, 18, 8),
    decoy = Resources.sprite_load(NAMESPACE, "cyborg_decoy", path.combine(SPRITE_PATH, "decoy.png"), 1, 18, 20),
}
    
local sprIdleHalf = Resources.sprite_load(NAMESPACE, "cyborg_idlehalf", path.combine(SPRITE_PATH, "idleHalf.png"), 1, 8, 14)
local sprWalkHalf = Resources.sprite_load(NAMESPACE, "cyborg_walkhalf", path.combine(SPRITE_PATH, "walkHalf.png"), 4, 10, 16)
local sprWalkBack = Resources.sprite_load(NAMESPACE, "cyborg_walkback", path.combine(SPRITE_PATH, "walkBack.png"), 4, 10, 16)
local sprJumpHalf = Resources.sprite_load(NAMESPACE, "cyborg_jumphalf", path.combine(SPRITE_PATH, "jumpHalf.png"), 1, 10, 12)
local sprJumpPeakHalf = Resources.sprite_load(NAMESPACE, "jumppeakhalf", path.combine(SPRITE_PATH, "jumpPeakHalf.png"), 1, 10, 12)
local sprFallHalf = Resources.sprite_load(NAMESPACE, "cyborg_fallhalf", path.combine(SPRITE_PATH, "fallHalf.png"), 1, 10, 12)
local sprShoot1 = Resources.sprite_load(NAMESPACE, "cyborg_shoot1", path.combine(SPRITE_PATH, "shoot1.png"), 6, 12, 16)
local sprShoot1Half = Resources.sprite_load(NAMESPACE, "cyborg_shoot1half", path.combine(SPRITE_PATH, "shoot1Half.png"), 6, 12, 16)
local sndShoot1 = Resources.sfx_load(NAMESPACE, "cyborg_shoot1snd", path.combine(SOUND_PATH, "skill1.ogg"))
local sprSparks1 = Resources.sprite_load(NAMESPACE, "cyborg_sparks1", path.combine(SPRITE_PATH, "sparks1.png"), 4, 26, 16)
local sprShoot2 = Resources.sprite_load(NAMESPACE, "cyborg_shoot2", path.combine(SPRITE_PATH, "shoot2.png"), 8, 24, 38)
local sprShoot2Alt = Resources.sprite_load(NAMESPACE, "cyborg_shoot2alt", path.combine(SPRITE_PATH, "shoot2alt.png"), 8, 34, 16)
local sndShoot2Alt = Resources.sfx_load(NAMESPACE, "cyborg_shoot2altsnd", path.combine(SOUND_PATH, "shoot2alt.ogg"))
local sprSparks2 = Resources.sprite_load(NAMESPACE, "cyborg_sparks2", path.combine(SPRITE_PATH, "sparks2.png"), 4, 26, 16)
local sndShoot2 = Resources.sfx_load(NAMESPACE, "cyborg_shoot2snd", path.combine(SOUND_PATH, "skill2.ogg"))
local sprShoot3 = Resources.sprite_load(NAMESPACE, "cyborg_shoot3a", path.combine(SPRITE_PATH, "shoot3a.png"), 3, 22, 32)
local sndShoot3 = Resources.sfx_load(NAMESPACE, "cyborg_shoot3asnd", path.combine(SOUND_PATH, "skill3a.ogg"))
local sprShoot3B = Resources.sprite_load(NAMESPACE, "cyborg_shoot3b", path.combine(SPRITE_PATH, "shoot3b.png"), 6, 22, 32)
local sndShoot3B = Resources.sfx_load(NAMESPACE, "cyborg_shoot3bsnd", path.combine(SOUND_PATH, "skill3b.ogg"))
local sprShoot4 = Resources.sprite_load(NAMESPACE, "cyborg_shoot4", path.combine(SPRITE_PATH, "shoot4.png"), 8, 20, 24)
local sndShoot4 = Resources.sfx_load(NAMESPACE, "cyborg_shoot4", path.combine(SOUND_PATH, "skill4.ogg"))
local sprBullet = Resources.sprite_load(NAMESPACE, "cyborg_bullet", path.combine(SPRITE_PATH, "bullet.png"), 2, 60, 24)
	local sprBulletMask = Resources.sprite_load(NAMESPACE, "cyborg_bulletmask", path.combine(SPRITE_PATH, "bulletMask.png"), 1, 34, 22)
	local sprTeleportA = Resources.sprite_load(NAMESPACE, "cyborg_teleporta", path.combine(SPRITE_PATH, "teleporta.png"), 8, 10, 18)
	local sprTeleportB = Resources.sprite_load(NAMESPACE, "cyborg_teleportb", path.combine(SPRITE_PATH, "teleportb.png"), 4, 10, 18)
	local sprCTeleportParticle = Resources.sprite_load(NAMESPACE, "cyborg_teleportparticle", path.combine(SPRITE_PATH, "teleportparticle.png"), 4, 10, 10)
	local sprCStarParticle = Resources.sprite_load(NAMESPACE, "cyborg_starparticle", path.combine(SPRITE_PATH, "starparticle.png"), 1, 6, 6)
	local sprMarkApply = Resources.sprite_load(NAMESPACE, "cyborg_markapply", path.combine(SPRITE_PATH, "markapply.png"), 8, 20, 20)
	local sndMarkApply = Resources.sfx_load(NAMESPACE, "cyborg_markapplysnd", path.combine(SOUND_PATH, "markapply.ogg"))
	local sprMarkExplode = Resources.sprite_load(NAMESPACE, "cyborg_markexplode", path.combine(SPRITE_PATH, "markexplode.png"), 17, 36, 50)
	local sndMarkExplode = Resources.sfx_load(NAMESPACE, "cyborg_markexplodesnd", path.combine(SOUND_PATH, "markexplode.ogg"))
    local sprSkills = Resources.sprite_load(NAMESPACE, "cyborg_skills", path.combine(SPRITE_PATH, "skills.png"), 7, 0, 0)
    
    cyborg:set_primary_color(Color.from_rgb(138, 183, 168))
    cyborg.sprite_loadout = Resources.sprite_load(NAMESPACE, "cyborg_select", path.combine(SPRITE_PATH, "select.png"), 17, 28, 0)
    cyborg.sprite_portrait = Resources.sprite_load(NAMESPACE, "cyborg_portrait", path.combine(SPRITE_PATH, "portrait.png"), 3)
    cyborg.sprite_portrait_small = Resources.sprite_load(NAMESPACE, "cyborg_portraitsmall", path.combine(SPRITE_PATH, "portraitSmall.png"))
    cyborg.sprite_title = sprites.walk
    cyborg.sprite_idle = sprites.idle
    cyborg.sprite_credits = sprites.idle
    cyborg:set_cape_offset(-1, -6, 0, -5)
    cyborg:set_animations(sprites)

    local log = Survivor_Log.new(cyborg, cyborg.sprite_portrait, sprites.jump)

    cyborg:set_stats_base({
        maxhp = 110,
        damage = 12,
        regen = 0.025
    })
    
    cyborg:set_stats_level({
        maxhp = 26,
        damage = 3,
        regen = 0.0025,
        armor = 3
    })
	
	-- setting up the so called "half sprite nonsense" 
    cyborg:onInit(function(actor)
		local data = actor:get_data()
		data.teleAvailable = false
		
		local idle_half = Array.new()
		local walk_half = Array.new()
		local jump_half = Array.new()
		local jump_peak_half = Array.new()
		local fall_half = Array.new()
		
		idle_half:push(sprites.idle, sprIdleHalf, 0)
		walk_half:push(sprites.walk, sprWalkHalf, 0, sprWalkBack)
		jump_half:push(sprites.jump, sprJumpHalf, 2)
		jump_peak_half:push(sprites.jump_peak, sprJumpPeakHalf, 2)
		fall_half:push(sprites.fall, sprFallHalf, 2)
		
		actor.sprite_idle_half = idle_half
		actor.sprite_walk_half = walk_half
		actor.sprite_jump_half = jump_half
		actor.sprite_jump_peak_half = jump_peak_half
		actor.sprite_fall_half = fall_half

		actor:survivor_util_init_half_sprites()
	end)
	
	-- resets the utility back to the standart one when teleporting out of a stage:setFocus()
	-- TODO make it check for which utility the player has selected because otherwise this will override any alt utilities too
	local leaving_stage = State.find("ror", "teleport")
	leaving_stage:onStep(function(actor, data)
		if actor.class == cyborg.value then
			actor:get_data().teleAvailable = false
			local skill = actor:get_active_skill(Skill.SLOT.utility)
			skill.name = "skill.recall_point.name"
			skill.description = "skill.recall_point.description"
			skill.sprite = sprSkills
			skill.subimage = 2
			skill.cooldown_base = 2 * 60
			gm._mod_ActorSkill_recalculateStats(skill)
		end
	end)
	
	-- the particle thats created when using the utility skill
	parCyborgTele = Particle.new("CyborgTele")
	parCyborgTele:set_sprite(sprCTeleportParticle, true, true, true)
	parCyborgTele:set_size(0.5, 1.5, -0.1, 0)
	parCyborgTele:set_direction(0, 90, 0, 0)
	
	-- the trail of the rising star main bullets
	parCyborgStarTrail = Particle.new("CyborgStarTrail")
	parCyborgStarTrail:set_sprite(sprCStarParticle, false, false, false)
	parCyborgStarTrail:set_orientation(0, 0, 22.5, 0, true)
	parCyborgStarTrail:set_size(1, 1, -0.1, 0)
	parCyborgStarTrail:set_life(10, 10)
	parCyborgStarTrail:set_color_rgb(139, 139, 237, 237, 227, 227)
	
	-- the hit spark of the rising star bullets
	parCyborgStarHit = Particle.new("CyborgStarHit")
	parCyborgStarHit:set_sprite(sprSparks1, true, true, false)
	parCyborgStarHit:set_life(16, 16)
	
	-- the rising star main bullets
	parCyborgStar = Particle.new("CyborgStar")
	parCyborgStar:set_sprite(sprCStarParticle, false, false, false)
	parCyborgStar:set_orientation(0, 0, 22.5, 0, true)
	parCyborgStar:set_speed(45, 45, 0, 0)
	parCyborgStar:set_step(1, parCyborgStarTrail)
	parCyborgStar:set_death(1, parCyborgStarHit)
	
	-- the crosshair thing that appears on enemies when using the dash secondary
	local objMark = Object.new(NAMESPACE, "cyborg_mark")
	
	objMark:set_depth(-5)
	objMark:set_sprite(sprMarkApply)
	
	objMark:onCreate(function(self)
		self.image_speed = 0.4
		-- spawns the crosshair at 3x the size
		self.image_xscale = 3
		self.image_yscale = 3
	end)
	
	objMark:onStep(function(self)
		local enemy = self:get_data().markedEnemy
		if self.image_index >= 7.0 then -- makes the crosshair stop its animation when its on its last frame
			self.image_speed = 0
		end
		if self.image_xscale > 1 and self.image_yscale > 1 then -- makes the crosshair shrink in size until it is normal size
			self.image_xscale = self.image_xscale - 0.4
			self.image_yscale = self.image_yscale - 0.4
		end
		-- teleports itself ontop of the enemy
		self.x = enemy.x
		self.y = enemy.y
	end)
	
	-- the warp point created by the utility skill
	local objTeleport = Object.new(NAMESPACE, "cyborg_teleport")
	
	objTeleport:set_depth(1)
	objTeleport:set_sprite(sprTeleportA)

	objTeleport:onCreate(function(self)
		self:get_data().timer = 0
		self.image_speed = 0.15
		self.sprite_index = sprTeleportA
	end)
	
	objTeleport:onStep(function(self)
		local parent = self:get_data().parent
		parent:get_data().teleExists = 1
		if parent and parent:exists() then
			local selfData = self:get_data()
			if selfData.timer >= 120 and self.sprite_index ~= sprTeleportB then -- after the warp point has been around for 120 or more ticks, change its sprite
				self.sprite_index = sprTeleportB
			elseif selfData.timer <= 120 and self.sprite_index ~= sprTeleportB then -- if it hasnt reached the 120 tick point, increase the ticks by 1 every frame
				selfData.timer = selfData.timer + 1
			end
		end
	end)
	
	-- the overheat redress projectile
	local objBullet = Object.new(NAMESPACE, "cyborg_bullet")
	
	objBullet:set_sprite(sprBullet)
	objBullet:set_depth(-5)
	
	objBullet:onCreate(function(self)
		local selfData = self:get_data()
		selfData.team = "player"
		selfData.rate = 0.008
		selfData._EfColor = Color.from_hex(0xF4F3B7)
		self.image_speed = 0.25
		self.mask_index = sprBulletMask
		selfData.time = 0
	end)
	
	objBullet:onStep(function(self)
		local selfData = self:get_data()
		local parent = selfData.parent
		
		self.x = self.x + gm.sign(self.image_xscale) * 4.6 -- make the bullet move
		
		selfData.time = selfData.time + 1
		
		self.image_yscale = self.image_yscale - selfData.rate -- reduce the bullets vertical size as it travels
		
		if parent then
			if selfData.time % math.floor(15 + ((1 - self.image_yscale) * 15)) == 0 then -- essentially makes the code below run less frequently the less bullets vertical size is
				local lightning = Object.find("ror", "ChainLightning"):create(self.x, self.y) -- create the lightning objects
				lightning.blend = selfData._EfColor
				lightning.parent = parent
				if parent:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then
					lightning.bounce = 3
					lightning.damage = gm.round((parent.damage * 0.5 + (0.5)) * self.image_yscale)
				else
					lightning.bounce = 1
					lightning.damage = gm.round((parent.damage * 0.3) * self.image_yscale)
				end
			end
		end
		if selfData.time % 5 == 0 then -- every 5 ticks run the code below
			local actorList = List.new()
			local xr = 10 * self.image_xscale
			local yr = 24 * self.image_yscale
			self:collision_rectangle_list(self.x - xr, self.y - yr, self.x + xr, self.y + yr, gm.constants.pActorCollisionBase, false, true, actorList, false) -- check for actors near the bullet and add them to actorList
			local targetList = List.new()
			for _, enemy in ipairs(actorList) do -- go through every actor in actorList
				if enemy.team ~= self.team then -- if the actor is in the enemy team, add them to targetList
					targetList:add(enemy)
				end
			end
			if targetList[1] ~= nil then -- if targetList has atleast 1 enemy in it, run the code below
				if parent:is_authority() then
					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, GM.get_buff_stack(parent, buff_shadow_clone) do
						local attack = parent:fire_explosion(self.x, self.y, 34, 26 * self.image_yscale, 3.15 * self.image_yscale, nil, sprSparks2)
						attack.attack_info.climb = i * 8
						attack.attack_info.KNOCKBACK_DIR = self.image_xscale
						attack.attack_info.KNOCKBACK_KIND = 1
					end
				end
			end
			targetList:destroy()
			actorList:destroy()
		end
		if self.image_yscale <= 0 then
			self:destroy()
		end
	end)
	
	-- set up funky attributes for all the skills
    local skill_unmaker = cyborg:get_primary()
	skill_unmaker.require_key_press = false
	skill_unmaker.is_primary = true
	skill_unmaker.does_change_activity_state = true
	skill_unmaker.hold_facing_direction = true
	skill_unmaker.required_interrupt_priority = State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	
    local skill_dash = cyborg:get_secondary()
	skill_dash.does_change_activity_state = true
	
	local skill_star = Skill.new(NAMESPACE, "cyborgStar")
	cyborg:add_secondary(skill_star)
	skill_star.does_change_activity_state = true
	
    local skill_recall = cyborg:get_utility()
	skill_recall.does_change_activity_state = true
	skill_recall.is_utility = true
	skill_recall.ignore_aim_direction = true
	
    local skill_redress = cyborg:get_special()
	skill_redress.does_change_activity_state = true

    local skill_redressScepter = Skill.new(NAMESPACE, "cyborgVBoosted")
	skill_redressScepter.does_change_activity_state = true
	skill_redress:set_skill_upgrade(skill_redressScepter)
    
	-- assign anims for each skill
    skill_unmaker:set_skill_animation(sprShoot1)
    skill_star:set_skill_animation(sprShoot2)
	skill_dash:set_skill_animation(sprShoot2Alt)
    skill_recall:set_skill_animation(sprShoot3)
    skill_redress:set_skill_animation(sprShoot4)
    skill_redressScepter:set_skill_animation(sprShoot4)
	
	-- assign a state for each skill (except for the boosted special, we will be using the unupgraded state for that for uhh reasons)
    local state_unmaker = State.new(NAMESPACE, skill_unmaker.identifier)
    local state_star = State.new(NAMESPACE, skill_star.identifier)
    local state_recall = State.new(NAMESPACE, skill_recall.identifier)
    local state_redress = State.new(NAMESPACE, skill_redress.identifier)
	local state_dash = State.new(NAMESPACE, skill_dash.identifier)

    -- PRIMARY --

    skill_unmaker:set_skill_icon(sprSkills, 0) 
    skill_unmaker:set_skill_properties(1.85, 30)

    skill_unmaker:onActivate(function(actor, skill, index)
        GM.actor_set_state(actor, state_unmaker)
    end)

    state_unmaker:onEnter(function(actor, data)
        actor.image_index2 = 0
        data.fired = 0
		actor:skill_util_strafe_init()
		actor:skill_util_strafe_turn_init()
    end)
    
state_unmaker:onStep(function(actor, data)
	actor.sprite_index2 = sprShoot1Half -- set the half sprite
	
	-- set up strafing
	actor:skill_util_strafe_update(0.33 * actor.attack_speed, 0.5)
	actor:skill_util_step_strafe_sprites()
	actor:skill_util_strafe_turn_update()
    
    actor:actor_animation_set(actor:actor_get_skill_animation(skill_unmaker), 0.22)
    
    if data.fired == 0 and actor.image_index >= 0 then

        local damage = actor:skill_get_damage(skill_unmaker)
		local dir = actor:skill_util_facing_direction()
        
        if actor:is_authority() then
            if not actor:skill_util_update_heaven_cracker(actor, damage) then
                local buff_shadow_clone = Buff.find("ror", "shadowClone")
                for i=0, GM.get_buff_stack(actor, buff_shadow_clone) do
                    local attack = actor:fire_bullet(actor.x, actor.y+1, 1000, dir, damage, nil, sprSparks1, Attack_Info.TRACER.bandit3)
                    attack.attack_info.climb = i * 8
                end
            end
        end

        actor:sound_play(sndShoot1, 0.6, 1 + math.random() * 0.2)
        data.fired = 1
    end

	if actor.image_index2 >= gm.sprite_get_number(actor.sprite_index2) then
		actor:skill_util_reset_activity_state()
	end
end)
	
	-- makes the attack interrupt itself at extremely high attack speeds
	state_unmaker:onGetInterruptPriority(function(actor, data)
	if actor.image_index2 + 0.33 * actor.attack_speed >= gm.sprite_get_number(actor.sprite_index2)+1 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.any
	end
	if actor.image_index2 > 2 then
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period
	else
		return State.ACTOR_STATE_INTERRUPT_PRIORITY.priority_skill
	end
end)

	-- ALT SECONDARY --
	-- BY THE WAY DONT MIND THAT THE ALT SECONDARY COMES BEFORE THE DEFAULT SECONDARY ITS BECAUSE I MADE THIS ONE FIRST ---

    skill_star:set_skill_icon(sprSkills, 1)
    skill_star:set_skill_properties(2.4, 4 * 60)

    skill_star:onActivate(function(actor, skill, index)
        GM.actor_set_state(actor, state_star)
    end)


    state_star:onEnter(function(actor, data)
        actor.image_index = 0
        data.starshots = 3
		
		-- check for enemies and add them to targetCheckRectangle
		local targetCheckRectangle = List.new()
		actor:collision_rectangle_list(actor.x, actor.y - 800, actor.x + 800 * actor.image_xscale, actor.y + 100, gm.constants.pActorCollisionBase, false, true, targetCheckRectangle, true)
		actor:get_data().targetList = List.new() -- using actor:get_data() because we want to transfer the list to the onStep callback
		actor:get_data().targetList:clear()
		for _, enemy in ipairs(targetCheckRectangle) do
			if enemy.team ~= actor.team and GM.point_distance(actor.x, actor.y, enemy.x, enemy.y) < 800 then -- if an enemy is on the enemy team and the distance between the player and the enemy is less than 800, add them to actor:get_data().targetList
				actor:get_data().targetList:add(enemy)
			end
		end
		targetCheckRectangle:destroy()
    end)
    
    -- Implement the actual mechanics of the skill inside of the state, 
    state_star:onStep(function(actor, data)
        -- Fix the horizontal speed of the survivor (maybe when it switches states?)
        actor:skill_util_fix_hspeed()
        
        -- Get the animation from the skill and set it for this state with a custom speed
        actor:actor_animation_set(actor:actor_get_skill_animation(skill_star), 0.2)

        -- Check if we already fired and 
        -- if the animation is frame number is greater or equal to 4
        -- Used to fire only once per activation and at a specific frame
        if (data.starshots == 3 and actor.image_index >= 3.0) or (data.starshots == 2 and actor.image_index >= 4.0) or (data.starshots == 1 and (actor.image_index >= 5.0 or actor.image_index >= 4.9)) then
            local damage = actor:skill_get_damage(skill_star)
			local dir = actor:skill_util_facing_direction()
			local angle = 0
			local offset = 0
			local distance = 0
			if data.starshots == 2 and actor.image_index >= 4.0 then
				offset = 1
			elseif data.starshots == 1 and (actor.image_index >= 5.0 or actor.image_index >= 4.9) then
				offset = 2
			end
			
			local targetList = actor:get_data().targetList
			local target = nil
			-- first attack shoots at the nearest enemy, second attack shoots at the second nearest enemy, etc. if there is no second or third enemy, just shoot at the first one instead
			if targetList[#targetList - offset] == nil then
				target = targetList[#targetList]
			else
				target = targetList[#targetList - offset]
			end
			if target ~= nil then
				distance = GM.point_distance(actor.x, actor.y, target.x, target.y)
			end
			if target == nil then -- if there is not target, shoot into the air with an offset
				angle = dir + offset * 11.25 * actor.image_xscale
				parCyborgStar:set_direction(angle, angle, 0, 0)
				parCyborgStar:set_life(800 / 45 + 1, 800 / 45 + 1, 0, 0)
				parCyborgStar:create(actor.x, actor.y)
			else -- if there is a target, shoot at them
				angle = math.deg(GM.arctan2(actor.y - target.y, target.x - actor.x))
				if actor:is_authority() then
					parCyborgStar:set_direction(angle, angle, 0, 0)
					parCyborgStar:set_life(distance / 45 + 1, distance / 45 + 1, 0, 0)
					parCyborgStar:create(actor.x, actor.y)
					local buff_shadow_clone = Buff.find("ror", "shadowClone")
					for i=0, GM.get_buff_stack(actor, buff_shadow_clone) do
						local attack = actor:fire_direct(target, damage, angle, target.x, target.y)
						attack.attack_info:set_stun(1.5)
						attack.attack_info.climb = i * 8
					end
				end
			end

            actor:sound_play(sndShoot1, 0.7, 0.7 + math.random() * 0.2)
			data.starshots = data.starshots - 1
        end

        actor:skill_util_exit_state_on_anim_end()
    end)

	state_star:onExit(function(actor, data)
		actor:get_data().targetList:destroy()
	end)
	
	-- SECONDARY --
	
	skill_dash:set_skill_icon(sprSkills, 6) 
    skill_dash:set_skill_properties(1.8, 5 * 60)
	
	skill_dash:onActivate(function(actor, skill, index)
        GM.actor_set_state(actor, state_dash)
    end)
	
	state_dash:onEnter(function(actor, data)
        actor.image_index = 0
		local actorData = actor:get_data()
		actorData.cyborgLockOnList = List.new()
		actorData.cyborgLockOnList:clear()
		actor:sound_play(sndShoot2Alt, 1, 1 + math.random() * 0.2)
	end)
	
	state_dash:onStep(function(actor, data)
		local actorData = actor:get_data()
		actor.sprite_index = sprShoot2Alt
		actor.image_speed = 0.2
		
		actor.pHspeed = actor.pHmax * 3 * actor.image_xscale
		local collisions = List.new()
		if actor.image_index < 8.0 then
		actor:collision_rectangle_list(actor.x - 8, actor.y - 13, actor.x + 8, actor.y + 13, gm.constants.pActorCollisionBase, false, true, collisions, false) -- check for collisions while the skill is active
		for _, enemy in ipairs(collisions) do
			local enemyData = enemy:get_data()
			if enemy.team ~= actor.team and enemyData.LockedOn == nil then -- check if the enemy is not on the players team and that they havent already been locked on
				enemyData.LockedOn = 1 -- make them locked on
				actorData.cyborgLockOnList:add(enemy) -- add them to a new list
				actor:sound_play(sndMarkApply, 1, 1 + math.random() * 0.2)
				local mark = objMark:create(enemy.x, enemy.y) -- create the crosshair object
				mark:get_data().markedEnemy = enemy -- let the mark know which enemy it belongs to
				enemyData.cyborgMark = mark -- let the enemy know which mark is their
			end
		end
		end
		collisions:destroy()
		actor:skill_util_exit_state_on_anim_end()
	end)
	
	state_dash:onExit(function(actor, data)
		local actorData = actor:get_data()
		for _, enemy in ipairs(actorData.cyborgLockOnList) do -- for each enemy that has been locked on, run the code below
			local enemyData = enemy:get_data()
			if enemyData.LockedOn == 1 then -- make sure that theyre locked on just in case
				enemyData.LockedOn = nil -- set remove their lock on
				enemyData.cyborgMark:destroy() -- destroy the crosshair object
				actor:sound_play(sndMarkExplode, 0.8, 1 + math.random() * 0.2)
				local explosion = actor:fire_explosion(enemy.x, enemy.y, 50, 50, actor:skill_get_damage(skill_dash), sprMarkExplode)
			end
		end
		actorData.cyborgLockOnList:destroy()
	end)
	
    -- UTILITY --
	-- TODO UHHH THE HOLD TO CANCEL THING --
	-- I HOPE KRIS DOES THIS TBH I HAVE NO CLUE HOW TO DO THAT IM SORRY IM TOO STUPID AND WANT TO WORK ON NEMESIS SNIPER OR THOSE Alternate Skills --

    skill_recall:set_skill_icon(sprSkills, 2)
    skill_recall:set_skill_properties(0, 2 * 60)

    skill_recall:onActivate(function(actor, skill, index)
        GM.actor_set_state(actor, state_recall)
    end)
	
    state_recall:onEnter(function(actor, data)
        actor.image_index = 0
    end)
    
    state_recall:onStep(function(actor, data)
		if actor:get_data().teleAvailable == false then -- if there is no warp point available, run the code below
			actor.sprite_index = actor:actor_get_skill_animation(skill_recall)
			actor.image_speed = 0.25
			if actor.image_index >= 1.0 then
				actor:sound_play(sndShoot3, 1, 1 + math.random() * 0.2)
			end
			if actor.image_index >= 2.0 then
				actor:get_data().teleAvailable = true -- set the .teleAvailable to true
				actor:get_data().activeTele = objTeleport:create(actor.x, actor.y) -- create a warp point object
				actor:get_data().activeTele:get_data().parent = actor -- tell the warp point who created it
				actor:get_data().activeTele.image_xscale = actor.image_xscale
				parCyborgTele:create(actor.x + math.random(-4,4), actor.y + math.random(0,4), 4)
				
				-- set the skill to "teleport to the warp point"
				local skill = actor:get_active_skill(Skill.SLOT.utility)
				skill.name = "skill.recall.name"
				skill.description = "skill.recall.description"
				skill.sprite = sprSkills
				skill.subimage = 3
				skill.cooldown_base = 6 * 60
				gm._mod_ActorSkill_recalculateStats(skill)
			end
		else -- if there is a warp point available, run the code below
			actor:skill_util_fix_hspeed()
			actor.sprite_index = sprShoot3B
			actor.image_speed = 0.25
			if actor.invincible < 3 then -- set the invulnerability
				actor.invincible = 3
			end
			if actor.image_index >= 1.0 then
				actor:sound_play(sndShoot3B, 1, 1 + math.random() * 0.2)
				parCyborgTele:create(actor.x + math.random(-4,4), actor.y + math.random(0,4), 1)
			end
			if actor.image_index >= 5.0 then
				-- reduce the skill cooldowns by 2 seconds
				actor:override_active_skill_cooldown(Skill.SLOT.secondary, math.max(actor:get_active_skill(Skill.SLOT.secondary).cooldown - 2 * 60, 1))
				actor:override_active_skill_cooldown(Skill.SLOT.special, math.max(actor:get_active_skill(Skill.SLOT.special).cooldown - 2 * 60, 1))
				actor:get_data().teleAvailable = false -- set the .teleAvailable to false
				if actor:get_data().activeTele:exists() then -- check if a warp point exists just in case
					-- set the players coords to the warp points coords
					actor.x = actor:get_data().activeTele.x
					actor.y = actor:get_data().activeTele.y
					-- ghost.x and ghost.y are used for multiplayer shena sheni shenana FUCKERY theyre used for multiplayer fuckery ok?
					actor.ghost_x = actor:get_data().activeTele.ghost_x
					actor.ghost_y = actor:get_data().activeTele.ghost_y
					actor.free = 1
					parCyborgTele:create(actor.x + math.random(-4,4), actor.y + math.random(0,4), 1)
					actor:get_data().activeTele:destroy() -- destroy the warp point object
				end
				
				-- set the skill to "create a warp point"
				local skill = actor:get_active_skill(Skill.SLOT.utility)
				skill.name = "skill.recall_point.name"
				skill.description = "skill.recall_point.description"
				skill.sprite = sprSkills
				skill.subimage = 2
				skill.cooldown_base = 2 * 60
				gm._mod_ActorSkill_recalculateStats(skill)
			end
		end
			actor:skill_util_exit_state_on_anim_end()
    end)

	-- SPECIAL --

    skill_redress:set_skill_icon(sprSkills, 4)
    skill_redress:set_skill_properties(4, 6 * 60)

    skill_redress:onActivate(function(actor, skill, index)
        GM.actor_set_state(actor, state_redress)
    end)

    state_redress:onEnter(function(actor, data)
        actor.image_index = 0
		data.fired = 0
    end)
    
    state_redress:onStep(function(actor, data)
        
        actor:actor_animation_set(actor:actor_get_skill_animation(skill_redress.value), 0.25)

        if actor.image_index >= 4.0 and data.fired == 0 then
			actor:screen_shake(5) -- causes minor screenshake
			data.fired = 1
            local bullet = objBullet:create(actor.x, actor.y) -- create the projectile
			bullet:get_data().parent = actor -- tell the projectile who created it
			actor.pVspeed = actor.pVmax * -0.6 -- apply vertical knockback
			actor.pHspeed = actor.pHmax * -3 * actor.image_xscale -- apply horizontal knockback
            actor:sound_play(sndShoot4, 1, 1 + math.random() * 0.2)
			if actor:item_stack_count(Item.find("ror", "ancientScepter")) > 0 then -- if the player has an ancient scepter, make the scale with the amount they have
				bullet.image_yscale = 1 + 0.5 * actor:item_stack_count(Item.find("ror", "ancientScepter"))
				bullet.image_xscale = 1 + 0.2 * actor:item_stack_count(Item.find("ror", "ancientScepter"))
				bullet:get_data().rate = bullet:get_data().rate * (1 + 0.5 * (actor:item_stack_count(Item.find("ror", "ancientScepter")) - 1)) -- also update .rate so the bullet lasts longer
			end
			bullet.image_xscale = bullet.image_xscale * actor.image_xscale
        end
        
        actor:skill_util_exit_state_on_anim_end()
    end)

	-- UPGRADED SPECIAL --

    skill_redressScepter:set_skill_icon(sprSkills, 5)
    skill_redressScepter:set_skill_properties(6.5, 6 * 60)

    skill_redressScepter:onActivate(function(actor, skill, index)
        GM.actor_set_state(actor, state_redress) -- since all the necessary tweaks related to ancient scepter are done inside the original specials state code, set the state to be the same one
		-- (btw wouldnt recommend doing this, this is just like an exception cuz its easier that way)
    end)
