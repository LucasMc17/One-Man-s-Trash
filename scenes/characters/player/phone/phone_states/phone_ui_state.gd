class_name PhoneUIState extends State

@export var SCREEN : Control
@export var SHOULD_POP_UP := false
var PREVIOUS_STATE : State

func enter(previous_state, _ext):
	super(previous_state, _ext)
	PREVIOUS_STATE = previous_state
	if SHOULD_POP_UP:
		pop_up()
	else:
		SCREEN.visible = true

func exit():
	SCREEN.visible = false

func pop_up():
	SCREEN.position.y = 1920
	SCREEN.visible = true

func update(_delta):
	if SHOULD_POP_UP:
		SCREEN.position.y = lerp(SCREEN.position.y, 0.0, 0.15)
