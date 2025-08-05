class_name Player extends CharacterBody3D

# EXPORTS
@export var MOUSE_SENSITIVITY := 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)

# NODES
@onready var CAMERA_CONTROLLER : Node3D = %CameraController
@onready var PHONE := %Phone
@onready var INTERACTOR := %Interactor
@onready var INTERACT_LABEL := %InteractLabel
@onready var HINT_LABEL := %HintLabel
@onready var STATE_MACHINE := %StateMachine
@onready var DIALOGUE_LAYER := %DialogueLayer

# GLOBALS
var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var _player_rotation : Vector3
var _camera_rotation : Vector3
var _current_rotation : float
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var talking_to : NPC
var looking_at : Interactable:
	set(val):
		if INTERACT_LABEL:
			if val:
				INTERACT_LABEL.text = val.message
			else:
				INTERACT_LABEL.text = ''
		looking_at = val
var current_state : PlayerState:
	get():
		return STATE_MACHINE.CURRENT_STATE
var hint := '':
	set(val):
		if HINT_LABEL:
			HINT_LABEL.text = val
		hint = val

func _ready():
	Global.GameState.PLAYER = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
		

func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY

func kill_camera_momentum():
	_rotation_input = 0.0
	_tilt_input = 0.0

func handle_idle_momentum(deceleration : float):
	var vel = Vector2(velocity.x,velocity.z)
	var temp = move_toward(vel.length(), 0, deceleration)
	velocity.x = vel.normalized().x * temp
	velocity.z = vel.normalized().y * temp
	move_and_slide()

func update_camera(delta):
	_current_rotation = _rotation_input
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_rotation_input = 0.0
	_tilt_input = 0.0

func exit_dialogue():
	if talking_to:
		if talking_to.current_state is NPCTalkState:
			talking_to.current_state.return_to_last_state()
	if current_state is TalkState:
		current_state.return_to_last_state()

# func _physics_process(delta):

func _process(_delta):
	if Global.Debug.PLAYER_STATUS:
		var degs = rad_to_deg(rotation.y) + 180
		var letter = 'S'
		if degs >= 22.5 and degs < 67.5:
			letter = 'SE'
		elif degs >= 67.5 and degs < 112.5:
			letter = 'E'
		elif degs >= 112.5 and degs < 157.5:
			letter = 'NE'
		elif degs >= 157.5 and degs < 202.5:
			letter = 'N'
		elif degs >= 202.5 and degs < 247.5:
			letter = 'NW'
		elif degs >= 247.5 and degs < 292.5:
			letter = 'W'
		elif degs >= 292.5 and degs < 337.5:
			letter = 'SW'
		Global.Debug.PLAYER_STATUS.direction = "%.2f" % degs + ' ' + letter
		Global.Debug.PLAYER_STATUS.velocity = str("%.2f" % velocity.length())

func update_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()

func update_input(speed : float, acceleration: float, deceleration: float):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
		move_and_slide()
	else:
		handle_idle_momentum(deceleration)

func update_interactor(_delta):
	var coll = INTERACTOR.get_collider()
	if coll is Interactable:
		looking_at = coll
	else:
		looking_at = null
