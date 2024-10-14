-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/detritiveTrematode.png", 1, false, false, 16, 20)

-- local item = Item.create("starstorm", "detritiveTrematode")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.common)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

-- Item.add_callback(item, "onHit", function(actor, victim, damager, stack)
-- 	if stack > 0 then
-- 		if victim.hp - damager.damage <= victim.maxhp * ((0.9 + stack / 1.2) * 0.033) and victim.hp > damager.damage and not victim.starstorm_diseaseAttacker then
-- 			Buff.apply(victim, Buff.find("starstorm-disease"))
-- 			if not victim.starstorm_diseaseAttacker then victim.starstorm_diseaseAttacker = actor end
-- 		end
-- 	end
-- end)

-- --[[ Item.add_callback(item, "onDraw", function(actor, stack)
-- 	if stack > 0 then
-- 		gm.draw_sprite_ext(actor.image, actor.subimage, actor.x, actor.y, actor.xscale, actor.yscale, 32896, 0.25)
-- 	end
-- end) ]]

-- -- Buff
-- local sprite = Resources.sprite_load(PATH.."Sprites/Buffs/disease.png", 1, false, false, 8, 8)

-- local buff = Buff.create("starstorm", "disease")
-- --[[ Buff.icon_sprite = sprite
-- Buff.icon_stack_subimage = false
-- Buff.draw_stack_number = false
-- Buff.max_stack = 1
-- Buff.is_timed = false
-- Buff.is_debuff = true 
-- commented out bc this will technically be correct once rorrtk updates lol]]

-- Buff.set_property(buff, Buff.PROPERTY.icon_sprite, sprite)
-- Buff.set_property(buff, Buff.PROPERTY.icon_stack_subimage, false)
-- Buff.set_property(buff, Buff.PROPERTY.draw_stack_number, false)
-- Buff.set_property(buff, Buff.PROPERTY.max_stack, 1)
-- Buff.set_property(buff, Buff.PROPERTY.is_timed, false)
-- Buff.set_property(buff, Buff.PROPERTY.is_debuff, true)

-- Buff.add_callback(buff, "onApply", function(actor, stack)
-- 	if not actor.starstorm_diseaseTimer then actor.starstorm_diseaseTimer = 0 end
-- end)

-- Buff.add_callback(buff, "onStep", function(actor, stack)
-- 	if actor then
-- 		local damage = actor.maxhp / 25
-- 		if actor.starstorm_diseaseTimer then
-- 			if actor.starstorm_diseaseTimer >= 60 then
-- 				if not actor.invincible or actor.invincible <= 0 then
-- 					if actor.starstorm_diseaseAttacker then
-- 						Actor.damage(actor, starstorm_diseaseAttacker, damage, actor.x, actor.y - 35, 32896)
-- 					else
-- 						Actor.damage(actor, nil, damage, actor.x, actor.y - 35, 32896)
-- 					end
-- 					actor.starstorm_diseaseTimer = 0
-- 				end
-- 			else
-- 				actor.starstorm_diseaseTimer = actor.starstorm_diseaseTimer + 1
-- 			end
-- 		end
-- 	end
-- end)
