local sprite = Resources.sprite_load(NAMESPACE, "WonderHerbs", path.combine(PATH, "Sprites/Items/wonderHerbs.png"), 1, 16, 16)

local wonderHerbs = Item.new(NAMESPACE, "wonderHerbs")
wonderHerbs:set_sprite(sprite)
wonderHerbs:set_tier(Item.TIER.common)
wonderHerbs:set_loot_tags(Item.LOOT_TAG.category_healing)

local color_herbs = Color.from_rgb(143, 255, 38)

local preserve_number
gm.pre_script_hook(gm.constants.actor_heal_raw, function(self, other, result, args)
	local actor = Instance.wrap(args[1].value)
	local stack = actor:item_stack_count(wonderHerbs)
	if stack > 0 then
		local amount = args[2].value
		preserve_number = amount

		local mult = 1 + stack * 0.12
		args[2].value = amount * mult

		local diff = amount - args[2].value

		if not gm.bool(args[3].value) then -- "is passive"
			gm.draw_damage(actor.x-12, actor.bbox_top+2, diff, 0, color_herbs, actor.team, 0)
		end
	end
end)
gm.post_script_hook(gm.constants.actor_heal_raw, function(self, other, result, args)
	if preserve_number then
		args[2].value = preserve_number -- this is necessary because leeching seed's healing number changes for some reason when you change args[2]. nightmare!!!!!
		preserve_number = nil
	end
end)
