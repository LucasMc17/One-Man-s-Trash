extends MarginContainer

## The contact this list chat represents.
var contact : TextContact
## If this list chat is beginning a new active conversation, this variable represents the exchange of messages.
var _messages_to_come : MessageList
## Whether or not this list chat has a notification.
var _has_notification := false:
	set(val):
		if _notification_circle:
			_notification_circle.visible = val
		_has_notification = val

@onready var _name_label = %ContactName
@onready var _message_label = %LastMessage
@onready var _notification_circle = %NotificationCircle

func _ready():
	Events.text_received.connect(_on_text_received)
	refresh()


func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.player_phone.current_state.transition('ChatState', { "contact": contact, "active": _has_notification, "new_exchange": _messages_to_come })
		Global.player_phone.state_machine.states.HomeState.remove_notification('ChatsIcon')
		if _has_notification:
			_has_notification = false
			Global.player.set_notification(false)


## Global event listener.
func _on_text_received(new_contact : TextContact, new_exchange : MessageList):
	if new_contact == contact:
		get_parent().move_child(self, 0)
		_has_notification = true
		var new_text_exchange = MessageList.new()
		new_text_exchange.TIME_STAMP = new_exchange.TIME_STAMP
		var first_text = new_exchange.MESSAGES.pop_front()
		new_text_exchange.MESSAGES.append(first_text)
		_message_label.text = first_text.MESSAGE
		contact.text_exchanges.append(new_text_exchange)
		_messages_to_come = new_exchange


## refresh the list chat scene with the latest information.
func refresh():
	_name_label.text = contact.contact_name
	_message_label.text = contact.text_exchanges[-1].MESSAGES[-1].MESSAGE
