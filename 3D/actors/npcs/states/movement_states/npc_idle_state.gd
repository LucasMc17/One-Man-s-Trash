class_name NPCIdleState
extends NPCMovementState
## Idle movement for NPCs. Can optionally be placed on a timer with another state to move to next.

## Whether or not to use a timer to determine when to move to the next state.
@export var _use_timer := false
## If using a timer, the time in seconds for which the NPC should idle.
@export var _timeout := 3.0
## If using a timer, the next state to move to after this state ends.
@export var _next_state : NPCMovementState

## The active timer counting down from the value of `_timeout`.
var _time_left := _timeout

func update(delta):
	super(delta)
	if _use_timer and !actor.current_attention.disable_movement:
		_time_left -= delta
		if _time_left <= 0:
			transition(_next_state.name, {})


func enter(previous_state, ext):
	super(previous_state, ext)
	actor.velocity.x = 0
	actor.velocity.z = 0
	actor.animated_mesh.play_animation("humans/idle")


func exit():
	_time_left = _timeout