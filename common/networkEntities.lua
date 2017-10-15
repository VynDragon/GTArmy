NetworkEntities = {}

NetworkEntity = Class.class(function(self, basename, basedata, localEntity)
	self.basename = basename
	self.data = basedata
	self.entity = localEntity
end)

local NetworkedEntitiesTable = {}

function NetworkEntities.add(networkId, entity)
	if NetworkedEntitiesTable[networkId] == nil then
		NetworkedEntitiesTable[networkId] = entity
		return 0
	end
	return 1
end

function NetworkEntities.remove(networkId)
	if not NetworkedEntitiesTable[networkId] == nil then
		NetworkedEntitiesTable[networkId] = nil
		return 0
	end
	return 1
end

function NetworkEntities.diffId(other)
	for key, value in pairs(NetworkedEntitiesTable) do
		if other[key] == nil then
			return 1
		end
	end
	return 0
end

function NetworkEntities.checkId()
	for key, value in pairs(NetworkedEntitiesTable) do
		if not NetworkDoesNetworkIdExist(key) then
			return 1
		end
	end
	return 0
end

function NetworkEntities.get()
	return NetworkedEntitiesTable
end

function NetworkEntities.toString()
	local buff = ""
	for key, value in pairs(NetworkedEntitiesTable) do
		buff = buff .. key .. '=' .. value .. ','
	end
	return buff
end