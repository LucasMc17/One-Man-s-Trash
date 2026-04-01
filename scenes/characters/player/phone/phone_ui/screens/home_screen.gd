extends Control

## Dictionary representing all icons in the home screen, keyed by their names.
var icons := {}

@onready var _icon_container = %IconContainer

func _ready():
	for child in _icon_container.get_children():
		icons[child.name] = child
	Events.text_received.connect(_on_text_received)


## Event listener for global signal.
func _on_text_received(_contact_name : TextContact, _new_exchange : MessageList):
	if icons.has('ChatsIcon'):
		icons.ChatsIcon.has_notification = true