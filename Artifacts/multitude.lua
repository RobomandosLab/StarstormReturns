-- hey its azzy !! azuline!!! az!!!! the fucking terezi pfp guy!!!!
-- artifact!!!! makes many enemy but weak enemy!!!
-- i tried commenting about everything you could get confused about

local loadout = Sprite.new("ArtifactOfMultitudeLoadout", path.combine(PATH, "Sprites/Artifacts/Multitude/loadout.png"), 3, 19, 19)
local pickup = Sprite.new("ArtifactOfMultitudePickup", path.combine(PATH, "Sprites/Artifacts/Multitude/pickup.png"), 1, 20, 20)

local multitude = Artifact.new("multitude")
multitude.sprite_loadout_id = loadout
multitude.sprite_pickup_id = pickup

local ARRIVING_TIME = 500 -- time before the horde arrives, used to display "prepare yourself...", time measured in game ticks (1 / 60 of a second)
local APPROACHING_TIME = 1000 -- time before the horde arrives, used to display "a horde of enemies is approaching", time measured in game ticks (1 / 60 of a second)

local step_callback = Callback.add(Callback.ON_STEP, function()
	if not multitude.active then return end
	
	local spawn = true
	
	-- tbh not sure why in ss1 it uses a different method here for determining whether it should display or not, but who cares, it works
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporter)) do
		if teleporter.active >= 2 then
			spawn = false
			break
		end
	end
	
	-- apply the same thing to the control panel on contact light
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oCommand)) do
		if teleporter.active >= 2 then
			spawn = false
			break
		end
	end
	
	local players = 0
	-- counting how many players are currently playing for multiplayer scaling reasons
	for _, player in ipairs(Instance.find_all(gm.constants.oP)) do
		players = players + 1
	end
	
	local director = GM._mod_game_getDirector()
	local data = Instance.get_data(director)
	local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7) -- time required for a horde of enemies to start spawning
	
	if spawn and gm._mod_game_get_timestop() <= 0 then -- if spawns are enabled and the time isnt stopped, procceed
		if not data.multitudeTime then
			data.multitudeTime = 100 -- set the initial multitude timer
		end
		if data.multitudeTime < timeRequired then -- increment the timer by one until it reaches timeRequired
			data.multitudeTime = data.multitudeTime + 1
			
			if data.multitudeTime > timeRequired - 100 then
				director.points = director.points + director.enemy_buff --  increase credit gain by a huge amount
				for _, player in ipairs(Instance.find_all(gm.constants.oP)) do
					player:screen_shake(40) -- gimme the screen shaker
				end
				local enemies = 0
				-- count all the enemies currently present
				for _, enemy in ipairs(Instance.find_all(gm.constants.pActor)) do
					if enemy.team == 2 then -- if the enemy is on the enemy team
						enemies = enemies + 1
					end
				end
				if math.random() > 0.5 and enemies < 60 then -- if there are less enemies than 60 and a 50% chance check succeeds, start spawning some enemies
					director:alarm_set(1, 1) -- force enemy spawns. contact! weve got 4, wait 6, no, 12... a lot of aliens heading your way! 
				end
			end
		else
			data.multitudeTime = 0 -- reset the timer to 0 once were done
		end
	end
end)

local draw_callback = Callback.add(Callback.ON_HUD_DRAW, function()
	local director = GM._mod_game_getDirector()
	local data = Instance.get_data(director)
	
	local spawn = true
	
	-- tbh not sure why in ss1 it uses a different method here for determining whether it should display or not, but who cares, it works
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporter)) do
		if teleporter.active >= 2 then
			spawn = false
			break
		end
	end
	
	-- apply the same thing to the control panel on contact light
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oCommand)) do
		if teleporter.active >= 2 then
			spawn = false
			break
		end
	end
	
	local players = 0
	for _, player in ipairs(Instance.find_all(gm.constants.oP)) do
		players = players + 1
	end
	
	-- display text warning about an incoming wave
	local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7)
	if spawn and data.multitudeTime then
		if data.multitudeTime < timeRequired - 200 then
			local x = Global.___view_l_x + Global.___view_l_w * (1 / 2)
			local y = Global.___view_l_y + Global.___view_l_h * (3 / 4)
			if data.multitudeTime > timeRequired - ARRIVING_TIME then
				gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1) -- makes the text use normal white font
				gm.scribble_draw(x, y, gm.translate("artifact.multitude.arriving")) -- the line itself is in the language file
			elseif data.multitudeTime > timeRequired - APPROACHING_TIME then
				gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1) -- makes the text use normal white font
				gm.scribble_draw(x, y, gm.translate("artifact.multitude.approaching")) -- the line itself is in the language file
			end
		end
	end
end)

-- disable the artifact initially
step_callback:toggle(false)
draw_callback:toggle(false)

Callback.add(multitude.on_set_active, function(active)
	step_callback:toggle(active)
	draw_callback:toggle(active)
end)