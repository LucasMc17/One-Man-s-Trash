class_name NPCState extends State

# EXPORTS
@export var ACTOR : NPC

# STATE ALLOWANCES
var _talk_enabled := true
var _gravity_enabled := true

func physics_update(delta):
	if _gravity_enabled:
		ACTOR.update_gravity(delta)

func enter(_prev_state, _ext):
	ACTOR.DEBUG_PANEL.state = name
