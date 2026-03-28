class_name PlayerState
extends ActorState
## A state specifically for use by the player.

func enter(_previous_state : State, _ext : Dictionary):
	if Global.debug.player_status:
		Global.debug.player_status.update_state(name)


## Checks if two key/button press events are the same.
func _compare_events(input_event : InputEvent, expected : InputEventKey) -> bool:
	if input_event is not InputEventKey:
		return false
	return input_event.keycode == expected.keycode and input_event.pressed == expected.pressed
