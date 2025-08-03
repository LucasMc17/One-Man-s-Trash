@tool
class_name NPC extends CharacterBody3D

@onready var STATE_MACHINE = %StateMachine

var current_state : NPCState:
	get():
		return STATE_MACHINE.CURRENT_STATE