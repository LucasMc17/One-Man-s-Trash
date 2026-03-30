extends Control

@onready var back_button : Button = %BackButton
@onready var _message_holder : VBoxContainer = %MessageHolder
@onready var _scroll_container : ScrollContainer = %ScrollContainer
@onready var _draft_text : Label = %DraftText
@onready var _typing_holder : PanelContainer = %TypingHolder
@onready var _typing_label : Label = %TypingLabel
@onready var _draft_holder : PanelContainer = %DraftHolder
# @onready var _send_button : Button = %SendButton

## Whether the conversation is active and should lock the player in until finished.
var active := false
## The text draft.
var draft := "":
	set(val):
		_draft_text.text = val
		draft = val
## Preloaded user message scene.
var _user_message := preload('./user_message.tscn')
## Preloaded contact message scene.
var _chat_message := preload('./chat_message.tscn')
## Preloaded time stamp scene.
var _time_stamp := preload('./time_stamp.tscn')

## Initialize the screen with the contact and past messages.
func activate(contact : TextContact) -> void:
	_typing_label.text = contact.contact_name + ' is typing...'
	for child in _message_holder.get_children():
		child.queue_free()
	for exchange in contact.text_exchanges:
		var time_stamp = _time_stamp.instantiate()
		time_stamp.text = exchange.TIME_STAMP
		_message_holder.add_child(time_stamp)
		for message in exchange.MESSAGES:
			if message is ContactMessage:
				var text_scene = _chat_message.instantiate()
				text_scene.message = message.MESSAGE
				_message_holder.add_child(text_scene)
			if message is UserMessage:
				var text_scene = _user_message.instantiate()
				text_scene.message = message.MESSAGE
				_message_holder.add_child(text_scene)
	_scroll_to_bottom.call_deferred()


## Send the finished text.
func send_text(text : UserMessage) -> void:
	var text_scene = _user_message.instantiate()
	text_scene.message = text.MESSAGE
	draft = ""
	_message_holder.add_child(text_scene)
	_draft_holder.modulate = Color(1, 1, 1, 0.5)
	_scroll_to_bottom.call_deferred()


## Allow the player to begin typing a response.
func activate_draft() -> void:
	_draft_holder.modulate = Color(1, 1, 1, 1)


## Instantiate a new text when received from the contact.
func receive_text(text : ContactMessage) -> void:
	var text_scene = _chat_message.instantiate()
	text_scene.message = text.MESSAGE
	_message_holder.add_child(text_scene)
	_typing_holder.visible = false
	_scroll_to_bottom.call_deferred()


## Activate the contact is typing indicator.
func set_typing() -> void:
	_typing_holder.visible = true
	# TODO: This one's not quite working yet
	_scroll_to_bottom.call_deferred()


## Scroll the player directly to the bottom, used after receiving a new text.
func _scroll_to_bottom() -> void:
	_scroll_container.set_deferred("scroll_vertical", _scroll_container.get_v_scroll_bar().max_value)


## Event listener.
func _on_send_button_pressed() -> void:
	# NOTE: To make this work, I think leveraging a global event might be the way.
	Global.log("Nice try this doesn't work yet")
	# var event = InputEventAction.new()
	# # Set the action name to the one defined in Project Settings
	# event.action = "enter" 
	# # Set 'pressed' to true to simulate a key press
	# event.pressed = true 
	# # Dispatch the event through the Input singleton
	# Input.parse_input_event(event) 
