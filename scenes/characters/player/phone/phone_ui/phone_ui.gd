extends Control

@onready var STATE_MACHINE = %StateMachine

var CURRENT_STATE : PhoneUIState:
	get():
		return STATE_MACHINE.CURRENT_STATE

func _ready():
	Global.GameState.PLAYER_PHONE = self
