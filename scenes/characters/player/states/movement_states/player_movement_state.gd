class_name PlayerMovementState
extends PlayerState
## A player state specifically handling movement.

# TODO: Decide: can this be an abstract class? Do we need to export these?
@export_group("Movement Settings")
## Whether or not the player should be affected by gravity while in this state.
@export var _gravity_enabled := true
## The player's maximum speed while in this state.
@export var _speed := 5.0
## How fast to accelerate toward the maximum speed while in this state.
@export var _acceleration := 0.2
## How fast to decelerate from the maximum speed toward 0 while in this state.
@export var _deceleration := 0.4
## A list of interactables (by `Interactable.interactable_key`) which the player cannot interact with from this state.
@export var _blocked_interactables : Array[StringName] = []

func update(delta):
	super(delta)
	if _gravity_enabled:
		actor.update_gravity(delta)


func input(event):
	super(event)
	if !actor.current_attention.disable_input:
		_movement_input(event)


# NOTE: Not sure how I feel about this.
## Function for handling specific, non WASD inputs from a move state. For example, space bar to get up while seated.
func _movement_input(event) -> void:
	pass