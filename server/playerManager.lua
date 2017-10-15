PlayerResourceName = 'GTArmy'
PlayerDataPath = 'player_data'

PlayerManager = Class.class(function(self)
	self.players = {}
end)

function PlayerManager:add(player)
	self.players[player.identifier] = player
end

function PlayerManager:remove(identifier)
	self.players[identifier] = nil
end


function PlayerManager:get(identifier)
	return self.players[identifier]
end

playerManager = PlayerManager()

AddEventHandler('playerConnecting', function(playerName, setKickReason , deferrals)
	local player = Player(source)
	print ('Player connected: ' .. player.identifier)
	local data = LoadResourceFile(PlayerResourceName, PlayerDataPath .. '/' .. player.identifier);
	if data == nil then
		print (player.identifier .. ' is a new player')
	else
		player:unserialize(data)
	end
    playerManager:add(player)
end)

AddEventHandler('playerDropped', function(playerName, setKickReason , deferrals)
	local identifier = Player.getIdentifier(source)
	local player = playerManager:get(identifier)
	local data = player:serialize()
	if string.len(data) > 7 then
		if not SaveResourceFile(PlayerResourceName, PlayerDataPath .. '/' .. identifier, data, string.len(data)) then
			print ('Failed to save data for player: ' .. player.identifier) 
		end
	else
		print ('Error in data for player: ' .. player.identifier)
	end
	playerManager:remove(identifier)
end)