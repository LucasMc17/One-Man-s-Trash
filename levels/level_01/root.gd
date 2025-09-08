extends Node3D

@onready var STATE_MACHINE = %StateMachine

var TAB : float:
	set(val):
		TAB = val
		Global.log(TAB)

var CURRENT_STATE : LevelState:
	get():
		return STATE_MACHINE.CURRENT_STATE

func _ready():
	Global.GameState.LEVEL = self
	Events.level_loaded.emit()
	Events.dialog_chosen.connect(_on_dialog_chosen)

func _on_dialog_chosen(_npc : NPC, behavior_flag : String):
	if behavior_flag == "TequilaShot":
		TAB += 7.0
		return
	if behavior_flag == "OldFashioned":
		TAB += 12.0
		return
	if behavior_flag == "IPA":
		TAB += 8.0
		return

func _on_bart_bathroom_oneoff_entered(_area, _body):
	Global.IMPORTANT_SCENES.BathroomDoor.is_open = false
