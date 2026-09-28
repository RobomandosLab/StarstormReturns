local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Mimic")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Mimic")

-- assets
local sprite_mask			= Sprite.new("MimicMask",			path.combine(SPRITE_PATH, "mask.png"), 1, 21, 24)
local sprite_palette		= Sprite.new("MimicPalette",		path.combine(SPRITE_PATH, "palette.png"))

local sprite_idle			= Sprite.new("MimicIdle",			path.combine(SPRITE_PATH, "idle.png"), 2, 30, 35)
local sprite_idle2			= Sprite.new("MimicIdle2",			path.combine(SPRITE_PATH, "idle2.png"), 2, 30, 45)
local sprite_walk			= Sprite.new("MimicWalk",			path.combine(SPRITE_PATH, "walk.png"), 8, 30, 35)
local sprite_walk2			= Sprite.new("MimicWalk2",			path.combine(SPRITE_PATH, "walk2.png"), 6, 30, 35)
local sprite_jump			= Sprite.new("MimicJump",			path.combine(SPRITE_PATH, "jump.png"), 1, 19, 28)
local sprite_jump_peak		= Sprite.new("MimicJumpPeak",		path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 19, 28)
local sprite_fall			= Sprite.new("MimicFall",			path.combine(SPRITE_PATH, "fall.png"), 1, 19, 28)
local sprite_death			= Sprite.new("MimicDeath",			path.combine(SPRITE_PATH, "death.png"), 10, 55, 93)
local sprite_shoot1a		= Sprite.new("MimicShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 10, 30, 45)
local sprite_shoot1b		= Sprite.new("MimicShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 4, 30, 45)
local sprite_shoot1c		= Sprite.new("MimicShoot1c",		path.combine(SPRITE_PATH, "shoot1c.png"), 6, 30, 45)
local sprite_portrait		= Sprite.new("MimicPortrait",		path.combine(SPRITE_PATH, "portrait.png"))

local sprite_inactive_idle	= Sprite.new("MimicInactiveIdle",	path.combine(SPRITE_PATH, "inactiveIdle.png"), 14, 30, 38)
local sprite_activate		= Sprite.new("MimicActivate",		path.combine(SPRITE_PATH, "spawn.png"), 18, 30, 60)
local sprite_vacuum			= Sprite.new("MimicVacuumFX", 		path.combine(SPRITE_PATH, "vacuumParticle.png"), 4, 4, 4)
local sprite_ping 			= Sprite.new("MimicPing", 			path.combine(SPRITE_PATH, "ping.png"), 1, 14, 19)

local sound_spawn			= Sound.new("MimicSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit				= Sound.new("MimicHit",				path.combine(SOUND_PATH, "hit.ogg"))
local sound_shoot			= Sound.new("MimicShoot",			path.combine(SOUND_PATH, "shoot.ogg"))
local sound_death			= Sound.new("MimicDeath",			path.combine(SOUND_PATH, "death.ogg"))

local efGoldSteal = Object.new("EfGoldSteal")
efGoldSteal:set_sprite(gm.constants.sEfGold1)
efGoldSteal:set_depth(-279)

local function select_item_to_steal(victim)
	local inventory = victim.inventory_item_order
	
	if #inventory > 0 then
		local chosen_id = inventory[math.random(#inventory)]
		local chosen_item = Item.wrap(chosen_id)
		return chosen_item
	end
	
	return nil
end

-- mimic
local mimic = Object.new("Mimic", Object.Parent.ENEMY_CLASSIC)
mimic:set_sprite(sprite_idle)
mimic:set_depth(10)

-- create the monster log
local mlog = ssr_create_monster_log("mimic")
mlog.sprite_id = sprite_walk
mlog.portrait_id = sprite_portrait
mlog.sprite_offset_x = 42
mlog.sprite_offset_y = 45
mlog.stat_hp = 200
mlog.stat_damage = 10
mlog.stat_speed = 2.6

local primary = Skill.new("mimicZ")

Callback.add(mimic.on_create, function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death
	actor.sprite_ping = sprite_ping

	actor.can_jump = true
	actor.leap_max_distance = 3

	actor.mask_index = sprite_mask

	actor.sound_hit = sound_hit
	actor.sound_death = sound_death

	-- damage, health, knockback cap/threshold, gold/exp reward
	actor:enemy_stats_init(10, 200, 200, 0)
	actor.pHmax_base = 2.4 + math.min(0.2 * GM._mod_game_getDirector().enemy_buff, 3)

	actor.z_range = 200
	actor:set_default_skill(Skill.Slot.PRIMARY, primary)

	actor.monster_log_drop_id = mlog.value

	actor:init_actor_late()
end)

Callback.add(mimic.on_step, function(actor)
	
end)

Callback.add(mimic.on_destroy, function(actor)
	Particle.find("Spark"):create(actor.x, actor.y, 7)
	actor:screen_shake(4)
end)

local mimicInactive = Object.new("MimicInactive", Object.Parent.INTERACTABLE)
mimicInactive:set_sprite(sprite_inactive_idle)
mimicInactive:set_depth(90)

local scan = Buff.new("mimicScan")
scan.show_icon = false
scan.is_timed = false

scan.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	local data = Instance.get_data(actor)
	local timer = data.__ssr_mimic_scan_anim
	local xx = Math.lerp(actor.x + (600 - 10 * math.min(timer * 2, 240)) * math.sin(math.rad(90 - 0.75 * math.min(timer, 120))), actor.x, (math.min(timer / 120, 1)))
	local yy = Math.lerp(actor.y - (400 - 10 * math.min(timer * 2, 240)) * math.sin(math.rad(90 - 0.75 * math.min(timer, 120))), actor.y, (math.min(timer / 120, 1)))
	
	gm.gpu_set_fog(true, Color.Item.RED, 0, 0)
	GM.draw_sprite_ext(gm.constants.sEfBossKillerCrosshair, timer / 4, xx, yy, 1, 1, 0, Color.WHITE, math.min(0.1 * timer, 1))
	gm.gpu_set_fog(false, Color.Item.RED, 0, 0)
	
	local mimic_data = Instance.get_data(Instance.wrap(data.__ssr_mimic_scan_parent))
	local item = mimic_data.target_items[1]
	local steal = mimic_data.steal_timer
	
	for i = 0, 2 do
		local panel_timer = timer - 120 - 10 * i
		local offset_x = -90
		local offset_y = -30
		local add_x = 0
		local size = 1
		
		if i == 0 then
			offset_x = -90
			offset_y = -30
			
			local class
		
			if actor.class then
				class = gm.translate(Survivor.wrap(actor.class).token_name_upper)
			elseif actor.name then
				class = actor.name
			else
				class = "???"
			end
			
			if gm.string_width(class) > 60 then
				add_x = -(gm.string_width(class) - 60 + 20)
			end
		elseif i == 1 then
			offset_x = -90
			offset_y = 30
			
			if gm.string_width("STOLEN : " .. string.format("%02d", math.floor(#mimic_data.stolen_items / 2))) > 60 then
				add_x = -(gm.string_width("STOLEN : " .. string.format("%02d", math.floor(#mimic_data.stolen_items / 2))) - 60 + 20)
			end
		elseif i == 2 then
			offset_x = 90
			offset_y = 0
			size = 2.5
		end
		
		if panel_timer < 0 or (panel_timer >= 3 and panel_timer <= 6) then
			gm.draw_set_alpha(0)
		else
			gm.draw_set_alpha(0.5)
		end
		
		if panel_timer <= 9 then
			gm.draw_set_colour(Color.WHITE)
		else
			gm.draw_set_colour(Color.Item.RED)
		end
		
		gm.draw_roundrect(actor.x + offset_x - 40 + add_x, actor.y + offset_y - 20 * size, actor.x + offset_x + 40, actor.y + offset_y + 20 * size, false)
		gm.draw_set_colour(Color.RED)
		gm.draw_roundrect(actor.x + offset_x - 40 + add_x, actor.y + offset_y - 20 * size, actor.x + offset_x + 40, actor.y + offset_y + 20 * size, true)
		gm.draw_set_alpha(1)
	end
	
	local item_x = actor.x + 90
	local item_y = actor.y
	
	if timer >= 150 then
		
		gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1)
		
		local class
		
		if actor.class then
			class = gm.translate(Survivor.wrap(actor.class).token_name_upper)
		elseif actor.name then
			class = actor.name
		else
			class = "???"
		end
		
		local add_x = 0
		
		if gm.string_width(class) > 60 then
			add_x = gm.string_width(class) - 60 + 20
		end
		
		if mimic_data.prep_timer > 0 then
			class = "I'M"
		end
		
		
		if mimic_data.prep_timer <= 0 or mimic_data.prep_timer % 60 >= 30 then
			gm.scribble_draw(actor.x - 90 - (add_x / 2), actor.y - 40, class)
		end
		
		gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1)
		
		local stolen = "STOLEN : " .. string.format("%02d", math.floor(#mimic_data.stolen_items / 2))
		
		local add_x = 0
		
		if gm.string_width("STOLEN : " .. string.format("%02d", math.floor(#mimic_data.stolen_items / 2))) > 60 then
			add_x = gm.string_width("STOLEN : " .. string.format("%02d", math.floor(#mimic_data.stolen_items / 2))) - 60 + 20
		end
		
		if mimic_data.prep_timer > 0 then
			stolen = "FOR"
		end
		
		if mimic_data.prep_timer <= 0 or mimic_data.prep_timer % 60 >= 30 then
			gm.scribble_draw(actor.x - 90 - (add_x / 2), actor.y + 25, stolen)
		end
		
		gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1)
		
		local scanning = "SCANNING..."
		
		if mimic_data.prep_timer > 0 then
			scanning = "COMING"
		end
		
		if mimic_data.prep_timer <= 0 or mimic_data.prep_timer % 60 >= 30 then
			gm.scribble_draw(item_x, item_y - 40, scanning)
		end
				
		if steal <= 120 then
			gm.draw_set_colour(Color.RED)
			
			if item and mimic_data.prep_timer <= 0 then
				GM.draw_sprite_ext(Item.wrap(item).sprite_id, 0, item_x, item_y, math.sin(math.rad(steal * 5)), 1, 0, Color.BLACK, 1)
				gm.draw_set_colour(Color.WHITE)
				
				local sprite = Item.wrap(item).sprite_id
				local w = GM.sprite_get_width(sprite)
				local h = GM.sprite_get_height(sprite)
				local xo = w - GM.sprite_get_xoffset(sprite)
				local yo = h - GM.sprite_get_yoffset(sprite)
				
				GM.draw_sprite_part_ext(Item.wrap(item).sprite_id, 0, 0, h * (1 - (steal / 120)), w, h, item_x - xo * math.sin(math.rad(steal * 5)), item_y - yo + (h * (1 - (steal / 120))), math.sin(math.rad(steal * 5)), 1, Color.WHITE, 1)
			end
			
			local percent = tostring(math.floor(math.min(100, (steal / 120) * 100))) .. "%"
			gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1)
			
			if mimic_data.prep_timer > 0 then
				percent = "YOU"
			end
			
			if mimic_data.prep_timer <= 0 or mimic_data.prep_timer % 60 >= 30 then
				gm.scribble_draw(item_x, item_y + 25, percent)
			end
		else
			if item and mimic_data.prep_timer <= 0 then
				local size = 1
				if steal >= 120 and steal <= 130 then
					gm.gpu_set_fog(true, Color.WHITE, 0, 0)
					size = 1.2
				end
				
				GM.draw_sprite_ext(Item.wrap(item).sprite_id, 0, item_x, item_y, 1 * size, 1 * size, 0, Color.WHITE, 1)
				
				gm.gpu_set_fog(false, Color.WHITE, 0, 0)
			end
			
			gm.scribble_set_starting_format("fntNormal", Color.LIME, 1)
			gm.scribble_draw(item_x, item_y + 25, string.upper(gm.translate("ui.done")))
		end
	end
	
	gm.draw_set_alpha(1)
	gm.draw_set_colour(Color.WHITE)
	
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(scan.on_apply, function(actor)
	local data = Instance.get_data(actor)
	data.__ssr_mimic_scan_anim = 0
	
	actor:sound_play(gm.constants.wCrateActivate, 1, 1)
end)

Callback.add(scan.on_step, function(actor)
	local data = Instance.get_data(actor)
	data.__ssr_mimic_scan_anim = data.__ssr_mimic_scan_anim + 1
	
	if data.__ssr_mimic_scan_anim % 30 == 0 and data.__ssr_mimic_scan_anim < 60 * 2 then
		actor:sound_play(gm.constants.wDroneRecycler_Activate, 1, 1)
	end
	
	if data.__ssr_mimic_scan_anim >= 120 and data.__ssr_mimic_scan_anim <= 140 and data.__ssr_mimic_scan_anim % 10 == 0 then
		actor:sound_play(gm.constants.wHANDShoot2_1, 1, 0.6 + 0.2 * math.random())
	end
	
	if not Instance.exists(data.__ssr_mimic_scan_parent) or Instance.wrap(data.__ssr_mimic_scan_parent).active > 0 then
		if Net.host then
			actor:buff_remove(scan)
		end
	end
end)

Callback.add(scan.on_remove, function(actor)
	local data = Instance.get_data(actor)
	data.__ssr_mimic_scan_anim = nil
end)

Callback.add(mimicInactive.on_create, function(self)
	GM.interactable_init_cost(self, 0, 50)
	
	local data = Instance.get_data(self)
	data.stolen_items = {}
	data.steal_timer = 0
	data.prep_timer = 0
	
	self.sprite_ping = gm.constants.sPing_Chest2
	self:interactable_init_name()
end)

Callback.add(mimicInactive.on_step, function(self)
	if Net.host then
		local target
		
		if self.active == 0 then
			if not Instance.exists(self.target) then
				target = self:collision_circle(self.x, self.y, 2000, gm.constants.oP, false, true)

				if target ~= -4 and Util.bool(target.is_targettable) and target.inventory_item_order:size() > 0 then
					self.target = target
					
					local data = Instance.get_data(target)
					data.__ssr_mimic_scan_parent = self.id
					target:buff_apply(scan, 60)
				end
			end
			
			if Instance.exists(self.target) and self.target:buff_count(scan) > 0 then
				local data = Instance.get_data(self)
				
				if Instance.get_data(self.target).__ssr_mimic_scan_anim then
					if Instance.get_data(self.target).__ssr_mimic_scan_anim >= 150 and data.prep_timer <= 0 then
						data.steal_timer = data.steal_timer + 1
						
						if data.steal_timer % 15 == 0 and data.steal_timer < 120 then
							self.target:sound_play(gm.constants.wUI_SliderTick, 1, 0.7 + 0.1 * data.steal_timer / 30)
						end
					end
				end
				
				if not data.target_items and #data.stolen_items < 1 then
					data.target_items = {}
					
					local i = 1
					for _, item in ipairs(self.target.inventory_item_order) do
						data.target_items[i] = item
						data.target_items[i + 1] = self.target.inventory_item_stack[item + 1]
						i = i + 2
					end
				end
				
				if #data.target_items < 1 and #data.stolen_items > 1 then
					data.prep_timer = data.prep_timer + 1
					
					if (data.prep_timer - 30) % 60 == 0 then
						self.target:sound_play(gm.constants.wDroneRecycler_Activate, 1, 1)
					end
					
					if data.prep_timer >= 3 * 60 then
						self.active = 1
						self.target:buff_remove(scan)
					end
				end
				
				if data.target_items then
					if data.steal_timer == 2 * 60 then
						self.target:sound_play(gm.constants.wMine, 1, 0.8 + 0.2 * math.random())
					end
					
					if data.steal_timer >= 3 * 60 then
						data.steal_timer = 0
						
						local item = table.remove(data.target_items, 1)
						local stack = table.remove(data.target_items, 1)
						
						table.insert(data.stolen_items, item)
						table.insert(data.stolen_items, stack)
					end
				end
			end
		end
	end
	
	if self.active == 1 then
		-- self.active gets automatically set to 2 internally so this only runs for one frame
		self.sprite_index = sprite_activate
		self.image_index = 0
		self.image_speed = 0.2
		self:sound_play(sound_spawn, 1, 1)
		self:sound_play(gm.constants.wPickup, 1, 0.7)
	elseif self.active == 2 then
		if self.image_index >= 14 and not self.stompied then
			self.stompied = true
			self:screen_shake(5)
			self:sound_play(gm.constants.wClayDeath, 0.7, 1.35)
		end

		if self.image_speed == 0 then
			if Net.host then
				local actor = mimic:create(self.x, self.y - 25)
				local data = Instance.get_data(self)
				
				for i, thing in ipairs(data.stolen_items) do
					if i % 2 == 1 and Item.wrap(thing) then
						actor:item_give(Item.wrap(thing), data.stolen_items[i + 1])
					end
				end

				self:instance_destroy_sync() -- tell clients to destroy this object, doesn't actually destroy it on the host
				self:destroy()
			end
		end
	end
end)

Callback.add(Callback.ON_STAGE_START, function()
	if Net.client then return end -- host handles spawning
	if Global.__gamemode_current >= 2 then return end -- don't spawn mimics in trials or tutorial..

	if math.random() <= 1 then
		-- function used by the game's director when spawninginteractables.
		gm._mod_game_getDirector():mapobject_spawn(mimicInactive.value, 1) -- second arg is required tile space
	end
end)
