-- TEMPORARY RETURNS API UNFINISHED THINGS --
-- basically lifted from rmt since returns api doesnt have them yet, once rapi adds them delete all this shit and use that instead

-- MONSTER LOGS
function ssr_set_monster_log_boss(self, is_boss)
	if type(is_boss) ~= "boolean" then log.error("is_boss should be a boolean, got a "..type(is_boss), 2) return end

	if is_boss then
		self.log_backdrop_index = 1
	else
		self.log_backdrop_index = 0
	end

	-- Remove previous monster log position (if found)
	local monster_log_order = List.wrap(gm.variable_global_get("monster_log_display_list"))
	local pos = monster_log_order:find(self)
	if pos then monster_log_order:delete(pos) end

	local pos = monster_log_order:size()
	for i, id in ipairs(monster_log_order) do
		if MonsterLog.wrap(id).log_backdrop_index > self.log_backdrop_index then
			pos = i
			break
		end
	end
	
	monster_log_order:insert(pos - 1, self)
end

function ssr_create_monster_log(identifier)
	-- check if monster_log already exists
	local monster_log = MonsterLog.find(identifier)
    if monster_log then return monster_log end

    -- create monster_log
    monster_log = MonsterLog.wrap(gm.monster_log_create("ssr", identifier))

    monster_log.sprite_id = gm.constants.sLizardWalk
    monster_log.portrait_id = gm.constants.sPortrait
	
	ssr_set_monster_log_boss(monster_log, false)

    return monster_log
end

-- ELITES
function ssr_create_elite(identifier)
	-- check if monster_log already exists
	local elite = Elite.find(identifier)
    if elite then return elite end

    -- create monster_log
    elite = Elite.wrap(gm.elite_type_create("ssr", identifier))

    return elite
end
-- END OF TEMPORARY RETURNS API UNFINISHED THINGS --

-- play animation and then fade it out object
local SSREfFadeout = Object.new("SSREfFadeout")

Callback.add(SSREfFadeout.on_create, function(self)
	self.fadeout_rate = 0.2
end)

Callback.add(SSREfFadeout.on_step, function(self)
	if self.image_index + self.image_speed >= gm.sprite_get_number(self.sprite_index) then
		self.image_speed = 0
	end
	
	if self.image_speed == 0 then
		self.image_alpha = self.image_alpha - self.fadeout_rate
		if self.image_alpha <= 0 then
			self:destroy()
		end
	end
end)

function ssr_create_fadeout(x, y, xscale, sprite, animation_speed, rate)
	local fadeout = Object.find("SSREfFadeout"):create(x, y)
	fadeout.image_xscale = xscale
	fadeout.sprite_index = sprite
	fadeout.image_speed = animation_speed
	fadeout.fadeout_rate = rate
end

-- math.approach from rorml
function ssr_approach(current, target, change)
	if current < target then 
		return math.min(target, current + change)
	elseif current > target then
		return math.max(target, current - change)
	end
end