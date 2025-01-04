local sprite = Resources.sprite_load(NAMESPACE, "UraniumHorseshoe", path.combine(PATH, "Sprites/Items/uraniumHorseshoe.png"), 1, 14, 17)
local sprite_footstep = Resources.sprite_load(NAMESPACE, "UraniumHorseshoeFootstep", path.combine(PATH, "Sprites/Items/Effects/horseshoeFootstep.png"), 7, 3, 0)

local parHorseshoe = Particle.new(NAMESPACE, "parHorshoe")
parHorseshoe:set_sprite(sprite_footstep, true, true, false)
parHorseshoe:set_life(56, 56)

local horseshoe = Item.new(NAMESPACE, "uraniumHorseshoe")
horseshoe:set_sprite(sprite)
horseshoe:set_tier(Item.TIER.common)
horseshoe:set_loot_tags(Item.LOOT_TAG.category_utility)

horseshoe:clear_callbacks()
horseshoe:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax + 0.28 * stack
	actor.pVmax = actor.pVmax + 0.6 * stack
end)

horseshoe:onPostStep(function(actor, stack)
	local data = actor:get_data()
	if not data.horseshoeTimer then 
		data.horseshoeTimer = 1 
	end
	if actor.pHspeed ~= 0 and actor:is_grounded() then
		data.horseshoeTimer = data.horseshoeTimer + 1
	else
		data.horseshoeTimer = 1
	end
	if data.horseshoeTimer % 10 == 0 then
		parHorseshoe:set_orientation(90 + 90 * actor.image_xscale, 90 + 90 * actor.image_xscale, 0, 0, false)
		parHorseshoe:create(actor.x, actor.y + 12, 1)
	end
end)