local sound = Sound.new("NemPortalPopOut", path.combine(PATH, "Sounds/Gameplay/portal_pop_out.ogg"))

local portal = Object.new("StartPortal")
portal:set_depth(100)
portal:set_sprite(Sprite.find("NemCommandoPortal"))

Callback.add(portal.on_create, function(self)	
	self.image_index = 0
	self.image_speed = 0
	
	local data = Instance.get_data(self)
	data.timer = 0
	data.state = 0
end)

Callback.add(portal.on_step, function(self)
	if not Instance.exists(self.parent) then self:destroy() return end
	local data = Instance.get_data(self)
	
	if data.timer >= 120 and data.state == 0 then
		data.state = 1
		
		self.sprite_index = self.sprite_portal
		self.image_xscale = self.parent.image_xscale
		self.image_index = 0
		self.image_speed = 0.2

		gm.sound_play_global(self.sound_portal, 1.5, 1)
	elseif data.timer >= 210 and data.state == 1 then
		data.state = 2
		
		self.parent.pVspeed = -5
		self.parent.pHspeed = 3.5
		
		gm.actor_activity_set(self.parent.id, 0, 0)

		gm.sound_play_global(sound.value, 1.5, 1)
	end
	
	data.timer = data.timer + 1

	if data.state < 2 then
		self.parent:actor_teleport(self.x, self.y - 40)
	elseif data.state >= 2 and self.image_index + self.image_speed >= self.image_number then
		self:destroy()
	end
end)

Callback.add(portal.on_draw, function(self)
	-- this is how umbrae do their cool parallax texture
	gm.shader_set(gm.constants.shd_umbra)
	local t2 = gm.sprite_get_texture(gm.constants.sUmbraStars, 0)
	gm.texture_set_stage(gm.shader_get_sampler_index(gm.constants.shd_umbra, "tex_stars1"), t2)
	gm.texture_set_stage(gm.shader_get_sampler_index(gm.constants.shd_umbra, "tex_stars2"), gm.sprite_get_texture(gm.constants.sUmbraStars, 1))
	local t = gm.sprite_get_texture(self.sprite_index, self.image_index)
	gm.shader_set_uniform_f(gm.shader_get_uniform(gm.constants.shd_umbra, "star_sample_scale"), (1 / gm.texture_get_texel_width(t)) * gm.texture_get_texel_width(t2), (1 / gm.texture_get_texel_height(t)) * gm.texture_get_texel_height(t2))
	local px = Instance.get_data(self).timer * 1.2
	local py = 0
	gm.shader_set_uniform_f(gm.shader_get_uniform(gm.constants.shd_umbra, "star_parallax"), px * gm.texture_get_texel_width(t2), py * gm.texture_get_texel_height(t2))
	GM.draw_sprite_ext(self.sprite_portal_inside, self.image_index, self.x, self.y, self.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha)
	gm.shader_reset()
end)

Callback.add(Callback.ON_STAGE_START, function()
	if GM._mod_game_getDirector().stages_passed > 0 then return end
	if Global.__gamemode_current >= 2 then return end
	if Net.online then return end
	
	if Instance.find(gm.constants.oP).is_nemesis then
		local pod = Instance.find(gm.constants.oBase)
		local inst = portal:create(pod.x, pod.y)
		inst.parent = Instance.find(gm.constants.oP)
		inst.sprite_portal = Instance.find(gm.constants.oP).sprite_portal or Sprite.find("NemCommandoPortal")
		inst.sprite_portal_inside = Instance.find(gm.constants.oP).sprite_portal_inside or Sprite.find("NemCommandoPortalInside")
		inst.sound_portal = Instance.find(gm.constants.oP).sound_portal or Sound.find("NemCommandoPortal")
		pod:destroy()
	end
end)