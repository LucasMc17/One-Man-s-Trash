@tool
class_name NPC extends CharacterBody3D

@onready var STATE_MACHINE = %StateMachine

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_state : NPCState:
	get():
		return STATE_MACHINE.CURRENT_STATE

func update_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()