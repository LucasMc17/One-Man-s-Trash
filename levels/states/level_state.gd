class_name LevelState extends State

## Optional new time stamp for the level state, updating the global time property
@export var TIME : String

func enter(previous_state, ext):
	super(previous_state, ext)
	if !TIME.is_empty():
		Global.GameState.TIME = TIME
	Events.level_state_changed.emit(self)