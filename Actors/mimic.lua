local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Mimic")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Mimic")

-- assets
local sprite_mask			= Sprite.new("MimicMask",			path.combine(SPRITE_PATH, "mask.png"), 1, 21, 24)
local sprite_palette		= Sprite.new("MimicPalette",		path.combine(SPRITE_PATH, "palette.png"))

local sprite_idle			= Sprite.new("MimicIdle",			path.combine(SPRITE_PATH, "idle.png"), 2, 30, 35)
local sprite_idle2			= Sprite.new("MimicIdle2",			path.combine(SPRITE_PATH, "idle2.png"), 2, 30, 45)
local sprite_walk			= Sprite.new("MimicWalk",			path.combine(SPRITE_PATH, "walk.png"), 8, 30, 35)
local sprite_walk2			= Sprite.new("MimicWalk2",			path.combine(SPRITE_PATH, "walk2.png"), 6, 30, 35)
local sprite_jump			= Sprite.new("MimicJump",			path.combine(SPRITE_PATH, "jump.png"), 1, 19, 28)
local sprite_jump_peak		= Sprite.new("MimicJumpPeak",		path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 19, 28)
local sprite_fall			= Sprite.new("MimicFall",			path.combine(SPRITE_PATH, "fall.png"), 1, 19, 28)
local sprite_death			= Sprite.new("MimicDeath",			path.combine(SPRITE_PATH, "death.png"), 10, 55, 93)
local sprite_shoot1a		= Sprite.new("MimicShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 10, 30, 45)
local sprite_shoot1b		= Sprite.new("MimicShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 4, 30, 45)
local sprite_shoot1c		= Sprite.new("MimicShoot1c",		path.combine(SPRITE_PATH, "shoot1c.png"), 6, 30, 45)
local sprite_portrait		= Sprite.new("MimicPortrait",		path.combine(SPRITE_PATH, "portrait.png"))

local sprite_inactive_idle	= Sprite.new("MimicInactiveIdle",	path.combine(SPRITE_PATH, "inactiveIdle.png"), 14, 30, 38)
local sprite_activate		= Sprite.new("MimicActivate",		path.combine(SPRITE_PATH, "spawn.png"), 18, 30, 60)
local sprite_vacuum			= Sprite.new("MimicVacuumFX", 		path.combine(SPRITE_PATH, "vacuumParticle.png"), 4, 4, 4)
local sprite_ping 			= Sprite.new("MimicPing", 			path.combine(SPRITE_PATH, "ping.png"), 1, 14, 19)
local sprite_found_you 		= Sprite.new("MimicFoundYou", 		path.combine(SPRITE_PATH, "found_you.png"), 1, 75, 95)

local sound_spawn			= Sound.new("MimicSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_hit				= Sound.new("MimicHit",				path.combine(SOUND_PATH, "hit.ogg"))
local sound_shoot			= Sound.new("MimicShoot",			path.combine(SOUND_PATH, "shoot.ogg"))
local sound_death			= Sound.new("MimicDeath",			path.combine(SOUND_PATH, "death.ogg"))

local efGoldSteal = Object.new("EfGoldSteal")
efGoldSteal:set_sprite(gm.constants.sEfGold1)
efGoldSteal:set_depth(-279)

local function select_item_to_steal(victim)
	local inventory = victim.inventory_item_order
	
	if #inventory > 0 then
		local chosen_id = inventory[math.random(#inventory)]
		local chosen_item = Item.wrap(chosen_id)
		return chosen_item
	end
	
	return nil
end

-- mimic
local mimic = Object.new("Mimic", Object.Parent.ENEMY_CLASSIC)
mimic:set_sprite(sprite_idle)
mimic:set_depth(10)

-- create the monster log
local mlog = ssr_create_monster_log("mimic")
mlog.sprite_id = sprite_walk
mlog.portrait_id = sprite_portrait
mlog.sprite_offset_x = 42
mlog.sprite_offset_y = 45
mlog.stat_hp = 200
mlog.stat_damage = 10
mlog.stat_speed = 2.6

local primary			= Skill.new("mimicZ")

Callback.add(mimic.on_create, function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death
	actor.sprite_ping = sprite_ping

	actor.can_jump = true
	actor.leap_max_distance = 3

	actor.mask_index = sprite_mask

	actor.sound_hit = sound_hit
	actor.sound_death = sound_death

	-- damage, health, knockback cap/threshold, gold/exp reward
	actor:enemy_stats_init(10, 200, 200, 0)
	actor.pHmax_base = 2.4 + math.min(0.2 * GM._mod_game_getDirector().enemy_buff, 3)

	actor.z_range = 200
	actor:set_default_skill(Skill.Slot.PRIMARY, primary)

	actor.monster_log_drop_id = mlog.value

	actor:init_actor_late()
end)

Callback.add(mimic.on_step, function(actor)
	
end)

Callback.add(mimic.on_destroy, function(actor)
	Particle.find("Spark"):create(actor.x, actor.y, 7)
	actor:screen_shake(4)
end)

local mimicInactive = Object.new("MimicInactive", Object.Parent.INTERACTABLE)
mimicInactive:set_sprite(sprite_inactive_idle)
mimicInactive:set_depth(90)

local scan = Buff.new("mimicScan")
scan.show_icon = false
scan.is_timed = false

scan.effect_display = EffectDisplay.func(function(actor_unwrapped)
	local actor = Instance.wrap(actor_unwrapped)
	local data = Instance.get_data(actor)
	local timer = data.__ssr_mimic_scan_anim
	local xx = Math.lerp(actor.x + (600 - 10 * math.min(timer * 2, 240)) * math.sin(math.rad(90 - 0.75 * math.min(timer, 120))), actor.x, (math.min(timer / 120, 1)))
	local yy = Math.lerp(actor.y - (400 - 10 * math.min(timer * 2, 240)) * math.sin(math.rad(90 - 0.75 * math.min(timer, 120))), actor.y, (math.min(timer / 120, 1)))
	
	GM.draw_sprite_ext(sprite_found_you, 0, xx, yy, 1, 1, 0, Color.WHITE, math.min(0.1 * timer, 1))
	
end, EffectDisplay.DrawPriority.BODY_POST)

Callback.add(scan.on_apply, function(actor)
	local data = Instance.get_data(actor)
	data.__ssr_mimic_scan_anim = 0
	
	actor:sound_play(gm.constants.wCrateActivate, 1, 1)
end)

Callback.add(scan.on_step, function(actor)
	local data = Instance.get_data(actor)
	data.__ssr_mimic_scan_anim = data.__ssr_mimic_scan_anim + 1
	
	if data.__ssr_mimic_scan_anim % 30 == 0 and data.__ssr_mimic_scan_anim < 60 * 2 then
		actor:sound_play(gm.constants.wDroneRecycler_Activate, 1, 1)
	end
	
	if data.__ssr_mimic_scan_anim == 2 * 60 then
		actor:sound_play(gm.constants.wHANDShoot2_1, 1, 0.7)
	end
end)

Callback.add(mimicInactive.on_create, function(self)
	GM.interactable_init_cost(self, 0, 50)
	self.sprite_ping = gm.constants.sPing_Chest2
	self:interactable_init_name()
end)

Callback.add(mimicInactive.on_step, function(self)
	if Net.host then
		if self.active == 0 and not Instance.exists(self.target) then
			local target = self:collision_circle(self.x, self.y, 2000, gm.constants.oP, false, true)

			if target ~= -4 and Util.bool(target.is_targettable) then
				self.target = target
				
				local data = Instance.get_data(target)
				data.__ssr_mimic_scan_parent = self.id
				target:buff_apply(scan, 60)
			end
		end
	end
	
	if self.active == 1 then
		-- self.active gets automatically set to 2 internally so this only runs for one frame
		self.sprite_index = sprite_activate
		self.image_index = 0
		self.image_speed = 0.2
		self:sound_play(sound_spawn, 1, 1)
		self:sound_play(gm.constants.wPickup, 1, 0.7)
	elseif self.active == 2 then
		if self.image_index >= 14 and not self.stompied then
			self.stompied = true
			self:screen_shake(5)
			self:sound_play(gm.constants.wClayDeath, 0.7, 1.35)
		end

		if self.image_speed == 0 then
			if Net.host then
				local actor = mimic:create(self.x, self.y - 25)

				self:instance_destroy_sync() -- tell clients to destroy this object, doesn't actually destroy it on the host
				self:destroy()
			end
		end
	end
end)

Callback.add(Callback.ON_STAGE_START, function()
	if Net.client then return end -- host handles spawning
	if Global.__gamemode_current >= 2 then return end -- don't spawn mimics in trials or tutorial..

	-- try spawning up to 3 mimics, though more than 1 is extremely unlikely
	for i = 0, 3 do
		if math.random() <= 1 then
			-- function used by the game's director when spawninginteractables.
			gm._mod_game_getDirector():mapobject_spawn(mimicInactive.value, 1) -- second arg is required tile space
		else
			break
		end
	end
end)
