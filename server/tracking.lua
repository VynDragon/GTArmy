Tracking = {}

local playerPositions = {}

RegisterServerEvent("GTArmy/reporting/Position")

AddEventHandler('GTArmy/reporting/Position', function(x, y, z)
	playerPositions[source] = {x, y, z}
end)

function Tracking.getPlayerPosition(player)
	if playerPositions[player] == nil then
		playerPositions[player] = {0, 0, 0}
	end
	return playerPositions[player][1], playerPositions[player][2], playerPositions[player][3]
end