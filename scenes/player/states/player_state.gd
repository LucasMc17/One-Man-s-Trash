class_name PlayerState extends State

# EXPORTS
@export var PLAYER : Player
@export_group("Movement Settings")
@export var SPEED : float = 5.0
@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.4

# STATE ALLOWANCES
var _phone_enabled := false
var _camera_enabled := false
var _movement_enabled := false
var _interact_enabled := false
var _gravity_enabled := true
var _mouse_enabled := false

func compare_events(input_event : InputEvent, expected : InputEventKey):
	if input_event is not InputEventKey:
		return false
	return input_event.keycode == expected.keycode and input_event.pressed == expected.pressed

func input(event : InputEvent):
	if name != 'PhoneState' and _phone_enabled and event.is_action_pressed("phone"):
		transition("PhoneState")
	if _interact_enabled and PLAYER.looking_at and compare_events(event, PLAYER.looking_at.interact_button):
		PLAYER.looking_at.interact(PLAYER)

func update(delta):
	if _camera_enabled:
		PLAYER.update_camera(delta)
	if _interact_enabled:
		PLAYER.update_interactor(delta)
	if _gravity_enabled:
		PLAYER.update_gravity(delta)
	if _movement_enabled:
		PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)

func enter(_previous_state : State, _ext : Dictionary):
	if Global.Debug.PLAYER_STATUS:
		Global.Debug.PLAYER_STATUS.state = name
	if _mouse_enabled:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if !_interact_enabled:
		PLAYER.INTERACT_LABEL.text = ''
