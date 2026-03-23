extends Button

@export var PREVIOUS_STATE_NAME := ""

func _pressed():
	if PREVIOUS_STATE_NAME == "":
		Global.player_phone.CURRENT_STATE.transition(Global.player_phone.CURRENT_STATE.PREVIOUS_STATE.name)
	else:
		Global.player_phone.CURRENT_STATE.transition(PREVIOUS_STATE_NAME)
