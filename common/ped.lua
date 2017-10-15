Ped = Class.class(function(self, type, model, weapon)
	self.type = type
	self.model = model
	self.weapon = weapon
	if weapon == nil then
		self.weapon = "WEAPON_UNARMED"
	end
end)

function Ped:unpack(value)
	self.type = value['type']
	self.model = value['model']
	self.weapon = value['weapon']
end