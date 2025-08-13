extends Control

func _on_phone_icon_pressed():
	Global.PLAYER_PHONE.CURRENT_STATE.transition('ChatsState')