-- starstorm returns
-- ssr team
log.info("Loading ".._ENV["!guid"]..".")
survivor_setup = require("./survivor_setup")
mods.on_all_mods_loaded(function() for _, m in pairs(mods) do if type(m) == "table" and m.RoRR_Modding_Toolkit then Actor = m.Actor Alarm = m.Alarm Buff = m.Buff Callback = m.Callback Class = m.Class Color = m.Color Equipment = m.Equipment Helper = m.Helper Instance = m.Instance Item = m.Item Net = m.Net Object = m.Object Player = m.Player Resources = m.Resources Skill = m.Skill Survivor = m.Survivor break end end end)

PATH = _ENV["!plugins_mod_folder_path"].."\\"

function __initialize()
	gm.translate_load_file(gm.variable_global_get("_language_map"), PATH.."Languages\\english.json")
	
	local folders = {
		--"Survivors",
		"Items",
	}
    for _, folder in ipairs(folders) do
        local names = path.get_files(PATH..folder)
        for _, name in ipairs(names) do require(name) end
    end
end