class_name LevelWaitState extends LevelState

@export var TIMER : Timer
@export var WAIT_TIME := 5.0
@export var NEXT_STATE : LevelState
@export var NEXT_STATE_EXTENSION := {}

func _ready():
	TIMER.timeout.connect(_on_timer_timeout)

func enter(previous_state, ext):
	super(previous_state, ext)
	TIMER.wait_time = WAIT_TIME
	TIMER.start()

func exit():
	TIMER.stop()

func _on_timer_timeout():
	transition(NEXT_STATE.name, NEXT_STATE_EXTENSION)