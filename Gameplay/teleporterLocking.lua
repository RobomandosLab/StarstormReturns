-- this code handles the case of multiple teleporters being available simultaneously, which is relevant for ethereal teleporters and the counterfeit tp equipment
-- when a teleporter is activated, all other teleporters on the stage are locked and cannot be used.
-- this only applies for classic and eclipse gamemodes, to prevent potential issues with other gamemodes.

Callback.add(Callback.TYPE.onInteractableActivate, "SSLockOtherTeleporters", function(interactable, player)
	if not GM.object_is(interactable, gm.constants.pTeleporter) then return end
	if interactable.is_ethereal and not interactable._did_warning then return end -- see ethereals.lua
	if Global.__gamemode_current >= 2 then return end

	local teleporters = Instance.find_all(gm.constants.pTeleporter)

	for _, tp in ipairs(teleporters) do
		if not tp:same(interactable) then
			tp.locked = true
		end
	end
end)

-- handle teleporters that've been spawned in, such as the counterfeit tp
gm.post_code_execute("gml_Object_pTeleporter_Create_0", function(self, other)
	if Global.__gamemode_current >= 2 then return end

	-- `teleporter_active` is seemingly set to the largest `active` variable of all teleporter instances
	if gm._mod_game_getDirector().teleporter_active > 0 then
		self.locked = true
	end
end)