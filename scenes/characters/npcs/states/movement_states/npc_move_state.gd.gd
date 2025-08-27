class_name NPCMoveState extends NPCMovementState

@export var PATH_INDEX := 0
@export var SHOULD_LOOP := false

@export var NEXT_STATE : NPCState

var PATH : Path3D
var TARGET_INDEX := 0
var TARGET_POSITION : Vector3
var POINT_COUNT := 0

func enter(previous_state, ext):
	super(previous_state, ext)
	PATH = ACTOR.MOVE_PATHS[PATH_INDEX]
	POINT_COUNT = PATH.curve.point_count - 1
	TARGET_POSITION = PATH.curve.get_point_position(TARGET_INDEX)

func physics_update(delta: float):
	super(delta)
	var direction = (TARGET_POSITION + PATH.global_position) - ACTOR.global_position
	if ACTOR.is_on_floor():
		if ACTOR.global_position.distance_to(TARGET_POSITION + PATH.global_position) > 0.2:
			var vector = direction.normalized() * 2.5
			ACTOR.velocity.x = vector.x
			ACTOR.velocity.z = vector.z
			ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, atan2(-ACTOR.velocity.x, -ACTOR.velocity.z), 0.15)
			# ACTOR.run()
		else:
			check_next_point()
	
	ACTOR.move_and_slide()

func check_next_point():
	if TARGET_INDEX == POINT_COUNT:
		if SHOULD_LOOP:
			TARGET_INDEX = 0
		else:
			transition(NEXT_STATE.name)
			return
	else:
		TARGET_INDEX += 1
	TARGET_POSITION = PATH.curve.get_point_position(TARGET_INDEX)
