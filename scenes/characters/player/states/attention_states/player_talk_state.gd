class_name TalkState extends PlayerAttentionState

var PREV_X_ROTATION : float
var PREV_Y_ROTATION : float
var TARGET_X_ROTATION : float
var TARGET_Y_ROTATION : float
var _NEXT_STATE_NAME : StringName = ""
var _NEXT_STATE_EXT := {}
var _EXITING := false

func _ready():
	DISABLE_MOVEMENT = true
	DISABLE_INPUT = true
	CAPTURE_MOUSE = false

func update(delta):
	super(delta)
	if _EXITING:
		lerp_away_from_target()
		if ACTOR.rotation.y < PREV_Y_ROTATION + 0.01 && ACTOR.rotation.y > PREV_Y_ROTATION - 0.01:
			print('y ok')
			if ACTOR.CAMERA_CONTROLLER.rotation.x < PREV_X_ROTATION + 0.01 && ACTOR.CAMERA_CONTROLLER.rotation.x > PREV_X_ROTATION - 0.01:
				print('x ok')
				super.transition(_NEXT_STATE_NAME, _NEXT_STATE_EXT)
	else:
		lerp_toward_target()

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	PREV_X_ROTATION = ACTOR.CAMERA_CONTROLLER.rotation.x
	PREV_Y_ROTATION = ACTOR.rotation.y

	if ext.has('TALK_TREE') and ext.has('TALKING_TO'):
		ext.TALK_TREE.activate(ext.TALKING_TO)
		ACTOR.DIALOGUE_LAYER.TALK_TREE = ext.TALK_TREE
		ACTOR.talking_to = ext.TALKING_TO
	ACTOR.DIALOGUE_LAYER.visible = true

	var target = ACTOR.talking_to.FOCUS_MARKER.global_position
	var direction = target - ACTOR.CAMERA_CONTROLLER.global_position
	var normalized = direction.normalized()
	TARGET_Y_ROTATION = atan2(-normalized.x, -normalized.z)

	var distance = sqrt(direction.x ** 2  + direction.z ** 2)
	var x_direction = Vector2(distance, direction.y)
	TARGET_X_ROTATION = atan2(x_direction.y, x_direction.x)
	# if previous_state._movement_enabled:
	# 	keep_momentum = true
	# prev_state = previous_state
	ACTOR.kill_camera_momentum()

func exit():
	PREV_X_ROTATION = 0.0
	PREV_Y_ROTATION = 0.0
	TARGET_X_ROTATION = 0.0
	TARGET_Y_ROTATION = 0.0
	_EXITING = false
	# keep_momentum = false
	# prev_state = null
	ACTOR.DIALOGUE_LAYER.visible = false
	ACTOR.talking_to = null

func transition(new_state_name : StringName, ext := {}):
	if !Global.PLAYER.MOVEMENT_STATE_MACHINE.DISABLED:
		_NEXT_STATE_NAME = new_state_name
		_NEXT_STATE_EXT = ext
		_EXITING = true

# func update(_delta):
# 	if keep_momentum:
# 		ACTOR.handle_idle_momentum(DECELERATION)

# func return_to_last_state():
# 	if prev_state:
# 		transition(prev_state.name)

func lerp_toward_target():
	ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, TARGET_Y_ROTATION, 0.15)
	ACTOR.CAMERA_CONTROLLER.rotation.x = lerp_angle(ACTOR.CAMERA_CONTROLLER.rotation.x, TARGET_X_ROTATION, 0.15)

func lerp_away_from_target():
	ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, PREV_Y_ROTATION, 0.15)
	ACTOR.CAMERA_CONTROLLER.rotation.x = lerp_angle(ACTOR.CAMERA_CONTROLLER.rotation.x, PREV_X_ROTATION, 0.15)
