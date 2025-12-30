-- its azuline again!!
-- clay admonitor is pretty easy to make tbh
-- the only exception is the push effect they have!! ill comment on it a bunch
local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Admonitor")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Admonitor")

local sprite_mask		= Sprite.new("AdmonitorMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 11, 26)
local sprite_palette	= Sprite.new("AdmonitorPalette",	path.combine(SPRITE_PATH, "palette.png"))
local sprite_portrait	= Sprite.new("AdmonitorPortrait",	path.combine(SPRITE_PATH, "portrait.png"))
local sprite_spawn		= Sprite.new("AdmonitorSpawn",		path.combine(SPRITE_PATH, "spawn.png"), 15, 58, 39)
local sprite_idle		= Sprite.new("AdmonitorIdle",		path.combine(SPRITE_PATH, "idle.png"), 18, 30, 27, 0.8)
local sprite_walk		= Sprite.new("AdmonitorWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 27, 31)
local sprite_jump		= Sprite.new("AdmonitorJump",		path.combine(SPRITE_PATH, "jump.png"), 1, 26, 33)
local sprite_jump_peak	= Sprite.new("AdmonitorJumpPeak",	path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 26, 33)
local sprite_fall		= Sprite.new("AdmonitorFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 26, 33)
local sprite_death		= Sprite.new("AdmonitorDeath",		path.combine(SPRITE_PATH, "death.png"), 14, 33, 53)
local sprite_shoot1		= Sprite.new("AdmonitorShoot1",		path.combine(SPRITE_PATH, "shoot1.png"), 30, 53, 86)

GM.elite_generate_palettes(sprite_palette)

local sound_spawn		= Sound.new("AdmonitorSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
local sound_shoot1a		= Sound.new("AdmonitorShoot1A",	path.combine(SOUND_PATH, "shoot1_1.ogg"))
local sound_shoot1b		= Sound.new("AdmonitorShoot1B",	path.combine(SOUND_PATH, "shoot1_2.ogg"))
local sound_death		= Sound.new("AdmonitorDeath",	path.combine(SOUND_PATH, "death.ogg"))

local push = Buff.new("AdmonitorPush")
push.show_icon = false
push.is_debuff = true

Callback.add(Callback.ON_STEP, function()
	for _, actor in ipairs(push:get_holding_actors()) do
		local data = Instance.get_data(actor)
		
		-- anyways we want to apply this to only classic actors (actors who interact with physics, have skills, etc)
		if GM.actor_is_classic(actor) and data.puncher_push then
			actor:skill_util_nudge_forward(actor.pHmax * data.puncher_push) -- this will move the victim by their max speed * the strength of the push
			data.puncher_push = ssr_approach(data.puncher_push, 0, 0.1) -- reduce the strength of the push, approaching 0
		end
		
		-- if the strength of the push is 0, end the debuff
		if not data.puncher_push or data.puncher_push == 0 then
			actor:buff_remove(push)
		end
	end
end)

-- create the monster log
local mlog = ssr_create_monster_log("admonitor")
mlog.sprite_id = sprite_idle
mlog.portrait_id = sprite_portrait
mlog.sprite_offset_x = 44
mlog.sprite_offset_y = 48
mlog.stat_hp = 350
mlog.stat_damage = 17
mlog.stat_speed = 1.6

local puncher = Object.new("Admonitor", Object.Parent.ENEMY_CLASSIC)
puncher:set_sprite(sprite_idle)
puncher:set_depth(11) -- depth of vanilla pEnemyClassic objects

local primary = Skill.new("admonitorZ")
local statePrimary = ActorState.new("admonitorPrimary")

Callback.add(puncher.on_create, function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_jump = true

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wClayHit
	actor.sound_death = sound_death

	actor:enemy_stats_init(17, 350, 50, 30) -- damage, hp, knockback cap, experience amount
	actor.pHmax_base = 1.6 -- speed, default speed is 2.4

	actor.z_range = 150 -- range of the primary
	actor.monster_log_drop_id = mlog.value
	actor:set_default_skill(Skill.Slot.PRIMARY, primary)

	actor:init_actor_late()
end)

Callback.add(primary.on_activate, function(actor, skill, slot)
	actor:set_state(statePrimary)
end)

Callback.add(statePrimary.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimary.on_step, function(actor, data)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprite_shoot1, 0.23) -- 0.23 is anim speed value, its 0.23 to make the animation match the sound

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sound_shoot1a, 1, 0.9 + math.random() * 0.2)
	end
	
	if data.fired == 1 and actor.image_index >= 14 then
		data.fired = 2
		actor:sound_play(sound_shoot1b, 1, 0.9 + math.random() * 0.2)
	end
	
	if data.fired == 2 and actor.image_index >= 16 then
		data.fired = 3
		if Net.host then
			local attack = actor:fire_explosion(actor.x + 75 * actor.image_xscale, actor.y - 13, 130, 40, 4.2, nil, gm.constants.wSparks4).attack_info
			attack.x = actor.x + 114 * actor.image_xscale
			attack.y = actor.y - 6
			attack.__ssr_puncher_push = 4 * actor.image_xscale
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

local packet = Packet.new("SyncAdmonitorPush")

local serializer = function(buffer, actor, strength)
	buffer:write_instance(actor)
	buffer:write_short(strength)
end

local deserializer = function(buffer)
	local actor = buffer:read_instance() -- send to clients who got hit
	local strength = buffer:read_short() -- send to clients the strength of knockback

	if not Instance.exists(actor) then return end
	
	Instance.get_data(actor).puncher_push = strength
	actor:buff_apply(push, 3 * 60) -- apply the knockback to the person who got hit
	actor:screen_shake(6)
end

packet:set_serializers(serializer, deserializer)

-- custom attack_info isnt synced >>
Callback.add(Callback.ON_ATTACK_HIT, function(hit_info)
	if hit_info.attack_info.__ssr_puncher_push then
		if hit_info.target and GM.actor_is_classic(hit_info.target) then
			if Net.online then
				packet:send_to_all(hit_info.target, hit_info.attack_info.__ssr_puncher_push) -- >> we check if the host has it, and if it does use a packet to sync the knockback effect for clients in multiplayer
			end
			
			Instance.get_data(hit_info.target).puncher_push = hit_info.attack_info.__ssr_puncher_push
			hit_info.target:buff_apply(push, 3 * 60)
			hit_info.target:screen_shake(6)
		end
	end
end)

local card = MonsterCard.new("admonitor")
card.object_id = puncher.value
card.spawn_cost = 160
card.spawn_type = 0 --MonsterCard.SpawnType.CLASSIC
card.can_be_blighted = true

if HOTLOADING then return end

local stages = {
	"templeOfTheElders",
	"riskOfRain",
	"boarBeach", -- ive got no idea why nk put them there in ss1 but we decided it would be funny to keep it, also moved to pre loop
}

local postLoopStages = {
	"sunkenTombs",
	"ancientValley",
	"magmaBarracks",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	
	if stage then
		stage:add_monster(card)
	end
end

for _, s in ipairs(postLoopStages) do
	local stage = Stage.find(s)
	
	if stage then
		stage:add_monster_loop(card)
	end
end