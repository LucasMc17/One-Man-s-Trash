class_name NPCMovementState
extends NPCState
## NPC State specifically for handling the actor's movement.

@export_group("Movement Settings")
## Whether or not the NPC is affected by gravity in the current state.
@export var _gravity_enabled := true
## If the NPC will move during this state, the speed at which they will do so.
@export var _speed : float = 2.5
## The speed at which the NPC will accelerate to their movement speed.
@export var _acceleration : float = 0.2
## The speed at which the NPC will decelerate from their movement speed.
@export var _deceleration : float = 0.4


func enter(previous_state, ext):
	super(previous_state, ext)
	actor.debug_label.change_param('movement', name)
	var previous_name : StringName
	if previous_state:
		previous_name = previous_state.name
	Events.npc_movement_changed.emit(actor, name, previous_name)


func update(delta):
	super(delta)
	if _gravity_enabled:
		actor.update_gravity(delta)
