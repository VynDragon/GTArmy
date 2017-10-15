local function getIdentifierLocal(playerId)
	local identifiers = GetPlayerIdentifiers(playerId)
	local steam, license = nil, nil
	for i,identifier in pairs(identifiers) do
		if string.find(identifier, "steam:") then
			steam = string.gsub(identifier, "steam:", "")
		end
		if string.find(identifier, "license:") then
			license = string.gsub(identifier, "license:", "")
		end
	end
	if license ~= nil then
		return license
	else
		return steam
	end
	return nil
end

Player = Class.class(function(self, playerId)
	self.identifier = getIdentifierLocal(playerId)
	self.inventory = Inventory()
	self.group = ArmyGroup()
	self.team = 0
end)

function Player:serialize()
	value = json.encode(self)
	return value
end


function Player:unserialize(data)
	value = json.decode(data)
	self.identifier = value['identifier']
	self.team = value['team']
	self.inventory:unpack(value['inventory'])
	self.group:unpack(value['group'])
	return data
end

function Player.getIdentifier(playerId)
	return getIdentifierLocal(playerId)
end


