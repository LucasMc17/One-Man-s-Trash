class_name Player
extends CharacterBody3D
## The player.

# TODO: No reason this can't move toa  global settings file

## How fast to translate mouse movement into camera movement.
@export var _mouse_sensitivity := 0.1
## The lower extreme the camera is allowed to tip to.
@export var _tilt_lower_limit := deg_to_rad(-90.0)
## The upper extreme the camera is allowed to tip to.
@export var _tilt_upper_limit := deg_to_rad(90.0)

## The NPC currently being spoken to by the player.
var talking_to : NPC
## The Interactable which the player is currently looking at.
var looking_at : Interactable:
	set(val):
		if _interact_label:
			if val and current_attention.can_interact:
				_interact_label.text = val.message
			else:
				_interact_label.text = ''
		looking_at = val
## Virtual property for the player's current attention state.
var current_attention : PlayerAttentionState:
	get():
		return attention_state_machine.current_state
## Virtual property for the player's current movement state.
var current_movement : PlayerMovementState:
	get():
		return movement_state_machine.current_state
## The hint at the bottom left of the screen.
var hint := '':
	set(val):
		if _hint_label:
			_hint_label.text = val
		hint = val
# TODO: This looks like a lot of redundancy, Do we need all this?
## Boolean tracking whether or not the player's last input was made with a mouse.
var _mouse_input : bool = false
## Keeps track of the rotation of the player's mouse to map it to the rotation of their camera.
var _mouse_rotation : Vector3
## The rotational input from the mouse.
var _rotation_input : float
## The up and down tilting input from the mouse.
var _tilt_input : float
## The player's rotation.
var _player_rotation : Vector3
## The camera's rotation.
var _camera_rotation : Vector3
## The player's overall rotation.
var _current_rotation : float
# TODO: Again, should be a global setting
## The gravity applied to the player.
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

## The camera (Node3D) holding the camera, used for rotating the camera on the z axis without 
## affecting the basis of the camera itself.
@onready var camera_controller : Node3D = %CameraController
## The player's camera.
@onready var camera : Camera3D = %Camera3D
# TODO: This will eventually be a global class.
## The player's phone.
@onready var phone : MeshInstance3D = %Phone
## The player's attention state machine.
@onready var attention_state_machine : StateMachine = %AttentionStateMachine
## The player's movement state machine.
@onready var movement_state_machine : StateMachine = %MovementStateMachine
## The UI layer for dialog.
@onready var dialog_layer : VBoxContainer = %DialogueLayer
## The UI label representing a prompt when the player looks at an interactable.
@onready var _interact_label : Label = %InteractLabel
## The player's raycast for interacting with objects.
@onready var _interactor : RayCast3D = %Interactor
## The UI label for a hint about what to do next.
@onready var _hint_label : Label = %HintLabel
## The UI label informing the player when they should check their phone for a notification.
@onready var _notification_label : Label = %NotificationLabel

func _ready():
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Events.text_received.connect(func(_contact, _new_messages): set_notification(true))


func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()


func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * _mouse_sensitivity
		_tilt_input = -event.relative.y * _mouse_sensitivity


func _process(_delta):
	# NOTE: I don't think I like this here.
	if Global.debug.player_status:
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
		Global.debug.player_status.update_direction("%.2f" % degs + ' ' + letter)
		Global.debug.player_status.update_velocity("%.2f" % velocity.length())


## Make the notification label visible or invisible.
func set_notification(val := true) -> void:
	_notification_label.visible = val


## Set the rotation and tilt input to 0 to instantly stop camera movement. To be called from specific player states.
func kill_camera_momentum() -> void:
	_rotation_input = 0.0
	_tilt_input = 0.0


## Update the camera's rotation based on input. To be called from specific player states.= which allow for camera input.
func update_camera(delta) -> void:
	_current_rotation = _rotation_input
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, _tilt_lower_limit, _tilt_upper_limit)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0) # NOTE: I think this is where the issue is where I can't change the character's starting rotation
	
	camera_controller.transform.basis = Basis.from_euler(_camera_rotation)
	camera_controller.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_rotation_input = 0.0
	_tilt_input = 0.0


# TODO: I think we can have the global event emitted from the exit option itself, and move this to a global event listener.
## Handle variable updates when the player exists conversation.
func exit_dialogue() -> void:
	Events.conversation_ended.emit(talking_to)
	if talking_to:
		if talking_to.current_attention is NPCTalkState:
			talking_to.current_attention.transition('IdleAttention')
	if current_attention is TalkState:
		current_attention.transition("Freelook")


## Move the player downward according to gravity whenever not on the floor. To be called from states which do not disable gravity.
func update_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta
		move_and_slide()


## handle movement inputs. To be called from specific player states which do not disable movement.
func update_input(speed : float, acceleration: float, deceleration: float) -> void:
	if current_attention.disable_movement:
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
		move_and_slide()
	else:
		_handle_idle_momentum(deceleration)


## Update the player's looking at field based on what the interactor is currently touching.
func update_interactor(_delta) -> void:
	var coll = _interactor.get_collider()
	if _get_interactibility(coll):
		looking_at = coll
	else:
		looking_at = null


## Gradually slow the player's momentum to 0 when no movement input is being made.
func _handle_idle_momentum(deceleration : float) -> void:
	var vel = Vector2(velocity.x,velocity.z)
	var temp = move_toward(vel.length(), 0, deceleration)
	velocity.x = vel.normalized().x * temp
	velocity.z = vel.normalized().y * temp
	move_and_slide()


## Check if the player can currently interact with something.
func _get_interactibility(collider : Node3D) -> bool:
	return collider is Interactable \
	and (collider.global_position - _interactor.global_position).length() < collider.max_distance \
	and collider.get_interactive() \
	and !current_movement._blocked_interactables.has(collider.interactable_key)
