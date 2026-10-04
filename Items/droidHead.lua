--Droid Head
local sprite_item = Sprite.new("DroidHead", path.combine(PATH, "Sprites/Items/droidHead.png"), 1, 16, 16)
local sound = Sound.new("DroidHeadSnd", path.combine(PATH, "Sounds/Items/droidHead.ogg"))

local doid = Item.new("droidHead")
doid:set_sprite(sprite_item)
doid:set_tier(ItemTier.RARE)
doid.loot_tags = Item.LootTag.CATEGORY_DAMAGE

ItemLog.new_from_item(doid)

Callback.add(Callback.ON_KILL_PROC, function(victim, actor)
	local stack = actor:item_count(doid)
	if stack <= 0 then return end
	if victim.elite_type == -1 then return end
	
	--strike drone reskin just like ss1, no real need for a custom drone or anything
	local strikedrone = Object.wrap(gm.constants.oDroneDisp)
	local dorne = strikedrone:create(victim.x, victim.y)
	
	local aa = (math.random(0, 360000) / 1000) --dk if there's an actual reason for why nk did this in ss1 and they called it dumb but w/e doing to be safe
	--ultimately it's to give drones a random space they'll occupy on spawn
	dorne.xx = math.cos(aa) * 25
	dorne.yy = 20 + math.sin(aa) * 25

	dorne.parent = actor
	dorne.master = actor
	
	--fx
	Particle.find("Spark"):create(victim.x, victim.y, 4, Particle.System.DAMAGE_ABOVE)
	dorne:sound_play(sound, 0.7, 0.9 + math.random() * 0.2) --that sound kinda loud otherwise tbh
	
	--set lifetime
	dorne:alarm_set(2, 450 + (250 * stack))
	
	--set it as elite
	GM.elite_set(dorne, victim.elite_type)
	
	--flash for funny
	local flash = GM.instance_create(dorne.x, dorne.y, gm.constants.oEfFlash)
	flash.parent = dorne
	flash.rate = 0.05
	flash.image_alpha = 1
	flash.image_blend = Elite.wrap(victim.elite_type).blend_col
	
end)

--personalized drone bc i like fun and whimsy :)
local function makedrone(inst)

	local helperdrone = Object.wrap(gm.constants.oDrone1B)
	local dorne = helperdrone:create(inst.x, inst.y)
	
	dorne:sound_play(sound, 0.7, 1.2 + math.random() * 0.2)
	
	if inst.sprite_drone_idle then
		dorne.sprite_idle = inst.sprite_drone_idle
		dorne.sprite_idle_broken = inst.sprite_drone_idle
	else
		dorne.sprite_idle = gm.constants.sDronePlayerCommandoIdle
		dorne.sprite_idle_broken = gm.constants.sDronePlayerCommandoIdle
	end
	
	if inst.sprite_drone_shoot then
		dorne.sprite_shoot1 = inst.sprite_drone_shoot
		dorne.sprite_shoot1_broken = inst.sprite_drone_shoot
		
	else
		dorne.sprite_shoot1 = gm.constants.sDronePlayerCommandoShoot
		dorne.sprite_shoot1_broken = gm.constants.sDronePlayerCommandoShoot
		
	end
	dorne.recycle_tier = 101 --playerdrone scrap
	
	dorne.parent = inst
	dorne.master = inst
	
	Particle.find("Spark"):create(inst.x, inst.y, 4, Particle.System.DAMAGE_ABOVE)
	
	local flash = GM.instance_create(dorne.x, dorne.y, gm.constants.oEfFlash)
	flash.parent = dorne
	flash.rate = 0.05
	flash.image_alpha = 1
	flash.image_blend = Survivor.wrap(inst.class).primary_color

	Instance.get_data(inst).droidHeadDrone = dorne
end

Callback.add(doid.on_acquired, function(actor, stack)

	local data = Instance.get_data(actor)
	if data.droidHeadDrone and Instance.exists(data.droidHeadDrone) then return end
	
	makedrone(actor)
	
end)

--remove the drone on full item removal
Callback.add(doid.on_removed, function(actor, stack)
	if stack > 1 then return end
	local data = Instance.get_data(actor)
	if Instance.exists(data.droidHeadDrone) then
		data.droidHeadDrone.hp = -math.huge
	end
	data.droidHeadDrone = nil

end)

--give the drone next stage
Callback.add(Callback.ON_STAGE_START, function()
	for _, actor in ipairs(doid:get_holding_actors()) do
		local data = Instance.get_data(actor)
		if not Instance.exists(data.droidHeadDrone) then
			makedrone(actor)
		
		end
	
	end

end)

--lang

	-- droidHead = {
		-- name = "Droid Head",
		-- pickup = "Gain a personalized drone. Spawn a temporary elite drone when slaying elite enemies.",
		-- description = "Grants a <y>personalized attack drone</c> on pickup. Killing an elite enemy spawns a <y>Security Drone</c> of the <b>same elite type</c> that lasts <b>11</c> <c_stack>(+4 seconds per stack)</c> <b>seconds</c>.",
		-- destination = "RoboFix,\nSOL 1,\nMars",
		-- date = "20/12/2056",
		-- story = "This is the droid head for the model ER-14 that you requested. Fully functional, just requires wiring. These are quite hard to obtain these days, given the whole RaCom controversy.\nDon't forget to disable the security protocols before handling, I don't think you want a hundred backup drones around your shop!\nIf you need any tools or pieces let me know.",
		-- priority = "<r>Fragile</c>"
	-- }