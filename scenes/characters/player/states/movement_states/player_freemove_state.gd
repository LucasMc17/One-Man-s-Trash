class_name PlayerFreemoveState extends PlayerMovementState

func update(delta):
	super(delta)
	ACTOR.update_input(SPEED, ACCELERATION, DECELERATION)