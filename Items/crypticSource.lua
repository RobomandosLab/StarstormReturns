local sprite = Resources.sprite_load(NAMESPACE, "CrypticSource", path.combine(PATH, "Sprites/Items/crypticSource.png"), 1, 16, 16)

local crypticSource = Item.new(NAMESPACE, "crypticSource")
crypticSource:set_sprite(sprite)
crypticSource:set_tier(Item.TIER.uncommon)
crypticSource:set_loot_tags(Item.LOOT_TAG.category_utility)

crypticSource:clear_callbacks()
crypticSource:onStep(function(actor, stack)
	if gm._mod_net_isClient() then return end

	local actor_data = actor:get_data()

	local true_direction = actor.image_xscale
	if actor.object_index == gm.constants.oEngiTurret then
		true_direction = actor.image_xscale2
	end

	if actor.pHspeed ~= 0 then
		true_direction = gm.sign(actor.pHspeed)
	end

	if not actor_data.last_direction then actor_data.last_direction = true_direction end

	if not actor_data.cryptic_source_cd then
		if actor_data.last_direction == true_direction * -1 then
			actor_data.cryptic_source_cd = 10
			actor_data.last_direction = true_direction

			local t = gm.instance_create(actor.x, actor.y, gm.constants.oChainLightning)
			t.parent = actor.value
			t.team = actor.team
			t.damage = math.ceil(actor.damage * (0.15 + (0.55 * stack)))
			t.blend = 0x57F2D3
			t.bounce = 2

			actor:sound_play_networked(gm.constants.wLightning, 0.25, 3.4 + math.random() * 0.3, actor.x, actor.y)
		end
	else
		if actor_data.cryptic_source_cd > 0 then
			actor_data.cryptic_source_cd = actor_data.cryptic_source_cd - 1
		else
			actor_data.cryptic_source_cd = nil
		end
	end
end)

