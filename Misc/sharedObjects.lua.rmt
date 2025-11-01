--Objects used in a lot of parts of the module

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