extends MarginContainer

@export var MESSAGES : Array[MessageList]
@export var MESSAGES_TO_COME : MessageList
@export var NAME : String

@onready var CONTACT_NAME = %ContactName
@onready var LAST_MESSAGE = %LastMessage

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.PLAYER_PHONE.CURRENT_STATE.transition('ChatState', { "message_list": MESSAGES })

func refresh():
	CONTACT_NAME.text = NAME
	LAST_MESSAGE.text = MESSAGES[-1].MESSAGES[-1].MESSAGE

func notify():
	var next_message = MESSAGES_TO_COME.MESSAGES.pop_front()
	var new_message_list = MessageList.new()
	new_message_list.MESSAGES.append(next_message)
	MESSAGES.append(new_message_list)
