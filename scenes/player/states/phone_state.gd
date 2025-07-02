class_name PhoneState extends PlayerState

func enter(previous_state : State = null, ext := {}):
	PLAYER.PHONE.activate()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func exit():
	PLAYER.PHONE.deactivate()

func input(event):
	if event.is_action_pressed("phone"):
		transition.emit("FreeMoveState")
