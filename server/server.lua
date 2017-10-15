-- This event gets called when the resource is starting
AddEventHandler('onResourceStart', function(resource)
	print("Grand Theft Army starting...")
end)

RegisterServerEvent("GTArmy/SpawnTestPed")
RegisterServerEvent("GTArmy/showentitytable")
RegisterServerEvent("GTArmy/networkEntities/got")
RegisterServerEvent("GTArmy/dumpplayers")
RegisterServerEvent("GTArmy/actualizeplayer")

AddEventHandler('GTArmy/SpawnTestPed', function()
	print('triggered SpawnTestPed')
	local x, y, z = Tracking.getPlayerPosition(source)
	print ('position' .. x .. ' ' .. y .. ' ' .. z)
	local identifier = Player.getIdentifier(source)
	local player = playerManager:get(identifier)
	player.group:add(ArmySoldier("Army", "S_M_Y_MARINE_01", nil))
	TriggerClientEvent("GTArmy/syncing/Ped/create", source, 29, 1702441027, x, y, z, 0);
end)

AddEventHandler('GTArmy/showentitytable', function()
	print('Entity table:' .. NetworkEntities.toString())
	TriggerClientEvent("GTArmy/networkEntities/get", source)
	soo = AddEventHandler('GTArmy/networkEntities/got', function(other)
		print('Entity table diff:' .. NetworkEntities.diffId(other))
		Wait(500)
		RemoveEventHandler(soo)
	end)
end)

AddEventHandler('GTArmy/dumpplayers', function()
	print(playerManager:serialize())
end)

AddEventHandler('GTArmy/actualizeplayer', function()
	print(playerManager:serialize())
end)
