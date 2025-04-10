local sprite = Resources.sprite_load(NAMESPACE, "Midas", path.combine(PATH, "Sprites/Equipments/midas.png"), 2, 16, 14)
local sound = Resources.sfx_load(NAMESPACE, "MidasUse", path.combine(PATH, "Sounds/Items/midasUse.ogg"))

-- these come from this file sarn posted in the rorr modding server, listing most enums used by the game's code.
-- https://discord.com/channels/1171745917272084550/1175150719700058233/1189771316522389566
local DAMAGE_INFLICT_FLAGS = {
	ignore_armor = 1 << 0,
	nonlethal = 1 << 1,
	pierce_shield = 1 << 2,
	ignore_invincibility = 1 << 3,
}

local midas = Equipment.new(NAMESPACE, "midas")
midas:set_sprite(sprite)
midas:set_cooldown(60)
midas:set_loot_tags(Item.LOOT_TAG.category_utility, Item.LOOT_TAG.equipment_blacklist_chaos)

midas:clear_callbacks()
midas:onUse(function(actor, embryo)
	actor:sound_play(sound, 1, 1)

	local deduction = math.floor(actor.hp * 0.5)

	if actor:is_authority() then
		-- same set of flags used by Lost Doll equipment
		local flags = DAMAGE_INFLICT_FLAGS.ignore_armor
					+ DAMAGE_INFLICT_FLAGS.nonlethal
					+ DAMAGE_INFLICT_FLAGS.ignore_invincibility
		gm.damage_inflict(actor.id, deduction, flags, -4, actor.x, actor.y, deduction, 2, Color.YELLOW, false);
	end

	local hud = GM._mod_game_getHUD()
	if hud ~= -4 then
		local reward = deduction + 25 * gm.cost_get_base_gold_price_scale()
		if embryo then
			reward = reward * 2
		end
		hud:add_gold_gml_Object_oHUD_Create_0(reward)
	end
end)
