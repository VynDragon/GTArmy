RegisterServerEvent("GTArmy/armygroupmanager/buy")
RegisterServerEvent("GTArmy/armygroupmanager/sell")


AddEventHandler('GTArmy/reporting/Position', function(x, y, z)
	playerPositions[source] = {x, y, z}
end)