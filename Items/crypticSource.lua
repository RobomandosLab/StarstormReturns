local sprite = Sprite.new("CrypticSource", path.combine(PATH, "Sprites/Items/crypticSource.png"), 1, 18, 18)

local crypticSource = Item.new("crypticSource")
crypticSource:set_sprite(sprite)
crypticSource:set_tier(ItemTier.UNCOMMON)
crypticSource.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(crypticSource)

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(crypticSource:get_holding_actors()) do
		if Net.host then
			if Instance.exists(actor) then
				local stack = actor:item_count(crypticSource)
				local data = Instance.get_data(actor)
				
				local true_direction = actor.image_xscale
				
				if true_direction then
					if actor.object_index == gm.constants.oEngiTurret then
						true_direction = actor.image_xscale2
					end

					if actor.pHspeed ~= 0 then
						true_direction = Math.sign(actor.pHspeed)
					end

					if not data.last_direction then data.last_direction = true_direction end

					if not data.cryptic_source_cd then
						if data.last_direction == true_direction * -1 then
							data.cryptic_source_cd = 10
							data.last_direction = true_direction

							local lightning = Object.find("ChainLightning"):create(actor.x, actor.y)
							lightning.parent = actor
							lightning.team = actor.team
							lightning.damage = math.ceil(actor.damage * (0.15 + (0.55 * stack)))
							lightning.blend = Color.from_rgb(211, 242, 87)
							lightning.bounce = 2

							actor:sound_play_networked(gm.constants.wLightning, 0.25, 3.4 + math.random() * 0.3, actor.x, actor.y)
						end
					else
						if data.cryptic_source_cd > 0 then
							data.cryptic_source_cd = data.cryptic_source_cd - 1
						else
							data.cryptic_source_cd = nil
						end
					end
				end
			end
		end
	end
end)

