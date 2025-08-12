extends Control

@onready var STATE_MACHINE = %StateMachine

func _ready():
	Global.GameState.PLAYER_PHONE = self

func _on_home_screen_chats_tapped():
	STATE_MACHINE.CURRENT_STATE.transition("ChatsState")


func _on_chats_screen_chat_selected(message_list):
	STATE_MACHINE.CURRENT_STATE.transition("ChatState", {"message_list": message_list})
