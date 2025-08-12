extends Control

signal chat_selected(message_list : MessageList)

@onready var CHATS = %Chats

func _ready():
	for child in CHATS.get_children():
		child.chat_selected.connect(func (message_list): chat_selected.emit(message_list))
