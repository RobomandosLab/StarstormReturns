-- hey its azzy !! azuline!!! az!!!! the fucking terezi pfp guy!!!!
-- artifact!!!! makes many enemy but weak enemy!!!
-- i tried commenting about everything you could get confused about

local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfMultitudeLoadout", path.combine(PATH, "Sprites/Artifacts/Multitude/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfMultitudePickup", path.combine(PATH, "Sprites/Artifacts/Multitude/pickup.png"), 1, 20, 20)

local multitude = Artifact.new(NAMESPACE, "multitude")
multitude:set_sprites(loadout, pickup)

Callback.add(Callback.TYPE.onStep, "MultitudeWave", function()
	if not multitude.active then return end
	
	local spawn = true
	
	-- if the teleporter is charged already, disable spawns
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporter)) do
		if teleporter.time >= teleporter.maxtime then
			spawn = false
			break
		end
	end
	-- apply the same thing to divine teleporters
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporterEpic)) do
		if teleporter.time >= teleporter.maxtime then
			spawn = false
			break
		end
	end
	
	-- If Providence or his Wurms are present, disable spawns
	if Instance.find(gm.constants.oBoss1):exists() or Instance.find(gm.constants.oWurmHead):exists() then
		spawn = false
	end
	
	local players = 0
	-- counting how many players are currently playing for multiplayer scaling reasons
	for _, player in ipairs(Instance.find_all(gm.constants.oP)) do
		players = players + 1
	end
	
	local director = GM._mod_game_getDirector()
	local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7) -- time required for a horde of enemies to start spawning
	
	if spawn and gm._mod_game_get_timestop() <= 0 then -- if spawns are enabled and the time isnt stopped, procceed
		if not director:get_data().multitudeTime then
			director:get_data().multitudeTime = 100 -- set the initial multitude timer
		end
		if director:get_data().multitudeTime < timeRequired then -- increment the timer by one until it reaches timeRequired
			director:get_data().multitudeTime = director:get_data().multitudeTime + 1
			
			if director:get_data().multitudeTime > timeRequired - 100 then
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
			director:get_data().multitudeTime = 0 -- reset the timer to 0 once were done
		end
	end
end)

Callback.add(Callback.TYPE.onDraw, "MultitudeWarningMessage", function()
	if not multitude.active then return end
	
	local director = GM._mod_game_getDirector()
	
	local spawn = true
	
	-- tbh not sure why in ss1 it uses a different method here for determining whether it should display or not, but who cares, it works
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporter)) do
		if teleporter.active >= 2 then
			spawn = false
			break
		end
	end
	-- apply the same thing to divine teleporters
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporterEpic)) do
		if teleporter.active >= 2 then
			spawn = false
			break
		end
	end
	
	if Instance.find(gm.constants.oBoss1):exists() or Instance.find(gm.constants.oWurmHead):exists() then
		spawn = false
	end
	
	local players = 0
	for _, player in ipairs(Instance.find_all(gm.constants.oP)) do
		players = players + 1
	end
	
	-- display text warning about an incoming wave
	local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7)
	local actor = Player.get_client()
	if spawn and director:get_data().multitudeTime then
		if director:get_data().multitudeTime < timeRequired - 200 then
			if director:get_data().multitudeTime > timeRequired - 500 then
				gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1) -- makes the text use normal white font
				gm.scribble_draw(actor.ghost_x, actor.ghost_y - 60, Language.translate_token("artifact.multitude.arriving")) -- the line itself is in the language file
			elseif director:get_data().multitudeTime > timeRequired - 1000 then
				gm.scribble_set_starting_format("fntNormal", Color.WHITE, 1)
				gm.scribble_draw(actor.ghost_x, actor.ghost_y - 60, Language.translate_token("artifact.multitude.approaching"))
			end
		end
	end
end)

Callback.add(Callback.TYPE.onEnemyInit, "MultitudeEnemyStatReduction", function(actor)
	if not multitude.active then return end
	
	-- reduce enemy stats when the artifact is active
	if actor:exists() then
		if actor.team == 2 and not GM.actor_is_boss(actor) then
			if actor.exp_worth then
				actor.exp_worth = actor.exp_worth * 0.4
			end
			actor.maxhp = actor.maxhp * 0.7
			actor.maxhp_base = actor.maxhp
			actor.hp = actor.maxhp

			actor.armor = actor.armor * 0.8
			actor.damage = gm.round(actor.damage * 0.7)
		end
	end
end)