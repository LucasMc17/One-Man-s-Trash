class_name NPCMoveState
extends NPCMovementState
## NPC Movement state for following simple paths. Useful when a simple linear movement 
## pattern will suffice, as opposed to a full nav mesh.

## The index of the path (within the NPC's `move_paths` property) which this state traces.
@export var _path_index := 0
## Whether or not the NPC should immediately loop the path again on completion. Useful for patrols.
@export var _should_loop := false
## The next state which the NPC should move to upon completing the path.
@export var _next_state : NPCState

## A variable for storing the path, once pulled from the NPC\s `move_paths` via the `_path_index` property.
var _path : Path3D
## The index of the point in the path which the NPC is currently moving toward.
var _target_index := 0
## The position (in local space) of the point in the path which the NPC is currently moving towards.
var _target_position : Vector3
## The count of points in the path which the NPC is navigating.
var _point_count := 0

func enter(previous_state, ext):
	super(previous_state, ext)
	_target_index = 0
	_path = actor.move_paths[_path_index]
	_point_count = _path.curve.point_count - 1
	_target_position = _path.curve.get_point_position(_target_index)
	actor.animated_mesh.play_animation("humans/walk")


func physics_update(delta: float):
	super(delta)
	var target = _target_position + _path.global_position
	if actor.global_position.distance_to(target) < 0.2:
		_check_next_point()
	else:
		actor.update_movement(_speed, target, _acceleration)


## Utility function for determining what to do upon reaching a point in the path (start from 0 again, move to the next point, or transition to the next state).
func _check_next_point():
	if _target_index == _point_count:
		if _should_loop:
			_target_index = 0
		else:
			transition(_next_state.name)
			return
	else:
		_target_index += 1
	_target_position = _path.curve.get_point_position(_target_index)
