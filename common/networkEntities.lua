NetworkEntities = {}

NetworkEntity = Class.class(function(self, basename, basedata, networkId, localEntity)
	self.basename = basename
	self.basedata = basedata
	self.networkId = networkId
	self.entity = localEntity
	self.waitingForCreation = true
end)

function NetworkEntity:reconstructBase()
	local that = _G[self.basename]()
	that:unpack(self.basedata)
	return that
end

function NetworkEntity:resolveLocalEntity()
	self.localEntity = NetworkGetEntityFromNetworkId(self.networkId)
end

NetworkedEntitiesTable = {}

local NetworkedEntitiesTableCounter = 1


function NetworkEntities.add(nentity)
	while NetworkedEntitiesTable[NetworkedEntitiesTableCounter] ~= nil do
		NetworkedEntitiesTableCounter = NetworkedEntitiesTableCounter + 1
		if NetworkedEntitiesTableCounter > 1000000 then
			NetworkedEntitiesTableCounter = 1
		end
	end
	NetworkedEntitiesTable[NetworkedEntitiesTableCounter] = nentity
	return 0
end

function NetworkEntities.remove(globalNetworkId)
	if NetworkedEntitiesTable[globalNetworkId] ~= nil then
		NetworkedEntitiesTable[globalNetworkId] = nil
		return 0
	end
	return 1
end

--[[function NetworkEntities.diffId(other)
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
end]]--

function NetworkEntities.get()
	return NetworkedEntitiesTable
end

local function orderedUnpack2Text(data)
	text = ''
	if type(data) == 'table' then
		a = {}
		for n in pairs(data) do table.insert(a, n) end
		table.sort(a)
		for i,n in ipairs(a) do text = text .. n .. orderedUnpack2Text(data[n]) end
	else
		return tostring(data)
	end
	return text
end

function NetworkEntities.getIdandHash()
	local buff = {}
	for k,v in pairs(NetworkedEntitiesTable) do
		local vnetworkId = v.networkId
		if vnetworkId == nil then
			vnetworkId = ''
		end
		buff[k] = Checksum.fletcher32(v.basename .. orderedUnpack2Text(v.basedata) .. vnetworkId)
	end
	return buff
end

function NetworkEntities.toString()
	return json.encode(NetworkedEntitiesTable)
end