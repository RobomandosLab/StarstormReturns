-- starstorm logo

local original_sprite = nil
local is_replaced = false

-- `true` if the logo should be replaced with Starstorm's, `false` to either keep it as is or revert it.
local function toggle_logo_replacement(enable)
	if enable == nil then
		enable = not is_replaced
	end

	if original_sprite == nil then
		original_sprite = gm.sprite_duplicate(gm.constants.sTitle)
	end

	if enable and not is_replaced then
		-- replace with Starstorm logo
		gm.sprite_replace(gm.constants.sTitle, path.combine(PATH, "Sprites/Menu/title.png"), 1, false, false, 364, 82)
		is_replaced = true
	elseif not enable and is_replaced then
		-- revert to original sprite
		gm.sprite_assign(gm.constants.sTitle, original_sprite)
		is_replaced = false
		--- It might be worth deleting the duplicated sprite if there proves to be memory leaks but there shouldn't be
		--- since it should only ever be duplicated once, hotloading might prove otherwise which could be just checked
		--- for when setting original_sprite = nil
	end
end

-- easier to do the options/config here
local title_replacement_checkbox = Options:add_checkbox("titleReplacement")

-- check Settings and return what this was set to (true/false)
title_replacement_checkbox:add_getter(function()
	--- uncomment this if we wanna check the toml file everytime we check its value if we want to have the ability for editing the toml file live
	-- Settings = SettingsFile:read()
	return Settings.title_replacement
end)

-- replace title if the checkbox is checked
title_replacement_checkbox:add_setter(function(value)
	Settings.title_replacement = value
	toggle_logo_replacement(value)
	SettingsFile:write(Settings)
end)

-- run once during initialization, Settings should have already been read by this point if the toml file exists.
if Settings.title_replacement == true then
	toggle_logo_replacement(true)
end
