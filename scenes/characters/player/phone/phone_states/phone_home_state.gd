class_name PhoneHomeState
extends PhoneUIState
## The UI state for the phone home screen

## Remove a notification from a specific icon. This is located here so that it can be called when clicking a list chat in the chats screen.
func remove_notification(icon_name : String):
	if _screen.icons.has(icon_name):
		_screen.icons[icon_name].has_notification = false