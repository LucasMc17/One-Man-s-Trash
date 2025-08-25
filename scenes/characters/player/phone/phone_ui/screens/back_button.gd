extends Button

@export var PREVIOUS_STATE_NAME := ""

func _pressed():
	if PREVIOUS_STATE_NAME == "":
		Global.PLAYER_PHONE.CURRENT_STATE.transition(Global.PLAYER_PHONE.CURRENT_STATE.PREVIOUS_STATE.name)
	else:
		Global.PLAYER_PHONE.CURRENT_STATE.transition(PREVIOUS_STATE_NAME)
