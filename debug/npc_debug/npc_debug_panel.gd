extends Node3D

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