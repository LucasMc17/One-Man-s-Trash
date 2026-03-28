class_name PlayerFreemoveState
extends PlayerMovementState
## The player's unrestricted movement state, able to move in any direction.

func update(delta):
	super(delta)
	actor.update_input(_speed, _acceleration, _deceleration)