-- starstorm returns
-- ssr team
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto(true)

PATH = _ENV["!plugins_mod_folder_path"]
NAMESPACE = "ssr"

local init = function()
	local folders = {
		"Misc", -- contains utility functions, so load first
		"Actors",
		"Gameplay",
		"Survivors",
		"Items",
	}
	for _, folder in ipairs(folders) do
		local names = path.get_files(path.combine(PATH, folder))
		for _, name in ipairs(names) do
			if string.sub(name, -4, -1) == ".lua" then
				require(name)
			end
		end
	end

	HOTLOADING = true
end
Initialize(init)

if HOTLOADING then
	init()
end
