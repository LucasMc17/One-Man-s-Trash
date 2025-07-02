class_name FreeMoveState extends PlayerState

@export var TOP_ANIM_SPEED : float = 2.2
@export var SPEED : float = 5.0
@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.4

func enter(previous_state : State, ext : Dictionary):
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update(delta: float):
	super(delta)
	
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	PLAYER.update_interactor(delta)
	PLAYER.update_camera(delta)
	
	# set_animation_speed(PLAYER.velocity.length())
	
	# if PLAYER.velocity.length() == 0.0:
	# 	transition.emit("IdlePlayerState")
	
	# if Input.is_action_pressed('sprint'):
	# 	transition.emit("SprintingPlayerState")
	
	# if Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
	# 	transition.emit("CrouchingPlayerState")
	
	# if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
	# 	transition.emit("JumpingPlayerState")
	
	if PLAYER.velocity.y < -3.0 and !PLAYER.is_on_floor():
		transition.emit("FallingPlayerState")

func exit():
	PLAYER.looking_at = null

func compare_events(input_event : InputEvent, expected : InputEventKey):
	if input_event is not InputEventKey:
		return false
	return input_event.keycode == expected.keycode and input_event.pressed == expected.pressed

func input(event):
	if event.is_action_pressed("phone"):
		transition.emit("PhoneState")
	if PLAYER.looking_at and compare_events(event, PLAYER.looking_at.interact_button):
		PLAYER.looking_at.interact(PLAYER)
