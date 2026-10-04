-- old butchered nonfunctional rmt code dont touch dont look
-- needs a rework anyways

-- local sprite_item = Sprite.new("PortableReactor", path.combine(PATH, "Sprites/Items/reactor.png"), 1, 17, 18)
-- local sprite_ef = Sprite.new("PortableReactorEf", path.combine(PATH, "Sprites/Items/Effects/reactorEf.png"), 10, 15, 15)
-- local sound_loop = Sound.new("PortableReactorSfx", path.combine(PATH, "Sounds/Items/portableReactor.ogg"))

-- local reactor = Item.new("portableReactor")
-- reactor:set_sprite(sprite_item)
-- reactor:set_tier(ItemTier.RARE)
-- reactor.loot_tags = Item.LootTag.CATEGORY_UTILITY

-- Callback.add(reactor.on_acquired, function(actor, stack)

	-- if not actor.portableActive then
		-- actor.portableActive = 0
	-- end

	-- if not actor.reactorTimer then
		-- actor.reactorTimer = 0
	-- end
	
-- end)

-- reactor.effect_display = EffectDisplay.func(function(actor_unwrapped)
	
	-- if actor.reactorTimer > 0 and actor.portableActive == 1 then
		-- local f = Global._current_frame
		-- local i = 0 + (f * 0.2)
		-- gm.draw_sprite(sprite_ef, i, actor.x, actor.y)
	-- end
	
-- end, EffectDisplay.DrawPriority.BODY_POST)

-- Callback.add(Callback.ON_STAGE_START, function()
	-- for _, actor in ipairs(reactor:get_holding_actors()) do
		-- --Wait for the actor to enter the stage to apply invincibility
		-- --Check if the actor exists to prevent a crash if the player exits the run before it's applied
		-- --Set the variable
		-- local function wait(actor, stack)
			-- if actor:exists() then
				-- --set timer
				-- actor.reactorTimer = (60 * (25 + (15 * stack)))
				-- actor.portableActive = 1
				-- actor.invincible = 10005
			-- end
		-- end
		-- Alarm.create(wait, 90, actor, stack)
	-- end

-- end)

-- portableReactor:onPostStep(function(actor)
	
	-- if actor:exists() then
	
		-- if actor.reactorTimer > 0 and actor.portableActive == 1 then
			-- actor.reactorTimer = actor.reactorTimer - 1
			-- --small thing to prevent invincibility from running out even with a looooooooooooot of stacks
			-- if actor.invincible < 10005 then
				-- actor.invincible = actor.invincible + 1
			-- end
			-- --start our sound
			-- if not loops[actor.id] then
				-- loops[actor.id] = gm.sound_loop(reactor_sound, 0.9)   -- arg2 is volume
			-- end
		-- end
		
		-- if actor.reactorTimer < 1 and actor.portableActive == 1 then
			-- --Stop the sound
			-- if loops[actor.id] then
				-- gm._mod_sound_stop(loops[actor.id])
				-- loops[actor.id] = nil
			-- end
			-- actor.invincible = 0
			-- actor.portableActive = 0
		-- end
		
	-- else
		-- --Needed to stop the sound when exiting a run
		-- if loops[actor.id] then
			-- gm._mod_sound_stop(loops[actor.id])
			-- loops[actor.id] = nil
		-- end
	-- end

-- end)

-- --Stop the sound when exiting the run
-- gm.post_script_hook(gm.constants.run_destroy, function(self, other, result, args)
    -- for _, sfx in pairs(loops) do
        -- gm._mod_sound_stop(sfx)
    -- end
    -- loops = {}
-- end)