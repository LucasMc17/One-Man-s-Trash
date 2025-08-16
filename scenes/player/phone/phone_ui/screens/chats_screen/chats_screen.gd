@tool
extends Control

@export var CONTACTS : Array[TextContact]

var LIST_CHAT = preload('./list_chat.tscn')

@onready var CHATS = %Chats
@onready var BACK_BUTTON = %BackButton

func _ready():
	for contact in CONTACTS:
		var list_chat_scene = LIST_CHAT.instantiate()
		list_chat_scene.CONTACT = contact
		CHATS.add_child(list_chat_scene)

func refresh_list_chats():
	for chat in CHATS.get_children():
		chat.refresh()
