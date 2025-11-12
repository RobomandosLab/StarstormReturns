local SPRITE_PATH = path.combine(PATH, "Sprites/Gameplay")
local SOUND_PATH = path.combine(PATH, "Sounds/Gameplay")

local sprite_portal = Sprite.new("NemPortal", path.combine(SPRITE_PATH, "void_portal.png"), 1, 37, 67)
local sprite_portal_inside = Sprite.new("NemPortalInside", path.combine(SPRITE_PATH, "void_portal_inside.png"), 1, 37, 67)

local portal = Object.new("StartPortal")
portal:set_depth(100)
portal:set_sprite(sprite_portal)

Callback.add(portal.on_create, function(self)
	self.image_yscale = 2
	self.visible = false
	
	local data = Instance.get_data(self)
	data.timer = 0
	data.draw_timer = 0
	data.state = 0
	
	self:move_contact_solid(270, -1)
end)

Callback.add(portal.on_step, function(self)
	local data = Instance.get_data(self)
	
	if data.timer >= 120 and data.state == 0 then
		data.state = 1
		self.image_xscale = 0
		
		gm.sound_play_global(gm.constants.wImpPortal1, 1, 1)
		gm.sound_play_global(gm.constants.wBoss1DeathWarp, 1, 1)
		
		self.visible = true
	elseif data.timer >= 180 and data.state == 1 then
		data.state = 2
		
		self.parent.pVspeed = -5
		self.parent.pHspeed = 3.5
		
		gm.actor_activity_set(self.parent.id, 0, 0)
	elseif data.timer >= 240 and data.state == 2 then
		data.state = 3
		gm.sound_play_global(gm.constants.wTeleporter_Complete, 1, 1)
	elseif data.timer >= 260 and data.state == 3 then
		self:destroy()
	end
	
	if data.state == 1 and self.image_xscale < 2 then
		self.image_xscale = self.image_xscale + 0.1
	elseif data.state == 3 and self.image_xscale > 0 then
		self.image_xscale = self.image_xscale - 0.1
	end
	
	data.timer = data.timer + 1
end)

Callback.add(portal.on_draw, function(self)
	-- idk what this does but this is how umbrae do their cool parallax texture
	gm.shader_set(gm.constants.shd_umbra)
	local t2 = gm.sprite_get_texture(gm.constants.sUmbraStars, 0)
	gm.texture_set_stage(gm.shader_get_sampler_index(gm.constants.shd_umbra, "tex_stars1"), t2)
	gm.texture_set_stage(gm.shader_get_sampler_index(gm.constants.shd_umbra, "tex_stars2"), gm.sprite_get_texture(gm.constants.sUmbraStars, 1))
	local t = gm.sprite_get_texture(self.sprite_index, self.image_index)
	gm.shader_set_uniform_f(gm.shader_get_uniform(gm.constants.shd_umbra, "star_sample_scale"), (1 / gm.texture_get_texel_width(t)) * gm.texture_get_texel_width(t2), (1 / gm.texture_get_texel_height(t)) * gm.texture_get_texel_height(t2))
	local px = Instance.get_data(self).timer * 1.2
	local py = 0
	gm.shader_set_uniform_f(gm.shader_get_uniform(gm.constants.shd_umbra, "star_parallax"), px * gm.texture_get_texel_width(t2), py * gm.texture_get_texel_height(t2))
	GM.draw_sprite_ext(sprite_portal_inside, self.image_index, self.x, self.y, self.image_xscale, self.image_yscale, self.image_angle, self.image_blend, self.image_alpha)
	gm.shader_reset()
end)

Callback.add(Callback.ON_STAGE_START, function()
	if GM._mod_game_getDirector().stages_passed > 0 then return end
	if Net.online then return end
	
	if Instance.find(gm.constants.oP).is_nemesis then
		local pod = Instance.find(gm.constants.oBase)
		local inst = portal:create(pod.x, pod.y)
		inst.parent = Instance.find(gm.constants.oP)
		pod:destroy()
	end
end)