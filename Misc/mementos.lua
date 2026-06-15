Global.class_memento = Array.new() -- array with all the memento items

Global.class_memento:push(Struct.new({ -- add memento 1
	sprite_id = gm.constants.sHoof -- right now only has sprite data
}))

Global.class_memento:push(Struct.new({ -- add memento 2
	sprite_id = gm.constants.sBlade -- right now also only has sprite data
}))

-- THIS NEEDS A PROPER CLASS ASAP
-- I am not familiar with building out a proper class, and that is just not what im trying to look at rn
-- I'm mainly messing with mechanics rn to see what's possible

-- WHAT THIS PROBABLY NEEDS TO WORK
-- GENERAL: if we use anything normal items do like pickups, wed need to make sure to alter behaviors related to items
-- Having .find() and whatnot like the RAPI classes is probably a good idea, generally making this work like RAPI is good
-- Giving actors some kind of :memento_set() and :memento_get() like equipments would be cool obvs -- this should just edit/retrieve the variable actor.memento_id variable

Callback.add(Callback.ON_STEP, function()
	local actor = Instance.find(Object.find("P"))
	
	--print(Global.class_memento[1].sprite_id)
	
	if gm.input_check_pressed("aim_left") then
		local thingy = Instance.create(actor.x + actor.image_xscale * 20, actor.y - 10, gm.constants.pPickup)
		thingy.sprite_index = Global.class_memento[1].sprite_id
		thingy.memento_id = 1
	end
	
	if gm.input_check_pressed("aim_right") then
		local thingy = Instance.create(actor.x + actor.image_xscale * 20, actor.y - 10, gm.constants.pPickup)
		thingy.sprite_index = Global.class_memento[2].sprite_id
		thingy.memento_id = 2
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
					--Instance.create(pickup.x, pickup.y - 16, Global.class_memento[actor.inventory_memento].object_id)
					local thingy = Instance.create(pickup.x, pickup.y - 16, gm.constants.pPickup) -- right now just create whatever since we dont have any mementos yet
					thingy.sprite_index = Global.class_memento[actor.inventory_memento].sprite_id
					thingy.memento_id = actor.inventory_memento
				end
				
				GM.callback_execute(33, pickup, actor)
				--__lf_pPickup_step_collect_item(id, tplayer, -1, tequipment);
				GM.instance_callback_call(pickup.on_collect, Array.new({"Instance", "Instance"}), pickup.id, actor)
				
				if not Net.online or Net.host then
					--equipment_set(tplayer, tequipment);
					actor.inventory_memento = pickup.memento_id
				
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

Hook.add_pre("gml_Object_pPickup_Draw_0", function(self, other) 
	if not self.memento_id then return end

	if self.item_switch == 1 then
		local string

		if GM.player_util_get_hold_swap(self.item_switch_player) then
			string = "Hold F to swap memento" -- placeholder strings obvs
		else
			string = "Press F to swap memento"
		end

		print(self.dx, Math.round(self.y) + 80, string)
		GM.scribble_set_starting_format("fntNormal", 16777215, 1)
		GM.scribble_draw(Math.round(self.x), Math.round(self.y) + 80, string)
	end
end)

Memento = {} -- api class

function Memento.new(identifier)
    --Memento[identifier] = {}
    -- theres functions here that the game uses to register objects and stuff
    -- ideally we get to a point where we can call gm.item_drop_object() and it spawns a pickup parented to pPickupMemento
end