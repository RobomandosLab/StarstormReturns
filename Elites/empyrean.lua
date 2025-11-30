-- ugh ..... ugmhgg .... it appreas it is me azuline again .....
-- this elite is gay af.... just like me ... so it was only appropriate that i would do it ....

local SPRITE_PATH = path.combine(PATH, "Sprites/Elites/Empyrean")
local SOUND_PATH = path.combine(PATH, "Sounds/Elites/Empyrean")

local sprite_icon = Sprite.new("EliteIconEmpyrean", path.combine(SPRITE_PATH, "icon.png"), 1, 25, 22)
local particle_sprite = Sprite.new("ParticleEmpyreanSpawnParticle", path.combine(SPRITE_PATH, "particle.png"), 6)
local sprite_beam = Sprite.new("EmpyreanBeam", path.combine(SPRITE_PATH, "beam.png"), 4, 0, 176)
local sprite_splash = Sprite.new("EmpyreanBeamSplash", path.combine(SPRITE_PATH, "splash.png"), 4, 0, 50)
local star_sprite = Sprite.new("EmpyreanWormStar", path.combine(SPRITE_PATH, "star.png"), 8, 16, 16)
local star_small_sprite = Sprite.new("EmpyreanWormStarSmall", path.combine(SPRITE_PATH, "star_small.png"), 1, 3, 2)

GM.elite_generate_palettes()

local gotanythingsharp = Sound.new("EmpyreanSpawn", path.combine(SOUND_PATH, "beam.ogg"))
local sound_spawn = Sound.new("EmpyreanSpawnShort", path.combine(SOUND_PATH, "spawn.ogg"))
local sound_spawn_alt = Sound.new("EmpyreanSpawnShortAlt", path.combine(SOUND_PATH, "spawn_alt.ogg"))
local sound_spawn_worm = Sound.new("EmpyreanSpawnWorm", path.combine(SOUND_PATH, "spawn_worm.ogg"))
local sound_star_spawn = Sound.new("EmpyreanStarSpawn", path.combine(SOUND_PATH, "star_spawn.ogg"))
local sound_star_shoot = Sound.new("EmpyreanStarShoot", path.combine(SOUND_PATH, "star_shoot.ogg"))
local sound_teleport1 = Sound.new("EmpyreanTeleport1", path.combine(SOUND_PATH, "teleport1.ogg"))
local sound_teleport2 = Sound.new("EmpyreanTeleport2", path.combine(SOUND_PATH, "teleport2.ogg"))
local sound_teleport3 = Sound.new("EmpyreanTeleport3", path.combine(SOUND_PATH, "teleport3.ogg"))

local empy = ssr_create_elite("empyrean")
empy.healthbar_icon = sprite_icon
empy.palette = gm.constants.sElitePaletteDummy
empy.blend_col = Color.WHITE

local evil = Particle.new("EmpyreanSpawnEvil")
evil:set_sprite(particle_sprite, true, true, false)
evil:set_life(15, 30)

local rainbowspark = Particle.new("EmpyreanRainbowSpark")
rainbowspark:set_shape(Particle.Shape.LINE)
rainbowspark:set_blend(true)
rainbowspark:set_alpha3(1, 1, 0)
rainbowspark:set_size(0, 1, 0, 0.01)
rainbowspark:set_orientation(0, 0, 0, 0, true)
rainbowspark:set_speed(0, 4, -0.04, 0.2)
rainbowspark:set_direction(0, 180, 0, 10)
rainbowspark:set_scale(0.1, 0.1)
rainbowspark:set_life(20, 100)

local teleport = Particle.new("EmpyreanTeleport")
teleport:set_sprite(star_small_sprite, true, true, false)
teleport:set_alpha3(0.75, 0.75, 0)
teleport:set_color2(Color.WHITE, Color.WHITE)
teleport:set_orientation(0, 0, 0, 0, true)
teleport:set_speed(1, 3, -0.03, 0.05)
teleport:set_direction(0, 360, 0, 10)
teleport:set_life(20, 100)

local empyorb = Item.new("eliteOrbEmpyrean")
empyorb.is_hidden = true

local teleorb = Item.new("elitePassiveTeleportEmpyrean")
teleorb.is_hidden = true

-- PUT ASPECTS HERE --
-- format is {"identifier", "namespace", stack}
local aspects = {
	-- VANILLA --
	
	-- volatile
	{"eliteOrbExplosiveShot", "ror", 2},
	{"elitePassiveVolatile", "ror", 1},
	
	-- overloading
	{"eliteOrbLightning", "ror", 1},
	{"elitePassiveOverloading", "ror", 1},
	
	-- leeching
	{"elitePassiveLeeching", "ror", 1},
	{"eliteOrbLifesteal", "ror", 7},
	
	-- frenzied (minus their teleporting orb)
	{"eliteOrbAttackSpeed", "ror", 3},
	{"eliteOrbMoveSpeed", "ror", 5},
	
	-- blazing
	{"eliteOrbFireTrail", "ror", 5},
	
	
	
	-- STARSTORM --
	
	-- poison
	{"eliteOrbPoison", "ssr", 1}
}
function ssr_give_empyrean_aspects(actor)
	for _, aspect in ipairs(aspects) do
		local item = Item.find(aspect[1], aspect[2])
		
		-- if the elite already has these orbs, remove them
		if actor:item_count(item) > 0 then
			actor:item_take(item, actor:item_count(item))
		end
 		
		-- give the orbs
		actor:item_give(item, aspect[3])
	end
	
	for id, stack in ipairs(actor.inventory_item_stack) do
		if stack > 0 then
			local item = Item.wrap(id - 1) -- subtract by one cuz lua tables start at 1 instead of 0
		end
	end
end

Callback.add(empy.on_apply, function(actor)
	actor:item_give(empyorb) -- applies most empyrean effects
	actor:item_give(teleorb) -- makes it teleport to the player from any location
	
	-- giga gold and exp
	if actor.exp_worth then
		actor.exp_worth = actor.exp_worth * 30 -- totals to 60x
	end
	
	-- immune to stun, knockback and fall damage
	actor.knockback_immune = true
	actor.stun_immune = true
	actor.fall_immune = true
	if actor.sprite_jump then
		actor.can_jump = true
	end
	actor.leap_max_distance = math.max(actor.leap_max_distance or 0, 2)
	
	Instance.get_data(actor).empy_quality = Global.__pref_graphics_quality -- get quality
	
	-- make maxhp_base modification take effect
	GM.actor_queue_dirty(actor) 
end)

Callback.add(empyorb.on_acquired, function(actor, stack)
	local data = Instance.get_data(actor)
	
	local all_monster_cards = MonsterCard.find_all()
	local normal_spawn = true
	for i, card in ipairs(all_monster_cards) do
		if card.object_id == actor.object_index then -- if the actor has a monster card
			print(card.spawn_type)
			if card.spawn_type ~= 0 then
				normal_spawn = false
				break
			end
		end
	end
	
	-- start the beam
	if actor.team ~= gm.constants.TEAM_PLAYER and normal_spawn then
		actor:move_contact_solid(270, -1) -- move the actor to the ground
		
		data.empy_beam = 180
		data.empy_beam_over = 0
		data.empy_color = 0
		actor:sound_play(gotanythingsharp, 2, 1)
	else
		data.empy_beam = 0
		data.empy_beam_over = 1
		data.no_beam_loser = 5
		data.empy_color = 0
		
		if math.random() <= 0.5 then
			actor:sound_play(sound_spawn, 3, 1)
		else
			actor:sound_play(sound_spawn_alt, 3, 1)
		end
		
		-- give them all elite aspects
		ssr_give_empyrean_aspects(actor)
	end
	
	-- apply screenshake
	actor:screen_shake(10)
	
	-- remove the passive teleport orb since empyreans have a custom one
	if actor:item_count(Item.find("elitePassiveTeleport")) > 0 then 
		actor:item_take(Item.find("elitePassiveTeleport"), actor:item_count(Item.find("elitePassiveTeleport")))
	end
end)

empyorb.effect_display = EffectDisplay.func(function(actor_unwrapped)	
	local actor = Instance.wrap(actor_unwrapped)
	local data = Instance.get_data(actor)
	
	if not data.empy_beam or not data.empy_beam_over then return end
	if data.empy_beam <= 0 or data.empy_beam_over ~= 0 then
		-- make it rainbow
		if actor.object_index ~= gm.constants.oWorm then
			GM.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x, actor.y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.from_hsv(data.empy_color % 360, 100, 100), actor.image_alpha)
		end
		
		actor.hud_health_color = Color.WHITE
		return 
	end
	
	local width = gm.sprite_get_width(actor.mask_index) / 2 + 32
	local part_width = math.ceil((((actor.x - actor.bbox_left) + (actor.bbox_right - actor.x)) / 2) * 1.5)
	local part_height = math.ceil(((actor.y - actor.bbox_top) + (actor.bbox_bottom - actor.y)) / 2)
	local silhouette_y = actor.y - 16 - (16 * Math.dsin(270 + data.empy_beam * 2))

	if data.empy_beam <= 10 then
		width = width * (1000 - (10 - data.empy_beam) ^ 3) / 1000 -- make the beam shrink when its lifetime ends
	elseif data.empy_beam > 168 then
		width = width * ((180 - data.empy_beam) ^ 3) / 1000 -- make the beam widen when it appears
	elseif data.empy_beam > 165 then
		width = width * (1.3 - ((169 - data.empy_beam) / 10)) -- make the beam shrink back to its normal size after it widens
	end
			
	--if data.empy_beam > 15 and data.empy_beam <= 170 then
		-- create the beam particles that touch the ground
		--beam:create_color(actor.x - width - math.random(3), actor.bbox_bottom - 88, Color.from_hsv(data.empy_color % 360, 100, 100), 1, Particle.System.MIDDLE)
		--beam:create_color(actor.x + width + math.random(3), actor.bbox_bottom - 88, Color.from_hsv(data.empy_color % 360, 100, 100), 1, Particle.System.MIDDLE)
		
		-- create the beam particles around the beam
		--for i = 1, 22 do
		--	local rnd = math.random(80, 1728)
		--	if gm.inside_view(actor.x, actor.y - rnd) == 1 then
		--		beam:create_color(actor.x - width - math.random(3), actor.bbox_bottom - math.random(88, 1152), Color.from_hsv(data.empy_color % 360, 100, 100), 1, Particle.System.MIDDLE)
		--		beam:create_color(actor.x + width + math.random(3), actor.bbox_bottom - math.random(88, 1152), Color.from_hsv(data.empy_color % 360, 100, 100), 1, Particle.System.MIDDLE)
		--	end
		--end
	--end
			
	-- draw the beam
	if data._imalpha then
		gm.draw_set_alpha(data._imalpha)
	else
		gm.draw_set_alpha(1)
	end
	gm.draw_set_color(Color.WHITE)
	gm.draw_rectangle(actor.x - width, 0, actor.x + width, actor.bbox_bottom, false)
	
	gm.gpu_set_fog(1, Color.from_hsv((data.empy_color) % 360, 100, 100), 0, 0)
	local closing_anim = math.min(1, ((180 - data.empy_beam) ^ 3) / 1000)
	local frame = (4 - ((data.empy_beam % 13) / 3))
	for i = 0, 6 do
		if i < 1 then
			GM.draw_sprite_ext(sprite_splash, frame, actor.x + (width - 2), actor.bbox_bottom, closing_anim, 1, 0, Color.WHITE, closing_anim)
			GM.draw_sprite_ext(sprite_splash, frame, actor.x - (width - 2), actor.bbox_bottom, -closing_anim, 1, 0, Color.WHITE, closing_anim)
		else
			GM.draw_sprite_ext(sprite_beam, frame, actor.x + (width - 2), actor.bbox_bottom - 50 - 176 * (i - 1), closing_anim, 1, 0, Color.WHITE, closing_anim)
			GM.draw_sprite_ext(sprite_beam, frame, actor.x - (width - 2), actor.bbox_bottom - 50 - 176 * (i - 1), -closing_anim, 1, 0, Color.WHITE, closing_anim)
		end
	end
	gm.gpu_set_fog(0, Color.from_hsv((data.empy_color) % 360, 100, 100), 0, 0)
	
	-- make it black and move
	GM.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x, silhouette_y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.BLACK, math.min(1, ((180 - data.empy_beam) ^ 3) / 1000))
	gm.draw_set_alpha(1)
end, EffectDisplay.DrawPriority.BODY_POST)

-- dont draw the healthbar while the beam is there
Hook.add_pre(gm.constants.draw_hp_bar, function(self, other, result, args)
	if self.elite_type ~= empy.value then return end
	if not Instance.get_data(self).empy_beam then return end
	
	if Instance.get_data(self).empy_beam <= 0 then
		return
	else
		return false
	end
end)

local guarded = false

-- disable fall damage for the elite to prevent cheese
Hook.add_pre(gm.constants.actor_phy_on_landed, function(self, other, result, args)
	if self.elite_type ~= empy.value then return end
	if not self.fall_immune then return end
	
    if not Util.bool(self.invincible) and self.fall_immune == true then
        self.invincible = 1
        guarded = true
    end
end)

Hook.add_post(gm.constants.actor_phy_on_landed, function(self, other, result, args)
    if guarded then
        self.invincible = 0
        guarded = false
    end
end)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(empyorb:get_holding_actors()) do
		if Instance.exists(actor) then
			local data = Instance.get_data(actor)
			
			data.empy_color = data.empy_color + 1
			
			if data.empy_beam > 0 and data.empy_beam_over == 0 then -- freeze the enemy
				-- store the enemy's certain stats so we can restore it later
				if not data._hmax then
					data._hmax = actor.pHmax
					data._vmax = actor.pVmax
					data._imspeed = actor.image_speed
					data._imalpha = actor.image_alpha
					data._intang = actor.intangible
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
				if data._imalpha then
					actor.image_alpha = data._imalpha * (10 - data.empy_beam) / 10
				else
					actor.image_alpha = (10 - data.empy_beam) / 10
				end
				
				-- (duke nukem voice) shake it baby
				actor:screen_shake(1)
				
				-- make it look like its floating
				if actor.sprite_fall then
					actor.sprite_index = actor.sprite_fall
				elseif actor.sprite_idle then
					actor.sprite_index = actor.sprite_idle
				end
				
				local part_width = math.ceil((((actor.x - actor.bbox_left) + (actor.bbox_right - actor.x)) / 2) * 1.5)
				local part_height = math.ceil(((actor.y - actor.bbox_top) + (actor.bbox_bottom - actor.y)) / 2)
				local silhouette_y = actor.y - 16 - (16 * Math.dsin(270 + data.empy_beam * 2))
				
				if math.random() <= 0.2 * data.empy_quality then
					-- create the black particles around the enemy
					evil:create_color(actor.x + math.random(-part_width, part_width), silhouette_y - part_height / 2 - math.random(part_height), Color.BLACK, 1, Particle.System.ABOVE)
				end
				
				if data.empy_quality >= 2 and data.empy_beam % (30 / data.empy_quality) == 0 then
					local fadeout1 = ssr_create_fadeout(actor.x + gm.sprite_get_width(actor.mask_index) / 4, actor.bbox_bottom, 1, gm.constants.sEfSplashWater, 0.3, 04)
					fadeout1.direction = 0
					fadeout1.speed = 8
					
					local fadeout2 = ssr_create_fadeout(actor.x - gm.sprite_get_width(actor.mask_index) / 4, actor.bbox_bottom, -1, gm.constants.sEfSplashWater, 0.3, 0.4)
					fadeout2.direction = 180
					fadeout2.speed = 8
				end
				
				data.empy_beam = data.empy_beam - 1
			elseif data.empy_beam_over == 0 and data.empy_beam <= 0 then -- unfreeze the enemy
				data.empy_beam_over = 1
				
				-- restore their speed
				actor.pHmax = data._hmax
				actor.pVmax = data._vmax
				actor.image_speed = data._imspeed
				actor.image_alpha = data._imalpha
				actor.intangible = data._intang
				
				--remove all the temporary variables
				data._hmax = nil
				data._vmax = nil
				data._imspeed = nil
				data._imalpha = nil
				data._intang = nil
				
				-- give them all elite aspects
				ssr_give_empyrean_aspects(actor)
				
				-- make the boss bar appear
				if actor.team ~= gm.constants.TEAM_PLAYER and Net.host then
					local arr = Array.new({actor})
					local party = actor:actor_create_enemy_party_from_ids(arr)
					local director = gm._mod_game_getDirector()
					gm.call("register_boss_party@gml_Object_oDirectorControl_Create_0", director, director, party.value)
				end
				
				-- make them move again !! yippie!!
				actor.state = 1
				actor:skill_util_reset_activity_state()
			end
			
			if data.no_beam_loser and Net.host then
				if data.no_beam_loser > 0 then -- wait 5 frames before adding empyreans that didnt play the animation to the boss party (prevents issues with max hp being fucked up on the boss bar)
					data.no_beam_loser = data.no_beam_loser - 1
				else
					data.no_beam_loser = nil
					if actor.team ~= gm.constants.TEAM_PLAYER then -- make the boss bar appear
						local arr = Array.new({actor})
						local party = actor:actor_create_enemy_party_from_ids(arr)
						local director = gm._mod_game_getDirector()
						gm.call("register_boss_party@gml_Object_oDirectorControl_Create_0", director, director, party.value)
					end
				end
			end
			
			if data.empy_beam_over == 1 and data.empy_beam <= 0 and data.empy_color % 2 == 0 and data.empy_quality >= 2 then
				rainbowspark:create_color(actor.x, actor.y, Color.from_hsv((data.empy_color) % 360, 100, 100), 1, Particle.System.BELOW)
			end
			
			if actor.object_index == gm.constants.oWorm or actor.object_index == gm.constants.oJellyG or actor.object_index == gm.constants.oJellyG2 then
				actor.image_blend = Color.from_hsv(data.empy_color % 360, 65, 100)
			end
		end
	end
end)

RecalculateStats.add(Callback.Priority.AFTER, function(actor, api)
    if actor.elite_type ~= empy.value then return end
	
	-- stat changes are multiplicative with normal elite stat changes
	-- so max hp for example will be base * 12 * 2.8 = 33.6x total multiplier
	
	api.maxhp_mult(12)
	api.damage_mult(5.4 / 1.9) -- totals to 5.4x
	api.cooldown_mult(0.5 / 0.3) -- totals to 50%
end)

Callback.add(teleorb.on_acquired, function(actor, stack)
	Instance.get_data(actor).empyrean_teleport = 480 + math.random(240)
end)

local tp_sounds = {
	sound_teleport1,
	sound_teleport2,
	sound_teleport3,
}

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(teleorb:get_holding_actors()) do
		if Instance.exists(actor) then
			local data = Instance.get_data(actor)
			
			if GM.actor_is_classic(actor) and not actor:is_climbing() then
				if data.empyrean_teleport > 0 then
					data.empyrean_teleport = data.empyrean_teleport - 1
				else
					local target = Instance.find(gm.constants.oP)
					
					-- teleport!
					if target and Math.distance(actor.x, actor.y, target.x, target.y) > 250 and Instance.exists(target) then
						if Net.host then
							GM.teleport_nearby(actor, target.x - (150 + math.random(50)) * Math.sign(target.pHspeed), target.y) -- teleport to this fool
							
							if Net.online then
								GM.net_send_instance_message(actor, 25)
							end
							
							actor.ghost_x = actor.x
							actor.ghost_y = actor.y
							actor.pVspeed = 0
							actor.pHspeed = 0
							actor.ai_tick_rate = 1
						end
						
						data.empyrean_teleport = 480 + math.random(240)
						
						-- create some effects so you know youre about to die
						local circle = Object.find("EfCircle"):create(actor.x, actor.y)
						circle.parent = actor
						circle.radius = math.ceil((((actor.x - actor.bbox_left) + (actor.bbox_right - actor.x) + (actor.y - actor.bbox_top) + (actor.bbox_bottom - actor.y)) / 4) * 1.5 )
						
						local flash = Object.find("EfFlash"):create(actor.x, actor.y)
						flash.parent = actor
						flash.rate = 0.02
						flash.image_alpha = 1
						
						-- disable skills for a second to prevent unfair deaths
						if Net.host then
							local frame = Global._current_frame
							for i = 0, 3 do
								local skill = actor:get_active_skill(i)
								skill.use_next_frame = math.max(skill.use_next_frame, frame + 60)
							end
						end
						
						teleport:create(actor.x, actor.y, (data.empy_quality - 1) * 15, Particle.System.MIDDLE)
						
						-- play one of 3 sounds randomly
						actor:sound_play(tp_sounds[math.random(1, 3)], 1, 0.8 + math.random() * 0.2)
					else
						data.empyrean_teleport = 60
					end
				end
			end
		end
	end
end)

--[[
-- empyrean worms !!!
-- make the worm bodies rainbow too and also make them create sparks
Hook.add_pre("gml_Object_oWormBody_Step_2", function(self, other)
	if self.parent.elite_type ~= empy.value then return end
	local data = Instance.get_data(self.parent)
	
	if self.parent.elite_type == empy.value then
		self.image_blend = Color.from_hsv((data.empy_color + (self.m_id - self.parent.m_id) * 18) % 360, 65, 100)
		
		if gm.inside_view(self.x, self.y) == 1 and data.empy_color % 3 == 0 then
			rainbowspark:create_color(self.x, self.y, Color.from_hsv((data.empy_color + self.y * (0.75)) % 360, 100, 100), 1, Particle.System.MIDDLE)
		end
	end
end)

-- make the worm bodies set their first alarm (needed to shoot the orbs)
Hook.add_pre("gml_Object_oWorm_Alarm_4", function(self, other)
	if self.elite_type ~= empy.value then return end
	
	if self.elite_type == empy.value then
		for _, segment in ipairs(self.body) do
			segment:alarm_set(1, 150 + (segment.m_id - self.m_id) * 2)
		end
	end
end)

-- play the spawn sound
Hook.add_pre("gml_Object_oWorm_Alarm_3", function(self, other)
	if self.elite_type ~= empy.value then return end
	
	if self.elite_type == empy.value then
		GM.sound_play_global(sound_spawn_worm, 1, 1)
	end
end)

-- special empyrean worm projectile
local oStarStorm = Object.new("EmpyreanWormStar")
oStarStorm:set_sprite(star_sprite)

Callback.add(oStarStorm.on_create, function(self)
	self.image_speed = 0.4
	self.image_alpha = 0.75
	self.direction = 0
	self.speed = 0
	
	local data = Instance.get_data(self)
	data.life = 600
	data.damage = 1
	data.targetX = 0
	data.targetY = 0
	data.team = 2
	
	self:sound_play(sound_star_spawn, 0.5, 0.8 + math.random() * 0.2)
end)

Callback.add(oStarStorm.on_draw, function(self)
	gm.draw_set_alpha(0.4)
	gm.draw_circle_colour(self.x, self.y, 20, self.image_blend, self.image_blend, false)
	gm.draw_set_alpha(1)
end)

Callback.add(oStarStorm.on_step, function(self)
	local data = Instance.get_data(self)
	
	if data.life > 0 then
		data.life = data.life - 1
	else
		self:destroy()
	end
	
	if not data.spawn_speed then
		data.spawn_speed = self.speed
	end
	
	if data.life >= 570 then -- do this for the first 30 frames after spawning
		self.speed = self.speed - data.spawn_speed / 30
	elseif data.life == 481 then -- make it idle for a second and a half, then >>
		local flash = Object.find("EfFlash"):create(self.x, self.y) -- >> make it flash
		flash.parent = self
		flash.rate = 0.03
		flash.image_alpha = 0.6
		
		self:sound_play(sound_star_shoot, 0.5, 0.8 + math.random() * 0.2) -- >> play this sound
		
		self.direction = Math.direction(self.x, self.y, data.targetX, data.targetY) -- >> make it aim at the player
	--elseif data.life >= 480 then -- while idling, create telegraph particles
		--if data.life % 10 == 0 then
			--telegraph:set_direction(Math.direction(self.x, self.y, data.targetX, data.targetY), Math.direction(self.x, self.y, data.targetX, data.targetY), 0, 0)
			--telegraph:create_color(self.x, self.y, self.image_blend, 1)
		--end
	elseif data.life >= 470 then -- once were done idling, descrease its speed to create a wind up effect for 10 frames
		self.speed = self.speed - 0.4
	else
		self.speed = math.min(30, self.speed + 0.6) -- then start increasing its speed for the rest of the duration
		
		for _, hitbox in ipairs(self:get_collisions(gm.constants.pActorCollisionBase)) do -- make it deal damage if it hits the opposite team
			local actor = GM.attack_collision_resolve(hitbox)
			
			if self:attack_collision_canhit(actor) and Instance.exists(self.parent) then
				if Net.host then
					local attack = self.parent:fire_direct(actor, data.damage / self.parent.damage)
				end

				self:sound_play(gm.constants.wExplosiveShot, 1, 0.8 + math.random() * 0.2)
				self:destroy()
			end
		end
	end
	
	if data.life % 5 == 0 then
		rainbowspark:create_color(self.x, self.y, self.image_blend, 1, Particle.System.MIDDLE)
	end
end)

-- make the worm shoot the star storm
Hook.add_pre("gml_Object_oWormBody_Alarm_1", function(self, other)
	if self.parent.elite_type ~= empy.value then return end
	
	if self.parent.elite_type == empy.value then
		self:alarm_set(1, 330)
	
		if self.parent.target then
			local star = oStarStorm:create(self.x, self.y)
			data = Instance.get_data(star)
			star.parent = self.parent
			data.team = self.parent.team
			data.targetX = self.parent.target.x
			data.targetY = self.parent.target.y
			data.damage = self.parent.damage * 0.07
			
			if math.random() <= 0.5 then
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
Hook.add_pre("gml_Object_oWormWarning_Step_0", function(self, other)
	if self.image_blend ~= Color.from_hsv((Global._current_frame - 1) % 360, 65, 100) then return end
	
	if self.image_blend == Color.from_hsv((Global._current_frame - 1) % 360, 65, 100) then -- check what color it was on the previous frame
		self.image_blend = Color.from_hsv(Global._current_frame % 360, 65, 100)
	end
end)
]]--

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

Callback.add(Callback.ON_STAGE_START, function()
	if not GM._mod_game_getDirector().__ssr_empyrean_chance then
		GM._mod_game_getDirector().__ssr_empyrean_chance = 0.02 -- higher chance so you see your first empyrean sooner
	end
end)

Callback.add(Callback.ON_ELITE_INIT, function(actor)
	if GM._mod_game_getDirector().stages_passed <= 8 then return end -- only spawns if its stage 9+
	if Global.__gamemode_current >= 2 then return end -- dont spawn empyreans in judgement
	if not Net.host then return end
	
	if actor.elite_type ~= empy.value then -- if the actor is not already empyrean
		local all_monster_cards = MonsterCard.find_all()
		local chance = GM._mod_game_getDirector().__ssr_empyrean_chance -- a value from 0 to 1
		local diff = math.max(1, (GM._mod_game_getDirector().enemy_buff - 16) / 4)
		for i, card in ipairs(all_monster_cards) do
			if card.object_id == actor.object_index then -- if the actor has a monster card
				if not blacklist[card.identifier] and (card.can_be_blighted == true or whitelist[card.identifier]) then -- if the actor is not blacklisted and can be blighted or is in the whitelist
					local cost = math.min(4, math.max(1, card.spawn_cost / 40 * diff))
					if Util.chance(chance / cost) then
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