Global.class_memento = Array.new() -- array with all the memento items

local MementoTier = ItemTier.new("Memento")
MementoTier.text_color = Color.Item.PURPLE
MementoTier.pickup_color = Color.Item.PURPLE
MementoTier.pickup_color_bright = Color.Item.PURPLE


Callback.add(Callback.ON_STEP, function()
	local actor = Instance.find(Object.find("P"))
	
	--print(Global.class_memento[1].sprite_id)
	
	if gm.input_check_pressed("aim_left") then
		Memento.create(1, actor.x + actor.image_xscale * 20, actor.y - 10)
	end
	
	if gm.input_check_pressed("aim_right") then
		Memento.create(2, actor.x + actor.image_xscale * 20, actor.y - 10)
	end
end)

Hook.add_pre(gm.constants.__lf_pPickup_step_collide_item, function(self, other, result, args)     
	local pickup = args[1].value
	local actor = args[2].value
	
	if not pickup.memento_id then return end -- if the pickup isnt a memento exit early
	
	if not Net.online or Net.host or pickup.force_pickup == actor.m_id then
		if pickup:alarm_get(0) == -1 then
			if actor.inventory_memento == nil then
				if (Net.online and Net.host) then
					gm.net_send_instance_message(17, actor.m_id)
				end
				
				GM.callback_execute(33, pickup, actor)
				--__lf_pPickup_step_collect_item(id, tplayer, -1, tequipment);
				GM.instance_callback_call(pickup.on_collect, Array.new({"Instance", "Instance"}), pickup.id, actor)
                        
                if not Net.online or Net.host then
					--equipment_set(tplayer, tequipment);
					actor.inventory_memento = pickup.memento_id
					Callback.wrap_type(Global.class_memento[pickup.memento_id].on_acquired):call(actor)
					
					if Net.online then
						GM.chat_add_system_message(1, "chat.pickup", actor.user_name_string_escaped, pickup.text1_key, pickup.text1_key_sub, 2, 1)
					end
				end
				
				return true
			end
		end
	end
	
	if actor.inventory_memento ~= nil and pickup:alarm_get(0) == -1 and actor.swap_item == 0 and actor.is_local then
		actor.swap_item = 1
		pickup.item_switch = 1
		pickup.item_switch_player = actor
	end
            
	if (Net.online and not Net.host) and pickup.item_switch == 1 then
		if actor:control_swap_pressed() then
			gm.net_send_instance_message(19, pickup.id)
		end
	end
	
	if (not Net.online or Net.host) or pickup.force_pickup == actor.m_id then
		if pickup.item_switch == 1 or pickup.force_pickup == actor.m_id then
			if actor:control_swap_pressed() or pickup.force_pickup == actor.m_id then
				if Net.online and Net.host then
					gm.net_send_instance_message(17, actor.m_id)
				end
						
				pickup.item_switch = 2
				
				if (not Net.online or Net.host) and actor.inventory_memento ~= nil then --and Global.class_memento[actor.inventory_memento].object_id ~= nil then
					Memento.create(actor.inventory_memento, pickup.x, pickup.y - 16)
					Callback.wrap_type(Global.class_memento[actor.inventory_memento].on_removed):call(actor)
				end
				
				GM.callback_execute(33, pickup, actor)
				--__lf_pPickup_step_collect_item(id, tplayer, -1, tequipment);
				GM.instance_callback_call(pickup.on_collect, Array.new({"Instance", "Instance"}), pickup.id, actor)
				
				if not Net.online or Net.host then
					--equipment_set(tplayer, tequipment);
					actor.inventory_memento = pickup.memento_id
					Callback.wrap_type(Global.class_memento[pickup.memento_id].on_acquired):call(actor)
				
					if Net.online then
						GM.chat_add_system_message(1, "chat.pickup", actor.user_name_string_escaped, pickup.text1_key, pickup.text1_key_sub, 2, 1)
					end
				end
				
				return true
			end
		end
	end
            
	return false
end)

-- shows the switch prompt when you are able to switch mementos
Hook.add_pre("gml_Object_pPickup_Draw_0", function(self, other) 
	if not self.memento_id then return end

	if self.item_switch == 1 then
		local string

		if GM.player_util_get_hold_swap(self.item_switch_player) then
			string = GM.translate("ui.memento.mementoHoldSwap", GM.control_string(self.item_switch_player.input_player_index, "interact"))
		else
			string = GM.translate("ui.memento.mementoSwap", GM.control_string(self.item_switch_player.input_player_index, "swap"))
		end

		GM.scribble_set_starting_format("fntNormal", 16777215, 1)
		GM.scribble_draw(Math.round(self.x), Math.round(self.y) + 80, string)
	end
end)

Memento = {} -- api class

function Memento.new(identifier) -- rn just using this as a reference for all the data mementos would need to have
	local size = Global.class_memento:size()

	Global.class_memento:push(Struct.new({
		identifier = identifier,
		index = size + 1,
		sprite_id = 0,
		on_acquired = Callback.new(identifier.."OnAcquired"),
		on_removed = Callback.new(identifier.."OnRemoved"),
	}))

	return Global.class_memento[size + 1]
end

function Memento.create(index, x, y) -- this should probably be an instance method (also it should do more than just take the index)
	if not Global.class_memento[index] then return end

	local pickup = Instance.create(x, y, gm.constants.pPickup)
	pickup.sprite_index = Global.class_memento[index].sprite_id
	pickup.memento_id = index
	pickup.tier = MementoTier
end