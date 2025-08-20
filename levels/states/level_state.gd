class_name LevelState extends State

func enter(previous_state, ext):
	super(previous_state, ext)
	Events.level_state_changed.emit(self)