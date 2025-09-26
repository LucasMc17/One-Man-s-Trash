class_name TalkState extends PlayerAttentionState

# var prev_state : PlayerState
# var keep_momentum := false

func _ready():
	DISABLE_MOVEMENT = true
	DISABLE_INPUT = true
	CAPTURE_MOUSE = false

func update(delta):
	super(delta)
	var target = ACTOR.talking_to.global_position
	var y_direction = (target - ACTOR.global_position).normalized()
	# var x_direction = (target - ACTOR.CAMERA_CONTROLLER.global_position).normalized()
	ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, atan2(-y_direction.x, -y_direction.z), 0.15)
	# ACTOR.CAMERA_CONTROLLER.rotation.x = lerp_angle(ACTOR.CAMERA_CONTROLLER.rotation.x, atan2(-x_direction.y, -x_direction.x), 0.15)

	var difference = target - ACTOR.CAMERA_CONTROLLER.global_position
	var distance = sqrt(difference.x ** 2  + difference.z ** 2)
	var x_direction = Vector2(distance, difference.y)
	# print(x_direction)
	ACTOR.CAMERA_CONTROLLER.rotation.x = lerp_angle(ACTOR.CAMERA_CONTROLLER.rotation.x, atan2(x_direction.y, x_direction.x), 0.15)

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	# if previous_state._movement_enabled:
	# 	keep_momentum = true
	# prev_state = previous_state
	ACTOR.kill_camera_momentum()
	if ext.has('TALK_TREE') and ext.has('TALKING_TO'):
		ext.TALK_TREE.activate(ext.TALKING_TO)
		ACTOR.DIALOGUE_LAYER.TALK_TREE = ext.TALK_TREE
		ACTOR.talking_to = ext.TALKING_TO
	ACTOR.DIALOGUE_LAYER.visible = true

func exit():
	# keep_momentum = false
	# prev_state = null
	ACTOR.DIALOGUE_LAYER.visible = false
	ACTOR.talking_to = null

# func update(_delta):
# 	if keep_momentum:
# 		ACTOR.handle_idle_momentum(DECELERATION)

# func return_to_last_state():
# 	if prev_state:
# 		transition(prev_state.name)
