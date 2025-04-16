local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Gatekeeper")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Gatekeeper")

local sprite_mask			= Resources.sprite_load(NAMESPACE, "GatekeeperMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 32, 94)
local sprite_laser_mask		= Resources.sprite_load(NAMESPACE, "GatekeeperLaserMask",	path.combine(SPRITE_PATH, "laserMask.png"), 1, 6, 8)
local sprite_palette		= Resources.sprite_load(NAMESPACE, "GatekeeperPalette",		path.combine(SPRITE_PATH, "palette.png"))
local sprite_spawn			= Resources.sprite_load(NAMESPACE, "GatekeeperSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 22, 66, 141)
local sprite_idle			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle",		path.combine(SPRITE_PATH, "idle.png"), 1, 52, 125)
local sprite_idle2			= Resources.sprite_load(NAMESPACE, "GatekeeperIdle2",		path.combine(SPRITE_PATH, "idle2.png"), 1, 52, 125)
local sprite_walk			= Resources.sprite_load(NAMESPACE, "GatekeeperWalk",		path.combine(SPRITE_PATH, "walk.png"), 6, 58, 126)
local sprite_shoot1a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1a",		path.combine(SPRITE_PATH, "shoot1a.png"), 7, 58, 126)
local sprite_shoot1b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot1b",		path.combine(SPRITE_PATH, "shoot1b.png"), 17, 58, 126)
local sprite_shoot2a		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2a",		path.combine(SPRITE_PATH, "shoot2a.png"), 5, 58, 126)
local sprite_shoot2b		= Resources.sprite_load(NAMESPACE, "GatekeeperShoot2b",		path.combine(SPRITE_PATH, "shoot2b.png"), 5, 58, 126)
local sprite_death			= Resources.sprite_load(NAMESPACE, "GatekeeperDeath",		path.combine(SPRITE_PATH, "death.png"), 7, 79, 148)
local sprite_portrait		= Resources.sprite_load(NAMESPACE, "GatekeeperPortrait",	path.combine(SPRITE_PATH, "portrait.png"))

gm.elite_generate_palettes(sprite_palette)

local sound_spawn			= Resources.sfx_load(NAMESPACE, "GatekeeperSpawn",			path.combine(SOUND_PATH, "spawn.ogg"))
local sound_laser_hit		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserHit",			path.combine(SOUND_PATH, "laserHit.ogg"))
local sound_laser_fire		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserFire",		path.combine(SOUND_PATH, "laserFire.ogg"))
local sound_laser_fire2		= Resources.sfx_load(NAMESPACE, "GatekeeperLaserFire2",		path.combine(SOUND_PATH, "laserFire2.ogg"))
local sound_laser_charge	= Resources.sfx_load(NAMESPACE, "GatekeeperLaserCharge",		path.combine(SOUND_PATH, "laserCharge.ogg"))
local sound_death			= Resources.sfx_load(NAMESPACE, "GatekeeperDeath",			path.combine(SOUND_PATH, "death.ogg"))

local keeper = Object.new(NAMESPACE, "Gatekeeper", Object.PARENT.enemyClassic)
local keeper_id = keeper.value

local objLaser = Object.new(NAMESPACE, "GatekeeperLaser")
objLaser.obj_depth = -5
objLaser:clear_callbacks()

objLaser:onCreate(function(self)
	local data = self:get_data()
	self.mask = sprite_laser_mask
	self.sprite_index = sprite_laser_mask
	self.image_yscale = 0 -- fuck it
	self:move_contact_solid(270, 200)
	self.parent = -4
	self.direction = 0
	self.speed = 0
	data.target = -4
	data.charge = 0
	data.timer = 30
	data.color = Color.from_hex(0x83CDCD)
end)

objLaser:onStep(function(self)
	local data = self:get_data()
	
	self:move_contact_solid(270, 200)
	
	if data.timer > 0 then
		data.timer = data.timer - 1
	else
		if data.charge < 110 then
			data.charge = data.charge + 1
		else
			self:destroy()
		end
		
		if data.colorCheck == nil and parent and parent:exists() then
			if self.parent.elite_type and self.parent.elite_type ~= -1 then
				data.color = Elite.wrap(self.parent.elite_type.blend_col)
			end
			data.colorCheck = true
		end
		
		if data.charge % 6 == 0 and self.parent and self.parent:exists() then
			local attack = self.parent:fire_explosion(self.x, self.y - 200, ((data.charge * 0.3) + 8), 400, 1 * data.charge * 0.005)
			attack.attack_info.gk_laser = true
			self.parent:fire_explosion(self.x, self.y, 0, 0, 0)
		end
	end
end)

objLaser:onDraw(function(self)
	local data = self:get_data()
	
	if data.timer > 0 then
		local width = data.timer * 0.4
		
		gm.draw_set_colour(Color.WHITE)
		gm.draw_set_alpha(0.3 + data.timer * 0.01)
		gm.draw_rectangle(self.x - width / 2, 0, self.x + width / 2, self.y - 1, true)
	else
		local color = data.color
		local width = data.charge * 0.4
		local alpha = math.min((110 - data.charge) * 0.08, 1)
		
		gm.draw_set_colour(color)
		gm.draw_set_alpha(0.75 * alpha)
		gm.draw_rectangle(self.x - width, 0, self.x + width, self.y - 1, false)
		gm.draw_set_colour(Color.WHITE)
		gm.draw_set_alpha(0.9 * alpha)
		gm.draw_rectangle(self.x - width / 2, 0, self.x + width / 2, self.y - 1, false)
	end
end)

Callback.add(Callback.TYPE.onAttackHit, "GatekeeperLaserHit", function(hit_info)
	if hit_info.gk_laser then
		hit_info:sound_play(sound_laser_hit, 0.6, 0.9 + math.random() * 0.2)
		hit_info:screen_shake(2)
	end
end)

local laserColor = Color.from_hex(0x83CDCD)

keeper.obj_sprite = sprite_idle
keeper.obj_depth = 11 -- depth of vanilla pEnemyClassic objects
keeper:clear_callbacks()

local keeperPrimary = Skill.new(NAMESPACE, "gatekeeperZ")
keeperPrimary.cooldown = 4 * 60
keeperPrimary.is_primary = true
keeperPrimary.is_utility = false
keeperPrimary.does_change_activity_state = true

local keeperSecondary = Skill.new(NAMESPACE, "gatekeeperX")

keeper:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_idle
	actor.sprite_jump_peak = sprite_idle
	actor.sprite_fall = sprite_idle
	actor.sprite_death = sprite_death

	actor.can_jump = false
	actor.can_drop = false

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wGuardHit
	actor.sound_death = sound_death

	actor:enemy_stats_init(24, 800, actor.maxhp / 3, 780)
	actor.pHmax_base = 1.4
	actor.knockback_immune = true
	actor.stun_immune = true
	actor.z_range = 800
	actor.x_range = 600
	actor:get_data().attack_mode = 1

	actor:set_default_skill(Skill.SLOT.primary, keeperPrimary)
	--actor:set_default_skill(Skill.SLOT.secondary, keeperSecondary)

	actor:init_actor_late()
end)

keeper:onStep(function(actor)
	actor:move_contact_solid(270, 40)
end)

local stateKeeperPrimaryA = State.new(NAMESPACE, "gatekeeperPrimaryA")
local stateKeeperPrimaryB = State.new(NAMESPACE, "gatekeeperPrimaryB")
stateKeeperPrimaryA:clear_callbacks()
stateKeeperPrimaryB:clear_callbacks()

keeperPrimary:clear_callbacks()
keeperPrimary:onActivate(function(actor)
	if actor:get_data().attack_mode == 1 then
		actor:enter_state(stateKeeperPrimaryA)
	else
		actor:enter_state(stateKeeperPrimaryB)
	end
end)

stateKeeperPrimaryA:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
	data.trx = nil
	data.try = nil
	data.trmoving = 0
	actor:sound_play(sound_laser_fire, 1, 0.8 + math.random() * 0.2)
end)

stateKeeperPrimaryA:onStep(function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1a, 0.16)
	if actor.image_index < 3 and data.fired == 0 then
		local target = actor.target.parent
		
		if target and target:exists() then
			if data.trx and data.try then
				local dif = data.trx - target.x
				if data.trx > target.x then
					data.trx = math.min(target.x, data.trx + dif * 0.6)
				else
					data.trx = math.max(target.x, data.trx + dif * 0.6)
				end
				
				dif = data.try - target.y
				if data.try > target.y then
					data.try = math.min(target.y, data.try - dif * 0.6)
				else
					data.try = math.max(target.y, data.try - dif * 0.6)
				end
				
				data.trmoving = target.pHspeed
			else
				data.trx = target.x
				data.try = target.y
				data.trmoving = 0
			end
		end
	end
	
	if actor.image_index >= 3 and data.fired == 0 then
		local target = actor.target.parent
		
		if target then
			data.fired = 1
			local laser = objLaser:create(data.trx, data.try)
			laser.parent = actor
			laser.speed = data.trmoving * 0.9
		end
	end
	
	if actor.image_index >= 3 and data.fired == 1 then
		data.targetting = nil
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)