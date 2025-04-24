local sprite = Resources.sprite_load(NAMESPACE, "BrassKnuckles", path.combine(PATH, "Sprites/Items/brassKnuckles.png"), 1, 15, 12)
local sprite_effect = Resources.sprite_load(NAMESPACE, "EfBrassKnuckles", path.combine(PATH, "Sprites/Items/Effects/brassKnuckles.png"), 4, 28, 24)
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
			local _damage_col = args[9]
			local attack_flags = args[8].value
			local true_hit = args[2].value

			_damage.value = math.ceil(_damage.value * 1.35)
			_damage_col.value = gm.merge_colour(_damage_col.value, 0, 0.25) -- tint damage number grey
			gm.sound_play_at(sound, 0.55, 0.8 + math.random() * 0.4, hit_x, hit_y)

			-- don't do hitsparks if the attack is the red damage from commando's wound debuff
			-- cause it always has an xscale of 1 and creates an ugly doubled up effect
			if attack_flags & Attack_Info.ATTACK_FLAG.commando_wound_damage == 0 then
				-- "true hit" is the instance that the attack actually hit
				-- helps for positioning the effect on brambles, worms, etc.
				if type(true_hit) == "number" then
					-- sometimes true_hit is an instance ID instead, fix it if that's the case
					true_hit = gm.CInstance.instance_id_to_CInstance[true_hit]
				end
				if not true_hit then return end

				local ef = gm.instance_create(true_hit.x, true_hit.y, gm.constants.oEfSparks)
				ef.sprite_index = sprite_effect
				ef.image_xscale = args[13].value
			end
		end
	end
end)
