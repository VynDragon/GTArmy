RegisterServerEvent("GTArmy/networkEntities/requestIdandHash")
RegisterServerEvent("GTArmy/networkEntities/requestId")
RegisterServerEvent("GTArmy/networkEntities/updateNetworkId")
RegisterServerEvent("GTArmy/networkEntities/reportLostControl")
RegisterServerEvent("GTArmy/networkEntities/reportHasControl")

--[[[AddEventHandler('GTArmy/networkEntities/create', function(netId, basename, basedata)
	NetworkEntities.add(netId, NetworkEntity(basename, basedata))
	TriggerClientEvent('GTArmy/networkEntities/create', -1, netId, basename, basedata)
end)

AddEventHandler('GTArmy/networkEntities/remove', function(netId)
	NetworkEntities.remove(netId)
	TriggerClientEvent('GTArmy/networkEntities/remove', -1, netId)
end)]]--

AddEventHandler('GTArmy/networkEntities/requestIdandHash', function()
	TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
end)

AddEventHandler('GTArmy/networkEntities/requestId', function(globalNetworkId)
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	if thatone == nil then
		TriggerClientEvent('GTArmy/networkEntities/receiveId', source, false)
	else
		--while thatone.waitingForCreation do
		--	Wait(10)
		--end
		TriggerClientEvent('GTArmy/networkEntities/receiveId', source, true, globalNetworkId, thatone.basename, json.encode(thatone.basedata), thatone.networkId)
	end
end)

AddEventHandler('GTArmy/networkEntities/updateNetworkId', function(globalNetworkId, networkId)
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	if thatone == nil then
		TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
	elseif thatone.waitingForCreation then
		thatone.networkId = networkId
		thatone.owner = source
		thatone.waitingForCreation = false
		--TriggerClientEvent('GTArmy/networkEntities/receiveId', source, true, globalNetworkId, thatone.basename, json.encode(thatone.basedata), thatone.networkId)
	end
end)

--[[AddEventHandler('GTArmy/networkEntities/reportInvalidEntity', function(globalNetworkId)
	print('client reported entity ' .. globalNetworkId .. ' is invalid')
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	thatone.invalidreports = thatone.invalidreports + 1
	if thatone == nil then
		TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
	elseif thatone.invalidreports > 3 then
		thatone.invalidreports = 0
		thatone.networkId = nil
		thatone.waitingForCreation = true
		TriggerClientEvent('GTArmy/networkEntities/receiveId', source, true, globalNetworkId, thatone.basename, json.encode(thatone.basedata), thatone.networkId)
	end
end)]]--

AddEventHandler('GTArmy/networkEntities/reportLostControl', function(globalNetworkId)
	print('client ' .. source .. ' reported entity ' .. globalNetworkId .. ' out of control')
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	if thatone == nil then
		TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
		return 
	end
	thatone.owner = nil
	TriggerClientEvent('GTArmy/networkEntities/reportAsOwner', -1, globalNetworkId)
end)

AddEventHandler('GTArmy/networkEntities/reportHasControl', function(globalNetworkId)
	print('client ' .. source .. ' reported is in control of entity ' .. globalNetworkId)
	local thatone = NetworkedEntitiesTable[globalNetworkId]
	if thatone ~= nil then
		thatone.owner = source
	end
end)

AddEventHandler('playerDropped', function()
	for k, v in pairs(NetworkedEntitiesTable) do
		if v.owner == source then
			NetworkedEntitiesTable[k].owner = nil
			TriggerClientEvent('GTArmy/networkEntities/reportAsOwner', -1, k)
		end
	end
end)


Citizen.CreateThread(function()
	local waitingForCreation = {}
	while true do
		local docheck = true
		for k, v in pairs(NetworkedEntitiesTable) do
			if v.waitingForCreation then 
				docheck = false
				if waitingForCreation[k] == nil then
					waitingForCreation[k] = 0
				end
				waitingForCreation[k] = waitingForCreation[k] + 1
				if waitingForCreation[k] > 2 then
					NetworkedEntitiesTable[k] = nil
				end
			elseif v.owner == nil then
				NetworkedEntitiesTable[k] = nil
			end
		end
		if docheck then
			waitingForCreation = {}
			TriggerClientEvent('GTArmy/networkEntities/check', -1, NetworkEntities.getIdandHash())
		end
		Wait(5000)
	end
end)