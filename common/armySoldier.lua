ArmySoldier = Class.class(Ped, function(self, type, model, weapon, spawnx, spawny, spawnz)
	Ped.init(self, type, model, weapon, spawnx, spawny, spawnz)
	
end)

function ArmySoldier:unpack(value)
	Ped.unpack(self, value)
end

function ArmySoldier:pack()
	return Ped.pack(self)
end

function ArmySoldier:genEntity()
	return Ped.genEntity(self)
end