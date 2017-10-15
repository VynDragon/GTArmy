Notifications = {}

function Notifications.notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	return DrawNotification(false, false)
end