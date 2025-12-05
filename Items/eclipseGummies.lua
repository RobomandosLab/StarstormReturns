-- uhmmmm its me azuline .... im a gummy now ...
local sprite_item = Sprite.new("EclipseGummies", path.combine(PATH, "Sprites/Items/eclipseGummies.png"), 1, 15, 16)
local sprite_buff = Sprite.new("EclipseGummiesBuff", path.combine(PATH, "Sprites/Buffs/gummiesBuff.png"), 10, 11, 12)
local sprite_ef = Sprite.new("EclipseGummiesEffect", path.combine(PATH, "Sprites/Items/Effects/gummies.png"), 6, 7, 7)

local sound_bounce = Sound.new("EclipseGummiesBounce", path.combine(PATH, "Sounds/Items/gummiesBounce.ogg"))
local sound_buff = Sound.new("EclipseGummiesBuff", path.combine(PATH, "Sounds/Items/gummiesBuff.ogg"))
local sound_buff_max = Sound.new("EclipseGummiesBuffMax", path.combine(PATH, "Sounds/Items/gummiesBuffMax.ogg"))

local gummies = Item.new("eclipseGummies")
gummies:set_sprite(sprite_item)
gummies:set_tier(ItemTier.COMMON)
gummies.loot_tags = Item.LootTag.CATEGORY_DAMAGE + Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(gummies)

local buff = Buff.new("gummyBuff")
buff.icon_sprite = sprite_buff
buff.icon_stack_subimage = true
buff.max_stack = 10
buff.is_timed = true

RecalculateStats.add(function(actor, api)
	local stack = actor:buff_count(buff)
	if stack <= 0 then return end
	
	if Instance.get_data(actor).gummy_stack_strength then
		api.pHmax_add(0.07 * stack * Instance.get_data(actor).gummy_stack_strength)
		api.attack_speed_add(0.025 * stack * Instance.get_data(actor).gummy_stack_strength)
	else
		api.pHmax_add(0.07 * stack)
		api.attack_speed_add(0.025 * stack)
	end
end)

Callback.add(buff.on_remove, function(self)
	Instance.get_data(self).gummy_stack_strength = nil
end)

local gummy_colors = {
	Color.from_hex(0xC76F91),
	Color.from_hex(0x9A6FC7),
	Color.from_hex(0x6FC781),
	Color.from_hex(0xE9BD93),
	Color.from_hex(0x6FBEC7),
	Color.from_hex(0xD4D161),
}

local obj_gummy = Object.new("EfGummy")
obj_gummy:set_depth(-20)
obj_gummy:set_sprite(sprite_ef)

Callback.add(obj_gummy.on_create, function(self)
	self.image_index = math.random(0, 5)
	self.image_speed = 0
	self.image_xscale = gm.choose(-1, 1)
	
	self.speed = 3 + math.random(2)
	self.direction = 45 + math.random(90)
	self.gravity = 0.2
	
	local data = Instance.get_data(self)
	data.bounces = 0
	data.spin_direction = self.image_xscale
	data.team = 1
	data.life = 600
	data.stack = 1
end)

Callback.add(obj_gummy.on_step, function(self)
	local data = Instance.get_data(self)
	
	if data.life > 0 then
		data.life = data.life - 1
	elseif data.life <= 0 and self.image_alpha > 0 then
		self.image_alpha = self.image_alpha - 0.1
	else
		self:destroy()
	end
	
	if data.bounces < 2 then
		self.image_angle = self.image_angle + self.speed * 2 * data.spin_direction
		
		if self:is_colliding(gm.constants.pBlock, self.x + gm.lengthdir_x(self.speed, self.direction), self.y + gm.lengthdir_y(self.speed, self.direction)) then
			if data.bounces < 1 then
				self.x = self.xprevious
				self.y = self.yprevious
				
				self:move_contact_solid(self.direction, -1)
				
				if self:is_colliding(gm.constants.pBlock, self.x, self.y + 1) then
					self.direction = 90 + math.random(-30, 30)
				elseif self:is_colliding(gm.constants.pBlock, self.x, self.y - 1) then
					self.direction = 270 + math.random(-30, 30)
				elseif self:is_colliding(gm.constants.pBlock, self.x + 1, self.y) then
					self.direction = 0 + math.random(-30, 30)
				else
					self.direction = 180 + math.random(-30, 30)
				end
				
				self.speed = self.speed * 0.5
				data.spin_direction = data.spin_direction * -1
				
				self:move_bounce_solid(false)
				
				self:sound_play(sound_bounce.value, 3, 0.9 + math.random() * 0.2)
			else			
				self.x = self.xprevious
				self.y = self.yprevious
				
				self.gravity = 0
				self.speed = 0
				
				self:move_contact_solid(self.direction, -1)
				
				if self:is_colliding(gm.constants.pBlock, self.x, self.y + 1) then
					self.image_angle = 0
				elseif self:is_colliding(gm.constants.pBlock, self.x, self.y - 1) then
					self.image_angle = 180
				elseif self:is_colliding(gm.constants.pBlock, self.x + 1, self.y) then
					self.image_angle = 90
				else
					self.image_angle = 270
				end
				
				self:move_contact_solid(self.image_angle - 90, -1)
				
				self:sound_play(sound_bounce.value, 3, 0.9 + math.random() * 0.2)
			end
			
			data.bounces = data.bounces + 1
		end
	end
	
	if data.team == 1 then
		for _, actor in ipairs(self:get_collisions(gm.constants.oP)) do
			if Instance.exists(actor) and GM.actor_is_alive(actor) then
				local flash = Object.find("EfFlash"):create(actor.x, actor.y)
				flash.parent = actor
				flash.rate = 0.05
				flash.image_alpha = 1
				flash.image_blend = gummy_colors[math.floor(self.image_index) + 1]
				
				if actor:buff_count(buff) < 9 then
					self:sound_play(sound_buff.value, 3, 1 + 0.05 * actor:buff_count(buff))
				else
					self:sound_play(sound_buff_max.value, 3, 1)
				end
				
				Instance.get_data(actor).gummy_stack_strength = data.stack
				actor:buff_apply(buff, 10 * 60)
				self:destroy()
			end
		end
	else
		for _, actor in ipairs(self:get_collisions(gm.constants.pActor)) do
			if Instance.exists(actor) and GM.actor_is_alive(actor) and actor.team == data.team then
				local flash = Object.find("EfFlash"):create(actor.x, actor.y)
				flash.parent = actor
				flash.rate = 0.05
				flash.image_alpha = 1
				flash.image_blend = gummy_colors[math.floor(self.image_index) + 1]
				
				if actor:buff_count(buff) < 9 then
					self:sound_play(sound_buff.value, 3, 1 + 0.05 * actor:buff_count(buff))
				else
					self:sound_play(sound_buff_max.value, 3, 1)
				end
				
				Instance.get_data(actor).gummy_stack_strength = data.stack
				actor:buff_apply(buff, 10 * 60)
				self:destroy()
			end
		end
	end
end)

Callback.add(Callback.ON_KILL_PROC, function(victim, killer)
	local stack = killer:item_count(gummies)
    if stack <= 0 then return end
	
	local inst = Instance.get_data(obj_gummy:create(victim.x, victim.y))
	inst.team = killer.team
	inst.stack = killer:item_count(gummies)
end)