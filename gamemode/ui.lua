RegisterNetEvent("GTArmy/gamemode/enableZones")
RegisterNetEvent("GTArmy/gamemode/enableBlips")


local enableZones = true
local enableBlips = false

AddEventHandler('GTArmy/gamemode/enableZones', function(yes)
	enableZones = yes
end)

AddEventHandler('GTArmy/gamemode/enableBlips', function(yes)
	enableBlips = yes
end)

local function pow(a, b)
	out = a
	for i=1,b do
		out = out * a
	end
	return out
end

local function round(a, pre)
    return math.floor(a * pow(10, pre) ) / pow(10, pre)
end

Citizen.CreateThread(function()
	while true do
		if enableZones then
			for k, v in pairs(CapturePoints) do
			Citizen.Trace(k .. v[1].. v[2].. v[3])
				Graphics.DrawMarker(1, v[1], v[2], v[3], 0, 0, 0, 0, v[4], v[5], v[6], 50, 255, 50, 15, false, false, false)
			end
			local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(PlayerId()), true))
			
			Graphics.text(': ' .. round(x,1) .. ' ' .. round(y,1) .. ' ' .. round(z,1), 0.1, 0.1, 0.2)
		end
        Wait(0)
	end
end)