class_name PlayerPhoneState extends PlayerAttentionState

# var prev_state : PlayerState
# var keep_momentum := false

func _ready():
	disable_movement = true
	DISABLE_INPUT = true
	CAPTURE_MOUSE = false

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	# if previous_state._movement_enabled:
	# 	keep_momentum = true
	# prev_state = previous_state
	actor.PHONE.activate()
	actor.kill_camera_momentum()

func exit():
	actor.PHONE.deactivate()
	Global.player_phone.CURRENT_STATE.transition('HomeState')
	# keep_momentum = false
	# prev_state = null

# func update(_delta):
# 	if keep_momentum:
# 		actor.handle_idle_momentum(DECELERATION)

func input(event):
	if event.is_action_pressed("phone"):
		# if prev_state:
		# 	transition(prev_state.name)
		# else:
			transition('Freelook')
