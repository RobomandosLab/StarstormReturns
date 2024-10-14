-- local sprite = Resources.sprite_load(PATH.."Sprites/Items/HuntersSigil/huntersSigil.png", 1, false, false, 16, 16)

-- local item = Item.create("starstorm", "huntersSigil")
-- Item.set_sprite(item, sprite)
-- Item.set_tier(item, Item.TIER.uncommon)
-- Item.set_loot_tags(item, Item.LOOT_TAG.category_healing)

-- local hsigil_stand_window = 5

-- Item.add_callback(item, "onStep", function(actor, stack)
--     if stack > 0 then
--         if actor.pHspeed ~= 0 or actor.pVspeed ~= 0 then
--             if not actor.ssr_hsigil_cooldown then
--                 actor.ssr_hsigil_cooldown = hsigil_stand_window
--             end

--             if actor.ssr_hsigil_cooldown <= 0 then
--                 Buff.apply(actor, Buff.find("starstorm-huntersSigilBuff"), hsigil_stand_window)
--             else
--                 actor.ssr_hsigil_cooldown = actor.ssr_hsigil_cooldown - 1
--             end
--         else
--             if Buff.get_stack_count(actor, Buff.find("starstorm-huntersSigilBuff")) > 0 then
--                 Buff.remove(actor, Buff.find("starstorm-huntersSigilBuff"))
--             end
--         end
--     end
-- end)

-- -- Buff
-- local armorIncrease = 15
-- local critChanceIncrease = 0.25

-- local buff = Buff.create("starstorm", "huntersSigilBuff")
-- Buff.set_property(buff, Buff.PROPERTY.icon_sprite, sprite)
-- Buff.set_property(buff, Buff.PROPERTY.icon_stack_subimage, false)

-- Buff.add_callback(buff, "onApply", function(actor, stack)
--     -- TODO: Add item stacking to buff effects
--     actor.armor = actor.armor + armorIncrease
--     actor.critical_chance = actor.critical_chance + (actor.critical_chance * critChanceIncrease)
-- end)

-- Buff.add_callback(buff, "onRemove", function(actor, stack)
--     -- TODO: Add item stacking to buff effects
--     actor.armor = actor.armor - armorIncrease
--     actor.critical_chance = actor.critical_chance - (actor.critical_chance * critChanceIncrease)
-- end)