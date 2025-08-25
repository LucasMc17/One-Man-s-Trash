class_name PhoneState extends PlayerState

var prev_state : PlayerState
var keep_momentum := false

func _ready():
	_phone_enabled = true
	_mouse_enabled = true

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	if previous_state._movement_enabled:
		keep_momentum = true
	prev_state = previous_state
	PLAYER.PHONE.activate()
	PLAYER.kill_camera_momentum()

func exit():
	PLAYER.PHONE.deactivate()
	Global.PLAYER_PHONE.CURRENT_STATE.transition('HomeState')
	keep_momentum = false
	prev_state = null

func update(_delta):
	if keep_momentum:
		PLAYER.handle_idle_momentum(DECELERATION)

func input(event):
	if event.is_action_pressed("phone"):
		if prev_state:
			transition(prev_state.name)
		else:
			transition('FreeMoveState')
