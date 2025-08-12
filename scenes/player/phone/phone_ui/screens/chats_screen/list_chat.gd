extends MarginContainer

signal chat_selected(message_list : MessageList)

@export var MESSAGES : MessageList
@export var MESSAGES_TO_COME : MessageList

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.log("CLICK")
		chat_selected.emit(MESSAGES)