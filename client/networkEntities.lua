RegisterNetEvent("GTArmy/networkEntities/receiveId")
RegisterNetEvent("GTArmy/networkEntities/check")
RegisterNetEvent("GTArmy/networkEntities/reportAsOwner")

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
	local ident = NetworkedEntitiesTable[key]
	local ent = NetToEnt(ident.networkId)
	if NetworkHasControlOfEntity(ent) then
		DeleteEntity(ent)
	end
	NetworkedEntitiesTable[k] = nil
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

AddEventHandler('GTArmy/networkEntities/receiveId', function(exist, globalNetworkId, basename, basedata, networkId, owner)
	if not exist then
		resolveSupplementaryId(k)
		return
	end
	local decodedData = json.decode(basedata)
	local entity = NetworkEntity(basename, decodedData, networkId)
	entity.owner = owner
	if networkId == nil then
		local entent = createEntity(globalNetworkId, entity)
		entity.networkId = NetworkGetNetworkIdFromEntity(entent)
		entity.owner = GetPlayerServerId(PlayerId())
		TriggerServerEvent('GTArmy/networkEntities/updateNetworkId', globalNetworkId, entity.networkId)
	end
	NetworkedEntitiesTable[globalNetworkId] = entity
end)

AddEventHandler('GTArmy/networkEntities/reportAsOwner', function(globalNetworkId)
	local ours = NetworkEntities[globalNetworkId]
	if ours ~= nil then
		local ent = NetToEnt(ours.networkId)
		if NetworkHasControlOfEntity(ent) then
			TriggerServerEvent('GTArmy/networkEntities/reportHasControl', globalNetworkId)
		end
	end
end)

local function checkNetworkIds()
	for k,v in pairs(NetworkedEntitiesTable) do
		if v.networkId ~= nil then
			if v.owner == GetPlayerServerId(PlayerId()) then
				local ent = NetToEnt(v.networkId)
				Citizen.Trace('entity for ' .. tostring(v.networkId) .. ' is ' .. tostring(ent))
				if not NetworkHasControlOfEntity(ent) or ent == nil or ent == 0 then
					TriggerServerEvent('GTArmy/networkEntities/reportLostControl', k)
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		checkNetworkIds()
		Wait(50)
	end
end)