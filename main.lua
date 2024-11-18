-- starstorm returns
-- ssr team
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

PATH = _ENV["!plugins_mod_folder_path"]
NAMESPACE = "ssr"

local init = function()
	gm.sprite_replace(gm.constants.sTitle, path.combine(PATH, "Sprites/Menu/title.png"), 1, false, false, 346, 82)

	local folders = {
		"Misc", -- contains utility functions, so load first
		"Actors",
		"Gameplay",
		"Survivors",
		"Items",
	}
	for _, folder in ipairs(folders) do
		local names = path.get_files(path.combine(PATH, folder))
		for _, name in ipairs(names) do require(name) end
	end

	HOTLOADING = true
end
Initialize(init)

if HOTLOADING then
	init()
end
