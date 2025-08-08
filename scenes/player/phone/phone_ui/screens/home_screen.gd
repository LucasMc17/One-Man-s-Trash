extends Control

signal chats_tapped()

func _on_phone_icon_pressed():
	chats_tapped.emit()
