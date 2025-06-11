local SPRITE_PATH = path.combine(PATH, "Sprites/Elites/Ethereal")
local SOUND_PATH = path.combine(PATH, "Sounds/Elites/Ethereal")

local ETHEREAL_HP_MULT = 3
local ETHEREAL_REWARD_MULT = 5
local ETHEREAL_BOMB_COOLDOWN = 800

local ETHEREAL_BOMB_RADIUS_START = 75
local ETHEREAL_BOMB_RADIUS_INCREMENT = 64
local ETHEREAL_BOMB_DAMAGE_COEFFICIENT = 0.35
local ETHEREAL_BOMB_DAMAGE_PERCENT_HP = 0.12

local ETHEREAL_BOMB_COLOR1 = Color.RED
local ETHEREAL_BOMB_COLOR2 = Color.LIME
local ETHEREAL_BOMB_COLOR3 = Color.BLUE

local ETHEREAL_BOMB_PULSE_INTERVAL = 30
local ETHEREAL_BOMB_PULSES = 3
local ETHEREAL_BOMB_PULSES_BOSS = 5

local sprite_icon = Resources.sprite_load(NAMESPACE, "EliteIconEthereal", path.combine(SPRITE_PATH, "icon.png"), 1, 21, 9)
local sprite_palette = Resources.sprite_load(NAMESPACE, "ElitePaletteEthereal", path.combine(SPRITE_PATH, "palette.png"))

local sound_spawn = Resources.sfx_load(NAMESPACE, "EtherealSpawn", path.combine(SOUND_PATH, "spawn.ogg"))

local particleEthereal = Particle.new(NAMESPACE, "Ethereal")
particleEthereal:set_life(20, 60)
particleEthereal:set_shape(Particle.SHAPE.disk)
particleEthereal:set_size(.05, .1, -0.001, 0.05)
particleEthereal:set_colour3(ETHEREAL_BOMB_COLOR2, ETHEREAL_BOMB_COLOR3, ETHEREAL_BOMB_COLOR1)
particleEthereal:set_alpha2(4, 0)
particleEthereal:set_blend(false)

local eliteEthereal = Elite.new(NAMESPACE, "ethereal")
eliteEthereal.healthbar_icon = sprite_icon
eliteEthereal.palette = sprite_palette
eliteEthereal.blend_col = Color.from_rgb(23, 255, 172)

local itemEliteOrbEthereal = Item.new(NAMESPACE, "eliteOrbEthereal", true) -- true for no logbook
itemEliteOrbEthereal.is_hidden = true

eliteEthereal:clear_callbacks()
eliteEthereal:onApply(function(actor)
	actor:item_give(itemEliteOrbEthereal)
	actor:item_give(Item.find("ror", "elitePassiveTeleport"))

	actor.maxhp_base = actor.maxhp_base * ETHEREAL_HP_MULT -- kind of dumb, but proper maxhp increases in RMT are too jank, so
	actor.exp_worth = actor.exp_worth * ETHEREAL_REWARD_MULT

	actor:sound_play(sound_spawn, 1, 0.9 + math.random() * 0.2)

	GM.actor_queue_dirty(actor) -- make maxhp_base modification take effect
end)

local objEtherealBomb = Object.new(NAMESPACE, "EtherealBomb")
objEtherealBomb.obj_depth = -1000

objEtherealBomb:clear_callbacks()
objEtherealBomb:onCreate(function(self)
	self.radius = 0
	self.next_radius = ETHEREAL_BOMB_RADIUS_START
	self.timer = ETHEREAL_BOMB_PULSE_INTERVAL
	self.pulses = ETHEREAL_BOMB_PULSES

	self.parent = -4
	self.damage = 10
	self.team = 2
end)
objEtherealBomb:onStep(function(self)
	self.timer = self.timer - 1

	if self.timer <= 0 then
		if self.pulses > 0 then
			self.timer = ETHEREAL_BOMB_PULSE_INTERVAL
			self.pulses = self.pulses - 1

			self.radius = self.next_radius
			self.next_radius = self.radius + ETHEREAL_BOMB_RADIUS_INCREMENT

			self:screen_shake(8)
			self:sound_play(gm.constants.wLightning, 1, 0.5 + self.pulses * 0.1)
			self:sound_play(gm.constants.wChainLightning, 0.7, 0.4 + math.random() * 0.2)

			local px, py = self.x, self.y
			local r = self.radius

			local count = r * 2

			for i=1, count do
				local ang = (i / count) * math.pi * 2
				local rr = r * math.random() ^ 0.1
				particleEthereal:create(px + math.sin(ang) * rr, py + math.cos(ang) * rr)
			end

			local targets = List.new()
			local count = self:collision_circle_list(self.x, self.y, self.radius, gm.constants.pActorCollisionBase, false, true, targets, false)

			for i=1, count do
				local victim = targets[i]

				if self:attack_collision_canhit(victim) then
					local attack_info = GM._mod_attack_fire_direct_noparent(victim, victim.x, victim.y, 0, self.team, self.damage, false, -1).attack_info
					attack_info.parent = self.parent
					attack_info.percent_hp = ETHEREAL_BOMB_DAMAGE_PERCENT_HP
				end
			end

			targets:destroy()
		else
			self:destroy()
		end
	end
end)
objEtherealBomb:onDraw(function(self)
	local r = self.radius
	local r2 = self.next_radius
	local t_frac = self.timer / ETHEREAL_BOMB_PULSE_INTERVAL
	local draw_foreshadow = self.pulses > 0

	local r0 = r + (r2 - r) * (1 - t_frac ^ 1.8)

	local r1 = r * (1 - t_frac ^ 9)
	local r2 = r * (1 - t_frac ^ 4)
	local r3 = r * (1 - t_frac ^ 2)

	gm.draw_set_colour(Color.WHITE)

	if draw_foreshadow then
		gm.draw_circle(self.x, self.y, r0, true)
		gm.gpu_set_blendmode(3)
		gm.draw_circle(self.x, self.y, r0-2, true)
	end
	gm.gpu_set_blendmode_ext(10, 4) -- inversion blend mode -- destination colour inv, source colour inv
	gm.draw_circle(self.x, self.y, r, false)
	gm.draw_set_colour(ETHEREAL_BOMB_COLOR1)
	gm.draw_circle(self.x, self.y, r1, false)
	gm.draw_set_colour(ETHEREAL_BOMB_COLOR2)
	gm.draw_circle(self.x, self.y, r2, false)
	gm.draw_set_colour(ETHEREAL_BOMB_COLOR3)
	gm.draw_circle(self.x, self.y, r3, false)

	gm.gpu_set_blendmode(0)
end)

itemEliteOrbEthereal:clear_callbacks()
itemEliteOrbEthereal:onAcquire(function(actor)
	actor:get_data().ethereal_cooldown = ETHEREAL_BOMB_COOLDOWN * 0.5 + math.random(-100, 100)
end)
itemEliteOrbEthereal:onPostStep(function(actor)
	local data = actor:get_data()

	data.ethereal_cooldown = data.ethereal_cooldown - 1

	if data.ethereal_cooldown == 180 then
		actor:sound_play(gm.constants.wEngi_TurretAlt_ActivateAndCharge, 1, 3)
	end

	if data.ethereal_cooldown <= 0 then
		data.ethereal_cooldown = ETHEREAL_BOMB_COOLDOWN + math.random(-100, 100)

		actor:screen_shake(20)
		actor:sound_play(gm.constants.wEngi_TurretAlt_Fire, 1, 0.4 + math.random() * 0.2)

		local bomb = objEtherealBomb:create(actor.x, actor.y)
		bomb.parent = actor
		bomb.team = actor.team
		bomb.damage = actor.damage * ETHEREAL_BOMB_DAMAGE_COEFFICIENT
		if GM.actor_is_boss(actor) then
			bomb.pulses = ETHEREAL_BOMB_PULSES_BOSS
		end
	end
end)
itemEliteOrbEthereal:onPreDraw(function(actor)
	local data = actor:get_data()

	if data.ethereal_cooldown < 180 then
		local x, y = actor.ghost_x, actor.ghost_y

		local frac1 = 1 - (data.ethereal_cooldown / 180)
		local frac2 = math.min(1, data.ethereal_cooldown / 5)

		local rad = 50 + (actor.bbox_bottom - actor.bbox_top) * 0.5
		rad = rad * frac1 * frac2 - math.random(5)

		gm.gpu_set_blendmode_ext(10, 4)
		gm.draw_set_colour(ETHEREAL_BOMB_COLOR1)
		gm.draw_circle(x, y, rad*0.8, false)
		gm.draw_set_colour(ETHEREAL_BOMB_COLOR2)
		gm.draw_circle(x, y, rad*0.9, false)
		gm.draw_set_colour(ETHEREAL_BOMB_COLOR3)
		gm.draw_circle(x, y, rad*1.0, false)
		gm.gpu_set_blendmode(0)

		for i=1, math.ceil(frac1 * 15) do
			local ang = math.random() * math.pi * 2
			particleEthereal:create(x + math.sin(ang) * rad, y + math.cos(ang) * rad, 1, Particle.SYSTEM.below)
		end
	end
end)

--//////// TESTING PURPOSES ////////--
gm.post_script_hook(gm.constants.init_actor_late, function(self)
	if self.team == 2 then
		GM.elite_set(self, eliteEthereal)
	end
end)