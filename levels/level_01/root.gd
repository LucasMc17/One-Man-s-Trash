extends Node3D

@onready var STATE_MACHINE = %StateMachine

var CURRENT_STATE : LevelState:
	get():
		return STATE_MACHINE.CURRENT_STATE

func _ready():
	Global.GameState.LEVEL = self