Keys = {}

local keysStatus = {}


Citizen.CreateThread(function()
	while true do
		for key, value in pairs(keysStatus) do
			if IsControlPressed(0, key) then
				keysStatus[key] = 1
			elseif IsControlJustReleased(0, key) then
				keysStatus[key] = 2
			else
				keysStatus[key] = 0
			end
		end
        Wait(10)
	end
end)

function Keys.status(key)
	if keysStatus[key] == nil then
		keysStatus[key] = 0
	end
	return keysStatus[key]
end

