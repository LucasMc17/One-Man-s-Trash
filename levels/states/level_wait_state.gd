class_name LevelWaitState extends LevelState

## The level timer to initialize for this state.
@export var timer : Timer
## How long in seconds the timer should run before this state expires.
@export var _wait_time := 5.0
## The next state to transition to once the timer ends.
@export var _next_state : LevelState
## The extension to pass to the next state.
@export var _next_state_extention := {}

func enter(previous_state, ext):
	super(previous_state, ext)
	timer.timeout.connect(_on_timer_timeout)
	if Debug.skip_wait_times:
		timer.wait_time = 0.1
	else:
		timer.wait_time = _wait_time
	timer.start()


func exit():
	timer.stop()
	timer.timeout.disconnect(_on_timer_timeout)


## Event Listener
func _on_timer_timeout():
	transition(_next_state.name, _next_state_extention)