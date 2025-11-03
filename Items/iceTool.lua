local sprite_item = Sprite.new("IceTool", path.combine(PATH, "Sprites/Items/iceTool.png"), 1, 16, 16)
local sprite_effect = Sprite.new("EfIceTool", path.combine(PATH, "Sprites/Items/Effects/iceTool.png"), 4, 13, 8)
local sound = Sound.new("IceTool", path.combine(PATH, "Sounds/Items/iceTool.ogg"))

local particleSpark = Particle.find("Spark")

-- this buff is used for the brief speed boost on walljump and while climbing
-- all applications of it use _internal functions to bypass networking, because player movement is clientside
local buffIceTool = Buff.new("IceTool")
buffIceTool.client_handles_removal = true
buffIceTool.show_icon = false
buffIceTool.max_stack = math.huge

local iceTool = Item.new("iceTool")
iceTool:set_sprite(sprite_item)
iceTool:set_tier(ItemTier.COMMON)
iceTool.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(iceTool)

Callback.add(iceTool.on_acquired, function(actor, stack)
	local data = Instance.get_data(actor)
	data.iceTool_jumps = stack

	if actor:is_climbing() then
		GM.apply_buff_internal(actor, buffIceTool, math.huge, 1)
	end
end)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(iceTool:get_holding_actors()) do
		local data = Instance.get_data(actor)
		local stack = actor:item_count(iceTool)

		local collision_dir = 0
		if actor:is_colliding(gm.constants.pBlock, actor.x - 1) then
			collision_dir = -1
		elseif actor:is_colliding(gm.constants.pBlock, actor.x + 1) then
			collision_dir = 1
		end
		
		local can_do_it = not actor:is_grounded() and collision_dir ~= 0 and data.iceTool_jumps > 0

		-- do some dumb jank to make ice tool take precedence over hopoo feather
		if can_do_it and not data.iceTool_feather_preserve then
			data.iceTool_feather_preserve = actor.jump_count
			actor.jump_count = math.huge
		elseif not can_do_it and data.iceTool_feather_preserve then
			actor.jump_count = data.iceTool_feather_preserve
			data.iceTool_feather_preserve = nil
		end

		-- just in-case something like a geyser or whatever changes the jump count ....
		-- this is all very jank and terrible but it's good enough and the QoL is worth it ....
		if actor.jump_count ~= math.huge and data.iceTool_feather_preserve then
			actor.jump_count = math.huge
		end

		if actor:is_grounded() or actor:is_climbing() then
			data.iceTool_jumps = stack
			return
		end

		if gm.bool(actor.moveUp_buffered) and can_do_it then
			print("hi")
			actor.pVspeed = -actor.pVmax - 1.5
			actor.free_jump_timer = 0
			actor.jumping = true
			actor.moveUp = false
			actor.moveUp_buffered = false

			actor.pHspeed = -actor.pHmax * collision_dir
			actor.image_xscale = -collision_dir

			data.iceTool_jumps = data.iceTool_jumps - 1

			if actor:is_authority() then
				-- send actor_position_info packet to sync the jumping velocity and stuff
				actor:net_send_instance_message(0)
			end

			if actor:buff_count(buffIceTool) > 0 then
				GM.set_buff_time_nosync(actor, buffIceTool, 30)
			else
				GM.apply_buff_internal(actor, buffIceTool, 30, 3)
			end

			actor:sound_play(sound, 1, 1)
			particleSpark:create(actor.x + 6 * collision_dir, actor.y, 2)
			ssr_create_fadeout(actor.x, actor.y, -collision_dir, sprite_effect, 0.25, 0.2)
		end
	end
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffIceTool)
    if stack <= 0 then return end
	
	actor.pHmax = actor.pHmax + stack * 0.5
end)

local stateClimb = ActorState.find("climb")

Callback.add(stateClimb.on_enter, function(actor, data)
	GM.apply_buff_internal(actor, buffIceTool, math.huge, actor:item_count(iceTool))
end)

Callback.add(stateClimb.on_exit, function(actor, data)
	GM.remove_buff_internal(actor, buffIceTool)
end)
