class_name NPCSitState extends NPCMovementState

@export var SEAT : Chair

var SIT_POSITION : Vector3
var GET_OFF_POSITION : Vector3
var _CAPTURED := false
var _EXITING := false
var _NEXT_STATE_NAME : StringName = ""
var _NEXT_STATE_EXT := {}

func _ready():
	GRAVITY_ENABLED = false

func enter(previous_state, ext):
	super(previous_state, ext)
	if ext.has('seat'):
		SEAT = ext.seat
	SIT_POSITION = SEAT.SIT_MARKER.global_position
	if ext.has('get_off_position'):
		GET_OFF_POSITION = ext.get_off_position
	else:
		GET_OFF_POSITION = SEAT.GET_OFF_MARKER.global_position

func update(delta):
	if !_CAPTURED:
		ACTOR.position = lerp(ACTOR.position, SIT_POSITION, 0.08)
		if ACTOR.position.distance_to(SIT_POSITION) < 0.01:
			_CAPTURED = true
	elif _EXITING:
		ACTOR.position = lerp(ACTOR.position, GET_OFF_POSITION, 0.08)
		if ACTOR.position.distance_to(GET_OFF_POSITION) < 0.01:
			super.transition(_NEXT_STATE_NAME)
	else:
		super(delta)

func transition(new_state_name : StringName, ext := {}):
	_NEXT_STATE_NAME = new_state_name
	_NEXT_STATE_EXT = ext
	_EXITING = true

func exit():
	SEAT.INTERACTABLE.ACTIVE = true
	_CAPTURED = false
	_EXITING = false
