ArmySoldier = Class.class(Ped, function(self, type, model, weapon)
	Ped.init(self, type, model, weapon)
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