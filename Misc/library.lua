-- play animation and then fade it out object
local SSREfFadeout = Object.new("SSREfFadeout")

Callback.add(SSREfFadeout.on_create, function(self)
	self.fadeout_rate = 0.2
end)

Callback.add(SSREfFadeout.on_step, function(self)
	if self.image_index + self.image_speed >= gm.sprite_get_number(self.sprite_index) then
		self.image_speed = 0
	end
	
	if self.image_speed == 0 then
		self.image_alpha = self.image_alpha - self.fadeout_rate
		if self.image_alpha <= 0 then
			self:destroy()
		end
	end
end)

function ssr_create_fadeout(x, y, xscale, sprite, animation_speed, rate)
	local fadeout = Object.find("SSREfFadeout"):create(x, y)
	fadeout.image_xscale = xscale
	fadeout.sprite_index = sprite
	fadeout.image_speed = animation_speed
	fadeout.fadeout_rate = rate
end