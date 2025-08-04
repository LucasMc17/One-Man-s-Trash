class_name NPCDebugPanel extends Node3D

@onready var STATE = %StateValue
var state : StringName:
	set(val):
		STATE.text = val
		state = val

@onready var NAME = %NameValue
var npc_name : StringName:
	set(val):
		NAME.text = val
		npc_name = val

func _ready():
	if Global.Debug.debug_override == "DEFER":
		visible = Global.Debug.show_npc_status