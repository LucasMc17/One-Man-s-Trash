class_name LevelState extends State

## Optional new time stamp for the level state, updating the global time property
@export var time : String

func enter(previous_state, ext):
	super(previous_state, ext)
	if !time.is_empty():
		Global.game_state.time = time
	Events.level_state_changed.emit(self)