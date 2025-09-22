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
	var mike = Global.NPCS.Mike
	var mike_chair = Global.IMPORTANT_SCENES.MikeChair
	mike.global_position = mike_chair.SIT_MARKER.global_position
	mike.current_movement.transition('Sit', { "seat": mike_chair })

func _on_dialog_chosen(_npc : NPC, behavior_flags : Dictionary):
	if behavior_flags.has("ADD_TO_TAB"):
		TAB += behavior_flags.ADD_TO_TAB

func _on_bart_bathroom_oneoff_entered(_area, _body):
	Global.IMPORTANT_SCENES.BathroomDoor.is_open = false
