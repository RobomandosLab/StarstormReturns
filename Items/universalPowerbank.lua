--god i fucking love Star          Storm              2
--Universal Charger port (Universal Powerbank)
local sprite_item = Sprite.new("UniversalPowerbank", path.combine(PATH, "Sprites/Items/universalPowerbank.png"), 1, 16, 16)
local sprite_ef = Sprite.new("UniversalPowerbankEf", path.combine(PATH, "Sprites/Items/Effects/powerbankFrame.png"), 1, 16, 16)

local powa = Item.new("powerBank")
powa:set_sprite(sprite_item)
powa:set_tier(ItemTier.UNCOMMON)
powa.loot_tags = Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(powa)

--setup
Callback.add(powa.on_acquired, function(actor, stack)
	if stack > 1 then return end
	Instance.get_data(actor).powerbankCooldown = 0

end)

--cleanup
Callback.add(powa.on_removed, function(actor, stack)
	if stack > 1 then return end
	Instance.get_data(actor).powerbankCooldown = nil
	Instance.get_data(actor).playedSound = nil

end)

--reset skills on use
Callback.add(Callback.ON_SKILL_ACTIVATE, function(actor, slot) --thank you for on_skill_activate rapi mwah
	local stack = actor:item_count(powa)
	if stack <= 0 then return end
	
	if slot == 0 then return end --if a primary skill is activated don't run this code
	
	local data = Instance.get_data(actor)
	
	local skill = ActorSkill.wrap(actor:get_active_skill(slot)) --get the skill that was used
	
	--along with checking against slot number being primary, also check against the is_primary variable that skills can have
	--may be dubiously compatible with survivor mods depending on how they use it for their skills but otherwise covers all bases i think
	
	--to check .is_primary, wrap the ActorSkill's skill_id using the Skill class
	if not Skill.wrap(skill.skill_id).is_primary then
		if data.powerbankCooldown and data.powerbankCooldown <= 0 then
			skill:reset_cooldown()
			data.powerbankCooldown = (12 * (100/(100 + (stack - 1)))) * 60 --MATH, same as ss2
			actor:sound_play(gm.constants.wAmethyst, 1.3, 0.8)
			data.playedSound = nil --sound for timer hitting 0
		end
	end

end)

--timer stuff
Callback.add(Callback.ON_PLAYER_STEP, function(actor)
	local stack = actor:item_count(powa)
	if stack <= 0 then return end
	
	local data = Instance.get_data(actor)
	if not data.powerbankCooldown then data.powerbankCooldown = 0 end
	
	if data.powerbankCooldown > 0 then
		data.powerbankCooldown = data.powerbankCooldown - 1
	
	end
	
	--telegraph for the timer hitting 0
	if data.powerbankCooldown == 60 then
		actor:sound_play(gm.constants.wAmethyst, 1, 1.2)
	end
	
	if data.powerbankCooldown <= 0 then
		if not data.playedSound then
			actor:sound_play(gm.constants.wAmethyst, 1, 1.4)
			actor:sound_play(gm.constants.wLoaderShield, 1, 0.8)
			data.playedSound = true
		end
	end

end)

--hud display
--sadly can't be drawn under the button icons, ty to anxvariable for telling me
Callback.add(Callback.ON_PLAYER_HUD_DRAW, function(actor, x, y)
	if actor:item_count(powa) <= 0 then return end
	local data = Instance.get_data(actor)
	
	if not (data.powerbankCooldown and data.powerbankCooldown <= 0) then return end
	
	--get the skills besides primary
	local sec = ActorSkill.wrap(actor:get_active_skill(1))
	local util = ActorSkill.wrap(actor:get_active_skill(2))
	local specil = ActorSkill.wrap(actor:get_active_skill(3))
	
	--nice little transparency pulse effect
	local alpha = math.sin(Global._current_frame * 0.05) * 0.23 + 0.7
	
	gm.draw_set_alpha(1)
	
	--only draw displays if skill doesn't have is_primary
	if not Skill.wrap(sec.skill_id).is_primary then
		GM.draw_sprite_ext(sprite_ef, 0, x + 44, y + 14, 1, 1, 0, Color.WHITE, alpha)
	end
	
	if not Skill.wrap(util.skill_id).is_primary then
		GM.draw_sprite_ext(sprite_ef, 0, x + 77, y + 14, 1, 1, 0, Color.WHITE, alpha)
	end
	
	if not Skill.wrap(specil.skill_id).is_primary then
		GM.draw_sprite_ext(sprite_ef, 0, x + 108, y + 14, 1, 1, 0, Color.WHITE, alpha)
	end
	
end)

--lang

	-- powerBank = {
		-- name = "Universal Powerbank",
		-- pickup = "Periodically refreshes one of your non-Primary skills on use.",
		-- description = "Every <b>12 seconds</c> <c_stack>(-10% per stack)</c>, instantly <b>refresh the cooldown</c> of your next used <b>non-Primary skill</c>.",
		-- destination = "g",
		-- date = "6767",
		-- story = "I AM NOT CRAZY!\nI am not crazy.. I KNOW he swapped those numbers, I knew it was 1216! One after Magna Carta, as if I could ever make such a mistake. Never. NEVER! I just– I just couldn’t prove it. He covered his tracks, he got that IDIOT, at the copy shop to lie for him.. You think this is something? You think this is bad? This? This chicanery? He’s done worse! That billboard! Are you telling me that a man just happens to fall like that? No! He orchestrated it! JIMMY! He DEFECATED through a SUNROOF! And I saved him! And I shouldn’t have. I took him into my own firm! What was I thinking?! He’ll never change. He’ll NEVER change! Ever since he was 9, always the same! Couldn’t keep his hands out of the cash drawer! But not our Jimmy! Couldn’t be precious JIMMY! Stealing them blind! And HE gets to be a lawyer?!?! What a sick joke! I should’ve stopped him when I had the chance..! And you, you have to stop him! You-..",
		-- priority = "<g>Priority</c>"
	-- }