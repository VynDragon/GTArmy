Citizen.CreateThread(function()
	while true do
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId()), true))
		TriggerServerEvent('GTArmy/reporting/Position', x, y, z)
		Wait(200)
	end
end)