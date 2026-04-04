extends LevelWaitState

func enter(previous_state, ext):
	super(previous_state, ext)
	World.npcs.Bart.current_movement.transition('GoToBathroom')
	