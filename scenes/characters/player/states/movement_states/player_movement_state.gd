class_name PlayerMovementState extends PlayerState

# EXPORTS
@export_group("Movement Settings")
@export var GRAVITY_ENABLED := true
@export var SPEED : float = 5.0
@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.4
@export var BLOCKED_INTERACTABLES : Array[StringName] = []

func update(delta):
	super(delta)
	if GRAVITY_ENABLED:
		ACTOR.update_gravity(delta)

func input(event):
	super(event)
	if !ACTOR.current_attention.DISABLE_INPUT:
		movement_input(event)

func movement_input(event):
	pass