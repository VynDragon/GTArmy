RegisterNetEvent("GTArmy/networkEntities/create")
RegisterNetEvent("GTArmy/networkEntities/remove")
RegisterNetEvent("GTArmy/networkEntities/get")


AddEventHandler('GTArmy/networkEntities/create', function(netId)
	NetworkEntities.add(netId, 0)
end)

AddEventHandler('GTArmy/networkEntities/remove', function(netId)
	NetworkEntities.remove(netId, 0)
end)

AddEventHandler('GTArmy/networkEntities/get', function()
	TriggerServerEvent('GTArmy/networkEntities/got', NetworkEntities.get())
end)