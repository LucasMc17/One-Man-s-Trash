class_name FreeMoveState extends PlayerState

func _ready():
	_phone_enabled = true
	_camera_enabled = true
	_movement_enabled = true
	_interact_enabled = true

func enter(previous_state : State, ext : Dictionary):
	super(previous_state, ext)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func exit():
	PLAYER.looking_at = null
