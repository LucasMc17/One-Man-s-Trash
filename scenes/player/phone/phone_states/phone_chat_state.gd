class_name PhoneChatState extends PhoneUIState

func enter(previous_state : PhoneUIState, ext := {}):
	super(previous_state, ext)
	if ext.has("message_list"):
		SCREEN.activate(ext.message_list)