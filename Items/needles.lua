local sprite_item = Sprite.new("Needles", path.combine(PATH, "Sprites/Items/needles.png"), 1, 16, 15)
local sprite_buff = Sprite.new("BuffNeedles", path.combine(PATH, "Sprites/Buffs/needles.png"), 1, 9, 8)
local sound = Sound.new("Needles", path.combine(PATH, "Sounds/Items/needles.ogg"))

local needles = Item.new("needles")
needles:set_sprite(sprite_item)
needles:set_tier(ItemTier.COMMON)
needles.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(needles)

local buffNeedles = Buff.new("Needles")
buffNeedles.icon_sprite = sprite_buff
buffNeedles.is_debuff = true

Callback.add(Callback.ON_HIT_PROC, function(actor, victim, hit_info)
	local stack = actor:item_count(needles)
    if stack <= 0 then return end
	
	if (math.random() <= 0.01 + stack * 0.02 or hit_info.attack_info:get_flag(AttackFlag.FORCE_PROC)) and victim:buff_count(buffNeedles) == 0 then
		victim:buff_apply(buffNeedles, 190)
	end
end)

Callback.add(buffNeedles.on_apply, function(actor)
	actor:sound_play(sound, 1, 1)
end)

-- onAttackHit callbacks and such can't be used to increase the damage because by then the visual damage number and crit sound were already decided on.
DamageCalculate.add(function(api)
	if not Instance.exists(api.parent) then return end
	
	local count = api.hit:buff_count(buffNeedles)
	if count <= 0 then return end
	
	if count > 0 then
		api:set_critical(true)
	end
end)
