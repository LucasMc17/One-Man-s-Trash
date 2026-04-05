extends Control
# TODO: Should be a global screen class.

@export var _contacts : Array[TextContact]

var _list_chat = preload('./list_chat.tscn')

@onready var back_button = %BackButton
@onready var _chats = %Chats

func _ready():
	for contact : TextContact in _contacts:
		var list_chat_scene = _list_chat.instantiate()
		list_chat_scene.contact = contact
		_chats.add_child(list_chat_scene)


## Trigger a refresh of the screen with the latest contacts and text messages
func refresh_list_chats():
	for chat in _chats.get_children():
		chat.refresh()
