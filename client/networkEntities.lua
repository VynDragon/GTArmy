RegisterNetEvent("GTArmy/networkEntities/receiveId")
RegisterNetEvent("GTArmy/networkEntities/check")


--[[AddEventHandler('GTArmy/networkEntities/create', function(netId, basename, basedata)
	NetworkEntities.add(netId, NetworkEntity(basename, basedata))
	Wait(1000)
	NetworkedEntitiesTable[netId]:resolveLocalEntity(netId)
end)

AddEventHandler('GTArmy/networkEntities/remove', function(netId)
	NetworkEntities.remove(netId)
end)

AddEventHandler('GTArmy/networkEntities/get', function()
	TriggerServerEvent('GTArmy/networkEntities/got', NetworkEntities.get())
end)]]--

local function resolveSupplementaryId(key)
	Citizen.Trace("Error : supplementary local networked entity with ID " .. key)
end

local function createEntity(globalNetworkId, networkEntity)
	Citizen.Trace("Creating entity " .. globalNetworkId)
	local klass = networkEntity:reconstructBase()
	return klass:genEntity()
end

AddEventHandler('GTArmy/networkEntities/check', function(idandHash)
	local ourtable = NetworkEntities.getIdandHash()
	for k, v in pairs(idandHash) do
		local ours = ourtable[k]
		if ours~= v then
			Citizen.Trace("Error : Difference between entities for " .. k .. " local hash is " .. tostring(ours) .. " distant hash is " .. v)
			TriggerServerEvent('GTArmy/networkEntities/requestId', k)
		end
		ourtable[k] = nil
	end
	for k,v in pairs(ourtable) do 
		resolveSupplementaryId(k)
	end
end)

AddEventHandler('GTArmy/networkEntities/receiveId', function(exist, globalNetworkId, basename, basedata, networkId)
	if not exist then
		resolveSupplementaryId(k)
		return
	end
	local decodedData = json.decode(basedata)
	local entity = NetworkEntity(basename, decodedData, networkId, nil)
	if networkId == nil then
		entity.entity = createEntity(globalNetworkId, entity)
		entity.networkId = NetworkGetNetworkIdFromEntity(entity.entity)
	end
	NetworkedEntitiesTable[globalNetworkId] = entity
	TriggerServerEvent('GTArmy/networkEntities/updateNetworkId', globalNetworkId, entity.networkId)
end)