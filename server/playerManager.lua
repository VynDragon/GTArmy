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

function PlayerManager:serialize(identifier)
	value = json.encode(self)
	return value
end

playerManager = PlayerManager()

AddEventHandler('playerConnecting', function(playerName, setKickReason , deferrals, offset_source)
	source_real = source
	if source_real == nil or source_real == '' then
		source_real = MAH_SOURCE_DEBUG
	end
	local player = Player(source_real)
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