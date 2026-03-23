class_name PlayerState extends ActorState

func compare_events(input_event : InputEvent, expected : InputEventKey):
	if input_event is not InputEventKey:
		return false
	return input_event.keycode == expected.keycode and input_event.pressed == expected.pressed

func enter(_previous_state : State, _ext : Dictionary):
	if Global.debug.player_status:
		Global.debug.player_status.update_state(name)
