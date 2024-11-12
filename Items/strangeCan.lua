--local sprite = Resources.sprite_load(PATH.."Sprites/Items/fork.png", 1, false, false, 16, 16)

-- local item = Item.create("starstorm", "strangeCan")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.common)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

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
