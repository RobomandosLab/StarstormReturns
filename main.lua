-- starstorm returns
-- ssr team
mods["ReturnsAPI-ReturnsAPI"].auto{mp = true, namespace = "ssr"}

PATH = _ENV["!plugins_mod_folder_path"]

local init = function()
	local folders = {
		"Misc", -- contains utility functions that other code depends on, so load first
		"Language",
		--"Actors",
		--"Elites",
		--"Gameplay",
		"Survivors",
		--"Items",
		--"Equipments",
		--"Artifacts"
	}

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
	--require("stageLoader")

	-- once we have loaded everything, enable hot/live reloading.
	-- this variable may be used by content code to make sure it behaves correctly when hotloading
	HOTLOADING = true
end

Initialize.add(init)

if HOTLOADING then
	init()
end
