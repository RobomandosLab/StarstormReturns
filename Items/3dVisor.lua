--3D Visor (rework)
local sprite_item = Sprite.new("3dVisorSpr", path.combine(PATH, "Sprites/Items/3dVisor.png"), 1, 17, 18)
local visor = Item.new("visor") --not named "3dVisor" bc lang files aughghghghghgh
visor:set_sprite(sprite_item)
visor:set_tier(ItemTier.RARE)
visor.loot_tags = Item.LootTag.CATEGORY_DAMAGE

local buff = Buff.new("visorDebuff")
buff.is_debuff = true
buff.show_icon = false
buff.is_timed = false

ItemLog.new_from_item(visor)

--setup
Callback.add(visor.on_acquired, function(actor, stack)
	
	local data = Instance.get_data(actor)
	if not data.visorTimer then
		data.visorTimer = 0
	end

end)

--cleanup
Callback.add(visor.on_removed, function(actor, stack)
	if stack > 1 then return end
	
	local data = Instance.get_data(actor)
	
	if data.visorTimer then
		data.visorTimer = nil
	end
	
	if data.visorFlashed then
		data.visorFlashed = nil
	end
end)

--quick flash effect function
local function flash(inst, pitch, rad1, rad2)

	local fl = GM.instance_create(inst.x, inst.y, gm.constants.oEfFlash)
	fl.parent = inst
	fl.rate = 0.04
	fl.image_alpha = 0.8
	fl.image_blend = Color.WHITE
	
	local circle = Object.find("EfCircle", "ror")
	local circle1 = circle:create(inst.x, inst.y)
	circle1.radius = rad1
	circle1.image_blend = gm.choose(Color.RED, Color.AQUA)	
	
	local circle2 = circle:create(inst.x, inst.y)
	circle2.radius = rad2
	if circle1.image_blend == Color.RED then
		circle2.image_blend = Color.AQUA
	else
		circle2.image_blend = Color.RED
	end
	inst:sound_play(gm.constants.wWispSpawn, 0.7, pitch)
end

--timer/apply debuff on contact
Callback.add(Callback.ON_STEP, function()
	for _, player in ipairs(visor:get_holding_actors()) do
		
		local data = Instance.get_data(player)
		
		if not data.visorTimer then
			data.visorTimer = 0
		end
		
		--telegraph
		if data.visorTimer == 90 then
			flash(player, 1.4, 1, 5)
		end
		
		if data.visorTimer <= 0 then
			if not data.visorFlashed then
				flash(player, 1.8, 8, 20)
				player:sound_play(gm.constants.wWispSpawn, 1, 1.8)
				data.visorFlashed = true
			end
			
			local list = player:get_collisions(gm.constants.pActor, player.x, player.y)
			
			if #list > 0 then
			
				for _, actor in ipairs(list) do
				
					if actor.team ~= player.team and actor:buff_count(buff) <= 0 and GM.actor_is_classic(actor) then
						actor:buff_apply(buff, 1)
						actor:apply_knockback(-actor.image_xscale, 2 * 60, 0)
						flash(actor, 2, 8, 20)
						data.visorTimer = 25 * 60
						break
					end
					
				end

			end
		
		end
		
		if data.visorTimer > 0 then
			if data.visorFlashed then
				data.visorFlashed = nil
			end
			data.visorTimer = data.visorTimer - 1
		end
	
	end
end)

--refresh visor cooldown on stage start
Callback.add(Callback.ON_STAGE_START, function()
	for _, player in ipairs(visor:get_holding_actors()) do
		local data = Instance.get_data(player)
		data.visorTimer = 0
	end
end)

--create attacks from the debuffed victim when they're hit
Callback.add(Callback.ON_HIT_PROC, function(actor, victim, hit_info)
	if victim:buff_count(buff) <= 0 then return end
	local xOffset = gm.sprite_get_xoffset(victim.sprite_idle)
	local xx = victim.bbox_left - 9
	local dir = actor:skill_util_facing_direction()

	if dir == 0 then
		xx = victim.bbox_right + 9
	end
	
	if not hit_info.attack_info.__ssr_is_visor_beam then
		local dmg = hit_info.attack_info.damage * (0.04 * math.max(1, actor:item_count(visor)))
		
		local attack = actor:fire_bullet((xx), hit_info.attack_info.y - 5, 800, dir, dmg, 1, nil, Tracer.COMMANDO2, false).attack_info
		attack.climb = 8 * 1.35
		attack.__ssr_is_visor_beam = 1
		attack.damage_color = Color.RED
		
		local attack2 = actor:fire_bullet((xx), hit_info.attack_info.y + 5, 800, dir, dmg, 1, nil, Tracer.COMMANDO2, false).attack_info
		attack2.climb = 8 * 2.43
		attack2.__ssr_is_visor_beam = 1
		attack2.damage_color = Color.AQUA
	end
end)

--vfx
buff.effect_display = EffectDisplay.func(function(actor_unwrapped)

	local actor = Instance.wrap(actor_unwrapped)
	local data = Instance.get_data(actor)
	if data.visorTimer then
		if data.visorTimer > 0 then return end
	end

	gm.gpu_set_blendmode(1)
	gm.draw_set_alpha(1)
	gm.draw_set_color(Color.WHITE)
	
	local off = math.sin(Global._current_frame * 0.04) * 3 + (4 * math.sin(Global._current_frame * 0.04))
	local alpha = math.sin(Global._current_frame * 0.02) * 0.2 + 0.5

	gm.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x - off, actor.y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.AQUA, actor.image_alpha * alpha)
	gm.draw_sprite_ext(actor.sprite_index, actor.image_index, actor.x + off, actor.y, actor.image_xscale, actor.image_yscale, actor.image_angle, Color.RED, actor.image_alpha * alpha)
	
	gm.draw_set_alpha(1)
	gm.gpu_set_blendmode(0)
	
end, EffectDisplay.DrawPriority.BODY_POST)

visor.effect_display = buff.effect_display

--lang

		-- visor = {
			-- name = "3D Visor",
			-- pickup = "Aberrate an enemy on touch. Aberrated enemies refract your attacks as piercing beams.",
			-- description = "Permanently <r>aberrate</c> an enemy on contact.\nWhen attacked, <r>aberrated</c> enemies fire <r>two</c> <b>piercing</c> beams in your facing direction for <y>40%</c> <c_stack>(+40% per stack)</c> <y>TOTAL damage</c> each. Recharges every <b>25 seconds</c>.",
			-- destination = "33,\nGolden Shore,\nEarth",
			-- date = "06/07/2056",
			-- story = "Thank you for trusting us, this delivery wouldn't be possible without you or our partners ETECH and AACOM.\nPackage contents:\n-3D Visor (2000s model)\n-One month premium subscription to our online store.\n-Retro care kit (x2)\n\n\nEnjoy!\nAnd remember, if you aren't satisfied, returns are always an option!",
			-- priority = "<r>Vintage</c>"
		-- }