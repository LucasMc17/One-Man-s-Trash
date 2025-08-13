class_name PhoneChatsState extends PhoneUIState

func enter(previous_state : PhoneUIState, ext := {}):
	super(previous_state, ext)
	SCREEN.refresh_all()