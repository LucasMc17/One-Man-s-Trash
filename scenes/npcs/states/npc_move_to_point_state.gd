class_name NPCMoveToPointState extends NPCState

# this will need a lot of reworking in prod but is a good starting point for now
@export var POINT : Marker3D
@export var NEXT_STATE : NPCState

func physics_update(_delta: float):
	var direction = POINT.global_position - ACTOR.global_position
	if ACTOR.is_on_floor():
		if ACTOR.global_position.distance_to(POINT.global_position) > 0.1:
			var vector = direction.normalized() * 2.5
			ACTOR.velocity.x = vector.x
			ACTOR.velocity.z = vector.z
			# ACTOR.run()
		else:
			transition(NEXT_STATE.name)
	
	ACTOR.move_and_slide()
