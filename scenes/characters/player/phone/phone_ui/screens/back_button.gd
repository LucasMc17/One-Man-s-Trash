extends Button

## The name of the state to send the player back to when clicking this button
@export var _previous_state_name := ""

func _pressed():
	if _previous_state_name == "":
		Global.player_phone.current_state.transition(Global.player_phone.current_state.previous_state.name)
	else:
		Global.player_phone.current_state.transition(_previous_state_name)
