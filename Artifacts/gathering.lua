-- hi its azuline again
-- this is my fav artifact from ss1 btw :3 anyways this one is pretty simple i wont be explaining much
-- btw this should prolly be redone a bit to account for nucleus gems when that gets added

local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringLoadout", path.combine(PATH, "Sprites/Artifacts/Gathering/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringPickup", path.combine(PATH, "Sprites/Artifacts/Gathering/pickup.png"), 1, 20, 20)

local gathering = Artifact.new(NAMESPACE, "gathering")
gathering:set_sprites(loadout, pickup)

-- we are using post_code_execute and pre_code_execute for less lag
-- wrapping "self" will also cause a lot of lag so we will have to use game maker functions instead of rmt methods (self:place_meeting() instead of self:is_colliding() for example)
gm.post_code_execute("gml_Object_oEfGold_Create_0", function(self, other)
	if not gathering.active then return end
	self.life = 1000
end)

gm.pre_code_execute("gml_Object_oEfGold_Step_2", function(self, other)
	if not gathering.active then return end
	if not self.gathering then -- for some reason this doesnt work if set in post create code
		self.value = self.value * 2
		self.gathering = true
	end
	
	if self:alarm_get(1) ~= -1 then -- alarm 1 controls whether the gold is homing in on the player or not
		self:alarm_set(1, -1) -- setting it to -1 if it isnt already -1 makes it not home in
	end
	
	-- alarm 2 controls whether the gold is being picked up
	-- whether this alarm is active or not is based on alarm 1, and since we stopped alarm 1 this wont work on its own
	if self:alarm_get(2) == -1 and self:place_meeting(self.x, self.y, gm.constants.oP) == 1.0 then -- solution? activate the alarm manually when a coin is colliding with a player object
		self:alarm_set(2, 3)
	end
	
	if (self.life or 0) > 0 then
		self.life = self.life - 1
		if self.life < 100 and self.life % 10 < 2 then -- make it blink when about to disappear!!
			self.visible = false
		else
			self.visible = true
		end
	else
		gm.instance_destroy(self)
	end
end)
