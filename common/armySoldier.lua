ArmySoldier = Class.class(Ped, function(self, type, model, weapon)
	Ped.init(self, type, model, weapon)
end)

function ArmySoldier:unpack(value)
	Ped.unpack(self, value)
end