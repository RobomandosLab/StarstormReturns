-- starstorm returns
-- ssr team
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

PATH = _ENV["!plugins_mod_folder_path"].."\\"
NAMESPACE = "ssr"

Initialize(function()
	gm.sprite_replace(gm.constants.sTitle, path.combine(PATH, "Sprites/Menu/title.png"), 1, false, false, 692/2, 163/2)

	local folders = {
		--"Survivors",
		"Items",
	}
	for _, folder in ipairs(folders) do
		local names = path.get_files(PATH..folder)
		for _, name in ipairs(names) do require(name) end
	end
end)
