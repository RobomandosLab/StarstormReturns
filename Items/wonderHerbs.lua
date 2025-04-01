local sprite = Resources.sprite_load(NAMESPACE, "WonderHerbs", path.combine(PATH, "Sprites/Items/wonderHerbs.png"), 1, 16, 16)

local wonderHerbs = Item.new(NAMESPACE, "wonderHerbs")
wonderHerbs:set_sprite(sprite)
wonderHerbs:set_tier(Item.TIER.common)
wonderHerbs:set_loot_tags(Item.LOOT_TAG.category_healing)
wonderHerbsID = wonderHerbs.value

local HEAL_COLOR = Color.from_rgb(143, 255, 38)

-- doesn't use onHeal due to its implementation not sufficiently covering every source of healing

local preserve_number
gm.pre_script_hook(gm.constants.actor_heal_raw, function(self, other, result, args)
	--local actor = Instance.wrap(args[1].value)
	--local stack = actor:item_stack_count(wonderHerbs)

	-- it's a smidge faster to just use these directly
	local actor = args[1].value or -4
	local stack = gm.item_count(actor, wonderHerbsID) or 0

	if stack > 0 then
		local in_amount = args[2].value
		local is_passive = args[3].value
		preserve_number = in_amount

		local mult = 1 + stack * 0.12

		local new_amount = in_amount * mult
		if not is_passive then
			-- non-regen healing will always be increased by atleast 1
			new_amount = math.max(new_amount, in_amount + 1)

			local diff = new_amount - in_amount
			gm.draw_damage(actor.x, actor.bbox_top+2, diff, 0, HEAL_COLOR, 4, 0)
		end

		args[2].value = new_amount
	end
end)
-- the argument is set back to its unmodified value to avoid weird inconsistencies where some cases end up modifying the vanilla healing number and others don't
-- it's weird and annoying and stupid and i hate it, but it is what it is
gm.post_script_hook(gm.constants.actor_heal_raw, function(self, other, result, args)
	if preserve_number then
		args[2].value = preserve_number
		preserve_number = nil
	end
end)
