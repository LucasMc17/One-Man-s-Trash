class_name PlayerSitState extends PlayerMovementState

# GLOBALS
@export var SEAT : Chair

var SIT_POSITION : Vector3
var GET_OFF_POSITION : Vector3
var _CAPTURED := false
var _EXITING := false

func enter(previous_state, ext):
	super(previous_state, ext)
	PLAYER.hint = 'Press [SPACE] to stand up'
	if ext.has('seat'):
		print(ext.seat)
		SEAT = ext.seat
	SIT_POSITION = SEAT.SIT_MARKER.global_position
	if ext.has('get_off_position'):
		GET_OFF_POSITION = ext.get_off_position
	else:
		GET_OFF_POSITION = SEAT.GET_OFF_MARKER.global_position

func update(delta):
	if !_CAPTURED:
		PLAYER.position = lerp(PLAYER.position, SIT_POSITION, 0.08)
		if PLAYER.position.distance_to(SIT_POSITION) < 0.01:
			_CAPTURED = true
	elif _EXITING:
		PLAYER.position = lerp(PLAYER.position, GET_OFF_POSITION, 0.08)
		if PLAYER.position.distance_to(GET_OFF_POSITION) < 0.01:
			transition("Freemove")
	else:
		super(delta)

func movement_input(event):
	super(event)
	if event.is_action_pressed("space"):
		_EXITING = true

func exit():
	PLAYER.hint = ''
	_CAPTURED = false
	_EXITING = false