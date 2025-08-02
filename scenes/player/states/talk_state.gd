class_name TalkState extends PlayerState

var prev_state : PlayerState
var keep_momentum := false

func _ready():
	_mouse_enabled = true

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	if previous_state._movement_enabled:
		keep_momentum = true
	prev_state = previous_state
	PLAYER.kill_camera_momentum()

func exit():
	keep_momentum = false
	prev_state = null

func update(_delta):
	if keep_momentum:
		PLAYER.handle_idle_momentum(DECELERATION)