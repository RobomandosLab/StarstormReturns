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
	local x, y = math.floor(actor.ghost_x+0.5), math.floor(actor.ghost_y+0.5)
	gm.draw_set_alpha(0.2)
	gm.draw_set_colour(0)
	gm.draw_circle(x, y, radius-1, true)
	gm.draw_circle(x, y, radius+1, true)
	gm.draw_set_alpha(1)
end)

-- onAttackHit callbacks and such can't be used to increase the damage because by then the visual damage number was already decided on.

-- signature:
-- damager_calculate_damage(hit_info, true_hit, hit, damage, critical, parent, proc, attack_flags, damage_col, team, climb, percent_hp, xscale, hit_x, hit_y)
gm.pre_script_hook(gm.constants.damager_calculate_damage, function(self, other, result, args)
	local parent = args[6].value

	if gm.instance_exists(parent) == 0.0 then return end

	local count = gm.item_count(parent or -4, brassKnucklesID) or 0
	if count > 0 then
		local hit_x = args[14].value
		local hit_y = args[15].value

		local radius = 30 + count * 30
		local dx = hit_x - parent.x
		local dy = hit_y - parent.y

		-- squared distance check
		if (dx * dx + dy * dy) <= (radius * radius) then
			local _damage = args[4]
			_damage.value = _damage.value * 1.35
			gm.sound_play_at(sound, 0.55, 0.8 + math.random() * 0.4, hit_x, hit_y)
		end
	end
end)
