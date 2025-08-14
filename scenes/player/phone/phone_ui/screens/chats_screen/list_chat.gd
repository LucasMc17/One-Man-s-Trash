@tool
extends MarginContainer

@export var MESSAGES_TO_COME : MessageList
@export var CONTACT : TextContact
@export var NOTIFICATION := false
@export var SHOULD_LOCK := false

@onready var NAME_LABEL = %ContactName
@onready var MESSAGE_LABEL = %LastMessage

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.PLAYER_PHONE.CURRENT_STATE.transition('ChatState', { "contact": CONTACT })
		if SHOULD_LOCK:
			Global.PLAYER.STATE_MACHINE.lock()
			Global.PLAYER_PHONE.STATE_MACHINE.lock()

func _ready():
	Events.text_received.connect(_on_text_received)
	NAME_LABEL.text = CONTACT.CONTACT_NAME
	MESSAGE_LABEL.text = CONTACT.TEXT_EXCHANGES[-1].MESSAGES[-1].MESSAGE

func notify():
	var next_message = MESSAGES_TO_COME.MESSAGES.pop_front()
	var new_text_exchange = MessageList.new()
	new_text_exchange.MESSAGES.append(next_message)
	CONTACT.TEXT_EXCHANGES.append(new_text_exchange)

func _on_text_received(contact_name : String, new_exchange : MessageList):
	if contact_name == CONTACT.CONTACT_NAME:
		NOTIFICATION = true
		SHOULD_LOCK = true
		var new_text_exchange = MessageList.new()
		new_text_exchange.TIME_STAMP = new_exchange.TIME_STAMP
		var first_text = new_exchange.MESSAGES.pop_front()
		new_text_exchange.MESSAGES.append(first_text)
		MESSAGE_LABEL.text = first_text.MESSAGE
		CONTACT.TEXT_EXCHANGES.append(new_text_exchange)
