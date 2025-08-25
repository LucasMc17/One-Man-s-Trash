class_name SittingState extends PlayerState

# GLOBALS
@export var SEAT : Chair

var sit_position : Vector3
var get_off_position : Vector3
var _captured := false
var _exiting := false

# func _ready():
# 	_phone_enabled = true
# 	_camera_enabled = true
# 	_gravity_enabled = false
# 	_interact_enabled = true

func enter(previous_state : State, ext : Dictionary):
	super(previous_state, ext)
	PLAYER.hint = 'Press [SPACE] to stand up'
	if ext.has('seat'):
		print(ext.seat)
		SEAT = ext.seat
	sit_position = SEAT.global_position + SEAT.sit_position
	if ext.has('get_off_position'):
		get_off_position = ext.get_off_position
	else:
		get_off_position = SEAT.GET_OFF_MARKER.global_position

func update(delta):
	if !_captured:
		PLAYER.position = lerp(PLAYER.position, sit_position, 0.08)
		if PLAYER.position.distance_to(sit_position) < 0.01:
			_captured = true
	elif _exiting:
		PLAYER.position = lerp(PLAYER.position, get_off_position, 0.08)
		if PLAYER.position.distance_to(get_off_position) < 0.01:
			transition("FreeMoveState")
	else:
		super(delta)

func input(event):
	super(event)
	if event.is_action_pressed("space"):
		_exiting = true

func exit():
	PLAYER.hint = ''
	_captured = false
	_exiting = false
