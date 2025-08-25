class_name PlayerFreemoveState extends PlayerMovementState

func update(delta):
	super(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)