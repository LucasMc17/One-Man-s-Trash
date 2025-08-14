class_name PhoneChatState extends PhoneUIState

func enter(previous_state : PhoneUIState, ext := {}):
	super(previous_state, ext)
	if ext.has("contact"):
		SCREEN.activate(ext.contact)