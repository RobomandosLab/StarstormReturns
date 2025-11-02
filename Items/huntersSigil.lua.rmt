local item_sprite = Resources.sprite_load(NAMESPACE, "HuntersSigil", path.combine(PATH, "Sprites/Items/huntersSigil.png"), 1, 15, 15)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffSigil", path.combine(PATH, "Sprites/Buffs/sigil.png"), 1, 6, 9)
local sound = Resources.sfx_load(NAMESPACE, "SigilBuff", path.combine(PATH, "Sounds/Items/huntersSigil.ogg"))

local ZONE_RADIUS = 64
local ZONE_RADIUS_SQ = ZONE_RADIUS^2

local huntersSigil = Item.new(NAMESPACE, "huntersSigil")
huntersSigil:set_sprite(item_sprite)
huntersSigil:set_tier(Item.TIER.uncommon)
huntersSigil:set_loot_tags(Item.LOOT_TAG.category_damage)

local buffSigil = Buff.new(NAMESPACE, "huntersSigil")
buffSigil.icon_sprite = buff_sprite
buffSigil.is_timed = true
buffSigil.max_stack = math.huge

local objSigilZone = Object.new(NAMESPACE, "EfSigilZone")
objSigilZone.obj_depth = -260

huntersSigil:clear_callbacks()
huntersSigil:onAcquire(function(actor, stack)
	if gm._mod_net_isClient() then return end
	local data = actor:get_data()
	if not data.sigil_timer then
		data.sigil_timer = 0
		data.sigil_zone = -4
	end
end)
huntersSigil:onRemove(function(actor, stack)
	if gm._mod_net_isClient() then return end
	if stack == 1 then
		local data = actor:get_data()
		Instance.wrap(data.sigil_zone):destroy()
		data.sigil_timer = nil
		data.sigil_zone = nil
	end
end)

huntersSigil:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end
	local data = actor:get_data()

	if actor.pHspeed == 0 and actor.pVspeed == 0 and not gm.actor_state_is_climb_state(actor.actor_state_current_id) then
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
end)

objSigilZone:clear_callbacks()
objSigilZone:onCreate(function(self)
	self.parent = -4
	self.timer = 0
	self.stack = 1
	self:sound_play(sound, 1, 0.9 + math.random() * 0.2)
	self:instance_sync()
end)
objSigilZone:onStep(function(self)
	if not GM.actor_is_alive(self.parent) then
		self:destroy()
		return
	end

	if self.timer % 5 == 0 then
		local to_buff = List.wrap(self:find_characters_circle(self.x, self.y, ZONE_RADIUS, false, self.parent.team, true))

		for _, target in ipairs(to_buff) do
			local diff = self.stack - target:buff_stack_count(buffSigil)
			if diff > 0 then
				-- only has an effect on the host
				target:buff_apply(buffSigil, 10, diff)
			else
				-- maintain the buff without clobbering the network
				GM.set_buff_time_nosync(target, buffSigil, 10)
			end
		end
	end

	self.timer = self.timer + 1

	if gm._mod_net_isClient() then return end
	-- host handles destroying the zone when its owner leaves it

	local dx = self.x - self.parent.x
	local dy = self.y - self.parent.y
	if (dx * dx + dy * dy) > ZONE_RADIUS_SQ then
		self:destroy()
	end
end)
objSigilZone:onDestroy(function(self)
	self:instance_destroy_sync()
end)

objSigilZone:onDraw(function(self)
	gm.draw_set_colour(Color.RED)
	gm.gpu_set_blendmode(1)
	gm.draw_set_alpha(0.5 + math.random()*0.2)

	gm.draw_circle(self.x, self.y, ZONE_RADIUS, true)

	gm.draw_set_alpha(1)
	gm.gpu_set_blendmode(0)
end)

objSigilZone:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_ushort(self.stack)
end)
objSigilZone:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.stack = buffer:read_ushort()
end)

buffSigil:clear_callbacks()
buffSigil:onStatRecalc(function(actor, stack)
	actor.armor = actor.armor + 5 + (10 * stack)
	actor.critical_chance = actor.critical_chance + 5 + (20 * stack)
end)
