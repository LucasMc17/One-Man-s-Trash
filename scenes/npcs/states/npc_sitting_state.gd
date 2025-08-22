class_name NPCSittingState extends NPCState

@export var SEAT : Chair

var sit_position : Vector3
var get_off_position : Vector3
var _captured := false
var _exiting := false
var _next_state : NPCState

func _ready():
	_gravity_enabled = false

func enter(previous_state, ext):
	super(previous_state, ext)
	if ext.has('seat'):
		SEAT = ext.seat
	sit_position = SEAT.global_position + SEAT.sit_position
	if ext.has('get_off_position'):
		get_off_position = ext.get_off_position
	if ext.has('next_state'):
		_next_state = ext.next_state

func update(delta):
	if !_captured:
		ACTOR.position = lerp(ACTOR.position, sit_position, 0.08)
		if ACTOR.position.distance_to(sit_position) < 0.1:
			_captured = true
		elif _exiting:
			ACTOR.position = lerp(ACTOR.position, get_off_position, 0.08)
			if ACTOR.position.distance_to(get_off_position) < 0.1:
				transition(_next_state.name)
	else:
		super(delta)

func exit():
	_captured = false
	_exiting = false
