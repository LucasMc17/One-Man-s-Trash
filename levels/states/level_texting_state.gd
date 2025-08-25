class_name LevelTextingState extends LevelState

@export var CONTACT : TextContact
@export var NEW_EXCHANGE : MessageList
@export var NEXT_STATE : LevelState

func enter(previous_state, ext):
	super(previous_state, ext)
	Events.text_received.emit(CONTACT, NEW_EXCHANGE)
	Events.texting_ended.connect(_on_texting_ended)

func exit():
	Events.texting_ended.disconnect(_on_texting_ended)

func _on_texting_ended(contact : TextContact):
	if contact == CONTACT:
		transition(NEXT_STATE.name)
