-- its azuline again!!
-- clay admonitor is pretty easy to make tbh
-- the only exception is the push effect they have!! ill comment on it a bunch
local SPRITE_PATH = path.combine(PATH, "Sprites/Actors/Admonitor")
local SOUND_PATH = path.combine(PATH, "Sounds/Actors/Admonitor")

local sprite_mask		= Resources.sprite_load(NAMESPACE, "AdmonitorMask",		path.combine(SPRITE_PATH, "mask.png"), 1, 11, 26)
local sprite_palette	= Resources.sprite_load(NAMESPACE, "AdmonitorPalette",	path.combine(SPRITE_PATH, "palette.png"))
local sprite_portrait	= Resources.sprite_load(NAMESPACE, "AdmonitorPortrait",	path.combine(SPRITE_PATH, "portrait.png"))
local sprite_spawn		= Resources.sprite_load(NAMESPACE, "AdmonitorSpawn",	path.combine(SPRITE_PATH, "spawn.png"), 15, 58, 39)
local sprite_idle		= Resources.sprite_load(NAMESPACE, "AdmonitorIdle",		path.combine(SPRITE_PATH, "idle.png"), 18, 30, 27)
local sprite_walk		= Resources.sprite_load(NAMESPACE, "AdmonitorWalk",		path.combine(SPRITE_PATH, "walk.png"), 8, 27, 31)
local sprite_jump		= Resources.sprite_load(NAMESPACE, "AdmonitorJump",		path.combine(SPRITE_PATH, "jump.png"), 1, 26, 33)
local sprite_jump_peak	= Resources.sprite_load(NAMESPACE, "AdmonitorJumpPeak",	path.combine(SPRITE_PATH, "jumpPeak.png"), 1, 26, 33)
local sprite_fall		= Resources.sprite_load(NAMESPACE, "AdmonitorFall",		path.combine(SPRITE_PATH, "fall.png"), 1, 26, 33)
local sprite_death		= Resources.sprite_load(NAMESPACE, "AdmonitorDeath",	path.combine(SPRITE_PATH, "death.png"), 14, 33, 53)
local sprite_shoot1		= Resources.sprite_load(NAMESPACE, "AdmonitorShoot1",	path.combine(SPRITE_PATH, "shoot1.png"), 30, 53, 86)

gm.elite_generate_palettes(sprite_palette)

local sound_spawn		= Resources.sfx_load(NAMESPACE, "AdmonitorSpawn",	path.combine(SOUND_PATH, "spawn.ogg"))
local sound_shoot1a		= Resources.sfx_load(NAMESPACE, "AdmonitorShoot1A",	path.combine(SOUND_PATH, "shoot1_1.ogg"))
local sound_shoot1b		= Resources.sfx_load(NAMESPACE, "AdmonitorShoot1B",	path.combine(SOUND_PATH, "shoot1_2.ogg"))
local sound_death		= Resources.sfx_load(NAMESPACE, "AdmonitorDeath",	path.combine(SOUND_PATH, "death.ogg"))

local push = Buff.new(NAMESPACE, "AdmonitorPush")
push.show_icon = false
push.is_debuff = true
push:clear_callbacks()

push:onPostStep(function(actor, stack)
	-- anyways we want to apply this to only classic actors (actors who interact with physics, have skills, etc)
	if GM.actor_is_classic(actor) and actor:get_data().puncher_push then
		actor:skill_util_nudge_forward(actor.pHmax * actor:get_data().puncher_push) -- this will move the victim by their max speed * the strength of the push
	end
	
	-- reduce the strength of the push, approaching 0 (technical: functionaly identical to math.approach from rorml)
	if actor:get_data().puncher_push < 0 then 
		actor:get_data().puncher_push = math.min(0, actor:get_data().puncher_push + 0.1)
	elseif actor:get_data().puncher_push > 0 then
		actor:get_data().puncher_push = math.max(0, actor:get_data().puncher_push - 0.1)
	end
	
	-- if the strength of the push is 0, end the debuff early
	if actor:get_data().puncher_push == 0 then
		GM.remove_buff(actor, push)
	end
end)

-- create the monster log
local mlog = Monster_Log.new(NAMESPACE, "admonitor")
mlog.sprite_id = sprite_idle
mlog.portrait_id = sprite_portrait
mlog.sprite_offset_x = 44
mlog.sprite_offset_y = 48
mlog.stat_hp = 350
mlog.stat_damage = 17
mlog.stat_speed = 1.6

local puncher = Object.new(NAMESPACE, "Admonitor", Object.PARENT.enemyClassic)
local puncher_id = puncher.value

puncher.obj_sprite = sprite_idle
puncher.obj_depth = 11 -- depth of vanilla pEnemyClassic objects

local puncherPrimary = Skill.new(NAMESPACE, "admonitorZ")
local statePuncherPrimary = State.new(NAMESPACE, "admonitorPrimary")

puncher:clear_callbacks()
puncher:onCreate(function(actor)
	actor.sprite_palette = sprite_palette
	actor.sprite_spawn = sprite_spawn
	actor.sprite_idle = sprite_idle
	actor.sprite_walk = sprite_walk
	actor.sprite_jump = sprite_jump
	actor.sprite_jump_peak = sprite_jump_peak
	actor.sprite_fall = sprite_fall
	actor.sprite_death = sprite_death

	actor.can_jump = false

	actor.mask_index = sprite_mask

	actor.sound_spawn = sound_spawn
	actor.sound_hit = gm.constants.wClayHit
	actor.sound_death = sound_death

	actor:enemy_stats_init(17, 350, 50, 30) -- damage, hp, knockback cap, experience amount
	actor.pHmax_base = 1.6 -- speed, default speed is 2.4

	actor.z_range = 150 -- range of the primary
	actor.monster_log_drop_id = mlog.value
	actor:set_default_skill(Skill.SLOT.primary, puncherPrimary)

	actor:init_actor_late()
end)

puncherPrimary:clear_callbacks()
puncherPrimary:onActivate(function(actor)
	actor:enter_state(statePuncherPrimary)
end)

statePuncherPrimary:clear_callbacks()
statePuncherPrimary:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

statePuncherPrimary:onStep(function(actor, data)
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
		if gm._mod_net_isHost() then
			local attack = actor:fire_explosion(actor.x + 75 * actor.image_xscale, actor.y - 5, 130, 32, 4.2, nil, gm.constants.wSparks4).attack_info
			attack.__ssr_puncher_push = 4 * actor.image_xscale
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)

local puncherPushSync = Packet.new()
puncherPushSync:onReceived(function(msg)
	local actor = msg:read_instance() -- send to clients who got hit
	local strength = msg:read_short() -- send to clients the strength of knockback

	if not actor:exists() then return end
	
	actor:get_data().puncher_push = strength
	GM.apply_buff(actor, push, 3 * 60, 1) -- apply the knockback to the person who got hit
end)

local function sync_puncher_push(actor, strength)
	if not gm._mod_net_isHost() then
		log.warning("sync_puncher_push called on client!")
		return
	end

	local msg = puncherPushSync:message_begin()
	msg:write_instance(actor)
	msg:write_short(strength)
	msg:send_to_all()
end

-- onAttackHit callbacks arent synced and only run for the host >>
Callback.add(Callback.TYPE.onAttackHit, "SSRPuncherPush", function(hit_info)
	if hit_info.attack_info.__ssr_puncher_push then
		if hit_info.target and GM.actor_is_classic(hit_info.target) then
			if gm._mod_net_isOnline() then
				sync_puncher_push(hit_info.target, hit_info.attack_info.__ssr_puncher_push) -- >> we use a packet to sync the knockback effect for clients in multiplayer
			end
			hit_info.target:get_data().puncher_push = hit_info.attack_info.__ssr_puncher_push
			GM.apply_buff(hit_info.target, push, 3 * 60, 1)
		end
	end
end)

local monsterCardPuncher = Monster_Card.new(NAMESPACE, "admonitor")
monsterCardPuncher.object_id = puncher_id
monsterCardPuncher.spawn_cost = 160
monsterCardPuncher.spawn_type = Monster_Card.SPAWN_TYPE.classic
monsterCardPuncher.can_be_blighted = true

local stages = {
	"ror-templeOfTheElders",
	"ror-riskOfRain",
	"ror-boarBeach", -- ive got no idea why nk put them there in ss1 but we decided it would be funny to keep it, also moved to pre loop
}

local postLoopStages = {
	"ror-sunkenTombs",
	"ror-ancientValley",
	"ror-magmaBarracks",
}

for _, s in ipairs(stages) do
	local stage = Stage.find(s)
	stage:add_monster(monsterCardPuncher)
end

for _, s in ipairs(postLoopStages) do
	local stage = Stage.find(s)
	stage:add_monster_loop(monsterCardPuncher)
end