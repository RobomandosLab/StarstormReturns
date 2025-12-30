local item_sprite = Sprite.new("MoltenCoin", path.combine(PATH, "Sprites/Items/moltenCoin.png"), 1, 12, 16)
local coin_sprite = Sprite.new("EfGoldMoltenCoin", path.combine(PATH, "Sprites/Items/Effects/moltenCoin.png"), 6, 5, 5)
local sound = Sound.new("MoltenCoin", path.combine(PATH, "Sounds/Items/moltenCoin.ogg"))

local moltenCoin = Item.new("moltenCoin")

local packet = Packet.new("SyncMoltenCoin")

local serializer = function(buffer, x, y, stack)
	buffer:write_int(x)
	buffer:write_int(y)
	buffer:write_uint(stack)
end

local deserializer = function(buffer, self)
	local x = buffer:read_int()
	local y = buffer:read_int()
	local stack = buffer:read_uint()
	
	local inst = Object.find("EfGold"):create(x, y)
	inst.hspeed = -4 + math.random() * 8
	inst.vspeed = -4 + math.random() * 8
	inst.sprite_index = coin_sprite
	inst.value.value = stack
end

packet:set_serializers(serializer, deserializer)

moltenCoin:set_sprite(item_sprite)
moltenCoin:set_tier(ItemTier.COMMON)
moltenCoin.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(moltenCoin)

Callback.add(Callback.ON_HIT_PROC, function(actor, victim, hit_info)
	local stack = actor:item_count(moltenCoin)
    if stack <= 0 then return end
	
	if math.random() <= 0.06 or hit_info.attack_info:get_flag(AttackFlag.FORCE_PROC) then
		victim:apply_dot((hit_info.damage / actor.damage) * 0.2, 2 + stack * 4, 30, actor, 4235519)

		victim:sound_play(sound, 1.0, 0.9 + math.random() * 0.2)

		local inst = Object.find("EfGold"):create(victim.x, victim.y)
		inst.hspeed = -4 + math.random() * 8
		inst.vspeed = -4 + math.random() * 8
		inst.sprite_index = coin_sprite
		inst.value.value = stack

		if Net.online and Net.host then
			packet:send_to_all(victim.x, victim.y, stack)
		end
	end
end)
