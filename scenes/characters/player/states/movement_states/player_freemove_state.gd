class_name PlayerFreemoveState extends PlayerMovementState

func update(delta):
	super(delta)
	actor.update_input(SPEED, ACCELERATION, DECELERATION)