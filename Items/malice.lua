local sprite = Resources.sprite_load(NAMESPACE, "malice", path.combine(PATH, "Sprites/Items/malice.png"), 1, 16, 18)

local RANGE_BASE = 90
local RANGE_STACK = 21
local DAMAGE_COEFFICIENT = 0.45

local malice = Item.new(NAMESPACE, "malice")
malice:set_sprite(sprite)
malice:set_tier(Item.TIER.common)
malice:set_loot_tags(Item.LOOT_TAG.category_damage)

local objEfMalice = Object.new(NAMESPACE, "EfMalice")

local partMalice = Particle.new(NAMESPACE, "Malice")

partMalice:set_shape(Particle.SHAPE.disk)
--partMalice.set_colour3(Color.from_hex(0xBD69D6), Color.from_hex(0x784591), Color.from_hex(0x890060)) -- doesnt work !?!?
GM.part_type_colour3(partMalice, Color.from_hex(0xBD69D6), Color.from_hex(0x784591), Color.from_hex(0x890060))
partMalice:set_alpha2(1, 0)
partMalice:set_size(0.09, 0.16, -0.005, 0)
partMalice:set_speed(0, 2, -0.002, 0)
partMalice:set_direction(0, 360, 0, 50)
partMalice:set_life(3, 45)

malice:clear_callbacks()
malice:onHitProc(function(actor, victim, stack, hit_info)
	local targets = List.wrap(gm.find_characters_circle(victim.x, victim.y, RANGE_BASE + (RANGE_STACK * stack - 1), true, victim.team, true))

	local maliced_count = 0

	-- pick random elements of the list and delete them, until the list is either empty or enough enemies have been maliced
	while #targets > 0 and maliced_count < stack do
		local index = math.random(#targets) - 1

		local to_malice = targets:get(index)
		if to_malice.id ~= victim.id then
			maliced_count = maliced_count + 1

			local m = objEfMalice:create(victim.x, victim.y)
			m.target = to_malice
			m.parent = actor
			m.critical = hit_info.critical
			m.damage = math.ceil(hit_info.damage * DAMAGE_COEFFICIENT)
		end

		targets:delete(index)
	end

	local ef = GM.instance_create(victim.x, victim.y, gm.constants.oEfCircle)
	ef.image_blend = Color.PURPLE
	ef.rate = 12
end)

objEfMalice:clear_callbacks()
objEfMalice:onCreate(function(self)
	self.damage = 0
	self.critical = false
	self.parent = -4
	self.target = -4

	self.speed = 7

	self:instance_sync()
end)
objEfMalice:onStep(function(self)
	if not Instance.exists(self.target) then self:destroy() return end
	if not Instance.exists(self.parent) then self:destroy() return end

	local x, y = self.x, self.y
	local target, parent = self.target, self.parent
	local tx, ty = target.x, target.y

	partMalice:create(x, y, 1, Particle.SYSTEM.above)

	self.direction = gm.point_direction(x, y, tx, ty)

	if gm.point_distance(x, y, tx, ty) < 8 then
		if gm._mod_net_isHost() then
			local atk = self.parent:fire_direct(target, 1, self.direction, x, y, gm.constants.sSparks6, false).attack_info
			atk.damage = self.damage
			atk.critical = self.critical
			atk.damage_color = Color.PURPLE
		end

		self:destroy()
	end
end)

-- clients dont need to know about the damage
objEfMalice:onSerialize(function(self, buffer)
	--buffer:write_uint(self.damage)
	buffer:write_instance(self.parent)
	buffer:write_instance(self.target)
end)
objEfMalice:onDeserialize(function(self, buffer)
	--self.damage = buffer:read_uint()
	self.parent = buffer:read_instance()
	self.target = buffer:read_instance()
end)
