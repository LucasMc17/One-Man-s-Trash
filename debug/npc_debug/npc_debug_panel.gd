class_name NPCDebugPanel extends Node3D

@onready var MOVEMENT = %MovementValue
var movement_state : StringName:
	set(val):
		MOVEMENT.text = val
		movement_state = val

@onready var ATTENTION = %AttentionValue
var attention_state : StringName:
	set(val):
		ATTENTION.text = val
		attention_state = val

@onready var NAME = %NameValue
var npc_name : StringName:
	set(val):
		NAME.text = val
		npc_name = val

func _ready():
	if Global.Debug.debug_override == "DEFER":
		visible = Global.Debug.show_npc_status