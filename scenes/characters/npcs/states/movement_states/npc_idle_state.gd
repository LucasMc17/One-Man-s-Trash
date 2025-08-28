class_name NPCIdleState extends NPCMovementState

@export var USE_TIMER := false
@export var TIMEOUT := 3.0
@export var NEXT_STATE : NPCMovementState

var TIME_LEFT := TIMEOUT

func update(delta):
	super(delta)
	if USE_TIMER:
		TIME_LEFT -= delta
		if TIME_LEFT <= 0:
			transition(NEXT_STATE.name, {})

func enter(previous_state, ext):
	super(previous_state, ext)
	ACTOR.velocity.x = 0
	ACTOR.velocity.z = 0

func exit():
	TIME_LEFT = TIMEOUT