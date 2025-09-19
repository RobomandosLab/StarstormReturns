local sprite = Resources.sprite_load(NAMESPACE, "DormantFungus", path.combine(PATH, "Sprites/Items/dormantFungus.png"), 1, 18, 18)
local sprite_footstep = Resources.sprite_load(NAMESPACE, "DormantFungusFootstep", path.combine(PATH, "Sprites/Items/Effects/dungus.png"), 24, 14, 24)
local sound = Resources.sfx_load(NAMESPACE, "DormantFungus", path.combine(PATH, "Sounds/Items/dormantFungus.ogg"))

local dormantFungus = Item.new(NAMESPACE, "dormantFungus")
dormantFungus:set_sprite(sprite)
dormantFungus:set_tier(Item.TIER.common)
dormantFungus:set_loot_tags(Item.LOOT_TAG.category_healing)
dormantFungus:clear_callbacks()

local parDungus = Particle.new(NAMESPACE, "parDungus")
parDungus:set_sprite(sprite_footstep, true, true, false)
parDungus:set_life(96, 96)
parDungus:set_alpha3(1, 1, 0)

local dungusShroomSync = Packet.new()
dungusShroomSync:onReceived(function(msg)
	local actor = msg:read_instance()

	if not actor:exists() then return end
	
	-- copied and pasted from uranium horseshoe basically
	parDungus:create(actor.x, actor.bbox_bottom + 1, 1)
end)

local function sync_dungus(actor)
	if not gm._mod_net_isHost() then
		log.warning("sync_dungus called on client!")
		return
	end

	local msg = dungusShroomSync:message_begin()
	msg:write_instance(actor)
	msg:send_to_all()
end

dormantFungus:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	if (math.abs(actor.pHspeed) >= actor.pHmax * 0.98) or actor.pVspeed ~= 0 then
		local actor_data = actor:get_data()

		if not actor_data.dungusTimer then
			actor_data.dungusTimer = 120
		end
		if actor_data.dungusTimer <= 0 then
			actor_data.dungusTimer = 120

			local regen = math.ceil(actor.maxhp * (1 - 1 / (0.02 * stack + 1)))
			actor:heal(regen)
			gm.sound_play_networked(sound, 1, (0.9 + math.random() * 0.2), actor.x, actor.y)
			
			-- copied and pasted from uranium horseshoe basically
			if Helper.is_false(actor.free) then
				parDungus:create(actor.x, actor.bbox_bottom + 1, 1)
				
				if gm._mod_net_isOnline() then
					sync_dungus(actor) -- particles arent synced by default so we have to use a packet for that
				end
			end
		else
			actor_data.dungusTimer = actor_data.dungusTimer - 1
		end
	end
end)


