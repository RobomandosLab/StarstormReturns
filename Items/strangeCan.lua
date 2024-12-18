local item_sprite = Resources.sprite_load(NAMESPACE, "StrangeCan", path.combine(PATH, "Sprites/Items/strangeCan.png"), 1, 16, 15)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffIntoxication", path.combine(PATH, "Sprites/Buffs/intoxication.png"), 1, 11, 12)

local sound = Resources.sfx_load(NAMESPACE, "IntoxicateApply", path.combine(PATH, "Sounds/Items/strangeCan.ogg"))

local strangeCan = Item.new(NAMESPACE, "strangeCan")
strangeCan:set_sprite(item_sprite)
strangeCan:set_tier(Item.TIER.uncommon)
strangeCan:set_loot_tags(Item.LOOT_TAG.category_damage)

local buffIntoxication = Buff.new(NAMESPACE, "intoxication")

strangeCan:clear_callbacks()
strangeCan:onHitProc(function(actor, victim, stack, hit_info)
	if math.random() <= 0.035 + (0.05 * stack) or hit_info.attack_info:get_attack_flag(Attack_Info.ATTACK_FLAG.force_proc) then
		gm.sound_play_networked(sound, 1, 1, victim.x, victim.y)
		victim:buff_apply(buffIntoxication, 7 * 60)
	end
end)

buffIntoxication.show_icon = true
buffIntoxication.icon_sprite = buff_sprite
buffIntoxication.is_debuff = true

local intoxication_damage_color = Color.from_rgb(62, 196, 85)

buffIntoxication:clear_callbacks()
buffIntoxication:onApply(function(actor, stack)
	actor:get_data().intoxication_timer = 0
end)
buffIntoxication:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	local data = actor:get_data()
	data.intoxication_timer = data.intoxication_timer + 1

	if data.intoxication_timer >= 90 then
		data.intoxication_timer = 0
		local time_left = actor:get_buff_time(actor, buffIntoxication)
		if time_left then
			local dmg = math.ceil(actor.hp * 0.03 * time_left / 60)
			actor:damage_inflict(actor, dmg, 0, -4, actor.x, actor.y, dmg, 1, intoxication_damage_color)
		end
	end
end)
