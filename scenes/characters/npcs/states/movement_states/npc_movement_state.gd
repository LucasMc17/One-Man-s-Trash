class_name NPCMovementState extends NPCState

@export_group("Movement Settings")
@export var GRAVITY_ENABLED := true
@export var SPEED : float = 2.5
@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.4

func enter(previous_state, ext):
	super(previous_state, ext)
	ACTOR.DEBUG_PANEL.movement_state = name

func update(delta):
	super(delta)
	if GRAVITY_ENABLED:
		ACTOR.update_gravity(delta)