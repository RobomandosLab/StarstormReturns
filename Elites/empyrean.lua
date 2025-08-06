-- ugh ..... ugmhgg .... it appreas it is me azuline again .....
-- this elite is gay af.... just like me ... so it was only appropriate that i would do it ....

local SPRITE_PATH = path.combine(PATH, "Sprites/Elites/Empyrean")
local SOUND_PATH = path.combine(PATH, "Sounds/Elites/Empyrean")

local sprite_icon = Resources.sprite_load(NAMESPACE, "EliteIconEmpyrean", path.combine(SPRITE_PATH, "icon.png"), 1, 24, 15)
local splash_sprite = Resources.sprite_load(NAMESPACE, "ParticleEmpyreanSpawnSplash", path.combine(SPRITE_PATH, "splash.png"), 6)
local beam_sprite = Resources.sprite_load(NAMESPACE, "ParticleEmpyreanSpawnBeam", path.combine(SPRITE_PATH, "beam.png"), 11)
local star_sprite = Resources.sprite_load(NAMESPACE, "EmpyreanWormStar", path.combine(SPRITE_PATH, "star.png"), 8, 16, 16)

local gotanythingsharp = Resources.sfx_load(NAMESPACE, "EmpyreanSpawn", path.combine(SOUND_PATH, "beam.ogg"))

local empy = Elite.new(NAMESPACE, "empyrean")
empy.healthbar_icon = sprite_icon
empy.palette = gm.constants.sElitePaletteDummy
empy.blend_col = Color.WHITE

GM.elite_generate_palettes()

local evil = Particle.new(NAMESPACE, "EmpyreanSpawnEvil")
evil:set_sprite(splash_sprite, true, true, false)
evil:set_life(15, 30)

local beam = Particle.new(NAMESPACE, "EmpyreanSpawnBeam")
beam:set_direction(270, 270, 0, 0)
beam:set_speed(8, 8, 0, 0)
beam:set_sprite(beam_sprite, true, true, false)
beam:set_life(10, 10)

local splash = Particle.new(NAMESPACE, "EmpyreanSpawnSplash")
splash:set_sprite(splash_sprite, true, true, false)
splash:set_scale(1.5, 1.5)
splash:set_life(15, 30)

local rainbowspark = Particle.new(NAMESPACE, "EmpyreanRainbowSpark")
rainbowspark:set_shape(Particle.SHAPE.line)
rainbowspark:set_blend(true)
rainbowspark:set_alpha3(1, 1, 0)
rainbowspark:set_size(0, 1, 0, 0.01)
rainbowspark:set_orientation(0, 0, 0, 0, true)
rainbowspark:set_speed(0, 4, -0.04, 0.2)
rainbowspark:set_direction(0, 180, 0, 10)
rainbowspark:set_scale(0.1, 0.1)
rainbowspark:set_life(20, 100)

local teleport = Particle.new(NAMESPACE, "EmpyreanTeleport")
teleport:set_shape(Particle.SHAPE.star)
teleport:set_alpha3(0.75, 0.75, 0)
teleport:set_color2(Color.WHITE, Color.WHITE)
teleport:set_orientation(0, 0, 0, 0, true)
teleport:set_speed(0, 3, -0.03, 0.05)
teleport:set_direction(0, 360, 0, 10)
teleport:set_scale(0.1, 0.1)
teleport:set_life(20, 100)

local telegraph = Particle.new(NAMESPACE, "EmpyreanStarTelegraph")
telegraph:set_shape(Particle.SHAPE.disk)
telegraph:set_alpha2(0.6, 0)
telegraph:set_blend(true)
telegraph:set_speed(6, 6, 0, 0)
telegraph:set_scale(0.1, 0.1)
telegraph:set_life(120, 120)

local empyorb = Item.new(NAMESPACE, "eliteOrbEmpyrean", true)
empyorb.is_hidden = true

local teleorb = Item.new(NAMESPACE, "elitePassiveTeleportEmpyrean", true)
teleorb.is_hidden = true

-- PUT ASPECTS HERE --
-- format is {"namespace-identifier", stack}
local aspects = {
	-- VANILLA --
	
	-- volatile
	{"ror-eliteOrbExplosiveShot", 2},
	{"ror-elitePassiveVolatile", 1},
	
	-- overloading
	{"ror-eliteOrbLightning", 1},
	{"ror-elitePassiveOverloading", 1},
	
	-- leeching
	{"ror-elitePassiveLeeching", 1},
	{"ror-eliteOrbLifesteal", 7},
	
	-- frenzied (minus their teleporting orb)
	{"ror-eliteOrbAttackSpeed", 3},
	{"ror-eliteOrbMoveSpeed", 5},
	
	-- blazing
	{"ror-eliteOrbFireTrail", 5},
	
	
	
	-- STARSTORM --
	
	-- poison
	{"ssr-eliteOrbPoison", 1}
}
function ssr_give_empyrean_aspects(actor)
	for _, aspect in ipairs(aspects) do
		local item = Item.find(aspect[1])
		
		-- if the elite already has these orbs, remove them
		if actor:item_stack_count(item) > 0 then
			actor:item_remove(item, actor:item_stack_count(item))
		end
 		
		-- give the orbs
		actor:item_give(item, aspect[2])
	end
	
	for id, stack in ipairs(actor.inventory_item_stack) do
		if stack > 0 then
			local item = Item.wrap(id - 1) -- subtract by one cuz lua tables start at 1 instead of 0
		end
	end
end

empy:clear_callbacks()
empy:onApply(function(actor)
	actor:item_give(empyorb) -- applies most empyrean effects
	actor:item_give(teleorb) -- makes it teleport to the player from any location
	
	-- stat changes are multiplicative with normal elite stat changes
	-- so max hp for example will be base * 12 * 2.8 = 33.6x total multiplier
	
	-- giga health
	actor.maxhp_base = actor.maxhp_base * 12
	actor.hp = actor.maxhp
	
	-- giga gold and exp
	if actor.exp_worth then
		actor.exp_worth = actor.exp_worth * 30 -- totals to 60x
	end
	
	-- immune to stun, knockback and fall damage
	actor.knockback_immune = true
	actor.stun_immune = true
	actor.fall_immune = true
	
	-- make maxhp_base modification take effect
	GM.actor_queue_dirty(actor) 
end)

empyorb:clear_callbacks()
empyorb:onAcquire(function(actor, stack)
	-- move the actor to the ground
	actor:move_contact_solid(270, -1)
	
	-- apply screenshake
	actor:screen_shake(4)
	
	-- play the spawn sound
	actor:sound_play(gotanythingsharp, 2, 1)
	
	-- start the beam
	if gm.inside_view(actor.x, actor.y) == 1 then
		actor:get_data().empy_beam = 180
		actor:get_data().empy_beam_over = 0
	else
		actor:get_data().empy_beam = 0
		actor:get_data().empy_beam_over = 1
		actor:get_data().no_beam_loser = 5
		
		-- give them all elite aspects
		ssr_give_empyrean_aspects(actor)
	end
	
	-- remove the passive teleport orb since empyreans have a custom one
	if actor:item_stack_count(Item.find("ror-elitePassiveTeleport")) > 0 then 
		actor:item_remove(Item.find("ror-elitePassiveTeleport"), actor:item_stack_count(Item.find("ror-elitePassiveTeleport")))
	end
end)

empyorb:onPostDraw(function(actor, stack)
	if actor:get_data().empy_beam and actor:get_data().empy_beam_over then
		if actor:get_data().empy_beam > 0 and actor:get_data().empy_beam_over == 0 then
			local width = gm.sprite_get_width(actor.mask_index) / 2 + 32
			local part_width = gm.round((((actor.x - actor.bbox_left) + (actor.bbox_right - actor.x)) / 2) * 1.5)
			local part_height = gm.round(((actor.y - actor.bbox_top) + (actor.bbox_bottom - actor.y)) / 2)
			local silhouette_y = actor.y - 16 - (16 * math.sin(gm.degtorad(270 + actor:get_data().empy_beam * 2)))

			if actor:get_data().empy_beam <= 10 then
				width = width * (1000 - (10 - actor:get_data().empy_beam) ^ 3) / 1000 -- make the beam shrink when its lifetime ends
			elseif actor:get_data().empy_beam > 168 then
				width = width * ((180 - actor:get_data().empy_beam) ^ 3) / 1000 -- make the beam widen when it appears
			elseif actor:get_data().empy_beam > 165 then
				width = width * (1.3 - ((169 - actor:get_data().empy_beam) / 10)) -- make the beam shrink back to its normal size after it widens
			else
				if math.random() >= 0.5 then
					-- create the black particles around the enemy
					evil:create_color(actor.x + math.random(-part_width, part_width), silhouette_y - part_height / 2 - math.random(part_height), Color.BLACK, 1, Particle.SYSTEM.middle)
					
					-- create the beam splashing particles
					local side = 1
					if math.random() >= 0.5 then
						side = -1
					end
					local ori = 180 + math.random(-45, 45) - 45 * side
					splash:set_orientation(ori, ori, 0, 0, false)
					splash:create_color(actor.x + (width + math.random(3)) * side, actor.bbox_bottom, Color.from_hsv(Global._current_frame % 360, 100, 100), 1, Particle.SYSTEM.middle)
				end
			end
			
			if actor:get_data().empy_beam > 15 and actor:get_data().empy_beam <= 170 then
				-- create the beam particles that touch the ground
				beam:create_color(actor.x - width - math.random(3), actor.bbox_bottom - 88, Color.from_hsv(Global._current_frame % 360, 100, 100), 1, Particle.SYSTEM.middle)
				beam:create_color(actor.x + width + math.random(3), actor.bbox_bottom - 88, Color.from_hsv(Global._current_frame % 360, 100, 100), 1, Particle.SYSTEM.middle)
				
				-- create the beam particles around the beam
				for i = 1, 22 do
					local rnd = math.random(80, 1728)
					if gm.inside_view(actor.x, actor.y - rnd) == 1 then
						beam:create_color(actor.x - width - math.random(3), actor.bbox_bottom - math.random(88, 1152), Color.from_hsv(Global._current_frame % 360, 100, 100), 1, Particle.SYSTEM.middle)
						beam:create_color(actor.x + width + math.random(3), actor.bbox_bottom - math.random(88, 1152), Color.from_hsv(Global._current_frame % 360, 100, 100), 1, Particle.SYSTEM.middle)
					end
				end
			end
			
			-- draw the beam
			if actor:get_data()._imalpha then
				gm.draw_set_alpha(actor:get_data()._imalpha)
			else
				gm.draw_set_alpha(1)
			end
			gm.draw_set_color(Color.WHITE)
			gm.draw_rectangle(actor.x - width, 0, actor.x + width, actor.bbox_bottom, false)
			
			-- make it black and move
			gm.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x, silhouette_y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.BLACK, math.min(1, ((180 - actor:get_data().empy_beam) ^ 3) / 1000))
			gm.draw_set_alpha(1)
		else
			-- make it rainbow
			if actor.object_index ~= gm.constants.oWorm then
				gm.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x, actor.y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.from_hsv(Global._current_frame % 360, 100, 100), actor.image_alpha)
			end
		end
	end
end)

-- dont draw the healthbar while the beam is there
gm.pre_script_hook(gm.constants.draw_hp_bar, function(self, other, result, args)
	if Wrap.wrap(self):get_data().empy_beam then
		if Wrap.wrap(self):get_data().empy_beam > 0 then
			return false
		end
	end
end)

local guarded = false

-- disable fall damage for the elite to prevent cheese
gm.pre_script_hook(gm.constants.actor_phy_on_landed, function(self, other, result, args)
    local real_self = Instance.wrap(self)
    if not gm.bool(self.invincible) and real_self.fall_immune == true then
        self.invincible = 1
        guarded = true
    end
end)

gm.post_script_hook(gm.constants.actor_phy_on_landed, function(self, other, result, args)
    if guarded then
        self.invincible = 0
        guarded = false
    end
end)

empyorb:onPostStep(function(actor, stack)
	if actor:get_data().empy_beam > 0 and actor:get_data().empy_beam_over == 0 then -- freeze the enemy
		-- store the enemy's certain stats so we can restore it later
		if not actor:get_data()._hmax then
			actor:get_data()._hmax = actor.pHmax
			actor:get_data()._vmax = actor.pVmax
			actor:get_data()._imspeed = actor.image_speed
			actor:get_data()._imalpha = actor.image_alpha
			actor:get_data()._intang = actor.intangible
		end
		
		-- make it not move
		actor.image_speed = 0.25
		actor.image_alpha = 0
		actor.pHmax = 0
		actor.pVmax = 0
		actor.intangible = true
		actor.activity = 50
		actor.__activity_handler_state = 50
		actor.state = 0
		
		-- smoother transition
		if actor:get_data()._imalpha then
			actor.image_alpha = actor:get_data()._imalpha * (10 - actor:get_data().empy_beam) / 10
		else
			actor.image_alpha = (10 - actor:get_data().empy_beam) / 10
		end
		
		-- (duke nukem voice) shake it baby
		actor:screen_shake(0.5)
		
		-- make it look like its floating
		if actor.sprite_fall then
			actor.sprite_index = actor.sprite_fall
		elseif actor.sprite_idle then
			actor.sprite_index = actor.sprite_idle
		end
		
		actor:get_data().empy_beam = actor:get_data().empy_beam - 1
	elseif actor:get_data().empy_beam_over == 0 and actor:get_data().empy_beam <= 0 then -- unfreeze the enemy
		actor:get_data().empy_beam_over = 1
		
		-- restore their speed
		actor.pHmax = actor:get_data()._hmax
		actor.pVmax = actor:get_data()._vmax
		actor.image_speed = actor:get_data()._imspeed
		actor.image_alpha = actor:get_data()._imalpha
		actor.intangible = actor:get_data()._intang
		
		--remove all the temporary variables
		actor:get_data()._hmax = nil
		actor:get_data()._vmax = nil
		actor:get_data()._imspeed = nil
		actor:get_data()._imalpha = nil
		actor:get_data()._intang = nil
		
		-- give them all elite aspects
		ssr_give_empyrean_aspects(actor)
		
		-- make the boss bar appear
		if actor.team ~= 1 and GM._mod_net_isHost() then
			local arr = Array.new({actor})
			local party = GM.actor_create_enemy_party_from_ids(arr)
			local director = GM._mod_game_getDirector()
			director:register_boss_party_gml_Object_oDirectorControl_Create_0(party)
		end
		
		-- make them move again !! yippie!!
		actor.state = 1
		actor:skill_util_reset_activity_state()
	end
	
	if actor:get_data().no_beam_loser and gm._mod_net_isHost() then
		if actor:get_data().no_beam_loser > 0 then -- wait 5 frames before adding empyreans that didnt play the animation to the boss party (prevents issues with max hp being fucked up on the boss bar)
			actor:get_data().no_beam_loser = actor:get_data().no_beam_loser - 1
		else
			actor:get_data().no_beam_loser = nil
			if actor.team ~= 1 then -- make the boss bar appear
				local arr = Array.new({actor})
				local party = GM.actor_create_enemy_party_from_ids(arr)
				local director = GM._mod_game_getDirector()
				director:register_boss_party_gml_Object_oDirectorControl_Create_0(party)
			end
		end
	end
	
	if gm.inside_view(actor.x, actor.y) == 1 and actor:get_data().empy_beam_over == 1 and actor:get_data().empy_beam <= 0 and Global._current_frame % 2 == 0 then
		rainbowspark:create_color(actor.x, actor.y, Color.from_hsv((Global._current_frame + actor.y * (0.75)) % 360, 100, 100), 1, Particle.SYSTEM.below)
	end
	
	if actor.object_index == gm.constants.oWorm or actor.object_index == gm.constants.oJellyG or actor.object_index == gm.constants.oJellyG2 then
		actor.image_blend = Color.from_hsv(Global._current_frame % 360, 65, 100)
	end
end)

empyorb:onPostStatRecalc(function(actor)
	-- giga damage
	if actor.elite_type then
		if actor.elite_type == empy.value then
			actor.damage = actor.damage * (5.4 / 1.9) -- totals to 5.4x
			actor.cdr = actor.cdr * (0.5 / 0.3) -- totals to 50%
		end
	end
end)

teleorb:clear_callbacks()
teleorb:onAcquire(function(actor, stack)
	actor:get_data().empyrean_teleport = 480 + math.random(240)
end)

teleorb:onPostStep(function(actor, stack)
	if GM.actor_is_classic(actor) then
		if actor:get_data().empyrean_teleport > 0 then
			actor:get_data().empyrean_teleport = actor:get_data().empyrean_teleport - 1
		elseif not gm.actor_state_is_climb_state(actor.actor_state_current_id) then
			local targets = Instance.find_all(gm.constants.oP)
			local target_fin = nil
			
			-- go through all players and find one that is grounded and not climbing
			for _, target in ipairs(targets) do
				if not gm.bool(target.free) and not gm.actor_state_is_climb_state(target.actor_state_current_id) and gm.point_distance(actor.x, actor.y, target.x, target.y) > 200 and not target.dead then
					target_fin = target
					break
				end
			end
			
			-- disable skills for a second to prevent unfair deaths
			if gm._mod_net_isHost() then
				for i = 0, 3 do
					local skill = actor:get_active_skill(i)
					skill.use_next_frame = math.max(skill.use_next_frame, Global._current_frame + 60)
				end
			end
			
			-- teleport!
			if target_fin then
				if gm._mod_net_isHost() then
					gm.teleport_nearby(actor.id, target_fin.x - (80 + math.random(20)) * gm.sign(target_fin.pHspeed), target_fin.y) -- teleport to this fool
					actor:net_send_instance_message(25)
					
					actor.ghost_x = actor.x
					actor.ghost_y = actor.y
					actor.pVspeed = 0
					actor.pHspeed = 0
					actor.ai_tick_rate = 1
				end
				
				actor:get_data().empyrean_teleport = 480 + math.random(240)
				
				-- create some effects so you know youre about to die
				local circle = GM.instance_create(actor.x, actor.y, gm.constants.oEfCircle)
				circle.parent = actor
				circle.radius = gm.round((((actor.x - actor.bbox_left) + (actor.bbox_right - actor.x) + (actor.y - actor.bbox_top) + (actor.bbox_bottom - actor.y)) / 4) * 1.5 )
				
				local flash = GM.instance_create(actor.x, actor.y, gm.constants.oEfFlash)
				flash.parent = actor
				flash.rate = 0.02
				flash.image_alpha = 1
				
				for i = 1, 36 do
					teleport:set_direction(10 * i, 10 * i, 0, 10)
					teleport:set_color2(Color.WHITE, gm.round(math.random(360)))
					teleport:create(actor.x, actor.y, 1, Particle.SYSTEM.middle)
				end
				
				actor:sound_play(gm.constants.wMS, 1, 0.8 + math.random() * 0.2)
				actor:sound_play(gm.constants.wBoss1DeathWarp, 1, 0.8 + math.random() * 0.2)
			end
		end
	end
end)

-- empyrean worms !!!
-- make the worm bodies rainbow too and also make them create sparks
gm.pre_code_execute("gml_Object_oWormBody_Step_2", function(self, other)
	if self.parent.elite_type == empy.value then
		self.image_blend = Color.from_hsv((Global._current_frame + (self.m_id - self.parent.m_id) * 18) % 360, 65, 100)
		
		if gm.inside_view(self.x, self.y) == 1 and Global._current_frame % 2 == 0 then
			rainbowspark:create_color(self.x, self.y, Color.from_hsv((Global._current_frame + self.y * (0.75)) % 360, 100, 100), 1, Particle.SYSTEM.middle)
		end
	end
end)

-- make the worm bodies set their first alarm (needed to shoot the orbs)
gm.pre_code_execute("gml_Object_oWorm_Alarm_4", function(self, other)
	if self.elite_type == empy.value then
		for _, segment in ipairs(self.body) do
			segment:alarm_set(1, 150 + (segment.m_id - self.m_id) * 2)
		end
	end
end)

-- special empyrean worm projectile
local oStarStorm = Object.new(NAMESPACE, "EmpyreanWormStar")
oStarStorm.obj_sprite = star_sprite
oStarStorm:clear_callbacks()

oStarStorm:onCreate(function(self)
	self.life = 600
	self.damage = 1
	self.targetX = 0
	self.targetY = 0
	self.team = 2
	self.image_speed = 0.4
	self.image_alpha = 0.75
	self.direction = 0
	self.speed = 0
	
	self:sound_play(gm.constants.wMedallion, 1, 0.8 + math.random() * 0.2)
	self:sound_play(gm.constants.wJellyHit, 1, 0.8 + math.random() * 0.2)
end)

oStarStorm:onDraw(function(self)
	gm.draw_set_alpha(0.4)
	gm.draw_circle_colour(self.x, self.y, 20, self.image_blend, self.image_blend, false)
	gm.draw_set_alpha(1)
end)

oStarStorm:onStep(function(self)
	if self.life > 0 then
		self.life = self.life - 1
	else
		self:destroy()
	end
	
	if not self.spawn_speed then
		self.spawn_speed = self.speed
	end
	
	if self.life >= 570 then -- do this for the first 30 frames after spawning
		self.speed = self.speed - self.spawn_speed / 30
	elseif self.life == 481 then -- make it idle for a second and a half, then >>
		local flash = GM.instance_create(self.x, self.y, gm.constants.oEfFlash) -- >> make it flash
		flash.parent = self
		flash.rate = 0.03
		flash.image_alpha = 0.6
		
		self:sound_play(gm.constants.wItemDrop_White, 0.8, 0.8 + math.random() * 0.2) -- >> play these sounds
		self:sound_play(gm.constants.wLizardR_Spear_2, 0.8, 1.2 + math.random() * 0.4)
		self:sound_play(gm.constants.wBossOrbShoot, 0.5, 1.2 + math.random() * 0.4)
		
		self.direction = gm.point_direction(self.x, self.y, self.targetX, self.targetY) -- >> make it aim at the player
	elseif self.life >= 480 then -- while idling, create telegraph particles
		if self.life % 8 == 0 then
			telegraph:set_direction(gm.point_direction(self.x, self.y, self.targetX, self.targetY), gm.point_direction(self.x, self.y, self.targetX, self.targetY), 0, 0)
			telegraph:create_color(self.x, self.y, self.image_blend, 1)
		end
	elseif self.life >= 470 then -- once were done idling, descrease its speed to create a wind up effect for 10 frames
		self.speed = self.speed - 0.4
	else
		self.speed = math.min(30, self.speed + 0.6) -- then start increasing its speed for the rest of the duration
		
		if self.life % 2 == 0 then -- create trails cuz theyre cool
			local trail = GM.instance_create(self.x, self.y, gm.constants.oEfTrail)
			trail.sprite_index = self.sprite_index
			trail.image_index = self.image_index
			trail.image_blend = self.image_blend
			trail.image_alpha = self.image_alpha
			trail.image_xscale = self.image_xscale
			trail.image_yscale = self.image_yscale
			trail.direction = self.direction
			trail.speed = self.speed * 0.75
			trail.depth = self.depth + 1
		end
		
		for _, actor in ipairs(self:get_collisions(gm.constants.pActorCollisionBase)) do -- make it deal damage if it hits the opposite team
			if self:attack_collision_canhit(actor) and Instance.exists(self.parent) then
				if gm._mod_net_isHost() then
					local attack = self.parent:fire_direct(actor, self.damage / self.parent.damage)
				end

				self:sound_play(gm.constants.wExplosiveShot, 1, 0.8 + math.random() * 0.2)
				self:destroy()
			end
		end
	end
	
	if gm.inside_view(self.x, self.y) == 1 and self.life % 3 == 0 then
		rainbowspark:create_color(self.x, self.y, self.image_blend, 1, Particle.SYSTEM.middle)
	end
end)

-- make the worm shoot the star storm
gm.pre_code_execute("gml_Object_oWormBody_Alarm_1", function(self, other)
	if self.parent.elite_type == empy.value then
		self:alarm_set(1, 330)
	
		if self.parent.target then
			local star = oStarStorm:create(self.x, self.y)
			star.parent = self.parent
			star.team = self.parent.team
			star.targetX = self.parent.target.x
			star.targetY = self.parent.target.y
			star.damage = self.parent.damage * 0.07
			if Helper.chance(0.5) then
				star.direction = self.image_angle - 90 + math.random(-45, 45)
			else
				star.direction = self.image_angle + 90 + math.random(-45, 45)
			end
			star.speed = math.random(4, 8)
			star.image_blend = self.image_blend
		end
	end
end)

-- make the warning change color
gm.pre_code_execute("gml_Object_oWormWarning_Step_0", function(self, other)
	if self.image_blend == Color.from_hsv((Global._current_frame - 1) % 360, 65, 100) then -- check what color it was on the previous frame
		self.image_blend = Color.from_hsv(Global._current_frame % 360, 65, 100)
	end
end)

local blacklist = {
	["lemrider"] = true, -- the spawn anim breaks since its 2 of them at once, also doesnt actually do most elite effects
	["bramble"] = true, -- requires major fixes that im not sure are even possible
 	["spitter"] = true, -- technically fully works but FUCK no
}

local whitelist = {
	["jellyfish"] = true,
	["magmaWorm"] = true,
	["swift"] = true, -- lmao cope
	["archerBug"] = true,
	["colossus"] = true,
	["ancientWisp"] = true,
	["ifrit"] = true,
	["wanderingVagrant"] = true,
	["youngVagrant"] = true,
}

Callback.add(Callback.TYPE.onGameStart, "SSResetEmpyreanChance", function()
	GM._mod_game_getDirector().__ssr_empyrean_chance = 0.02 -- higher chance so you see your first empyrean sooner
end)

Callback.add(Callback.TYPE.onEliteInit, "SSSpawnEmpyrean", function(actor)
	if GM._mod_game_getDirector().stages_passed < 8 then return end -- only spawns if its stage 9+
	if not GM._mod_net_isHost() then return end
	
	if actor.elite_type ~= empy.value then -- if the actor is not already empyrean
		local all_monster_cards = Monster_Card.find_all()
		local chance = GM._mod_game_getDirector().__ssr_empyrean_chance -- a value from 0 to 1
		local diff = math.max(1, (GM._mod_game_getDirector().enemy_buff - 16) / 4)
		for i, card in ipairs(all_monster_cards) do
			if card.object_id == actor.object_index then -- if the actor has a monster card
				if not blacklist[card.identifier] and (card.can_be_blighted == true or whitelist[card.identifier]) then -- if the actor is not blacklisted and can be blighted or is in the whitelist
					local cost = math.min(4, math.max(1, card.spawn_cost / 40 * diff))
					if Helper.chance(chance / cost) then
						GM.elite_set(actor, empy.value) -- make it empyrean
						GM._mod_game_getDirector().__ssr_empyrean_chance = 0.005 * diff -- reset the chance
					else
						GM._mod_game_getDirector().__ssr_empyrean_chance = GM._mod_game_getDirector().__ssr_empyrean_chance + 0.002 * diff -- increase the chance on fail
					end
					break
				end
			end
		end
	end
end)