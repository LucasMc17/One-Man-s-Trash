@tool
class_name NPC extends CharacterBody3D

@onready var STATE_MACHINE := %StateMachine
@onready var DEBUG_PANEL := %NPCDebugPanel

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_state : NPCState:
	get():
		if STATE_MACHINE:
			return STATE_MACHINE.CURRENT_STATE
		else:
			return null

func update_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()

func _ready():
	DEBUG_PANEL.npc_name = name