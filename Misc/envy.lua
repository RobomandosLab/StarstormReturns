Memento = {} -- api class

function Memento.find(identifier)
	local result = nil
	
	for _, memento in ipairs(Global.class_memento) do
		if memento.identifier then
			if identifier == memento.identifier then
				result = memento
				break
			end
		end
	end

	return result
end

function Memento.new(identifier) -- rn just using this as a reference for all the data mementos would need to have
	local size = Global.class_memento:size()

	Global.class_memento:push(Struct.new({
		identifier = identifier,
		index = size + 1,
		sprite_id = 0,
		on_acquired = Callback.new(identifier.."OnAcquired"),
		on_removed = Callback.new(identifier.."OnRemoved"),
	}))

	return Global.class_memento[size + 1]
end

-- really all of these functions probably ought to be reorganized and 
function Memento.create(index, x, y) -- this should probably be an instance method (also it should do more than just take the index)
	if not Global.class_memento[index] then return end

	local pickup = Instance.create(x, y, gm.constants.pPickup)
	pickup.sprite_index = Global.class_memento[index].sprite_id
	pickup.memento_id = index
	pickup.tier = MementoTier
end

function Memento.add(actor, index)
	if (not Net.online or Net.host) then
		actor.memento_inventory:push(index)
		Callback.wrap_type(Global.class_memento[index].on_acquired):call(actor)

		if actor.memento_slots < actor.memento_inventory:size() then
			local dropped = actor.memento_inventory:get(0)
			Memento.create(dropped, actor.x, actor.y - 20)
			Callback.wrap_type(Global.class_memento[dropped].on_removed):call(actor)
			actor.memento_inventory:delete(0)
		end
	end
end

return Memento