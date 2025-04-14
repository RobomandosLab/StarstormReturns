local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfMultitude", path.combine(PATH, "Sprites/Artifacts/Multitude/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfMultitude", path.combine(PATH, "Sprites/Artifacts/Multitude/pickup.png"), 1, 20, 20)

local multitude = Artifact.new(NAMESPACE, "Multitude")
multitude:set_sprites(loadout, pickup)

Callback.add(Callback.TYPE.onStep, "MultitudeWave", function()
	if not multitude.active then return end
	
	local spawn = true
	
	-- if the teleporter is charged already, set spawn to false
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporter)) do
		if teleporter.time >= teleporter.maxtime then
			spawn = false
			break
		end
	end
	
	local players = 0
	-- checking how many players are currently playing for multiplayer scaling reasons
	for _, gamer in ipairs(Instance.find_all(gm.constants.oP)) do -- "gamer" here isnt even used i just thought itd be funny lmao
		players = players + 1
	end
	
	local director = GM._mod_game_getDirector()
	local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7) -- time required for a horde of enemies to start spawning
	
	if gm._mod_game_get_timestop() <= 0 then
		if not director:get_data().multitudeTime then
			director:get_data().multitudeTime = 100
		end
		if director:get_data().multitudeTime < timeRequired then
			director:get_data().multitudeTime = director:get_data().multitudeTime + 1
			
			if director:get_data().multitudeTime > timeRequired - 100 then
				director.points = director.points + director.enemy_buff
				for _, player in ipairs(Instance.find_all(gm.constants.oP)) do
					player:screen_shake(40)
				end
				local enemies = 0
				for _, enemy in ipairs(Instance.find_all(gm.constants.pActor)) do
					if enemy.team == 2 then -- if the enemy is on the enemy team
						enemies = enemies + 1
					end
				end
				if math.random() > 0.5 and enemies < 60 then -- if there are less enemies than 60 and a 50% chance check succeeds, start spawning some enemies
					director:alarm_set(1, 1) -- contact! weve got 4, wait 6, no, 12... a lot of aliens heading your way! 
				end
			end
		else
			director:get_data().multitudeTime = 0
		end
	end
end)

Callback.add(Callback.TYPE.onDraw, "MultitudeWarningMessage", function()
	if not multitude.active then return end
	
	local director = GM._mod_game_getDirector()
	
	local spawn = true
	for _, teleporter in ipairs(Instance.find_all(gm.constants.oTeleporter)) do
		if teleporter.active >= 3 then
			spawn = false
			break
		end
	end
	
	local players = 0
	for _, gamer in ipairs(Instance.find_all(gm.constants.oP)) do
		players = players + 1
	end
	
	for _, actor in ipairs(Instance.find_all(gm.constants.oP)) do
		if Instance.find(gm.constants.oHUD).show_skills then
			local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7)
			if spawn and director:get_data().multitudeTime then
				if director:get_data().multitudeTime < timeRequired - 200 then
					if director:get_data().multitudeTime > timeRequired - 1000 then
						gm.draw_set_halign(1)
						gm.draw_set_valign(1)
						gm.draw_set_font(2.0)
						gm.draw_text_transformed_colour(actor.x, actor.y - 50, "Prepare yourself...", 1, 1, 0, Color.WHITE, Color.WHITE, Color.WHITE, Color.WHITE, 1)
					elseif director:get_data().multitudeTime > timeRequired - 2000 then
						gm.draw_set_halign(1)
						gm.draw_set_valign(1)
						gm.draw_set_font(2.0)
						gm.draw_text_transformed_colour(actor.x, actor.y - 50, "A horde of enemies is approaching.", 1, 1, 0, Color.WHITE, Color.WHITE, Color.WHITE, Color.WHITE, 1)
					end
				end
			end
		end
	end
end)

Callback.add(Callback.TYPE.onEnemyInit, "MultitudeEnemyStatReduction", function(actor)
	if not multitude.active then return end
	
	if actor:exists() then
		if actor.team == 2 and not GM.actor_is_boss(actor) then
			if actor.exp_worth then
				actor.exp_worth = actor.exp_worth * 0.4
			end
			actor.maxhp = actor.maxhp * 0.7
			actor.hp = actor.maxhp
			actor.armor = actor.armor * 0.8
			actor.damage = gm.round(actor.damage * 0.7)
		end
	end
end)