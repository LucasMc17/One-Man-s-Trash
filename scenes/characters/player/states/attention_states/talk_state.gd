class_name TalkState extends PlayerAttentionState

# var prev_state : PlayerState
# var keep_momentum := false

func _ready():
	CAPTURE_MOUSE = false

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	# if previous_state._movement_enabled:
	# 	keep_momentum = true
	# prev_state = previous_state
	PLAYER.kill_camera_momentum()
	if ext.has('TALK_TREE'):
		PLAYER.DIALOGUE_LAYER.TALK_TREE = ext.TALK_TREE
	if ext.has('TALKING_TO'):
		PLAYER.talking_to = ext.TALKING_TO
	PLAYER.DIALOGUE_LAYER.visible = true

func exit():
	# keep_momentum = false
	# prev_state = null
	PLAYER.DIALOGUE_LAYER.visible = false
	PLAYER.talking_to = null

# func update(_delta):
# 	if keep_momentum:
# 		PLAYER.handle_idle_momentum(DECELERATION)

# func return_to_last_state():
# 	if prev_state:
# 		transition(prev_state.name)