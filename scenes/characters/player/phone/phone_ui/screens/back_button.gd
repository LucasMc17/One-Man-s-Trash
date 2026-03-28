extends Button

@export var PREVIOUS_STATE_NAME := ""

func _pressed():
	if PREVIOUS_STATE_NAME == "":
		Global.player_phone.current_state.transition(Global.player_phone.current_state.previous_state.name)
	else:
		Global.player_phone.current_state.transition(PREVIOUS_STATE_NAME)
