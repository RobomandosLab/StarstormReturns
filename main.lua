-- starstorm returns
-- ssr team
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto(true)

PATH = _ENV["!plugins_mod_folder_path"]
NAMESPACE = "ssr"

-- requires all files in the given directory, in arbitrary order.
local function require_all_in_directory(directory)
	-- NOTE: this includes filepaths within subdirectories of the above folders
	local filepaths = path.get_files(path.combine(PATH, directory))
	for _, filepath in ipairs(filepaths) do
		-- filter for files with the .lua extension, incase there's non-lua files
		if string.sub(filepath, -4, -1) == ".lua" then
			require(filepath)
		end
	end
end

-- requires files in the given directory, specified by a table of strings.
local function require_ordered_in_directory(directory, ordering)
	for _, entry in ipairs(ordering) do
		local filepath = path.combine(PATH, directory, entry)
		require(filepath)
	end
end

local init = function()
	require_all_in_directory("Misc") -- contains utility libraries and the like, so load first
	require_all_in_directory("Actors")
	require_all_in_directory("Elites")
	require_ordered_in_directory("Gameplay", {
		"typhoon", -- Typhoon has to be loaded first, because the ethereal difficulties depend on it
		"ethereals",
		"teleporterLocking",
	})
	require_ordered_in_directory("Survivors", {
		"executioner",
		"mule",
		"knight",
		"chirr",
		"technician",
		"nemesisCommando",
		"nemesisMercenary",
	})
	require_all_in_directory("Items")
	require_all_in_directory("Equipments")
	require_all_in_directory("Artifacts")

	require("stageLoader") --temporary

	-- once we have loaded everything, enable hot/live reloading.
	-- this variable may be used by content code to make sure it behaves correctly when hotloading
	HOTLOADING = true
end
Initialize(init)

if HOTLOADING then
	init()
end
