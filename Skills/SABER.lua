local SPRITE_PATH = path.combine(PATH, "Sprites/Skills/SABER")
local SOUND_PATH = path.combine(PATH, "Sounds/Skills/SABER")

local sprSaber = Resources.sprite_load(NAMESPACE, "saber", path.combine(SPRITE_PATH, "saber.png"), 6, 30, 18)
local sndSaber = Resources.sfx_load(NAMESPACE, "saber", path.combine(SOUND_PATH, "saber.ogg"))
local sprSaberIcon = Resources.sprite_load(NAMESPACE, "saber_icon", path.combine(SPRITE_PATH, "saber_icon.png"))

local skill_saber = Skill.new(NAMESPACE, "robomando_saber")
local state_saber = State.new(NAMESPACE, "robomando_saber")

Survivor.find("ror-robomando"):add_primary(skill_saber)

skill_saber:set_skill_icon(sprSaberIcon, 0)
skill_saber:set_skill_properties(2.3, 40)
skill_saber.is_primary = true

skill_saber:clear_callbacks()
skill_saber:onActivate(function(actor)
    actor:enter_state(state_saber)
end)

state_saber:clear_callbacks()
state_saber:onEnter(function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

state_saber:onStep(function(actor, data)
	local damage = actor:skill_get_damage(skill_saber)
	actor:skill_util_fix_hspeed()
	actor:actor_animation_set(sprSaber, 0.2)
	
	if actor.image_index >= 3 and data.fired == 0 then
		data.fired = 1
		actor:sound_play(sndSaber, 5, 0.9 + math.random() * 0.2)
		
		if actor:is_authority() then
			local buff_shadow_clone = Buff.find("ror", "shadowClone")
			for i=0, actor:buff_stack_count(buff_shadow_clone) do
				local slash = actor:fire_explosion(actor.x + 30 * actor.image_xscale, actor.y, 60, 40, damage, nil, gm.constants.sSparks9r)
				slash.attack_info.climb = i * 8
			end
		end
	end
	
	actor:skill_util_exit_state_on_anim_end()
end)