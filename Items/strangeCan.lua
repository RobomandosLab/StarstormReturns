local sprite = Resources.sprite_load(NAMESPACE, "StrangeCan", path.combine(PATH, "Sprites/Items/strangeCan.png"), 1, 14, 11)
local sound = Resources.sfx_load(NAMESPACE, "IntoxicateApply", path.combine(PATH, "Sounds/Items/strangeCan.ogg"))

local strangeCan = Item.new(NAMESPACE, "strangeCan")
strangeCan:set_sprite(sprite)
strangeCan:set_tier(Item.TIER.uncommon)
strangeCan:set_loot_tags(Item.LOOT_TAG.category_damage)

local buffIntoxication = Buff.new(NAMESPACE, "intoxication")

strangeCan:clear_callbacks()
strangeCan:onHit(function(actor, victim, damager, stack)
	if math.random() <= 0.035 + (0.05 * stack) then
		victim:sound_play(sound, 1, 1)
		victim:buff_apply(buffIntoxication, 7 * 60)
	end
end)

buffIntoxication.show_icon = false
buffIntoxication.is_debuff = true

local intoxication_damage_color = Color.from_rgb(62, 196, 85)

buffIntoxication:clear_callbacks()
buffIntoxication:onApply(function(actor, stack)
	actor:get_data().intoxication_timer = 0
end)
buffIntoxication:onStep(function(actor, stack)
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

-- Item.add_callback(item, "onHit", function(actor, victim, damager, stack)
-- 	if stack > 0 then
-- 		if math.chance(3.5 + (5 * stack)) and victim.hp > damager.damage and not victim.starstorm_intoxicationAttacker then
-- 			Buff.apply(victim, Buff.find("starstorm-intoxication"), 300)
-- 			if not victim.starstorm_intoxicationAttacker then victim.starstorm_intoxicationAttacker = actor end
-- 		end
-- 	end
-- end)

-- -- Buff
-- local sprite = Resources.sprite_load(PATH.."Sprites/Buffs/disease.png", 1, false, false, 8, 8)

-- local buff = Buff.create("starstorm", "intoxication")

-- Buff.set_property(buff, Buff.PROPERTY.icon_sprite, sprite)
-- Buff.set_property(buff, Buff.PROPERTY.icon_stack_subimage, false)
-- Buff.set_property(buff, Buff.PROPERTY.draw_stack_number, true)
-- Buff.set_property(buff, Buff.PROPERTY.max_stack, 999)
-- Buff.set_property(buff, Buff.PROPERTY.is_timed, true)
-- Buff.set_property(buff, Buff.PROPERTY.is_debuff, true)

-- Buff.add_callback(buff, "onApply", function(actor, stack)
-- 	if not actor.starstorm_toxicTimer then actor.starstorm_toxicTimer = 0 end
-- end)

-- Buff.add_callback(buff, "onStep", function(actor, stack)
-- 	if actor then
-- 		local damage = math.ceil((actor.hp * 0.03 * buff.timeLeft / 60) * (100 / (100 + actor.armor)))
-- 		if actor.starstorm_toxicTimer then
-- 			if actor.starstorm_toxicTimer >= 60 then
-- 				if not actor.invincible or actor.invincible <= 0 then
-- 					if actor.starstorm_diseaseAttacker then
-- 						Actor.damage(actor, starstorm_diseaseAttacker, damage, actor.x, actor.y - 35, 65280)
-- 					else
-- 						Actor.damage(actor, nil, damage, actor.x, actor.y - 35, 65280)
-- 					end
-- 					actor.starstorm_toxicTimer = 0
-- 				end
-- 			else
-- 				actor.starstorm_toxicTimer = actor.starstorm_toxicTimer + 1
-- 			end
-- 		end
-- 	end
-- end)
