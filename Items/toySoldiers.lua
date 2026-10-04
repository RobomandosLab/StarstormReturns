--toy soldiers by Digbugreal
--needs stacking / damage tuning, stun tuning, follow player ai
--toymandoes circle ropes like headless chickens forever if they cant reach them (most of the time they cant)
--they also circle around certain bosses without doing anything
--item kind of sucks rn sadly ....................................

--item sprites
local spr_item		= Sprite.new("ToySoldiers", path.combine(PATH, "Sprites/Items/toySoldiers.png"), 1, 16, 16)
local spr_capsule 	= Sprite.new("toyCapsuleLanding", path.combine(PATH, "Sprites/Items/Effects/toypodLand.png"), 7, 32, 176)

--toy commando sprites
local spr_idle		= Sprite.new("toyIdle", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/idle.png"), 1, 9, 7)
local spr_climb		= Sprite.new("toyClimb", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/climb.png"), 2, 4, 6)
local spr_walk		= Sprite.new("toyWalk", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/walk.png"), 8, 4, 6)
spr_walk:set_speed(0.75)
local spr_jump		= Sprite.new("toyJump", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/jump.png"), 1, 3, 6)
local spr_Shoot1	= Sprite.new("toyShoot1", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/shoot1.png"), 5, 7, 7)
local spr_Shoot2	= Sprite.new("toyShoot2", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/shoot2.png"), 5, 8, 6)
local spr_Shoot3	= Sprite.new("toyShoot3", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/shoot3.png"), 9, 6, 6)
local spr_Shoot4_1	= Sprite.new("toyShoot4_1", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/shoot4_1.png"), 6, 6, 6)
local spr_Shoot4_2	= Sprite.new("toyShoot4_2", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/shoot4_2.png"), 7, 19, 6)
local spr_death		= Sprite.new("toyDeath", path.combine(PATH, "Sprites/Items/Effects/toySoldiers/death.png"), 5, 9, 4)

--sounds
local snd_shoot		= Sound.new("TsCommandoShoot1", path.combine(PATH, "Sounds/Items/ts_bullet1.ogg"))
local snd_shoot2	= Sound.new("TsCommandoShoot2", path.combine(PATH, "Sounds/Items/ts_bullet2.ogg"))
local snd_shoot3	= Sound.new("TsCommandoShoot3", path.combine(PATH, "Sounds/Items/ts_bullet3.ogg"))

local toycap = Item.new("toySoldiers")
toycap:set_sprite(spr_item)
toycap:set_tier(ItemTier.RARE)
toycap.loot_tags = Item.LootTag.CATEGORY_DAMAGE + Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(toycap)

local capObj = Object.new("capsuleObj")
capObj:set_sprite(spr_capsule)

local toy = Object.new("toymando", Object.Parent.ENEMY_CLASSIC) --make it an enemy so there's no need to make *as much* custom ai for it
toy:set_sprite(spr_idle)
toy:set_depth(11)

local primary = Skill.new("toyZ")
local statePrimary = ActorState.new("toyPrimary")
local secondary = Skill.new("toyX")
local stateSecondary = ActorState.new("toySecondary")
local utility = Skill.new("toyC")
local stateUtility = ActorState.new("toyUtility")
local special = Skill.new("toyV")
local stateSpecial = ActorState.new("toySpecial")
local stateSpecialAlternating = ActorState.new("toySpecialAlternating") --special state where commando fires both ways

secondary.cooldown = 3 * 60
utility.cooldown = 4 * 60
special.cooldown = 5 * 60

Callback.add(toy.on_create, function(actor)
	actor.parent = -4
	
	actor.team = 1
	actor.can_rope = true
	actor.sprite_idle = spr_idle
	actor.sprite_walk = spr_walk
	
	actor.sprite_jump = spr_jump
	actor.sprite_jump_peak = spr_jump
	actor.sprite_fall = spr_jump
	
	actor.sprite_death = spr_death
	actor.sprite_ping = spr_idle
	actor.sprite_climb = spr_climb
	
	actor.sound_hit = gm.constants.wGolemHit
	actor.sound_hit_pitch = 1.5
	actor.sound_death = gm.constants.wPlayer_TakeHeavyDamage 
	
	actor.can_jump = true
	
	actor:enemy_stats_init(6, 60, 22, 0)
	actor.pHmax_base = 2.6
	actor.intangible = true
	
	--skill use ranges
	actor.z_range = 150
	actor.x_range = 150
	actor.c_range = 150
	actor.v_range = 150 
	
	actor:set_default_skill(Skill.Slot.PRIMARY, primary)
	actor:set_default_skill(Skill.Slot.SECONDARY, secondary)
	actor:set_default_skill(Skill.Slot.UTILITY, utility)
	actor:set_default_skill(Skill.Slot.SPECIAL, special)
	
	actor:init_actor_late()
end)

-- Callback.add(toy.on_destroy, function(actor)
	-- toy:sound_play(gm.constants.wPlayer_TakeHeavyDamage, 1, 1.45)

-- end)


Callback.add(toy.on_step, function(actor)

	-- if Instance.get_data(actor).lifetime and Instance.get_data(actor).lifetime > 0 then
		-- Instance.get_data(actor).lifetime =  Instance.get_data(actor).lifetime - 1
	-- end
	
	-- if Instance.get_data(actor).lifetime and Instance.get_data(actor).lifetime <= 0 then
		-- self:destroy()
	-- end
	
	--if distance from parent is too big then
		--actor:alarm_set(0, -1)
	--end
	
	--if actor:alarm_get(0) == -1 then blahblah make it follow actor somehow
	-- print(Instance.find(gm.constants.pTeleporter))
	local tp = Instance.find(gm.constants.pTeleporter)
	if tp.time == tp.maxtime then
		actor.hp = -math.huge
	end
end)

Callback.add(capObj.on_create, function(self)
	self.parent = -4
	self.image_speed = 0.2
	self.timer = 61
	
	Sound.wrap(gm.constants.wPodLand):play(self.x, self.y, 1, 2.4)

end)

--capsule obj

Callback.add(capObj.on_step, function(self)
	if not ssr_is_colliding_stage(self) then
		ssr_move_contact_solid(self, 90)
	end
	
	if self.image_index >= 6 then
		self.image_speed = 0
	end
	if self.image_index >= 6 and self.timer > -1 then
		self.timer = self.timer - 1
		if self.timer % 20 == 0 then
			local mand = toy:create(self.x, self.y - 10)
			mand.parent = self.parent
			mand.pVspeed = mand.pVmax * -2
			mand.damage = mand.damage + (3 * (self.count - 1))
			
			--pilot parachute
			local chute = Instance.create(mand.x, mand.y, gm.constants.oPilotChute)
			chute.image_xscale = 0.5
			chute.image_yscale = 0.5
			chute.parent = mand
			chute.depth = mand.depth
			Sound.wrap(gm.constants.wBanditShoot2):play(self.x, self.y, 1, 1.3)
		end
	end
	
	if self.timer == 0 then
		self.depth = 12
	end
end)

Callback.add(Callback.ON_INTERACTABLE_ACTIVATE, function(int, actor)
	if actor:item_count(toycap) <= 0 then return end
	
	if int.active == 1 then
		if gm.object_is(int:get_object_index(), gm.constants.pTeleporter) or int:get_object_index() == gm.constants.oCommand then
			local xRange = math.random(int.x - 150, int.x + 150)
			local capsule = capObj:create(xRange, int.y)
			capsule.parent = actor
			capsule.count = actor:item_count(toycap)
			
		end
	end
end)

--Skills for the lil guys

--primary
Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary)
end)

Callback.add(statePrimary.on_enter, function(actor, data)
	actor.image_index = 0
	
	data.fired = 0 
	--make it fire twyce we're goin RETRO dubble tape !!!!!!
	data.loop = math.ceil(2 * math.min(actor.attack_speed, 3.3))

end)

Callback.add(statePrimary.on_step, function(actor, data) -- runs on every tick while the survivor is in this state
	
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(spr_Shoot1, 0.3)
	
	if data.fired == 0 then
		data.fired = 1
		data.loop = data.loop - 1
		
		actor:sound_play(snd_shoot, 1, 1.1 + math.random() * 0.15)

		if actor:is_authority() then
			local dir = actor:skill_util_facing_direction()

			local attack = actor:fire_bullet(actor.x - (3 * actor.image_xscale), actor.y + 2, 1400, dir, 0.6, nil, gm.constants.sSparks1, Tracer.COMMANDO1).attack_info
			ssr_set_no_proc(attack)
			attack.climb = 8 * 1.35
		end
	end
	
	if math.floor(actor.image_index) > gm.sprite_get_number(actor.sprite_index) - 4 then
		if (data.loop > 0) then
			data.fired = 0
			actor.image_index = 0
		else
			actor:skill_util_reset_activity_state()
		end
	end
	
	
	actor:skill_util_exit_state_on_anim_end() 
end)

--secondary
Callback.add(secondary.on_activate, function(actor, skill, slot)
	actor:set_state(stateSecondary)
end)

Callback.add(stateSecondary.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(stateSecondary.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(spr_Shoot2, 0.25)
	
	if data.fired == 0 then
		data.fired = 1

		actor:sound_play(snd_shoot2, 1, 1.2)
		actor:screen_shake(4)

		if actor:is_authority() then
			local dir = actor:skill_util_facing_direction()

			local attack = actor:fire_bullet(actor.x, actor.y, 1400, dir, 2.3, 1, gm.constants.sSparks2, Tracer.COMMANDO2).attack_info
			ssr_set_no_proc(attack)
			attack.climb = 8 * 1.35
			attack.knockback = attack.knockback + 4

		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

--utility

stateUtility.activity_flags = ActorState.ActivityFlag.ALLOW_ROPE_CANCEL

Callback.add(utility.on_activate, function(actor, skill, slot)
	actor:set_state(stateUtility)
end)

Callback.add(stateUtility.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(stateUtility.on_step, function(actor, data)
	actor:actor_animation_set(spr_Shoot3, 0.3, false)
	actor.invincible = math.max(actor.invincible, 5)
	actor.pHspeed = actor.pHmax * 2.4 * actor.image_xscale
	
	if actor.image_index >= 1 and data.fired == 0 then
		data.fired = 1
		actor:sound_play(gm.constants.wCommandoRoll, 0.9, 1.5)
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

--specil

Callback.add(special.on_activate, function(actor, skill, slot)
	if actor:check_trace(600, 0) and actor:check_trace(600, 180) then
		actor:set_state(stateSpecialAlternating)
	else
		actor:set_state(stateSpecial)
	end
end)

Callback.add(stateSpecial.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
	
	data.loop = math.ceil(6 * math.min(actor.attack_speed, 3.3))

end)

Callback.add(stateSpecial.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(spr_Shoot4_1, 0.3)
	
	if actor.image_index >= 1 and data.fired == 0 then
		data.fired = 1
		data.loop = data.loop - 1
		actor:sound_play(snd_shoot3, 1, 0.85 + math.random() * 0.15)
		
		if actor:is_authority() then
			local dir = actor:skill_util_facing_direction() + Math.round(math.random(-2, 2)) -- add a 2 degree bullet inaccuracy

			local attack = actor:fire_bullet(actor.x - (3 * actor.image_xscale), actor.y + 2, 1400, dir, 0.6, nil, gm.constants.sSparks1, Tracer.COMMANDO1).attack_info
			ssr_set_no_proc(attack)
			attack.climb = 8 * 1.35
			attack.stun = 0.1
		end
	end
	
	if math.floor(actor.image_index) > gm.sprite_get_number(actor.sprite_index) - 4 then
		if (data.loop > 0) then
			data.fired = 0
			actor.image_index = 1
		else
			actor:skill_util_reset_activity_state()
		end
	end
end)

--specil alt

Callback.add(stateSpecialAlternating.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0

	data.loop = math.ceil(6 * math.min(actor.attack_speed, 3.3))

end)

Callback.add(stateSpecialAlternating.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(spr_Shoot4_2, 0.3)
	
	if (actor.image_index >= 1 and data.fired == 0) or (actor.image_index >= 3 and data.fired == 1) then -- fire once on the second frame, and again on the fourth frame
		data.fired = data.fired + 1
		data.loop = data.loop - 1 -- decrement the loop value
		actor:sound_play(snd_shoot3, 1, 0.85 + math.random() * 0.15)
		
		if actor:is_authority() then
			local dir = actor:skill_util_facing_direction() + Math.round(math.random(-2, 2)) + (data.fired * 180) -- flip the direction if its the fourth frame bullet

			local attack = actor:fire_bullet(actor.x - (3 * actor.image_xscale), actor.y + 2, 1400, dir, 0.6, nil, gm.constants.sSparks1, Tracer.COMMANDO1).attack_info
			ssr_set_no_proc(attack)
			attack.climb = 8 * 1.35
			attack.stun = 0.1

		end
	end
	
	if actor.image_index + actor.image_speed >= gm.sprite_get_number(actor.sprite_index) - 3 then -- if the animation is about to end
		if (data.loop > 0) then
			data.fired = 0
			actor.image_index = 0
		else
			actor:skill_util_reset_activity_state()
		end
	end
end)


--lang below

	-- toySoldiers = {
		-- name = "Toy Soldiers",
		-- pickup = "Calls down a group of Toy Soldiers during the teleporter event.",
		-- description = "Calls down a group of Toy Soldiers during the teleporter event. Super wip",
		-- destination = "g",
		-- date = "four",
		-- story = "tuouy storie",
		-- priority = "<r>Fra jee lay</c>"
	-- }