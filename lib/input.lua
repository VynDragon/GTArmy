Input = {}

function Input.text()
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 21)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0);
		Wait(0)
	end
	return GetOnscreenKeyboardResult()
end


