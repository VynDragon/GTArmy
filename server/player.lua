Player = Class.class(function(self, playerId)
	self.identifier = Identifier.getIdentifierLocal(playerId)
	self.inventory = Inventory()
	self.group = ArmyGroup()
	self.team = 0
	self.isNew = true
end)

function Player:serialize()
	value = json.encode(self)
	return value
end


function Player:unserialize(data)
	value = json.decode(data)
	self.isNew = false
	self.identifier = value['identifier']
	self.team = value['team']
	self.inventory:unpack(value['inventory'])
	self.group:unpack(value['group'])
	return data
end

function Player.getIdentifier(playerId)
	return Identifier.getIdentifierLocal(playerId)
end


