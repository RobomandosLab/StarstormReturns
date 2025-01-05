-- hey hey its me azuline
-- this is probably the easiest item in ssr with the exception of the fork
-- ill comment on literally everything because of this

-- load the sprites for the item and the footstep effect
local sprite = Resources.sprite_load(NAMESPACE, "UraniumHorseshoe", path.combine(PATH, "Sprites/Items/uraniumHorseshoe.png"), 1, 14, 17)
local sprite_footstep = Resources.sprite_load(NAMESPACE, "UraniumHorseshoeFootstep", path.combine(PATH, "Sprites/Items/Effects/horseshoeFootstep.png"), 7, 3, 0)

-- create and setup the footstep particle
local parHorseshoe = Particle.new(NAMESPACE, "parHorshoe")
parHorseshoe:set_sprite(sprite_footstep, true, true, false)
parHorseshoe:set_life(56, 56) -- 56 is used here because it is a multiple of 7, and 7 is how many frames are in the footstep animation

-- create and setup the item itself
local horseshoe = Item.new(NAMESPACE, "uraniumHorseshoe")
horseshoe:set_sprite(sprite)
horseshoe:set_tier(Item.TIER.common)
horseshoe:set_loot_tags(Item.LOOT_TAG.category_utility)

-- setup the effects of the item
horseshoe:clear_callbacks()
horseshoe:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax + 0.28 * stack -- default player speed is almost always 2.8, meaning that increasing the speed by +0.28 were essentially increasing it by 10%
	actor.pVmax = actor.pVmax + 0.6 * stack -- same as above except the default max jump height is 6
end)

-- making the footstep particle actually appear in game
horseshoe:onPostStep(function(actor, stack)
	local data = actor:get_data() -- get_data() can be used for storing any information about an instance (the player here). were gonna be using it in the code below
	
	-- the horseshoe timer will be nil when we start the game, and since trying to do math on a nil value is impossible we just detect if a value is nil and then set it to 1 instead
	if not data.horseshoeTimer then
		data.horseshoeTimer = 1 
	end
	
	if actor.pHspeed ~= 0 and actor:is_grounded() then -- if the player is moving on the ground, we increase the timer by one on every frame
		data.horseshoeTimer = data.horseshoeTimer + 1
	else -- if they arent, we reset it back to 1
		data.horseshoeTimer = 1
	end
	
	-- if the timer is a multiple of 10, we create a footstep particle
	-- the operator % in lua will return the remainder of a division
	-- this is also why we have been using 1 as our starting value instead of 0, cuz 0 divided by 10 will have a remainder of 0, meaning that this code will run on every tick while youre in the air or moving (which is bad cuz we dont want to do that)
	if data.horseshoeTimer % 10 == 0 then
		parHorseshoe:set_orientation(90 + 90 * actor.image_xscale, 90 + 90 * actor.image_xscale, 0, 0, false) -- actor.image_xscale is the direction the player is looking in, with 1 being right and -1 being left
		parHorseshoe:create(actor.x, actor.y + 12, 1) -- creating a particle at 12 pixels below the players y coordiante will make it at the players feet level
	end
end)