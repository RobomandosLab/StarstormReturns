local sprite = Resources.sprite_load(NAMESPACE, "HuntersSigil", path.combine(PATH, "Sprites/Items/huntersSigil.png"), 1, 16, 16)
local sound = Resources.sfx_load(NAMESPACE, "SigilBuff", path.combine(PATH, "Sounds/Items/huntersSigil.ogg"))

local buffSigil = Buff.new(NAMESPACE, "sigilBuff")
local huntersSigil = Item.new(NAMESPACE, "huntersSigil")
huntersSigil:set_sprite(sprite)
huntersSigil:set_tier(Item.TIER.uncommon)
huntersSigil:set_loot_tags(Item.LOOT_TAG.category_damage)

huntersSigil:clear_callbacks()
huntersSigil:onPickup(function(actor, stack)
	if gm._mod_net_isClient() then return end
	local data = actor:get_data()
	if not data.sigil_timer then
		data.sigil_timer = 0
	end
end)
huntersSigil:onRemove(function(actor, stack)
	if gm._mod_net_isClient() then return end
	if stack == 1 then
		actor:buff_remove(buffSigil)
	end
end)

huntersSigil:onStep(function(actor, stack)
	if gm._mod_net_isClient() then return end
	local data = actor:get_data()

	if actor.pHspeed == 0 and actor.pVspeed == 0 and not gm.actor_state_is_climb_state(actor.actor_state_current_id) then
		data.sigil_timer = data.sigil_timer + 1
		if data.sigil_timer > 60 and actor:buff_stack_count(buffSigil) == 0 then
			actor:buff_apply(buffSigil)
		end
	else
		if actor:buff_stack_count(buffSigil) then
			actor:buff_remove(buffSigil)
			data.sigil_timer = 0
		end
	end
end)

buffSigil:clear_callbacks()
buffSigil:onApply(function(actor)
	actor:sound_play(sound, 1, 0.9 + math.random() * 0.2)
end)
buffSigil:onStatRecalc(function(actor)
	local item_stack = actor:item_stack_count(huntersSigil)
	actor.armor = actor.armor + 5 + (10 * item_stack)
	actor.critical_chance = actor.critical_chance + 5 + (20 * item_stack)
end)
