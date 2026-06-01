local sprite = Sprite.new("DenizuCrown", path.combine(PATH, "Sprites/Items/denizuCrown.png"), 1, 16, 16)
local effect = Sprite.new("DenizuCrownEffect", path.combine(PATH, "Sprites/Items/Effects/denizuCrown.png"), 1, 4, 6)

local crown = Item.new("denizuCrown")
crown:set_sprite(sprite)
crown:set_tier(ItemTier.SPECIAL)
crown.loot_tags = 0

local part_ice = Particle.new("denizuCrown")
part_ice:set_sprite(gm.constants.sEFIceCrystal, false, false, true)
part_ice:set_life(5, 10)
part_ice:set_alpha2(0.35, 0)
part_ice:set_scale(0.5, 0.5)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(crown:get_holding_actors()) do
		if Instance.exists(actor) then
			local data = Instance.get_data(actor)
			
			if not data.crystal_time then
				data.crystal_time = 0
			elseif data.crystal_time < 78 then
				data.crystal_time = data.crystal_time + 1
			else
				data.crystal_time = -78
			end
			
			data.global_time = Global._current_frame
			
			local yy = actor.y
			if actor.sprite_idle then
				yy = yy - gm.sprite_get_height(actor.sprite_idle) * 1.33
			else
				yy = yy - 20
			end
			
			yy = yy - math.sin(data.global_time * 0.02) * 5
			
			if data.global_time % 3 == 0 then
				part_ice:set_orientation(math.sin(data.crystal_time * 0.02) * -15, math.sin(data.crystal_time * 0.02) * -15, 0, 0, false)
				part_ice:create(actor.x - math.sin(data.crystal_time * 0.02) * 15, yy + 10 + math.cos((data.crystal_time + 156) / 50) * -3, 1, Particle.System.MIDDLE)
				part_ice:set_orientation(math.sin(data.crystal_time * 0.02) * 15, math.sin(data.crystal_time * 0.02) * 15, 0, 0, false)
				part_ice:create(actor.x + math.sin(data.crystal_time * 0.02) * 15, yy + 10 + math.cos((data.crystal_time + 156) / 50) * 3, 1, Particle.System.MIDDLE)
			end
		end
	end
end)

crown.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	local crystal_time = Instance.get_data(actor).crystal_time
	local global_time = Instance.get_data(actor).global_time
	
	local yy = actor.y
	if actor.sprite_idle then
		yy = yy - gm.sprite_get_height(actor.sprite_idle) * 1.33
	else
		yy = yy - 20
	end
	
	yy = yy - math.sin(global_time * 0.02) * 5
	
	GM.draw_sprite_ext(gm.constants.sEFIceCrystal, 0, actor.x - math.sin(crystal_time * 0.02) * 15, yy + 10 + math.cos((crystal_time + 156) / 50) * -3, 0.5, 0.5, math.sin(crystal_time * 0.02) * -15, Color.WHITE, 0.80 + math.sin(global_time * 0.02) * -0.2)
	GM.draw_sprite_ext(effect, 0, actor.x, yy, 1, 1, 0, Color.WHITE, 0.75 + math.sin(global_time * 0.02) * 0.1)
	GM.draw_sprite_ext(gm.constants.sEFIceCrystal, 0, actor.x + math.sin(crystal_time * 0.02) * 15, yy + 10 + math.cos((crystal_time + 156) / 50) * 3, -0.5, 0.5, math.sin(crystal_time * 0.02) * -15, Color.WHITE, 0.80 + math.sin(global_time * 0.02) * -0.2)
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(Callback.ON_STAGE_START, function()
	for _, actor in ipairs(Instance.find_all(gm.constants.oP)) do
		if actor:item_count(crown) <= 0 then
			if (actor.user_name == "-" or actor.user_name_string_escaped == "-") or 
			(actor.user_name == "_" or actor.user_name_string_escaped == "_") or 
			(actor.user_name == "Denizu" or actor.user_name_string_escaped == "Denizu") or 
			(actor.user_name == "denizu" or actor.user_name_string_escaped == "denizu") then
				actor:item_give(crown)
			end
		end
	end
end)