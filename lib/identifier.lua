Identifier = {}

function Identifier.getIdentifierLocal(playerId)
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