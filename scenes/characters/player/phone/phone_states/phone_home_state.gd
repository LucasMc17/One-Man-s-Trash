class_name PhoneHomeState extends PhoneUIState

func remove_notification(icon_name : String):
	if SCREEN.ICONS.has(icon_name):
		SCREEN.ICONS[icon_name].NOTIFICATION = false