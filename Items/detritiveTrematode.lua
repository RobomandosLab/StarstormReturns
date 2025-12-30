local item_sprite = Sprite.new("DetritiveTrematode", path.combine(PATH, "Sprites/Items/detritiveTrematode.png"), 1, 14, 20)
local buff_sprite = Sprite.new("BuffDisease", path.combine(PATH, "Sprites/Buffs/disease.png"), 1, 8, 8)

local DAMAGE_COLOR = Color.from_rgb(187, 211, 91)

local detritiveTrematode = Item.new("detritiveTrematode")
detritiveTrematode:set_sprite(item_sprite)
detritiveTrematode:set_tier(ItemTier.COMMON)
detritiveTrematode.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(detritiveTrematode)

local buffDisease = Buff.new("disease")
buffDisease.icon_sprite = buff_sprite
buffDisease.is_debuff = true
buffDisease.is_timed = false

Callback.add(buffDisease.on_apply, function(actor)
	actor:sound_play(gm.constants.wBrambleShoot1, 0.8, 0.4 + math.random() * 0.2)
end)

Callback.add(buffDisease.on_step, function(actor)
	if Net.client then return end
	
	if Global._current_frame % 30 == 0 then
		local dmg = Instance.get_data(actor).__ssr_trematode_damage or 1
		gm.damage_inflict(actor.id, dmg, 0, -4, actor.x, actor.y, dmg, 1, DAMAGE_COLOR)
	end
end)

DamageCalculate.add(function(api)
	if not Instance.exists(api.hit) then return end
	if not Instance.exists(api.parent) then return end
	if api.hit:buff_count(buffDisease) > 0 then return end

	local count = api.parent:item_count(detritiveTrematode)

	if count > 0 then
		if api.hit.hp <= 0 then return end
		if api.hit.team == api.parent.team then return end -- meteor procs trematode on your teammates and yourself. prevent this from becoming an issue lmaoooo
		
		local threshold = 0.1 + 0.05 * count

		if api.hit.hp <= api.hit.maxhp * threshold then
			api.hit:buff_apply(buffDisease, 60)
			Instance.get_data(api.hit).__ssr_trematode_damage = api.parent.damage * 0.5
		end
	end
end)
