

-- takes in an Elite type, and a boolean on whether to toggle it on or off.
function toggle_elite_type(elite, enable)
	for _, card in ipairs(Monster_Card.find_all()) do
		local elite_list = List.wrap(card.elite_list)

		if enable then
			if not elite_list:contains(elite) then
				elite_list:add(elite)
				print("added elite "..elite.identifier.." for card "..card.identifier)
			end
		else
			local _index = elite_list:find(elite)
			if _index then
				elite_list:delete(_index)
				print("removed elite "..elite.identifier.." for card "..card.identifier)
			end
		end
	end
end