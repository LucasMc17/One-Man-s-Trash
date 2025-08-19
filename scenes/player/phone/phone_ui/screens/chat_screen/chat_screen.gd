extends Control

@onready var MESSAGE_HOLDER := %MessageHolder
@onready var SCROLL_CONTAINER := %ScrollContainer
@onready var DRAFT_TEXT := %DraftText
@onready var TYPING_HOLDER := %TypingHolder
@onready var TYPING_LABEL := %TypingLabel
@onready var BACK_BUTTON := %BackButton
@onready var DRAFT_HOLDER := %DraftHolder
@onready var SEND_BUTTON := %SendButton

var USER_MESSAGE = preload('./user_message.tscn')
var CHAT_MESSAGE = preload('./chat_message.tscn')
var TIME_STAMP = preload('./time_stamp.tscn')
var ACTIVE := false

var DRAFT := "":
	set(val):
		DRAFT_TEXT.text = val
		DRAFT = val

func _ready():
	MESSAGE_HOLDER.child_entered_tree.connect(scroll_to_bottom)

func scroll_to_bottom(node):
	await node.ready
	if !node.is_node_ready():
		await get_tree().process_frame
	SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value

func activate(contact : TextContact):
	TYPING_LABEL.text = contact.CONTACT_NAME + ' is typing...'
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

func send_text(text : UserMessage):
	var text_scene = USER_MESSAGE.instantiate()
	text_scene.MESSAGE = text.MESSAGE
	DRAFT = ""
	MESSAGE_HOLDER.add_child(text_scene)
	DRAFT_HOLDER.modulate = Color(1, 1, 1, 0.5)

func activate_draft():
	DRAFT_HOLDER.modulate = Color(1, 1, 1, 1)

func receive_text(text : ContactMessage):
	var text_scene = CHAT_MESSAGE.instantiate()
	text_scene.MESSAGE = text.MESSAGE
	MESSAGE_HOLDER.add_child(text_scene)
	TYPING_HOLDER.visible = false

func keep_scroll_at_bottom():
	# I don't like this but it's needed until I can get the scroll to work consistently
	if ACTIVE:
		SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value

func set_typing():
	TYPING_HOLDER.visible = true
	# SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value

	# await TYPING_HOLDER.visibility_changed
	# SCROLL_CONTAINER.scroll_vertical = SCROLL_CONTAINER.get_v_scroll_bar().max_value


func _on_send_button_pressed():
	Global.log("Nice try this doesn't work yet")
	# var event = InputEventAction.new()
	# # Set the action name to the one defined in Project Settings
	# event.action = "enter" 
	# # Set 'pressed' to true to simulate a key press
	# event.pressed = true 
	# # Dispatch the event through the Input singleton
	# Input.parse_input_event(event) 
