class_name NPCMovementState extends NPCState

var GRAVITY_ENABLED := true

func update(delta):
	super(delta)
	if GRAVITY_ENABLED:
		ACTOR.update_gravity(delta)