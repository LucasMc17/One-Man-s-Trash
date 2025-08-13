extends HBoxContainer

func _on_back_button_pressed():
	Global.PLAYER_PHONE.CURRENT_STATE.transition("ChatsState")
