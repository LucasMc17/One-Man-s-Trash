class_name PhoneChatsState
extends PhoneUIState
## The UI state for the Chats Screen of the phone.

func enter(_previous_state, _ext):
	super(_previous_state, _ext)
	_screen.refresh_list_chats()
