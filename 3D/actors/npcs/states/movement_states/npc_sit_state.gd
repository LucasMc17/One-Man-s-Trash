class_name NPCSitState
extends NPCMovementState
## NPC Movement State representing sitting in a specific chair

## The seat which the NPC is sitting in
@export var _seat : Chair

## The position of the seat.
var _sit_position : Vector3
## The position which the NPC will move toward when exiting the seat
var _get_off_position : Vector3
## Whether or not the NPC has reached the seat and can stop lerping towards it.
var _captured := false
## Whether or not the NPC is currently in the act of getting up from the seat.
var _exiting := false
## The next state to move to after exiting the sitting state.
var _next_state_name : StringName = ""
## The extension object to pass to the next state.
var _next_state_ext := {}

func _ready():
	_gravity_enabled = false


func enter(previous_state, ext):
	super(previous_state, ext)
	if ext.has('seat'):
		_seat = ext.seat
		_seat.interactable.deactivate()
	_sit_position = _seat.sit_marker.global_position
	if ext.has('get_off_position'):
		_get_off_position = ext.get_off_position
	else:
		_get_off_position = _seat.get_off_marker.global_position


func update(delta):
	if !_captured:
		actor.position = lerp(actor.position, _sit_position, 0.08)
		if actor.position.distance_to(_sit_position) < 0.01:
			_captured = true
	elif _exiting:
		actor.position = lerp(actor.position, _get_off_position, 0.08)
		if actor.position.distance_to(_get_off_position) < 0.01:
			super.transition(_next_state_name)
	else:
		super(delta)


# NOTE: Overrides super function here to provide special behavior of moving away from chair while still in the sitting state.
func transition(new_state_name : StringName, ext := {}):
	_next_state_name = new_state_name
	_next_state_ext = ext
	_exiting = true


func exit():
	_seat.interactable.activate()
	_captured = false
	_exiting = false
