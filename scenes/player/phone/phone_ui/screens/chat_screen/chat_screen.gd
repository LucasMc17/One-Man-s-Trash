extends Control

@onready var MESSAGE_HOLDER := %MessageHolder
@onready var SCROLL_CONTAINER := %ScrollContainer
@onready var DRAFT_TEXT := %DraftText

var USER_MESSAGE = preload('./user_message.tscn')
var CHAT_MESSAGE = preload('./chat_message.tscn')
var TIME_STAMP = preload('./time_stamp.tscn')

var DRAFT := "":
	set(val):
		DRAFT_TEXT.text = val
		DRAFT = val


func activate(contact : TextContact):
	for child in MESSAGE_HOLDER.get_children():
		child.queue_free()
	for exchange in contact.TEXT_EXCHANGES:
		var time_stamp = TIME_STAMP.instantiate()
		time_stamp.text = exchange.TIME_STAMP
		MESSAGE_HOLDER.add_child(time_stamp)
		for message in exchange.MESSAGES:
			if message is ContactMessage:
				var text_scene = CHAT_MESSAGE.instantiate()
				text_scene.MESSAGE = message.MESSAGE
				MESSAGE_HOLDER.add_child(text_scene)
			if message is UserMessage:
				var text_scene = USER_MESSAGE.instantiate()
				text_scene.MESSAGE = message.MESSAGE
				MESSAGE_HOLDER.add_child(text_scene)
	await get_tree().process_frame
	SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value

func send_text(text : UserMessage):
	var text_scene = USER_MESSAGE.instantiate()
	text_scene.MESSAGE = text.MESSAGE
	MESSAGE_HOLDER.add_child(text_scene)
	DRAFT = ""
	await get_tree().process_frame
	SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value

func receive_text(text : ContactMessage):
	var text_scene = CHAT_MESSAGE.instantiate()
	text_scene.MESSAGE = text.MESSAGE
	MESSAGE_HOLDER.add_child(text_scene)
	await get_tree().process_frame
	SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value
