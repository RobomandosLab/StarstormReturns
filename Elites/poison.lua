local SPRITE_PATH = path.combine(PATH, "Sprites/Elites/Poison")
local SOUND_PATH = path.combine(PATH, "Sounds/Elites/Poison")

local sprite_icon = Sprite.new("EliteIconPoison", path.combine(SPRITE_PATH, "icon.png"), 1, 14, 10)
local sprite_palette = Sprite.new("ElitePalettePoison", path.combine(SPRITE_PATH, "palette.png"))

local sound_poison_cloud = Sound.new("PoisonCloud", path.combine(SOUND_PATH, "poisonCloud.ogg"))
local sound_poison_inflict = Sound.new("PoisonInflict", path.combine(SOUND_PATH, "poisonInflict.ogg"))

local elitePoison = ssr_create_elite("poison")
elitePoison.healthbar_icon = sprite_icon
elitePoison.palette = sprite_palette
elitePoison.blend_col = Color.PURPLE

GM.elite_generate_palettes()

local itemEliteOrbPoison = Item.new("eliteOrbPoison")
itemEliteOrbPoison.is_hidden = true

Callback.add(elitePoison.on_apply, function(actor)
	actor:item_give(itemEliteOrbPoison)
end)

Callback.add(Callback.ON_HIT_PROC, function(actor, victim, hit_info)
	local stack = actor:item_count(itemEliteOrbPoison)
    if stack <= 0 then return end
	
	GM.sound_play_networked(sound_poison_inflict, 1, 0.9 + math.random() * 0.2, victim.x, victim.y)

	local dot = Object.find("Dot"):create(victim.x, victim.y)
	dot.parent = actor
	dot.team = actor.team
	dot.target = victim

	dot.damage = math.ceil(victim.maxhp * 0.03)
	dot.ticks = 4
	dot.rate = 60
	dot.textColor = Color.PURPLE

	dot:alarm_set(0, dot.rate) -- oDot usually does its first tick instantly -- make it delayed
end)

Callback.add(Callback.ON_STEP, function()
	if Net.client then return end

	for _, actor in ipairs(itemEliteOrbPoison:get_holding_actors()) do
		if Instance.exists(actor) then
			local data = Instance.get_data(actor)
			
			if not data.poison_timer then
				data.poison_timer = 30
			end

			data.poison_timer = data.poison_timer - 1
			if data.poison_timer < 0 then
				data.poison_timer = 30 + math.random(30)

				if math.random() < 0.05 and actor.damage then
					GM.sound_play_networked(sound_poison_cloud, 1, 0.9 + math.random() * 0.2, actor.x, actor.y)

					local cloud = Object.find("MushDust"):create(actor.x, actor.bbox_bottom - 24)
					cloud.parent = actor
					cloud.team = actor.team
					cloud.damage = actor.damage * 0.3
					cloud:alarm_set(0, 60 * 5) -- set lifetime
				end
			end
		end
	end
end)

local blacklist = {
	["magmaWorm"] = true, -- worm uses blend_col, looks ugly, and isn't made very interesting by this elite affix anyhow
}

-- dunno if this is the best way to go about this, but it works well enough for now
local all_monster_cards = MonsterCard.find_all()
for i, card in ipairs(all_monster_cards) do
	if not blacklist[card.identifier] then
		local elite_list = List.wrap(card.elite_list)
		if not elite_list:contains(elitePoison) then
			elite_list:add(elitePoison)
		end
	end
end
