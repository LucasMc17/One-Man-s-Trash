extends LevelWaitState

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.npcs.Bart.current_movement.transition('GoToBathroom')
	