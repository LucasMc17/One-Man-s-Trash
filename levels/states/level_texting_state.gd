class_name LevelTextingState extends LevelState

@export var CONTACT : TextContact
@export var NEW_EXCHANGE : MessageList

func enter(previous_state, ext):
	super(previous_state, ext)
	Events.text_received.emit(CONTACT, NEW_EXCHANGE)