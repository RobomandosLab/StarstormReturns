local SPRITE_PATH = path.combine(PATH, "Sprites/Elites/Poison")
local SOUND_PATH = path.combine(PATH, "Sounds/Elites/Poison")

local sprite_icon = Resources.sprite_load(NAMESPACE, "EliteIconPoison", path.combine(SPRITE_PATH, "icon.png"), 1, 14, 10)
local sprite_palette = Resources.sprite_load(NAMESPACE, "ElitePalettePoison", path.combine(SPRITE_PATH, "palette.png"))

local sound_poison_cloud = Resources.sfx_load(NAMESPACE, "PoisonCloud", path.combine(SOUND_PATH, "poisonCloud.ogg"))
local sound_poison_inflict = Resources.sfx_load(NAMESPACE, "PoisonInflict", path.combine(SOUND_PATH, "poisonInflict.ogg"))

local elitePoison = Elite.new(NAMESPACE, "poison")
elitePoison.healthbar_icon = sprite_icon
elitePoison.palette = sprite_palette
elitePoison.blend_col = Color.PURPLE

GM.elite_generate_palettes()

local itemEliteOrbPoison = Item.new(NAMESPACE, "eliteOrbPoison", true) -- true for no logbook
itemEliteOrbPoison.is_hidden = true

elitePoison:clear_callbacks()
elitePoison:onApply(function(actor)
	actor:item_give(itemEliteOrbPoison)
end)

itemEliteOrbPoison:clear_callbacks()
itemEliteOrbPoison:onHitProc(function(actor, victim, stack, hit_info)
	GM.sound_play_networked(sound_poison_inflict, 1, 0.9 + math.random() * 0.2, victim.x, victim.y)

	local dot = GM.instance_create(victim.x, victim.y, gm.constants.oDot)
	dot.parent = actor
	dot.team = actor.team
	dot.target = victim

	dot.damage = math.ceil(victim.maxhp * 0.03)
	dot.ticks = 4
	dot.rate = 60
	dot.textColor = Color.PURPLE

	dot:alarm_set(0, dot.rate) -- oDot usually does its first tick instantly -- make it delayed
end)
itemEliteOrbPoison:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	local data = actor:get_data()
	if not data.poison_timer then
		data.poison_timer = 30
	end

	data.poison_timer = data.poison_timer - 1
	if data.poison_timer < 0 then
		data.poison_timer = 30 + math.random(30)

		if math.random() < 0.05 then
			GM.sound_play_networked(sound_poison_cloud, 1, 0.9 + math.random() * 0.2, actor.x, actor.y)

			local cloud = GM.instance_create(actor.x, actor.y, gm.constants.oMushDust)
			cloud.parent = actor
			cloud.team = actor.team
			cloud.damage = actor.damage * 0.3
			cloud:alarm_set(0, 60 * 5) -- set lifetime
		end
	end
end)

local blacklist = {
	["magmaWorm"] = true,
}

local all_monster_cards = Monster_Card.find_all()
for i, card in ipairs(all_monster_cards) do
	if not blacklist[card.identifier] then
		local elite_list = List.wrap(card.elite_list)
		if not elite_list:contains(elitePoison) then
			elite_list:add(elitePoison)
		end
	end
end
