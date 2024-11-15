CustomTracer = {}

local current_id = Damager.TRACER.player_drone + 1
local funcs = {}

CustomTracer.new = function(func)
	local id = current_id
	funcs[id] = func

	current_id = current_id + 1
	return id
end

CustomTracer.make_sprite_tiling = function(sprite)
	local nine = GM.sprite_nineslice_create()
	GM.variable_struct_set(nine, "enabled", true)
	GM.variable_struct_set(nine, "tilemode", GM.array_create(5, 1))
	GM.sprite_set_nineslice(sprite, nine)
end

CustomTracer.create_tracer = function(id, x1, y1, x2, y2)
	local fn = funcs[id]
	if fn then
		fn(x1, y1, x2, y2)
	end
end

CustomTracer.create_tracer_networked = function(id, x1, y1, x2, y2)
	CustomTracer.create_tracer(id, x1, y1, x2, y2)

	if gm._mod_net_isOnline() then
		local msg = TracerPacket:message_begin()
		msg:write_byte(id)
		msg:write_int(x1)
		msg:write_int(y1)
		msg:write_int(x2)
		msg:write_int(y2)
		if gm._mod_net_isHost() then
			msg:send_to_all()
		else
			msg:send_to_host()
		end
	end
end

TracerPacket = Packet.new()
TracerPacket:onReceived(function(msg, player)
	local id = msg:read_byte()
	local x1 = msg:read_int()
	local y1 = msg:read_int()
	local x2 = msg:read_int()
	local y2 = msg:read_int()

	CustomTracer.create_tracer(id, x1, y1, x2, y2)

	if gm._mod_net_isHost() then -- relay to clients except the one who sent you it
		local msg = TracerPacket:message_begin()
		msg:write_byte(id)
		msg:write_int(x1)
		msg:write_int(y1)
		msg:write_int(x2)
		msg:write_int(y2)
		msg:send_exclude(player)
	end
end)

local bx, by, custom_id
gm.pre_code_execute("gml_Object_oBulletAttack_Step_1", function(self, other)
	if funcs[self.attack_info.tracer_kind] then
		bx, by = self.x, self.y
		custom_id = self.attack_info.tracer_kind
		self.attack_info.tracer_kind = 0
	end
end)
gm.post_code_execute("gml_Object_oBulletAttack_Step_1", function(self, other)
	if custom_id then
		CustomTracer.create_tracer_networked(custom_id, bx, by, self.x, self.y)
		custom_id = nil
	end
end)
