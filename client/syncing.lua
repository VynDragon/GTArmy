RegisterNetEvent("GTArmy/syncing/Ped/create")
RegisterNetEvent("GTArmy/syncing/Ped/setWeapon")
RegisterNetEvent("GTArmy/syncing/Ped/delete")

AddEventHandler('GTArmy/syncing/Ped/create', function(type, hash, x, y, z, h)
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(0)
	end
	local ped = CreatePed(type, hash, x, y, z, h, true, false)
	SetModelAsNoLongerNeeded(hash)
	SetEntityAsMissionEntity(ped, true, true)
	local netId = NetworkGetNetworkIdFromEntity(ped)
	SetNetworkIdExistsOnAllMachines(netId, true)
	NetworkEntities.add(netId, ped)
	TriggerServerEvent('GTArmy/networkEntities/create', netId)
end)

AddEventHandler('GTArmy/syncing/Ped/setWeapon', function(netId, weapon)
	
end)

