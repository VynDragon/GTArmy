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

function Ped:pack()
	buff = {}
	buff.type = self.type
	buff.model = self.model
	buff.weapon = self.weapon
	return buff
end

function Ped:genEntity()
	local hash = GetHashKey(self.model)
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(0)
	end
	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId()), true))
	local ped = CreatePed(self.type, hash, x, y, z + 3, h, true, false)
	SetModelAsNoLongerNeeded(hash)
	SetEntityAsMissionEntity(ped, true, true)
	local netId = NetworkGetNetworkIdFromEntity(ped)
	SetNetworkIdExistsOnAllMachines(netId, true)
	return ped
end