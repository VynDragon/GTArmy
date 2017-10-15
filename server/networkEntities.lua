RegisterServerEvent("GTArmy/networkEntities/requestIdandHash")
RegisterServerEvent("GTArmy/networkEntities/requestId")
RegisterServerEvent("GTArmy/networkEntities/updateNetworkId")

--[[[AddEventHandler('GTArmy/networkEntities/create', function(netId, basename, basedata)
	NetworkEntities.add(netId, NetworkEntity(basename, basedata))
	TriggerClientEvent('GTArmy/networkEntities/create', -1, netId, basename, basedata)
end)

AddEventHandler('GTArmy/networkEntities/remove', function(netId)
	NetworkEntities.remove(netId)
	TriggerClientEvent('GTArmy/networkEntities/remove', -1, netId)
end)]]--

AddEventHandler('GTArmy/networkEntities/getIdandHash', function()
	TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
end)

AddEventHandler('GTArmy/networkEntities/requestId', function(globalNetworkId)
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	if thatone == nil then
		TriggerClientEvent('GTArmy/networkEntities/receiveId', source, false)
	else
		TriggerClientEvent('GTArmy/networkEntities/receiveId', source, true, globalNetworkId, thatone.basename, json.encode(thatone.basedata), thatone.networkId)
	end
end)

AddEventHandler('GTArmy/networkEntities/updateNetworkId', function(globalNetworkId, networkId)
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	if thatone == nil then
		TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
	elseif thatone.waitingForCreation then
		thatone.networkId = networkId
		thatone.waitingForCreation = false
		TriggerClientEvent('GTArmy/networkEntities/receiveId', source, true, globalNetworkId, thatone.basename, json.encode(thatone.basedata), thatone.networkId)
	end
end)