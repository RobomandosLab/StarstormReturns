-- hi its azuline again
-- this is my fav artifact from ss1 btw :3 anyways this one is pretty simple i wont be explaining much
-- btw this should prolly be redone a bit to account for nucleus gems when that gets added
-- also also also thanks to onyx (0n_x) for optimizing this mess of an artifact! ! ! ! should be way less laggier now

local loadout = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringLoadout", path.combine(PATH, "Sprites/Artifacts/Gathering/loadout.png"), 3, 19, 19)
local pickup = Resources.sprite_load(NAMESPACE, "ArtifactOfGatheringPickup", path.combine(PATH, "Sprites/Artifacts/Gathering/pickup.png"), 1, 20, 20)

local gathering = Artifact.new(NAMESPACE, "gathering")
gathering:set_sprites(loadout, pickup)

-- we are using post_code_execute and pre_code_execute for less lag
-- wrapping "self" will also cause a lot of lag so we will have to use game maker functions instead of rmt methods (self:place_meeting() instead of self:is_colliding() for example)
gm.post_code_execute("gml_Object_oEfGold_Create_0", function(self, other)
	if not gathering.active then return end
	-- value gets set after creation, so waiting a frame to change it
	Alarm.create(function()
		self.value = self.value * 2
	end, 1)
	self.lifetime = 1000
end)

-- It's preferred to always let basegame functions run, this mostly just undoes what alarm[1] is doing
-- also doesn't need the worksaround with alarm[2]
gm.post_code_execute("gml_Object_oEfGold_Alarm_1", function(self, other)
	if not gathering.active then return end
	self.hspeed = 0
	self.vspeed = 0
	self.speed = 5 -- the pickup radius is loosely related to speed, if speed is 0 then you wouldnt be able to pick up the coin

	self.lifetime = self.lifetime - 5
	if self.lifetime < 100 then
		if self.lifetime % 15 < 10 then
			self.visible = true
		else
			self.visible = false
		end
	end
	if self.lifetime <= 0 then
		gm.instance_destroy(self)
	end
end)