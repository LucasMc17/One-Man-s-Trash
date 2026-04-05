class_name PlayerSitState
extends PlayerMovementState
## The player's seated state.

## The seat which the player is sitting in
@export var _seat : Chair

## The position of the seat.
var _sit_position : Vector3
## The position which the player will move toward when exiting the seat
var _get_off_position : Vector3
## Whether or not the player has reached the seat and can stop lerping towards it.
var _captured := false
## Whether or not the player is currently in the act of getting up from the seat.
var _exiting := false
## The next state to move to after exiting the sitting state.
var _next_state_name : StringName = ""
## The extension object to pass to the next state.
var _next_state_ext := {}

func _ready():
	_gravity_enabled = false
	blocked_interactables = ['chair']


func enter(previous_state, ext):
	super(previous_state, ext)
	actor.hint = 'Press [SPACE] to stand up'
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
			super.transition(_next_state_name, _next_state_ext)
	else:
		super(delta)


# NOTE: Overrides super function here to provide special behavior of moving away from chair while still in the sitting state.
func transition(new_state_name : StringName, ext := {}):
	if !World.player.movement_state_machine.disabled:
		_next_state_name = new_state_name
		_next_state_ext = ext
		_exiting = true


func exit():
	_seat.interactable.activate()
	actor.hint = ''
	_captured = false
	_exiting = false
	_next_state_name = ""
	_next_state_ext = {}


# Special input for getting up
func _movement_input(event):
	super(event)
	if event.is_action_pressed("space"):
		transition("Freemove")
