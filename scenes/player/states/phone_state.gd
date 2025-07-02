class_name PhoneState extends PlayerState

@export var DECELERATION : float = 0.4

func enter(previous_state : State = null, ext := {}):
	PLAYER.PHONE.activate()
	PLAYER.kill_camera_momentum()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func exit():
	PLAYER.PHONE.deactivate()

func update(_delta):
	PLAYER.handle_idle_momentum(DECELERATION)

func input(event):
	if event.is_action_pressed("phone"):
		transition("FreeMoveState")
