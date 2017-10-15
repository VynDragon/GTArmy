-- This event gets called when the resource is starting
AddEventHandler('onResourceStart', function(resource)
	print("Grand Theft Army starting...")
end)

RegisterServerEvent("GTArmy/SpawnTestPed")
RegisterServerEvent("GTArmy/showentitytable")
RegisterServerEvent("GTArmy/networkEntities/got")
RegisterServerEvent("GTArmy/dumpplayers")
RegisterServerEvent("GTArmy/actualizeplayer")

MAH_SOURCE_DEBUG = nil

AddEventHandler('GTArmy/SpawnTestPed', function()
	print('triggered SpawnTestPed')
	local x, y, z = Tracking.getPlayerPosition(source)
	local identifier = Player.getIdentifier(source)
	local player = playerManager:get(identifier)
	local soldier = ArmySoldier("Army", "S_M_Y_MARINE_01", "WEAPON_ASSAULTRIFLE", x, y, z)
	player.group:add(soldier)
	NetworkEntities.add(NetworkEntityServer("ArmySoldier", soldier:pack()))
	TriggerClientEvent('GTArmy/networkEntities/check', source, NetworkEntities.getIdandHash())
	--TriggerClientEvent("GTArmy/syncing/Ped/create", source, 29, 1702441027, x, y, z, 0);
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
	MAH_SOURCE_DEBUG = source 
	TriggerEvent('playerConnecting', nil, nil, nil)
end)
