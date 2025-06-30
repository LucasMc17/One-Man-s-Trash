class_name PhoneState extends PlayerState

func enter(previous_state):
	PLAYER.PHONE.activate()

func exit():
	PLAYER.PHONE.deactivate()

func input(event):
	if event.is_action_pressed("phone"):
		transition.emit("FreeMoveState")
