local sprite_item = Resources.sprite_load(NAMESPACE, "IceTool", path.combine(PATH, "Sprites/Items/iceTool.png"), 1, 18, 16)
local sprite_effect = Resources.sprite_load(NAMESPACE, "EfIceTool", path.combine(PATH, "Sprites/Items/Effects/iceTool.png"), 4, 13, 8)
local sound = Resources.sfx_load(NAMESPACE, "IceTool", path.combine(PATH, "Sounds/Items/iceTool.ogg"))

local particleSpark = Particle.find("ror", "Spark")

local efIceTool = Object.new(NAMESPACE, "EfIceTool")
efIceTool.obj_sprite = sprite_effect

local buffIceTool = Buff.new(NAMESPACE, "IceTool")
buffIceTool.client_handles_removal = true
buffIceTool.show_icon = false
buffIceTool.max_stack = math.huge

local iceTool = Item.new(NAMESPACE, "iceTool")
iceTool:set_sprite(sprite_item)
iceTool:set_tier(Item.TIER.common)
iceTool:set_loot_tags(Item.LOOT_TAG.category_utility)

iceTool:clear_callbacks()
iceTool:onAcquire(function(actor, stack)
	local data = actor:get_data()
	data.iceTool_jumps = stack

	if gm.actor_state_is_climb_state(actor.actor_state_current_id) then
		GM.apply_buff_internal(actor, buffIceTool, math.huge, 1)
	end
end)

iceTool:onPostStep(function(actor, stack)
	local data = actor:get_data()

	local is_climbing = gm.actor_state_is_climb_state(actor.actor_state_current_id)
	local is_airborne = gm.bool(actor.free)
	local jump_input = gm.bool(actor.moveUp) or gm.bool(actor.moveUp_buffered)

	if not is_airborne or is_climbing then
		data.iceTool_jumps = stack
		return
	end

	if jump_input and is_airborne then
		local feather_count = actor:item_stack_count(Item.find("ror", "hopooFeather"))

		-- make sure feathers have been exhausted
		if actor.jump_count >= feather_count and data.iceTool_jumps > 0 then
			local xscale = 0
			if actor:is_colliding(gm.constants.pBlock, actor.x-1) then
				xscale = -1
			elseif actor:is_colliding(gm.constants.pBlock, actor.x+1) then
				xscale = 1
			end
			if xscale ~= 0 then
				actor.pVspeed = -actor.pVmax - 1.5
				actor.free_jump_timer = 0
				actor.jumping = true
				actor.moveUp = false
				actor.moveUp_buffered = false

				actor.pHspeed = -actor.pHmax * xscale
				actor.image_xscale = -xscale

				data.iceTool_jumps = data.iceTool_jumps - 1

				if actor:is_authority() then
					actor:net_send_instance_message(0)
				end

				if actor:buff_stack_count(buffIceTool) > 0 then
					GM.set_buff_time_nosync(actor, buffIceTool, 30)
				else
					GM.apply_buff_internal(actor, buffIceTool, 30, 3)
				end

				actor:sound_play(sound, 1, 1)
				particleSpark:create(actor.x + 6 * xscale, actor.y, 2)

				efIceTool:create(actor.x, actor.y).image_xscale = xscale
			end
		end
	end
end)

efIceTool:clear_callbacks()
efIceTool:onCreate(function(self)
	self.image_speed = 0.2
end)
efIceTool:onStep(function(self)
	if self.image_index + self.image_speed >= 4 then
		self.image_speed = 0
	end
	if self.image_speed == 0 then
		self.image_alpha = self.image_alpha - 0.2
		if self.image_alpha <= 0 then
			self:destroy()
		end
	end
end)

buffIceTool:clear_callbacks()
buffIceTool:onStatRecalc(function(actor, stack)
	actor.pHmax = actor.pHmax + stack * 0.5
end)

local stateClimb = State.find("ror", "climb")

stateClimb:clear_callbacks()
stateClimb:onEnter(function(actor, data)
	local stack = actor:item_stack_count(iceTool)
	GM.apply_buff_internal(actor, buffIceTool, math.huge, stack)
end)
stateClimb:onExit(function(actor, data)
	GM.remove_buff_internal(actor, buffIceTool)
end)
