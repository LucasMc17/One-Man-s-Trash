class_name PlayerState extends State

# EXPORTS
@export var PLAYER : Player
@export_group("Movement Settings")
@export var SPEED : float = 5.0
@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.4

func compare_events(input_event : InputEvent, expected : InputEventKey):
	if input_event is not InputEventKey:
		return false
	return input_event.keycode == expected.keycode and input_event.pressed == expected.pressed

func enter(_previous_state : State, _ext : Dictionary):
	if Global.Debug.PLAYER_STATUS:
		Global.Debug.PLAYER_STATUS.state = name
