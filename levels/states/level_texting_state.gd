class_name LevelTextingState extends LevelState

## The contact whom the player must have a text conversation with to end this state.
@export var _contact : TextContact
## The new exchange the player will have during this level state.
@export var _new_exchange : MessageList
## The state to transition to after the text conversation ends.
@export var _next_state : LevelState
## The extension to pass to the next state.
@export var _next_state_extention := {}

func enter(previous_state, ext):
	super(previous_state, ext)
	Events.text_received.emit(_contact, _new_exchange)
	Events.texting_ended.connect(_on_texting_ended)


func exit():
	Events.texting_ended.disconnect(_on_texting_ended)


## Event Listener for global signal.
func _on_texting_ended(contact : TextContact):
	if contact == _contact:
		transition(_next_state.name, _next_state_extention)
