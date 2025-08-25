class_name LevelWaitState extends LevelState

@export var TIMER : Timer
@export var WAIT_TIME := 5.0
@export var NEXT_STATE : LevelState
@export var NEXT_STATE_EXTENSION := {}

func enter(previous_state, ext):
	super(previous_state, ext)
	TIMER.timeout.connect(_on_timer_timeout)
	if Global.Debug.skip_wait_times:
		TIMER.wait_time = 0.1
	else:
		TIMER.wait_time = WAIT_TIME
	TIMER.start()

func exit():
	TIMER.stop()
	TIMER.timeout.disconnect(_on_timer_timeout)

func _on_timer_timeout():
	transition(NEXT_STATE.name, NEXT_STATE_EXTENSION)