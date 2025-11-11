-- starstorm returns
-- ssr team
mods["ReturnsAPI-ReturnsAPI"].auto{mp = true, namespace = "ssr"}

--- GLOBALS (Should be in ALL-CAPS for constants, Uppercase Initial for variables)
PATH = _ENV["!plugins_mod_folder_path"]
-- mod options stuff

Options = ModOptions.new("ssr")
-- Settings with defaults
-- (useful for setting the default settings when the toml file hasn't been generated
-- or config options are missing due to a new update adding more)

Settings = {
	title_replacement = true,
}

SettingsFile = TOML.new()

local init = function()
	--- Initialize settings here before requiring anything, useful if some options require a restart to apply.
	if SettingsFile:read() == nil then
		SettingsFile:write(Settings)
	else
		Settings = SettingsFile:read()
	end

	local folders = {
		"Misc", -- contains utility functions that other code depends on, so load first
		"Language",
		"Actors",
		"Elites",
		"Gameplay",
		"Survivors",
		"Items",
		"Equipments",
		--"Artifacts",
		"Stages"
	}

	Stage.remove_all_rooms() -- reload stages

	for _, folder in ipairs(folders) do
		-- NOTE: this includes filepaths within subdirectories of the above folders
		local filepaths = path.get_files(path.combine(PATH, folder))
		for _, filepath in ipairs(filepaths) do
			-- filter for files with the .lua extension, incase there's non-lua files
			if string.sub(filepath, -4, -1) == ".lua" then
				require(filepath)
			end
		end
	end

	-- once we have loaded everything, enable hot/live reloading.
	-- this variable may be used by content code to make sure it behaves correctly when hotloading
	HOTLOADING = true
end

Initialize.add(init)

if HOTLOADING then
	init()
end
