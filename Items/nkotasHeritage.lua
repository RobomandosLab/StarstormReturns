--Nkota's Heritage
local sprite_item = Sprite.new("NkotasHeritage", path.combine(PATH, "Sprites/Items/nikotasHeritage.png"), 1, 17, 18)
local sprite_par = Sprite.new("NkotasParticle", path.combine(PATH, "Sprites/Items/Effects/nkotaHpardis.png"), 26, 5, 5)
local sprite_txt = Sprite.new("NkotasText", path.combine(PATH, "Sprites/Items/Effects/nkotaHdis.png"), 11, 30, 0)
local sprite_level = Sprite.new("NkotaLevelUp", path.combine(PATH, "Sprites/Items/Effects/levelup.png"), 31, 73, 10)

local sound = Sound.new("NkotasHeritage", path.combine(PATH, "Sounds/Items/nkotasHeritage.ogg"))

local nkota = Item.new("nkotasHeritage")
nkota:set_sprite(sprite_item)
nkota:set_tier(ItemTier.RARE)
nkota.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(nkota)

--Particle
local parNk = Particle.new("particleNkotas")
parNk:set_life(30, 60)
parNk:set_alpha3(1, 1, 0.35)
parNk:set_direction(180, 360, 0, 0)
parNk:set_speed(0, 0.1, 0.003, 0.02)
parNk:set_gravity(0.007, 90)
parNk:set_sprite(sprite_par, false, false, false)
parNk:set_color3(Color.RED, Color.RED, Color.BLACK)

--Nkota's heritage level up effect done by Azuline
Hook.add_pre("gml_Object_oEfLevel_Draw_0", function(self, other)
	local parent = self.parent
	if not self.parent then return end
	local data = Instance.get_data(self)
	
	if Instance.exists(parent) and not data.nkotas and not data.time then
		if parent:item_count(nkota) > 0 then
			data.nkotas = true
			data.time = 0
		end
	end
	
	if data.nkotas and data.time then 
		if Instance.exists(parent) then
			self.x = parent.ghost_x
			self.y = parent.ghost_y + self.yo
		end
		
		data.time = data.time + 1
		
		if not gm.inside_view_large(self.x, self.y) then
			return false
		end
		
		local width = GM.sprite_get_width(sprite_level) + 8
		local height = GM.sprite_get_height(sprite_level) + 8
		local particle_blend = -1
		
		if data.time < 138 then --draw the two lines
			GM.draw_sprite_ext(gm.constants.sEfLevelUp, self.image_index, self.x + (width / 2), self.y - 7, 1, 1, 0, Color.FUCHSIA, 1)
			GM.draw_sprite_ext(gm.constants.sEfLevelUp, self.image_index, self.x - (width / 2), self.y - 7, -1, 1, 0, Color.FUCHSIA, 1)
		end
		
		GM.draw_sprite_ext(sprite_level, data.time * 0.2, self.x, self.y, 1, 1, 0, Color.WHITE, 1)
		
		if data.time <= 4 then
			local fskip = 1
			if Global.__frameskip then
				fskip = 2
			end
			
			for i=1, fskip do
				parNk:create(self.x + math.random(width / -2 + 8, width / 2 + 8), self.y + math.random(-10, -5), math.random(1, 2), Particle.System.DAMAGE_ABOVE)
				parNk:set_subimage(math.random(0, sprite_par.subimages - 1))
			end
		end
		
		return false
	end
end)

--particle drawing on player
nkota.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local player = Instance.wrap(actor_unwrapped)
	if math.random(0, 9) then
		local particlex = player.x + math.random(-10, 10)
		local particley = player.y + math.random(-10, 6)
		if gm.point_distance(player.x, player.y, particlex, particley) <= 4 then
			parNk:create(particlex, particley, 1, Particle.System.BELOW)
			parNk:set_subimage(math.random(0, sprite_par.subimages - 1))
		end
	end
end, EffectDisplay.DrawPriority.BODY_PRE)

--Dedicated Chest spawning function
local function makeChest(inst)
	local data = Instance.get_data(inst)
	
	local stacks = inst:item_count(nkota)
	
	local levelCalc = stacks * (math.sqrt(GM._mod_game_getDirector().player_level * 13) - 4)
	
	local chest
	--chest odds math
	local roll = math.random(0, 100)
	if roll <= ((0.2 * levelCalc) - 1) then
		chest = Object.find("Chest5"):create(inst.x, inst.y)
		chest:screen_shake(10)
		sound:play(chest.x, chest.y, 1, 0.7 + math.random() * 0.2)
	elseif roll <= (4 * levelCalc) then
		chest = Object.find("Chest2"):create(inst.x, inst.y)
		chest:screen_shake(6)
		sound:play(chest.x, chest.y, 1, 0.8 + math.random() * 0.2)
	else
		chest = Object.find("Chest1"):create(inst.x, inst.y)
		chest:screen_shake(2)
		sound:play(chest.x, chest.y, 1, 0.9 + math.random() * 0.2)
	end
	
	--settin' chest
	chest.cost = 0
	chest:interactable_cache_strings()
	chest.depth = 1
	--cue cleanup
	Instance.get_data(chest).nkDestroy = 180
	--text :)
	chest.text = "<r><spr NkotasParticle 3><spr NkotasParticle 12><spr NkotasParticle 1><spr NkotasParticle 9><spr NkotasParticle 13> <spr NkotasParticle 8><spr NkotasParticle 5><spr NkotasParticle 18><spr NkotasParticle 9><spr NkotasParticle 20><spr NkotasParticle 1><spr NkotasParticle 7><spr NkotasParticle 5>..</c>"
	if not ssr_is_colliding_stage(chest) then
		ssr_move_contact_solid(chest, 90, math.huge)
	end
	
	local flash = GM.instance_create(chest.x, chest.y, gm.constants.oEfFlash)
	flash.parent = chest
	flash.rate = 0.05
	flash.image_alpha = 1
	flash.image_blend = Color.RED
	
	--chest particle burst
	local height = gm.round(gm.sprite_get_height(chest.sprite_index) / 4)
	local width = gm.round(gm.sprite_get_width(chest.sprite_index) / 4)
	
	for i = 15, math.random(16, 40) do
		Alarm.add(math.random(0, 20), function()
			if not Util.bool(Global.__run_exists) then return end
			
			parNk:set_subimage(math.random(0, sprite_par.subimages - 1))
			parNk:create(chest.x + math.random(-width - 5, width + 5), chest.y + math.random(-height - 20, height - 10), 1, Particle.System.ABOVE)
		end)
	end
	
	ssr_create_fadeout(chest.x, chest.y + 15, 1, sprite_txt, 0.16, 0.05) --using fadeout as a quick way to draw the display

end

--give chest on levelup
Hook.add_post(gm.constants["player_level_up@gml_Object_oDirectorControl_Create_0"], function()
	for _, actor in ipairs(nkota:get_holding_actors()) do
		
		local data = Instance.get_data(actor)
		
		local tp = Instance.find(gm.constants.oTeleporter) 
		local etp = Instance.find(gm.constants.oTeleporterEpic)
		
		--check if player levels up while leaving stage
		if tp then
			if tp.active >= 4 then --tp.active is 4 when leaving the stage, 5 when you teleport
		
				if not data.pendingNkotas then
					data.pendingNkotas = 1
				else
					data.pendingNkotas = data.pendingNkotas + 1
				end
				
			else
				makeChest(actor)
			end
			
		elseif etp then
			if etp.active >= 4 then --tp.active is 4 when leaving the stage, 5 when you teleport
		
				if not data.pendingNkotas then
					data.pendingNkotas = 1
				else
					data.pendingNkotas = data.pendingNkotas + 1
				end
				
			else
				makeChest(actor)
			end
			
		end
		
	end
end)

--chest post-use cleanup
Hook.add_post("gml_Object_pInteractableChest_Step_2", function(self, other, result, args)
	local data = Instance.get_data(self)
	if not data.nkDestroy then return end
	
	if self.active >= 2 and data.nkDestroy > 0 then
		data.nkDestroy = data.nkDestroy - 1
	end
	
	if data.nkDestroy <= 0 then
		if self.image_alpha > 0 then
			self.image_alpha = self.image_alpha - 0.1
		end
		
		if self.image_alpha <= 0 then
		
			--chest particle burst (copied from before lol)
			local height = gm.round(gm.sprite_get_height(self.sprite_index) / 4)
			local width = gm.round(gm.sprite_get_width(self.sprite_index) / 4)
			
			for i = 10, math.random(11, 20) do
				Alarm.add(math.random(0, 20), function()
					if not Util.bool(Global.__run_exists) then return end
					
					parNk:set_subimage(math.random(0, sprite_par.subimages - 1))
					parNk:create(self.x + math.random(-width - 5, width + 5), self.y + math.random(-height - 20, height - 10), 1, Particle.System.ABOVE)
				end)
			end
			
			self:destroy()
		end
	end

end)

--nkota payouts on tp event start
Callback.add(Callback.ON_INTERACTABLE_ACTIVATE, function(interactable, actor)
	if actor:item_count(nkota) <= 0 then return end
	
	if interactable.active == 1 then
		if gm.object_is(interactable:get_object_index(), gm.constants.pTeleporter) or interactable:get_object_index() == gm.constants.oCommand then
			makeChest(actor)
		end
	end
end)

--post-tp-levelup chest distribution
Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(nkota:get_holding_actors()) do
		local data = Instance.get_data(actor)
		
		if not data.pendingNkotas then return end
		
		if data.pendingNkotas > 0 and data.nkTimer then
			if data.nkTimer > 0 then
				data.nkTimer = data.nkTimer - 1
			else
				makeChest(actor)
				data.pendingNkotas = data.pendingNkotas - 1
				data.nkTimer = 20
			end
		elseif data.pendingNkotas <= 0 then
			data.nkTimer = nil
			data.pendingNkotas = nil
		end
	
	end

end)

--savemod compat for Nkota's carried-over chests
local sm = mods["Klehrik-SaveMod"] 
if sm then

	--Saving Data
	Callback.add(Callback.find("save", "saveMod"), function(data) --when to save the data, runs at the start of a stage that isn't stage 1.
		for _, actor in ipairs(nkota:get_holding_actors()) do
			--data is a table added by savemod,
			--so reserve a spot in that table with a subtable that includes the mod's namespace
			--to distinguish from other mods that may save data
			table.insert(data, {namespace, "nkotaRemember", 0})
			--second arg is there to distinguish data for when more ssr savemod stuff is done
			--third arg will be the actual nkotas data
			
			for _, list in ipairs(data) do --iterate through the data table and check for the namespace and specified data
				if list[1] == namespace and list[2] == "nkotaRemember" then 
					list[3] = Instance.get_data(actor).pendingNkotas --nkotas data is now stored this way
				end
			end
			
		end
	end)
	
	--Loading Data
	Callback.add(Callback.find("load", "saveMod"), function(data) --when a run is loaded through savemod
		for _, actor in ipairs(Instance.find_all(gm.constants.oP)) do 
		
			for _, list in ipairs(data) do
				if list[1] == namespace and list[2] == "nkotaRemember" then --get the mod's stored data
					Instance.get_data(actor).pendingNkotas = list[3]
				end
			end
			
		end
	end)
	
end

--queue tp levelup chest giving at stage start
Callback.add(Callback.ON_STAGE_START, function()
	if not (sm and sm.is_loading()) then
	
		for _, actor in ipairs(nkota:get_holding_actors()) do
			local data = Instance.get_data(actor)
			if data.pendingNkotas and data.pendingNkotas > 0 then
				data.nkTimer = 115
			end

		end
		
	else 
	
		if Global._current_frame == 2 then --has to be delayed slightly for savemod
			for _, actor in ipairs(nkota:get_holding_actors()) do
				local data = Instance.get_data(actor)
				if data.pendingNkotas and data.pendingNkotas > 0 then
					data.nkTimer = 115
				end

			end
		end

	end
	
end)


--lang below
	-- nkotasHeritage = {
		-- name = "Nkota's Heritage",
		-- pickup = "Earn a free chest on level up or activating the teleporter.",
		-- description = "On <b>level up</c> or <b>activating the Teleporter</c>, earn a <y>free</c> Common, <g>Uncommon</c>, or <r>Rare</c> Chest <c_stack>(+100% higher quality odds per stack)</c> based on your <b>current level</c>.",
		-- destination = "Naaga 23,\nH4D3S,\nEarth",
		-- date = "05/05/2056",
		-- story = "After Nkota's siblings attempted to get the heritage for themselves, someone stole the article in what seemed to be an act of vengeance.\nIt only fell into my hands after a young man sold it for an adequate amount of money. I am sending it to you as you might be able to help me analyze it.\n\nI am willing to sell it to a museum and give you a cut if it IS the authentic one.",
		-- priority = "<r>Fragile</c>"
	-- }