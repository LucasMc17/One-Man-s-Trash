class_name PhoneUIState
extends State
## UI state for use inside the phone UI.

## The UI screen this state is linked to and should instantiate.
@export var _screen : Control
## Whether or not the screen, when activated, should move up from the bottom, imitating mdoern smart phone design.
@export var _should_pop_up := false

## The previous state in use before this one, for reverting on the back button being clicked.
var previous_state : State

func enter(prev_state, _ext):
	super(prev_state, _ext)
	prev_state = previous_state
	if _should_pop_up:
		_pop_up()
	else:
		_screen.visible = true


func exit():
	_screen.visible = false


func update(_delta):
	if _should_pop_up:
		_screen.position.y = lerp(_screen.position.y, 0.0, 0.15)


## Move the screen to the bottom so that it can lerp smoothly towards the top.
func _pop_up():
	_screen.position.y = 1920
	_screen.visible = true
