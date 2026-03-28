class_name PlayerSitState extends PlayerMovementState

# GLOBALS
@export var SEAT : Chair

var SIT_POSITION : Vector3
var GET_OFF_POSITION : Vector3
var _CAPTURED := false
var _EXITING := false
var _NEXT_STATE_NAME : StringName = ""
var _NEXT_STATE_EXT := {}

func _ready():
	GRAVITY_ENABLED = false
	BLOCKED_INTERACTABLES = ['chair']

func enter(previous_state, ext):
	super(previous_state, ext)
	actor.hint = 'Press [SPACE] to stand up'
	if ext.has('seat'):
		SEAT = ext.seat
		SEAT.interactable.deactivate()
	SIT_POSITION = SEAT._sit_marker.global_position
	if ext.has('get_off_position'):
		GET_OFF_POSITION = ext.get_off_position
	else:
		GET_OFF_POSITION = SEAT._get_off_marker.global_position

func update(delta):
	if !_CAPTURED:
		actor.position = lerp(actor.position, SIT_POSITION, 0.08)
		if actor.position.distance_to(SIT_POSITION) < 0.01:
			_CAPTURED = true
	elif _EXITING:
		actor.position = lerp(actor.position, GET_OFF_POSITION, 0.08)
		if actor.position.distance_to(GET_OFF_POSITION) < 0.01:
			super.transition(_NEXT_STATE_NAME, _NEXT_STATE_EXT)
	else:
		super(delta)

func transition(new_state_name : StringName, ext := {}):
	if !Global.player.MOVEMENT_STATE_MACHINE.DISABLED:
		_NEXT_STATE_NAME = new_state_name
		_NEXT_STATE_EXT = ext
		_EXITING = true


func movement_input(event):
	super(event)
	if event.is_action_pressed("space"):
		transition("Freemove")

func exit():
	SEAT.interactable.activate()
	actor.hint = ''
	_CAPTURED = false
	_EXITING = false
	_NEXT_STATE_NAME = ""
	_NEXT_STATE_EXT = {}
