Ped = Class.class(function(self, type, model, weapon, spawnx, spawny, spawnz)
	self.type = type
	self.model = model
	self.weapon = weapon
	self.spawnx = spawnx
	self.spawny = spawny
	self.spawnz = spawnz
	if weapon == nil then
		self.weapon = "WEAPON_UNARMED"
	end
end)

function Ped:unpack(value)
	self.type = value['type']
	self.model = value['model']
	self.weapon = value['weapon']
	self.spawnx = value['spawnx']
	self.spawny = value['spawny']
	self.spawnz = value['spawnz']
end

function Ped:pack()
	buff = {}
	buff.type = self.type
	buff.model = self.model
	buff.weapon = self.weapon
	buff.spawnx = self.spawnx
	buff.spawny = self.spawny
	buff.spawnz = self.spawnz
	return buff
end

function Ped:genEntity()
	local hash = GetHashKey(self.model)
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(0)
	end
	local ped = CreatePed(self.type, hash, self.spawnx, self.spawny, self.spawnz + 0.1, 0, true, false)
	SetModelAsNoLongerNeeded(hash)
	GiveWeaponToPed(ped, GetHashKey(self.weapon), 1000, false, true)
	SetPedInfiniteAmmo(ped, true, GetHashKey(self.weapon))
	SetEntityAsMissionEntity(ped, true, true)
	local netId = NetworkGetNetworkIdFromEntity(ped)
	SetNetworkIdExistsOnAllMachines(netId, true)
	return ped
end