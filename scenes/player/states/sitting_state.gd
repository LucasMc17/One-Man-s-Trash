class_name SittingState extends PlayerState

# GLOBALS
var sitting_position : Vector3
var _captured := false

func enter(previous_state : State, ext : Dictionary):
	print('im sitting now :)')
	if ext.has('sitting_position'):
		sitting_position = ext.sitting_position

func update(delta):
	if !_captured:
		PLAYER.position = lerp(PLAYER.position, sitting_position, 0.08)
		if PLAYER.position.distance_to(sitting_position) < 0.1:
			_captured = true
	else:
		PLAYER.update_camera(delta)
