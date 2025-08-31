extends LevelWaitState

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.NPCS.Bart.current_movement.transition('GoToBathroom')
	