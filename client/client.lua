AddEventHandler('onPlayerJoining', function(playerId, name)
end)

showmarker = false

Citizen.CreateThread(function()
	while true do
		if Keys.status(288) == 2 then
			TriggerServerEvent('GTArmy/SpawnTestPed')
			Notifications.notify('sent SpawnTestPed')
		end
		if Keys.status(289) == 2 then
			TriggerServerEvent('GTArmy/showentitytable')
			Notifications.notify('sent showentitytable')
		end
		if Keys.status(166) == 2 then
			showmarker = not showmarker
			Notifications.notify('showmarker = ' .. tostring(showmarker))
		end
		if Keys.status(167) == 2 then
			local text = Input.text()
			if text ~= nil then
				Notifications.notify(text)
			else
				Notifications.notify('text is nil')
			end
		end
		if Keys.status(168) == 2 then
			TriggerServerEvent('GTArmy/dumpplayers')
			Notifications.notify('sent dumpplayers')
		end
		if Keys.status(169) == 2 then
			TriggerServerEvent('GTArmy/actualizeplayer')
			Notifications.notify('sent actualizeplayer')
		end
        Wait(10)
	end
end)

Citizen.CreateThread(function()
	while true do
		if showmarker then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId()), true))
			Graphics.DrawMarker(2, x, y, z + 1, 0, 180, 0, 0, 0.8, 0.8, 0.8, 255, 255, 255, 200, false, false, false)
			Graphics.text('showmarker : ' .. x .. ' ' .. y .. '' .. z, 0.1, 0.1, 0.2)
		end
        Wait(0)
	end
end)
 

