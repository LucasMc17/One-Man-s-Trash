extends Control

@onready var STATE_MACHINE = %StateMachine

func _on_home_screen_chats_tapped():
	STATE_MACHINE.CURRENT_STATE.transition("ChatsState")
