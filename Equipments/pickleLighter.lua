--Pickle!?
--ss1 safeguard lantern port kind of
local sprite = Sprite.new("PickleLighter", path.combine(PATH, "Sprites/Equipments/pickleLighter.png"), 2, 16, 14)

local pickle = Equipment.new("pickle")
pickle:set_sprite(sprite)
pickle.cooldown = 90 * 60
pickle.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_equipment(pickle)

Callback.add(pickle.on_use, function(actor, embryo)
	Instance.get_data(actor).pickleTimer = 20 * 60
end)

Callback.add(Callback.ON_PLAYER_STEP, function(actor)
	local data = Instance.get_data(actor)
	if not (data.pickleTimer and data.pickleTimer > 0) then return end
	if data.pickleTimer > 0 then
		data.pickleTimer = data.pickleTimer - 1
	end
	if Global._current_frame % 15 == 0 then
		local attack = actor:fire_explosion(actor.x, actor.y, 80, 80, 0.3, nil, gm.constants.sWispSpark, false).attack_info
		attack.__ssr_dam_pickle = 1
		ssr_set_no_proc(attack)
	end

end)

--vfx similar to lantern
pickle.effect_display = EffectDisplay.func(function(actor_unwrapped) --particle drawing on player
	local actor = Instance.wrap(actor_unwrapped)
	local data = Instance.get_data(actor)
	if not (data.pickleTimer and data.pickleTimer > 0) then return end

	gm.gpu_set_blendmode(1)
	gm.draw_set_alpha((math.min(60, data.pickleTimer) / 60) - 0.4)
	gm.draw_circle_color(actor.x, actor.y, (22 + gm.random(1.5)) * 2, Color.GREEN, Color.GREEN, 0)
	gm.draw_circle_color(actor.x, actor.y, (19 + gm.random(1.5)) * 2, Color.GREEN, Color.GREEN, 0)
	
	gm.gpu_set_blendmode(0)
	gm.draw_set_alpha(1)
	
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(Callback.ON_ATTACK_HIT, function(hit_info)
	if not hit_info.attack_info.__ssr_dam_pickle then return end
	
	local victim = hit_info.target
	victim:buff_apply(19, 90) --19 is the id of vanilla fear debuff

end)

--lang

	-- pickle = {
		-- name = "Pickle Lighter",
		-- pickup = "Pickle?!",
		-- description = "Gain a small light radius for 20 seconds. <r>Fears</c> and damages nearby enemies for 30% damage.",
		-- destination = "gas station",
		-- date = "twenty two",
		-- story = "<r>PICKLE NO GOOD</c>",
		-- priority = "<r>Volatile</c>"
	-- }