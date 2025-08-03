local SPRITE_PATH = path.combine(PATH, "Sprites/Elites/Empyrean")
local SOUND_PATH = path.combine(PATH, "Sounds/Elites/Empyrean")

local sprite_icon = Resources.sprite_load(NAMESPACE, "EliteIconEmpyrean", path.combine(SPRITE_PATH, "icon.png"), 1, 24, 15)
local sprite_palette = Resources.sprite_load(NAMESPACE, "ElitePaletteEmpyrean", path.combine(SPRITE_PATH, "palette.png"))
local splash_sprite = Resources.sprite_load(NAMESPACE, "ParticleEmpyreanSpawnSplash", path.combine(SPRITE_PATH, "splash.png"), 6)
local beam_sprite = Resources.sprite_load(NAMESPACE, "ParticleEmpyreanSpawnBeam", path.combine(SPRITE_PATH, "beam.png"), 11)

local gotanythingsharp = Resources.sfx_load(NAMESPACE, "EmpyreanSpawn", path.combine(SOUND_PATH, "beam.ogg"))

local empy = Elite.new(NAMESPACE, "empyrean")
empy.healthbar_icon = sprite_icon
empy.palette = sprite_palette
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
rainbowspark:set_size(0, 2, 0, 0.02)
rainbowspark:set_orientation(0, 0, 0, 0, true)
rainbowspark:set_speed(0, 4, -0.04, 0.2)
rainbowspark:set_direction(0, 180, 0, 10)
rainbowspark:set_scale(0.1, 0.1)
rainbowspark:set_life(20, 100)



-- PUT ASPECTS HERE --
function ssr_give_empyrean_aspects(actor)
	-- VANILLA ELITES --

	-- volatile
	actor:item_give(Item.find("ror-eliteOrbExplosiveShot"))
	actor:item_give(Item.find("ror-elitePassiveVolatile"))
	
	-- overloading effects
	actor:item_give(Item.find("ror-eliteOrbLightning"))
	actor:item_give(Item.find("ror-elitePassiveOverloading"))
	
	-- leeching effects
	actor:item_give(Item.find("ror-elitePassiveLeeching"))
	actor:item_give(Item.find("ror-eliteOrbLifesteal"))
	
	-- frenzied effects
	actor:item_give(Item.find("ror-eliteOrbAttackSpeed"))
	actor:item_give(Item.find("ror-eliteOrbMoveSpeed"))
	actor:item_give(Item.find("ror-elitePassiveTeleport"))
	
	-- blazing effects
	actor:item_give(Item.find("ror-eliteOrbFireTrail"))
	
	-- STARSTORM ELITES --
	
	-- poison effects
	actor:item_give(Item.find("ssr-eliteOrbPoison"))
end

local empyorb = Item.new(NAMESPACE, "eliteOrbEmpyrean", true)
empyorb.is_hidden = true

empy:clear_callbacks()
empy:onApply(function(actor)
	actor:item_give(empyorb)
	
	-- giga health
	actor.maxhp_base = actor.maxhp_base * 10
	actor.hp = actor.maxhp
	
	 -- giga gold and exp
	if actor.exp_worth then
		actor.exp_worth = math.min(actor.exp_worth * 15, 5000000)
	end
	
	-- make maxhp_base modification take effect
	GM.actor_queue_dirty(actor) 
end)

empyorb:clear_callbacks()
empyorb:onAcquire(function(actor, stack)
	
	-- play the spawn sound
	actor:sound_play(gm.constants.wWormExplosion, 1, 0.6)
	actor:sound_play(gotanythingsharp, 1, 1)
	
	-- start the beam
	if gm.inside_view(actor.x, actor.y) == 1 then
		actor:get_data().empy_beam = 180
		actor:get_data().empy_beam_over = 0
	else
		actor:get_data().empy_beam = 0
		actor:get_data().empy_beam_over = 1
		
		-- give them all elite aspects
		ssr_give_empyrean_aspects(actor)
	end

	-- make the boss bar appear
	if actor.team ~= 1 then
		local arr = Array.new({actor})
		local party = GM.actor_create_enemy_party_from_ids(arr)
		local director = GM._mod_game_getDirector()
		director:register_boss_party_gml_Object_oDirectorControl_Create_0(party)
	end
end)

empyorb:onPostDraw(function(actor, stack)
	if actor:get_data().empy_beam > 0 and actor:get_data().empy_beam_over == 0 then
		local width = gm.sprite_get_width(actor.mask_index) * 1.5
		local part_width = gm.round((((actor.x - actor.bbox_left) + (actor.bbox_right - actor.x)) / 2) * 1.5)
		local part_height = gm.round(((actor.y - actor.bbox_top) + (actor.bbox_bottom - actor.y)) / 2)
		local silhouette_y = actor.y - 16 - (16 * math.sin(gm.degtorad(270 + actor:get_data().empy_beam * 2)))

		if actor:get_data().empy_beam <= 10 then
			width = width * (1000 - (10 - actor:get_data().empy_beam) ^ 3) / 1000 -- make the beam shrink when its lifetime ends
		elseif actor:get_data().empy_beam > 168 then
			width = width * ((180 - actor:get_data().empy_beam) ^ 3) / 1000 -- make the beam widen when it appears
		elseif actor:get_data().empy_beam > 165 then
			width = width * (1.3 - ((169 - actor:get_data().empy_beam) / 10)) -- make the beam widen when it appears
		else
			if math.random() >= 0.5 then
				-- create the black particles around the enemy
				evil:create_color(actor.x + math.random(-part_width, part_width), silhouette_y - part_height - math.random(part_height), Color.BLACK, 1)
				
				-- create the beam splashing particles
				local side = 1
				if math.random() >= 0.5 then
					side = -1
				end
				local ori = 180 + math.random(-45, 45) - 45 * side
				splash:set_orientation(ori, ori, 0, 0, false)
				splash:create_color(actor.x + (width + math.random(-3, 3)) * side, actor.bbox_bottom, Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
			end
		end
		
		if actor:get_data().empy_beam > 15 and actor:get_data().empy_beam <= 170 then
			-- create the beam particles that touch the ground
			beam:create_color(actor.x - width - math.random(3), actor.y - 72, Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
			beam:create_color(actor.x + width + math.random(3), actor.y - 72, Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
			
			-- create the beam particles around the beam
			for i = 0, 15 do
				beam:create_color(actor.x - width - math.random(3), actor.y - math.random(80, 1152), Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
				beam:create_color(actor.x + width + math.random(3), actor.y - math.random(80, 1152), Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
			end
			
			if gm.inside_view(actor.x, actor.y - 1152) == 1 then
				for i = 0, 7 do
					beam:create_color(actor.x - width - math.random(-3, 3), actor.y - math.random(1152, 1728), Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
					beam:create_color(actor.x + width + math.random(-3, 3), actor.y - math.random(1152, 1728), Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
				end
			end
		end
		
		-- draw the beam
		gm.draw_set_alpha(1)
		gm.draw_set_color(Color.WHITE)
		gm.draw_rectangle(actor.x - width, 0, actor.x + width, actor.bbox_bottom, false)
		
		-- make it black and move
		gm.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x, silhouette_y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.BLACK, math.min(1, ((180 - actor:get_data().empy_beam) ^ 3) / 1000))
	else
		-- make it rainbow
		gm.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x, actor.y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.from_hsv(Global._current_frame % 360, 100, 100), 1)
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

empyorb:onPostStep(function(actor, stack)
	if actor:get_data().empy_beam > 0 and actor:get_data().empy_beam_over == 0 then -- freeze the enemy
		-- store the enemy's max speeds so you can restore it later
		if not actor:get_data()._hmax and not actor:get_data()._vmax and not actor:get_data()._imspeed and not actor:get_data().imalpha and not actor:get_data().kbimmune and not actor:get_data().stimmune then
			actor:get_data()._hmax = actor.pHmax
			actor:get_data()._vmax = actor.pVmax
			actor:get_data()._imspeed = actor.image_speed
			actor:get_data().imalpha = actor.image_alpha
			actor:get_data().kbimmune = actor.knockback_immune
			actor:get_data().stimmune = actor.stun_immune
		end
		
		-- make it not move
		actor.image_speed = 0.25
		actor.image_alpha = 0
		actor.knockback_immune = true
		actor.stun_immune = true
		actor.pHmax = 0
		actor.pVmax = 0
		actor.activity = 50
		actor.__activity_handler_state = 50
		actor.state = 0
		
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
		actor.image_alpha = actor:get_data().imalpha
		actor.knockback_immune = actor:get_data().kbimmune
		actor.stun_immune = actor:get_data().stimmune
		
		
		-- give them all elite aspects
		ssr_give_empyrean_aspects(actor)
		
		-- make them move again !! yippie!!
		actor.state = 1
		actor:skill_util_reset_activity_state()
	end
	
	if gm.inside_view(actor.x, actor.y) == 1 and actor:get_data().empy_beam_over == 1 and actor:get_data().empy_beam <= 0 and Global._current_frame % 2 == 0 then
		rainbowspark:create_color(actor.x, actor.y, Color.from_hsv((Global._current_frame + actor.y * (0.75)) % 360, 100, 100), 1, Particle.SYSTEM.middle)
	end
end)

local blacklist = {
	["evolvedLemurian"] = true, -- evolved lemurians try not to fuck everything up challenge (impossible) (gone wrong) (called the idpd) (a nuclear missile is heading for your house) (it is 102m away from your house) (sorry not sorry)
	["lemrider"] = true,
	["bramble"] = true,
}

local all_monster_cards = Monster_Card.find_all()
for i, card in ipairs(all_monster_cards) do
	if not blacklist[card.identifier] then
		local elite_list = List.wrap(card.elite_list)
		if not elite_list:contains(empy) then
			elite_list:add(empy)
		end
	end
end
