local item_sprite = Sprite.new("GuardingAmulet", path.combine(PATH, "Sprites/Items/guardingAmulet.png"), 1, 19, 16)
local effect_sprite = Sprite.new("EfGuardingAmulet", path.combine(PATH, "Sprites/Items/Effects/guardingAmulet.png"), 1, 4, 9)
local sound = Sound.new("GuardingAmulet", path.combine(PATH, "Sounds/Items/guardingAmulet.ogg"))

local DAMAGE_MULTIPLIER = 0.6

local guardingAmulet = Item.new("guardingAmulet")
guardingAmulet:set_sprite(item_sprite)
guardingAmulet:set_tier(ItemTier.COMMON)
guardingAmulet.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(guardingAmulet)

local function get_true_xscale(actor)
	if actor.object_index == gm.constants.oEngiTurret then
		return actor.image_xscale2
	end
	return actor.image_xscale
end

guardingAmulet.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	if not Instance.get_data(actor).amulet_pulse then return end
	
	local pulse = Instance.get_data(actor).amulet_pulse * 0.2
	
	local actor_xscale = get_true_xscale(actor)
	local xscale = (1 + pulse) * actor_xscale
	local yscale = 1 + pulse
	
	local xx = 0
	if actor.sprite_walk_half ~= nil and actor.sprite_walk_half[4] ~= nil then
		xx = actor.x - (gm.round(gm.sprite_get_width(actor.sprite_walk_half[4]) / 2 + 5)) * actor_xscale
	else
		xx = actor.x - 20 * actor_xscale
	end
	
	local yy = actor.bbox_bottom - gm.round(gm.sprite_get_height(actor.sprite_idle) / 2) + math.sin(Global._current_frame * 0.04)
	
	gm.gpu_set_blendmode(1)
	GM.draw_sprite_ext(effect_sprite, 0, xx, yy, xscale, yscale, 0, Color.WHITE, 0.75 + math.sin(Global._current_frame * 0.02) * 0.1)
	if pulse > 0 then
		GM.draw_sprite_ext(effect_sprite, 0, xx, yy, xscale, yscale, 0, Color.WHITE, pulse * 3)
	end
	gm.gpu_set_blendmode(0)
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(guardingAmulet:get_holding_actors()) do
		if Instance.exists(actor) then
			local data = Instance.get_data(actor)
			
			if not data.amulet_pulse then
				data.amulet_pulse = 0
			end
			
			if data.amulet_pulse > 0 then
				data.amulet_pulse = data.amulet_pulse - 1
			end
		end
	end
end)

-- onAttackHit callbacks and such can't be used to modify the damage because by then the visual damage number was already drawn.
DamageCalculate.add(function(api)
	local count = api.hit:item_count(guardingAmulet)
	if count <= 0 then return end
	
	if count > 0 then
		local attack_x = nil
		if api.parent and Instance.exists(api_parent) then
			attack_x = api_parent.x
		else
			attack_x = api.hit_x.value
		end
		
		-- use the x locations of the actors to determine blocking .... not ideal but it works?
		if Math.sign(api.hit.x - attack_x) == get_true_xscale(api.hit) then
			api.damage = math.ceil(api.damage * DAMAGE_MULTIPLIER ^ count)

			Instance.get_data(api.hit).amulet_pulse = 10
			api.hit:sound_play(sound, 1, 0.9 + math.random() * 0.2)
			api.hit:sound_play(gm.constants.wMercenary_Parry_Deflection, 0.5, 1.5 + math.random() * 0.5)
		end
	end
end)
