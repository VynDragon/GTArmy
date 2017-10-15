AddEventHandler('playerConnecting', function(playerName, setKickReason , deferrals)
	Wait(500)
	TriggerEvent("GTArmy/Player/getprop", Identifier.getIdentifierLocal(source), "isNew")
end)

AddEventHandler('playerDropped', function(playerName, setKickReason , deferrals)

end)


AddEventHandler("GTArmy/Player/returnprop", function(who, what, value)
	if what == 'isNew' then
		if value then
			TriggerEvent("GTArmy/Player/Inventory/add", Values.MONEY_NAME, Values.START_MONEY_AMOUNT )
		end
	end
end)


AddEventHandler('onMapStart', function(resourceName, metadata)
	
end)