local sprite = Resources.sprite_load(NAMESPACE, "ArmedBackpack", path.combine(PATH, "Sprites/Items/armedBackpack.png"), 1, 16, 16)
local sound = Resources.sfx_load(NAMESPACE, "ArmedBackpack", path.combine(PATH, "Sounds/armedBackpack.ogg"))

local tracer = CustomTracer.new(function(x1, y1, x2, y2)
	local offset = -1 + math.random() * 3

	local tr = gm.instance_create(x1, y1 + offset, gm.constants.oEfLineTracer)
	tr.xend = x2
	tr.yend = y2 + offset
	tr.sprite_index = gm.constants.sPilotShoo1BTracer
	tr.image_speed = 2
	tr.rate = 0.125
	tr.bm = 1 -- additive
	tr.image_blend = Color.from_rgb(170, 78, 66)
end)

local armedBackpack = Item.new(NAMESPACE, "armedBackpack")
armedBackpack:set_sprite(sprite)
armedBackpack:set_tier(Item.TIER.common)
armedBackpack:set_loot_tags(Item.LOOT_TAG.category_damage)

armedBackpack:clear_callbacks()
armedBackpack:onPostAttack(function(actor, damager, stack)
	if not gm.bool(damager.proc) then return end

	local force_proc = damager.attack_flags & (1 << 29) ~= 0
	if math.random() <= 0.12 + (0.065 * stack) or force_proc then
		local dir = actor:skill_util_facing_direction() + 180

		-- infer the direction from the attack direction if its horizontal enough
		-- this improves many cases like huntress autoaim, suppressive fire, engi turrets, etc.
		local attack_xvector = gm.lengthdir_x(1, damager.direction)
		if attack_xvector > 0.5 then
			dir = 180
		elseif attack_xvector < -0.5 then
			dir = 0
		end

		local attack = actor:fire_bullet(actor.x - actor.image_xscale * 5, actor.y-4, 500, dir, 1.5, nil, gm.constants.sSparks1, tracer)
		attack:set_proc(false)
		actor:sound_play_networked(sound, 0.8, 1 + math.random() * 0.2, actor.x, actor.y)
	end
end)
