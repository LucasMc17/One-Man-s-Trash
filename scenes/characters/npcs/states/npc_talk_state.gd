# class_name NPCTalkState
extends NPCState

var prev_state : NPCState

func enter(previous_state, ext): 
	super(previous_state, ext)
	prev_state = previous_state
	# ACTOR.look_at(Global.PLAYER.global_position)
	ACTOR.rotation.x = 0
	ACTOR.rotation.z = 0
	# var direction = POINT.global_position - ACTOR.global_position

func exit():
	super()
	prev_state = null

func return_to_last_state():
	if prev_state:
		transition(prev_state.name)

func physics_update(delta: float):
	super(delta)
	# var direction = Global.PLAYER.CAMERA_CONTROLLER.global_position - ACTOR.global_position
	# ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, atan2(-direction.x, -direction.y), 0.15)
