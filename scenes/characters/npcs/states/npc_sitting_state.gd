class_name NPCSittingState extends NPCState

@export var SEAT : Chair

# var SIT_POSITION : Vector3
# var GET_OFF_POSITION : Vector3
# var _CAPTURED := false
# var _EXITING := false
# var _NEXT_STATE : StringName

# func _ready():
# 	_gravity_enabled = false

# func enter(previous_state, ext):
# 	super(previous_state, ext)
# 	if ext.has('seat'):
# 		SEAT = ext.seat
# 	sit_position = SEAT.global_position + SEAT.sit_position
# 	if ext.has('get_off_position'):
# 		get_off_position = ext.get_off_position
# 	else:
# 		get_off_position = SEAT.GET_OFF_MARKER.global_position
# 	if ext.has('next_state'):
# 		_next_state = ext.next_state

# func update(delta):
# 	if !_captured:
# 		ACTOR.position = lerp(ACTOR.position, sit_position, 0.08)
# 		if ACTOR.position.distance_to(sit_position) < 0.01:
# 			_captured = true
# 	elif _exiting:
# 		ACTOR.position = lerp(ACTOR.position, get_off_position, 0.08)
# 		if ACTOR.position.distance_to(get_off_position) < 0.01:
# 			super.transition(_next_state)
# 	else:
# 		super(delta)

# func transition(new_state_name : StringName, _ext := {}):
# 	_next_state = new_state_name
# 	_exiting = true

# func exit():
# 	_captured = false
# 	_exiting = false
