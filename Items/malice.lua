local item_sprite = Resources.sprite_load(NAMESPACE, "malice", path.combine(PATH, "Sprites/Items/malice.png"), 1, 16, 18)
local spark_sprite = gm.constants.sSparks18s--Resources.sprite_load(NAMESPACE, "SparkMalice", path.combine(PATH, "Sprites/Items/Effects/malice.png"), 4, 8, 4)

local RANGE_BASE = 90
local RANGE_STACK = 21
local DAMAGE_COEFFICIENT = 0.45

local TRAVEL_TIME = 1 / 10 -- 10 frames
local COLOR_BRIGHT = Color.from_rgb(188, 17, 255)

local malice = Item.new(NAMESPACE, "malice")
local objEfMalice = Object.new(NAMESPACE, "EfMalice")
local partMalice = Particle.new(NAMESPACE, "Malice")

malice:set_sprite(item_sprite)
malice:set_tier(Item.TIER.common)
malice:set_loot_tags(Item.LOOT_TAG.category_damage)

partMalice:set_shape(Particle.SHAPE.disk)
partMalice:set_life(15, 25)
partMalice:set_size(0.08, 0.12, -0.005, 0)
partMalice:set_colour3(COLOR_BRIGHT, Color.PURPLE, Color.PURPLE)

local buffWound = Buff.find("ror", "commandoWound")

malice:clear_callbacks()
malice:onHitProc(function(attacker, victim, stack, hit_info)
	-- prevent proccing more than once per attack, not ideal (doesn't even work for multihit projectiles) but performance is very bad otherwise
	if hit_info.attack_info.__ssr_maliced then return end
	hit_info.attack_info.__ssr_maliced = true

	-- wounding works by firing direct attacks on each hit. this bypasses the above thing, so work around it ....
	if hit_info.attack_info:get_attack_flag(Attack_Info.ATTACK_FLAG.commando_wound_damage) then return end
	if victim:buff_stack_count(buffWound) > 0 then stack = stack * 2 end

	-- actually handle malice functionality now.
	-- avoids use of wrapping here as much as possible to try and claw up perf
	local _malice_target_list = gm.ds_list_create()

	-- looks for actor hitboxes rather than just actors directly, so that worms, brambles, etc. interact intuitively with malice
	local _count = victim.value:collision_circle_list(hit_info.x, hit_info.y, RANGE_BASE + (RANGE_STACK * stack - 1), gm.constants.pActorCollisionBase, false, true, _malice_target_list, true)
	local maliced_actors = {}
	local maliced_count = 0

	for i=1, _count do
		local target_hitbox = gm.ds_list_find_value(_malice_target_list, i - 1)
		local target_actor = gm.attack_collision_resolve(target_hitbox)

		if target_actor ~= -4 and not maliced_actors[target_actor.id]
		and target_actor.id ~= victim.id and gm.team_canhit(attacker.team, target_actor.team) then
			local m = objEfMalice:create(hit_info.x, hit_info.y)
			m.target = target_hitbox
			m.parent = attacker
			m.critical = hit_info.critical
			m.damage = math.ceil(hit_info.damage * DAMAGE_COEFFICIENT)

			maliced_actors[target_actor.id] = true
			maliced_count = maliced_count + 1

			if maliced_count >= stack then
				break
			end
		end
	end

	gm.ds_list_destroy(_malice_target_list)
end)

local __quality = 3

objEfMalice:clear_callbacks()
objEfMalice:onCreate(function(self)
	self.damage = 0
	self.critical = false
	self.parent = -4
	self.target = -4

	self.fract = 0
	self.direction = math.random(360)

	-- this is a bit silly but it seemed like a bad idea to read it in the step so lol
	__quality = Global.__pref_graphics_quality

	self:instance_sync()
end)
objEfMalice:onStep(function(self)
	if not Instance.exists(self.target) then self:destroy() return end
	if not Instance.exists(self.parent) then self:destroy() return end

	self.fract = self.fract + TRAVEL_TIME

	local target, parent = self.target, self.parent
	local tx, ty = target.x, target.y

	local coff = math.sin(self.fract * math.pi)
	self.x = gm.lerp(self.xstart, tx, self.fract) + gm.lengthdir_x(16, self.direction) * coff
	self.y = gm.lerp(self.ystart, ty, self.fract) + gm.lengthdir_y(16, self.direction) * coff

	local dx, dy = self.x - self.xprevious, self.y - self.yprevious

	-- spawn 3 particles per step at max quality, and only 1 at min
	for i=0, __quality - 1 do
		local f = i / __quality
		partMalice:create(self.x - dx * f, self.y - dy * f, 1, Particle.SYSTEM.above)
	end

	if self.fract + TRAVEL_TIME > 1 then
		if gm._mod_net_isHost() then
			local dir = gm.point_direction(self.xprevious, self.yprevious, self.x, self.y)
			local atk = self.parent:fire_direct(target, 1, dir, self.x, self.y, spark_sprite, false).attack_info
			atk.damage = self.damage
			atk.critical = self.critical
			atk.damage_color = COLOR_BRIGHT
		end

		self:destroy()
	end
end)

objEfMalice:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_instance(self.target)
end)
objEfMalice:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.target = buffer:read_instance()
end)