extends Control

@onready var MESSAGE_HOLDER := %MessageHolder
@onready var SCROLL_CONTAINER := %ScrollContainer

var USER_MESSAGE = preload('./user_message.tscn')
var CHAT_MESSAGE = preload('./chat_message.tscn')

func activate(message_list : MessageList):
	for child in MESSAGE_HOLDER.get_children():
		child.queue_free()
	for message in message_list.MESSAGES:
		if message is ContactMessage:
			var text_scene = CHAT_MESSAGE.instantiate()
			text_scene.MESSAGE = message.MESSAGE
			MESSAGE_HOLDER.add_child(text_scene)
		if message is UserMessage:
			var text_scene = USER_MESSAGE.instantiate()
			text_scene.MESSAGE = message.MESSAGE
			MESSAGE_HOLDER.add_child(text_scene)
	SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value
