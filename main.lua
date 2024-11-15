-- starstorm returns
-- ssr team
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

PATH = _ENV["!plugins_mod_folder_path"]
NAMESPACE = "ssr"

local init = function()
	gm.sprite_replace(gm.constants.sTitle, path.combine(PATH, "Sprites/Menu/title.png"), 1, false, false, 692/2, 163/2)

	local folders = {
		"Misc",
		"Actors",
		"Gameplay",
		"Survivors",
		"Items",
	}
	for _, folder in ipairs(folders) do
		local names = path.get_files(path.combine(PATH, folder))
		for _, name in ipairs(names) do require(name) end
	end
end
Initialize(init)

if HOTLOADING then
	init()
end
HOTLOADING = true
