extends Control

@onready var CHATS = %Chats

func refresh_all():
	for child in CHATS.get_children():
		child.refresh()
