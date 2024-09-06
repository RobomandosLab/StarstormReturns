local sprite = Resources.sprite_load(PATH.."Sprites/Items/armedBackpack.png", 1, false, false, 16, 16)

local item = Item.create("starstorm", "armedBackpack")
Item.set_sprite(item, sprite)
Item.set_tier(item, Item.TIER.common)
Item.set_loot_tags(item, Item.LOOT_TAG.category_damage)

Item.add_callback(item, "onHit", function(actor, victim, damager, stack)
	if Helper.chance(0.12 + (0.065 * stack)) then
		attack = gm._mod_attack_fire_bullet(
			actor,
			actor.x,
			actor.y,
			700,
			gm.actor_get_facing_direction(actor) + 180,
			1.5,
			gm.constants.sSparks1,
			false,
			true
		)
		attack.tracer_kind = ATTACK_TRACER_KIND.commando1
	end	
end)
