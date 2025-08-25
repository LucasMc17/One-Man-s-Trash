class_name PhoneChatsState extends PhoneUIState

func enter(_previous_state, _ext):
	super(_previous_state, _ext)
	SCREEN.refresh_list_chats()
