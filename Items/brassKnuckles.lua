local sprite = Sprite.new("BrassKnuckles", path.combine(PATH, "Sprites/Items/brassKnuckles.png"), 1, 15, 12)
local sprite_effect = Sprite.new("EfBrassKnuckles", path.combine(PATH, "Sprites/Items/Effects/brassKnuckles.png"), 4, 28, 24)
local sound = Sound.new("BrassKnuckles", path.combine(PATH, "Sounds/Items/brassKnuckles.ogg"))

local brassKnuckles = Item.new("brassKnuckles")
brassKnuckles:set_sprite(sprite)
brassKnuckles:set_tier(ItemTier.COMMON)
brassKnuckles.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(brassKnuckles)

brassKnuckles.effect_display = EffectDisplay.func(function(actor, x, y)
	local radius = 30 + 30 * Instance.wrap(actor):item_count(brassKnuckles)
	gm.draw_set_alpha(0.2)
	gm.draw_set_colour(0)
	gm.draw_circle(x, y, radius - 1, true)
	gm.draw_circle(x, y, radius + 1, true)
	gm.draw_set_alpha(1)
end)

DamageCalculate.add(function(api)
	if not Instance.exists(api.parent) then return end

	local count = api.parent:item_count(brassKnuckles)
	if count <= 0 then return end
	
	if count > 0 then
		local radius = 30 + 30 * count
		local dx = api.hit_x - api.parent.x
		local dy = api.hit_y - api.parent.y

		-- squared distance check
		if (dx * dx + dy * dy) <= (radius * radius) then
			api.damage = math.ceil(api.damage * 1.35)
			api.damage_col = gm.merge_colour(api.damage_col, 0, 0.25) -- tint damage number grey
			sound:play(api.hit_x, api.hit_y, 0.55, 0.8 + math.random() * 0.4)

			-- don't do hitsparks if the attack is the red damage from commando's wound debuff
			-- cause it always has an xscale of 1 and creates an ugly doubled up effect
			if api.attack_flags & AttackFlag.COMMANDO_WOUND_DAMAGE == 0 then
				
				if not api.true_hit then return end

				local effect = Object.find("EfSparks"):create(api.true_hit.x, api.true_hit.y)
				effect.sprite_index = sprite_effect
				effect.image_xscale = api.xscale
			end
		end
	end
end)
