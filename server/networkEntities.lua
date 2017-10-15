RegisterServerEvent("GTArmy/networkEntities/create")
RegisterServerEvent("GTArmy/networkEntities/remove")

AddEventHandler('GTArmy/networkEntities/create', function(netId)
	NetworkEntities.add(netId, 0)
	TriggerClientEvent('GTArmy/networkEntities/create', -1, netId)
end)

AddEventHandler('GTArmy/networkEntities/remove', function(netId)
	NetworkEntities.remove(netId, 0)
	TriggerClientEvent('GTArmy/networkEntities/remove', -1, netId)
end)