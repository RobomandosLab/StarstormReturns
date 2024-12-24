-- CUSTOM TRACER SYSTEM
-- this aims to seamlessly extend the game's tracer system, with all the capabilities of vanilla tracers
-- attack networking transmits tracer IDs in a byte, which means there can be up to 255 fully working tracers, including vanilla ones
-- past ID 255, tracers will work locally, but will appear incorrect to other players in netplay

-- TracerKindInfo struct fields:
-- `consistent_sparks_flip`				-- if true, disables horizontal flipping of sparks on missed bullets
-- `show_sparks_if_miss`				-- if false, sparks won't appear when the bullet doesn't hit anything
-- `sparks_offset_y`					-- vertical offset for hitsparks using this tracer.
-- `show_end_sparks_on_piercing_hit`	-- if false, bullets that pierced wont show sparks on their endpoint
-- `override_sparks_miss`				-- spark sprite to use instead when missing, or -1
-- `override_sparks_solid`				-- spark sprite to use instead when hitting a solid, or -1
-- `draw_tracer`						-- if the bullet_draw_tracer function should be called

CustomTracer = {}

local last_vanilla_id = Attack_Info.TRACER.player_drone
local free_id = last_vanilla_id + 1
local funcs = {}

--- allocates a custom tracer, returning its ID and TracerKindInfo struct. this ID can be passed to bullet attacks, which automatically handles networking
CustomTracer.new = function(func)
	if free_id > 255 then
		log.warning("CustomTracer.new(): Allocated tracer IDs have exceeded 255. This will cause problems in netplay. Yell at Kris about this!")
	end

	local id = free_id
	funcs[id] = func

	free_id = free_id + 1

	local tracer_kind_info = gm["@@NewGMLObject@@"](gm.constants.TracerKindInfo)
	gm.array_set(gm.variable_global_get("tracer_info"), id, tracer_kind_info)
	return id, tracer_kind_info
end

--- calls the handler function for the given tracer ID, if one exists
--- mostly only for internal use.
CustomTracer.draw_tracer = function(id, x1, y1, x2, y2, col)
	local fn = funcs[id]
	if fn then
		fn(x1, y1, x2, y2, col)
	end
end

--- utility function that takes a given sprite ID and configures it to not stretch when used in a line tracer.
CustomTracer.make_sprite_tiling = function(sprite)
	local nine = gm.sprite_nineslice_create()
	gm.variable_struct_set(nine, "enabled", true)
	gm.variable_struct_set(nine, "tilemode", gm.array_create(5, 1))
	gm.sprite_set_nineslice(sprite, nine)
end

gm.post_script_hook(gm.constants.bullet_draw_tracer, function(self, other, result, args)
	local kind = args[1].value
	if kind <= last_vanilla_id then return end

	local col = args[2].value
	local x1, y1, x2, y2 = args[3].value, args[4].value, args[5].value, args[6].value

	CustomTracer.draw_tracer(kind, x1, y1, x2, y2, col)
end)
gm.post_script_hook(gm.constants.bullet_draw_tracer_networked, function(self, other, result, args)
	if args[1].value > 63 then
		log.warning("CustomTracer: bullet_draw_tracer_networked can't transmit tracer IDs above 63. consult Kris if this is an issue for you.")
	end
end)

-- for future reference.
-- these are the functions used by bullet_draw_tracer_networked to encode and decode tracers
-- supposedly, tracer IDs are encoded into 6 bits -- this is only true for bullet_draw_tracer_networked -- standard attacks encode the ID in 8 bits.
-- bullet_draw_tracer_networked is only used by one thing in the vanilla game -- sniper's alt utility skill
-- so it's not really worth the time to rewrite it to extend the range ..

--local net_packet_vfx_tracer_write = gm.constants.__net_packet_vfx_tracer_write___anon__30474_gml_GlobalScript_scr_network_packets_objects
--local net_packet_vfx_tracer_read = gm.constants.__net_packet_vfx_tracer_read___anon__30474_gml_GlobalScript_scr_network_packets_objects
