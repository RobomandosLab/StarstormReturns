local item_sprite = Sprite.new("malice", path.combine(PATH, "Sprites/Items/malice.png"), 1, 16, 18)
local spark_sprite = gm.constants.sSparks18s

local RANGE_BASE = 90
local RANGE_STACK = 21
local DAMAGE_COEFFICIENT = 0.45

local TRAVEL_TIME = 1 / 10 -- 10 frames
local COLOR_BRIGHT = Color.from_rgb(188, 17, 255)

local malice = Item.new("malice")
local efMalice = Object.new("EfMalice")
local partMalice = Particle.new("Malice")

malice:set_sprite(item_sprite)
malice:set_tier(ItemTier.COMMON)
malice.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(malice)

partMalice:set_shape(Particle.Shape.DISK)
partMalice:set_life(15, 25)
partMalice:set_size(0.08, 0.12, -0.005, 0)
partMalice:set_colour3(COLOR_BRIGHT, Color.PURPLE, Color.PURPLE)

local buffWound = Buff.find("commandoWound")

Callback.add(Callback.ON_HIT_PROC, function(actor, victim, hit_info)
	local stack = actor:item_count(malice)
    if stack <= 0 then return end
	
	-- prevent proccing more than once per attack, not ideal (doesn't even work for multihit projectiles) but performance is very bad otherwise
	if hit_info.attack_info.__ssr_maliced then return end
	hit_info.attack_info.__ssr_maliced = true

	-- wounding works by firing direct attacks on each hit. this bypasses the above thing, so work around it ....
	if hit_info.attack_info:get_flag(AttackFlag.COMMANDO_WOUND_DAMAGE) then return end
	if victim:buff_count(buffWound) > 0 then stack = stack * 2 end
	
	-- actually handle malice functionality now.
	-- looks for actor hitboxes rather than just actors directly, so that worms, brambles, etc. interact intuitively with malice
	local hitbox_table = victim:get_collisions_circle(gm.constants.pActorCollisionBase, RANGE_BASE + (RANGE_STACK * stack - 1), hit_info.x, hit_info.y)
	local maliced_actors = {}
	local maliced_count = 0

	for _, hitbox in ipairs(hitbox_table) do
		local enemy = GM.attack_collision_resolve(hitbox)
		
		if Instance.exists(enemy) and not maliced_actors[enemy.id] and enemy.id ~= victim.id and gm.team_canhit(actor.team, enemy.team) then
			local inst = efMalice:create(hit_info.x, hit_info.y)
			inst.parent = actor
			Instance.get_data(inst).target = hitbox
			Instance.get_data(inst).critical = hit_info.critical
			Instance.get_data(inst).damage = math.ceil(hit_info.damage * DAMAGE_COEFFICIENT)

			maliced_actors[enemy.id] = true
			maliced_count = maliced_count + 1

			if maliced_count >= stack then
				break
			end
		end
	end
end)

local quality = 3

Callback.add(efMalice.on_create, function(inst)
	local data = Instance.get_data(inst)
	
	data.damage = 0
	data.critical = false
	data.target = -4
	data.fract = 0

	-- this is a bit silly but it seemed like a bad idea to read it in the step so lol
	quality = Global.__pref_graphics_quality
	
	inst.direction = math.random(360)
	inst.parent = -4
	inst:instance_sync()
end)

Callback.add(efMalice.on_step, function(inst)
	local data = Instance.get_data(inst)
	
	if not Instance.exists(data.target) then inst:destroy() return end
	if not Instance.exists(inst.parent) then inst:destroy() return end

	data.fract = data.fract + TRAVEL_TIME

	local target, parent = data.target, inst.parent
	local tx, ty = target.x, target.y

	local coff = math.sin(data.fract * math.pi)
	inst.x = gm.lerp(inst.xstart, tx, data.fract) + gm.lengthdir_x(16, inst.direction) * coff
	inst.y = gm.lerp(inst.ystart, ty, data.fract) + gm.lengthdir_y(16, inst.direction) * coff

	local dx, dy = inst.x - inst.xprevious, inst.y - inst.yprevious

	-- spawn 3 particles per step at max quality, and only 1 at min
	for i = 0, quality - 1 do
		local offset = i / quality
		partMalice:create(inst.x - dx * offset, inst.y - dy * offset, 1)
	end

	if data.fract + TRAVEL_TIME > 1 then
		if Net.host then
			local dir = Math.direction(inst.xprevious, inst.yprevious, inst.x, inst.y)
			local attack = inst.parent:fire_direct(target, 1, dir, inst.x, inst.y, gm.constants.sSparks18s, false).attack_info
			attack.damage = data.damage
			attack.critical = data.critical
			attack.damage_color = COLOR_BRIGHT
		end

		inst:destroy()
	end
end)

-- networking
local serializer = function(inst, buffer)
	buffer:write_instance(inst.parent)
	buffer:write_instance(Instance.get_data(inst).target)
end

local deserializer = function(inst, buffer)
	inst.parent = buffer:read_instance()
	Instance.get_data(inst).target = buffer:read_instance()
end

Object.add_serializers(efMalice, serializer, deserializer)