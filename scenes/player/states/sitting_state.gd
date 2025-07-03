class_name SittingState extends PlayerState

# GLOBALS
var sitting_position : Vector3
var _captured := false

func _ready():
	_phone_enabled = true
	_camera_enabled = true
	_gravity_enabled = false
	_interact_enabled = true

func enter(previous_state : State, ext : Dictionary):
	super(previous_state, ext)
	PLAYER.hint = 'Press [SPACE] to stand up'
	if ext.has('sitting_position'):
		sitting_position = ext.sitting_position

func update(delta):
	if !_captured:
		PLAYER.position = lerp(PLAYER.position, sitting_position, 0.08)
		if PLAYER.position.distance_to(sitting_position) < 0.1:
			_captured = true
	else:
		super(delta)

func input(event):
	super(event)
	if event.is_action_pressed("space"):
		transition("FreeMoveState")

func exit():
	PLAYER.hint = ''
	_captured = false