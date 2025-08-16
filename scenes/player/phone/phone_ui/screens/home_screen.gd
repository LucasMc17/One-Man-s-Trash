extends Control

@onready var ICON_CONTAINER = %IconContainer

var ICONS := {}

func _ready():
	for child in ICON_CONTAINER.get_children():
		ICONS[child.name] = child
	Events.text_received.connect(_on_text_received)

func _on_text_received(_contact_name : TextContact, _new_exchange : MessageList):
	if ICONS.has('ChatsIcon'):
		ICONS.ChatsIcon.NOTIFICATION = true