class_name NPCIdleWithTimer extends NPCState

@export var TIMEOUT := 3.0
@export var NEXT_STATE : NPCState

var time_left := TIMEOUT

func update(delta):
	time_left -= delta
	if time_left <= 0:
		transition(NEXT_STATE.name, {})

func exit():
	time_left = TIMEOUT
