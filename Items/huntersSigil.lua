local item_sprite = Sprite.new("HuntersSigil", path.combine(PATH, "Sprites/Items/huntersSigil.png"), 1, 15, 15)
local buff_sprite = Sprite.new("BuffSigil", path.combine(PATH, "Sprites/Buffs/sigil.png"), 1, 6, 9)
local sound = Sound.new("SigilBuff", path.combine(PATH, "Sounds/Items/huntersSigil.ogg"))

local ZONE_RADIUS = 64 -- change to 80 later cuz this is just too small
local ZONE_RADIUS_SQ = ZONE_RADIUS^2

local huntersSigil = Item.new("huntersSigil")
huntersSigil:set_sprite(item_sprite)
huntersSigil:set_tier(ItemTier.UNCOMMON)
huntersSigil.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(huntersSigil)

local buffSigil = Buff.new("huntersSigil")
buffSigil.icon_sprite = buff_sprite
buffSigil.is_timed = true
buffSigil.max_stack = math.huge

local objSigilZone = Object.new("EfSigilZone")
objSigilZone.obj_depth = -260

Callback.add(huntersSigil.on_acquired, function(actor, stack)
	if Net.client then return end
	
	local data = Instance.get_data(actor)
	
	if not data.sigil_timer then
		data.sigil_timer = 0
		data.sigil_zone = -4
	end
end)

Callback.add(huntersSigil.on_removed, function(actor, stack)
	if Net.client then return end
	
	if stack == 1 then
		local data = Instance.get_data(actor)
		Instance.wrap(data.sigil_zone):destroy()
		data.sigil_timer = nil
		data.sigil_zone = nil
	end
end)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(huntersSigil:get_holding_actors()) do
		if Net.host then
			if Instance.exists(actor) and GM.actor_is_alive(actor) then
				local stack = actor:item_count(huntersSigil)
				local data = Instance.get_data(actor)

				if actor.pHspeed == 0 and actor.pVspeed == 0 and not actor:is_climbing() then
					data.sigil_timer = data.sigil_timer + 1
					
					if data.sigil_timer > 60 and not Instance.exists(data.sigil_zone) then
						local zone = objSigilZone:create(actor.x, actor.y)
						zone.parent = actor
						zone.stack = stack
						data.sigil_zone = zone.id -- use the inst's ID instead of the inst wrapper directly because that caused random errors ...
					end
				else
					data.sigil_timer = 0
				end
			end
		end
	end
end)

Callback.add(objSigilZone.on_create, function(self)	
	local data = Instance.get_data(self)
	data.timer = 0
	data.stack = 1
	
	self.parent = -4	
	self:sound_play(sound, 1, 0.9 + math.random() * 0.2)
	self:instance_sync()
end)

Callback.add(objSigilZone.on_step, function(self)
	if not GM.actor_is_alive(self.parent) then
		self:destroy()
		return
	end
		
	local data = Instance.get_data(self)

	if data.timer % 5 == 0 then
		for _, target in ipairs(self:get_collisions_circle(gm.constants.pActor, ZONE_RADIUS, self.x, self.y)) do
			if target.team == self.parent.team then
				local diff = data.stack - target:buff_count(buffSigil)
				if diff > 0 then
					-- only has an effect on the host
					target:buff_apply(buffSigil, 15, diff)
				else
					-- maintain the buff without clobbering the network
					GM.set_buff_time_nosync(target, buffSigil, 15)
				end
			end
		end
	end

	data.timer = data.timer + 1

	if Net.client then return end
	-- host handles destroying the zone when its owner leaves it

	local dx = self.x - self.parent.x
	local dy = self.y - self.parent.y
	if (dx * dx + dy * dy) > ZONE_RADIUS_SQ then
		self:destroy()
	end
end)

Callback.add(objSigilZone.on_destroy, function(self)
	self:instance_destroy_sync()
end)

Callback.add(objSigilZone.on_draw, function(self)
	gm.draw_set_colour(Color.RED)
	gm.gpu_set_blendmode(1)
	gm.draw_set_alpha(0.5 + math.random() * 0.2)
	gm.draw_circle(self.x, self.y, math.min(ZONE_RADIUS, math.sqrt(Instance.get_data(self).timer * 300)), true)
	gm.draw_set_alpha(1)
	gm.gpu_set_blendmode(0)
end)

RecalculateStats.add(function(actor, api)
	local stack = actor:buff_count(buffSigil)
    if stack <= 0 then return end
	
	api.armor_add(5 + 10 * stack)
	api.critical_chance_add(5 + 20 * stack)
end)

-- networking
local serializer = function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_ushort(self.stack)
end

local deserializer = function(self, buffer)
	self.parent = buffer:read_instance()
	self.stack = buffer:read_ushort()
end

Object.add_serializers(objSigilZone, serializer, deserializer)
