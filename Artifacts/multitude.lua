local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfMultitude", path.combine(PATH, "Sprites/Artifacts/Multitude/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfMultitude", path.combine(PATH, "Sprites/Artifacts/Multitude/pickup.png"), 1, 20, 20)
local sound1 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound1", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude1.ogg"))
local sound2 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound2", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude2.ogg"))
local sound3 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound3", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude3.ogg"))
local sound4 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound4", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude4.ogg"))
local sound5 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound5", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude5.ogg"))
local sound6 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound6", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude6.ogg"))
local sound7 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound7", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude7.ogg"))
local sound8 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound8", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude8.ogg"))
local sound9 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound9", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude9.ogg"))
local sound10 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound10", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude10.ogg"))
local sound11 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound11", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude11.ogg"))
local sound12 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound12", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude12.ogg"))
local sound13 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound13", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude13.ogg"))
local sound14 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound14", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude14.ogg"))
local sound15 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound15", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude15.ogg"))
local sound16 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound16", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude16.ogg"))
local sound17 = Resources.sfx_load(NAMESPACE, "ArtifactOfMultitudeSound17", path.combine(PATH, "Sprites/Artifacts/Multitude/multitude17.ogg"))

local function swarmincoming(actor, volume, pitch)
	local rng = math.random(0, 10)
	
	if rng >= 9 then
		actor:sound_play(sound1, volume, pitch)
	elseif rng >= 8 then
		actor:sound_play(sound2, volume, pitch)
	elseif rng >= 7 then
		actor:sound_play(sound3, volume, pitch)
	elseif rng >= 6 then
		actor:sound_play(sound4, volume, pitch)
	elseif rng >= 5 then
		actor:sound_play(sound5, volume, pitch)
	elseif rng >= 4 then
		actor:sound_play(sound6, volume, pitch)
	elseif rng >= 3 then
		actor:sound_play(sound7, volume, pitch)
	elseif rng >= 2 then
		actor:sound_play(sound8, volume, pitch)
	elseif rng >= 1 then
		actor:sound_play(sound9, volume, pitch)
	else
		actor:sound_play(sound10, volume, pitch)
	end
end

local function swarmarrived(actor, volume, pitch)
	local rng = math.random(0, 7)
	
	if rng >= 6 then
		actor:sound_play(sound11, volume, pitch)
	elseif rng >= 5 then
		actor:sound_play(sound12, volume, pitch)
	elseif rng >= 4 then
		actor:sound_play(sound13, volume, pitch)
	elseif rng >= 3 then
		actor:sound_play(sound14, volume, pitch)
	elseif rng >= 2 then
		actor:sound_play(sound15, volume, pitch)
	elseif rng >= 1 then
		actor:sound_play(sound16, volume, pitch)
	else
		actor:sound_play(sound17, volume, pitch)
	end
end

local multitude = Artifact.new(NAMESPACE, "Multitude")
multitude:set_sprites(loadout, pickup)

Callback.add(Callback.TYPE.onStep, "MultitudeOnStep", function()
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
		if not director:get_data().incoming then
			director:get_data().incoming = 0
		end
		if not director:get_data().arrived then
			director:get_data().arrived = 0
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
			director:get_data().incoming = 0
			director:get_data().arrived = 0
		end
	end
end)

Callback.add(Callback.TYPE.onHUDDraw, "MultitudeOnHUDDraw", function()
	if not multitude.active then return end
	
	local director = GM._mod_game_getDirector()
	local width = gm.display_get_width()
	local height = gm.display_get_height()
	
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
	
	for _, gamer in ipairs(Instance.find_all(gm.constants.oP)) do
		if Instance.find(gm.constants.oHUD).show_skills then
			local timeRequired = (6500 + director.time_start) / ((players * 0.3) + 0.7)
			if spawn and director:get_data().multitudeTime then
				if director:get_data().multitudeTime < timeRequired - 200 then
					if director:get_data().multitudeTime > timeRequired - 300 and director:get_data().arrived == 0 then
						--gm.scribble_set_starting_format("fntNormal", 16777215, 1)
						--gm.scribble_draw(gamer.x, gamer.y - 25, "Prepare yourself...")
						swarmarrived(gamer, 1, 1)
						director:get_data().arrived = 1
					elseif director:get_data().multitudeTime > timeRequired - 1000 and director:get_data().incoming == 0 then
						--gm.scribble_set_starting_format("fntNormal", 16777215, 1)
						--gm.scribble_draw(gamer.x, gamer.y - 25, "A horde of enemies is approaching.")
						swarmincoming(gamer, 1, 1)
						director:get_data().incoming = 1
					end
				end
			end
		end
	end
end)

Callback.add(Callback.TYPE.onEnemyInit, "MultitudeOnEnemyInit", function(actor)
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