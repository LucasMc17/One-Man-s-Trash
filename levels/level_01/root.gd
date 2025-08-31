extends Node3D

@onready var STATE_MACHINE = %StateMachine

var CURRENT_STATE : LevelState:
	get():
		return STATE_MACHINE.CURRENT_STATE

func _ready():
	Global.GameState.LEVEL = self
	Events.level_loaded.emit()

func _on_bart_bathroom_oneoff_entered(area, body):
	Global.IMPORTANT_SCENES.BathroomDoor.is_open = false
