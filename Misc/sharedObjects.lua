--Objects used in a lot of parts of the module

obj_sparks = Object.new(NAMESPACE, "sparks")
obj_sparks:set_sprite(gm.constants.sSparks2)
obj_sparks.obj_depth = 1
obj_sparks:onCreate(function(inst)
	inst.frame_index = 0
	inst.image_yscale = math.random(0, 1) * 2 - 1
	inst.image_speed = 0.33
end)
obj_sparks:onStep(function(inst)
	inst.frame_index = inst.frame_index + inst.image_speed
	inst.image_index = inst.frame_index
	if inst.frame_index >= gm.sprite_get_number(inst.sprite_index) then
		inst:destroy()
	end
end)
obj_sparks:onDraw(function(inst)
	if inst.skinnable then
		inst:actor_skin_skinnable_draw_self()
	end
end)

obj_fading_sparks = Object.new(NAMESPACE, "fading_sparks")
obj_fading_sparks:set_sprite(gm.constants.sEfChestRain)
obj_fading_sparks:set_depth(1)
obj_fading_sparks:onCreate(function(inst)
	local data = inst:get_data()
	data.delay = 5 * 60
	data.rate = 1 / 600
	data.frame_index = 0
	inst.image_speed = 0.2
end)
obj_fading_sparks:onStep(function(inst)
	local data = inst:get_data()
	local frames = gm.sprite_get_number(inst.sprite_index)
	data.frame_index = data.frame_index + inst.image_speed
	inst.image_index = math.min(inst.image_index, frames - 1)
	if inst.image_index >= frames - 1 then
		inst.image_index = frames - 1
		data.delay = data.delay - 1
		if data.delay <= 0 then
			inst.image_alpha = inst.image_alpha - data.rate
			if inst.image_alpha <= 0 then
				inst:destroy()
			end
		end
	end
end)

obj_sprite_layer = Object.new(NAMESPACE, "sprite_layer")
obj_sprite_layer:set_sprite(gm.constants.sEfChestRain)
obj_sprite_layer.obj_depth = 1
obj_sprite_layer:onCreate(function(inst)
	inst.image_speed = 0
end)
obj_sprite_layer:onStep(function(inst)
	if not inst.parent or not Instance.exists(inst.parent) then
		inst:destroy()
	end
end)
obj_sprite_layer:onDraw(function(inst)
	if inst.skinnable then
		inst:actor_skin_skinnable_draw_self()
	end
end)