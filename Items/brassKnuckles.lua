local sprite = Resources.sprite_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sprites/Items/brassKnuckles.png"), 1, 15, 12)
local sound = Resources.sfx_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sounds/Items/brassKnuckles.ogg"))

local brassKnuckles = Item.new(NAMESPACE, "brassKnuckles")
brassKnuckles:set_sprite(sprite)
brassKnuckles:set_tier(Item.TIER.common)
brassKnuckles:set_loot_tags(Item.LOOT_TAG.category_damage)

local brassKnucklesID = brassKnuckles.value

brassKnuckles:clear_callbacks()
brassKnuckles:onPostDraw(function(actor, stack)
	local radius = 30 + stack * 30
	gm.draw_set_alpha(0.2)
	gm.draw_set_colour(0)
	gm.draw_circle(actor.ghost_x, actor.ghost_y, radius-1, true)
	gm.draw_circle(actor.ghost_x, actor.ghost_y, radius+1, true)
	gm.draw_set_alpha(1)
end)

-- onAttackHit callbacks and such can't be used to increase the damage because by then the visual damage number was already decided on.

-- signature:
-- damager_calculate_damage(hit_info, true_hit, hit, damage, critical, parent, proc, attack_flags, damage_col, team, climb, percent_hp, xscale, hit_x, hit_y)
gm.pre_script_hook(gm.constants.damager_calculate_damage, function(self, other, result, args)
	--local _true_hit = args[2]
	local _hit = args[3]
	local _damage = args[4]
	--local _critical = args[5]
	local _parent = args[6]
	--local _proc = args[7]
	--local _attack_flags = args[8]
	--local _damage_col = args[9]
	--local _team = args[10]
	--local _climb = args[11]
	--local _percent_hp = args[12]
	--local _xscale = args[13]
	local _hit_x = args[14]
	local _hit_y = args[15]

	local count = gm.item_count(_parent.value, brassKnucklesID)
	if count > 0 then
		local parent = Instance.wrap(_parent.value)
		local hit_x = _hit_x.value
		local hit_y = _hit_y.value

		local radius = 30 + count * 30
		local dx = hit_x - parent.x
		local dy = hit_y - parent.y

		-- squared distance check
		if (dx * dx + dy * dy) <= (radius * radius) then
			_damage.value = _damage.value * 1.35
			gm.sound_play_at(sound, 0.55, 0.8 + math.random() * 0.4, hit_x, hit_y)
		end
	end
end)
