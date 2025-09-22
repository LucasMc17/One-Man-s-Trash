@tool
class_name NPC extends CharacterBody3D

@export var TALK_TREE : TalkTree
@export var MOVE_PATHS : Array[Path3D] = []

@onready var ATTENTION_STATE_MACHINE := %AttentionStateMachine
@onready var MOVEMENT_STATE_MACHINE := %MovementStateMachine
@onready var DEBUG_LABEL := %DebugLabel
@onready var INTERACTABLE := %Interactable

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_attention : NPCAttentionState:
	get():
		if ATTENTION_STATE_MACHINE:
			return ATTENTION_STATE_MACHINE.CURRENT_STATE
		else:
			return null
var current_movement : NPCMovementState:
	get():
		if MOVEMENT_STATE_MACHINE:
			return MOVEMENT_STATE_MACHINE.CURRENT_STATE
		else:
			return null

func update_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()

func _ready():
	INTERACTABLE.interacted.connect(_on_interactable_interacted)
	DEBUG_LABEL.change_param('name', name)
	if Global.Debug.debug_override == "DEFER":
		DEBUG_LABEL.visible = Global.Debug.show_npc_status

func update_movement(speed : float, target : Vector3, acceleration : float):
	if current_attention.DISABLE_MOVEMENT:
		return
	var direction = (target) - global_position
	if is_on_floor():
		var vector = direction.normalized()
		velocity.x = lerp(velocity.x, vector.x * speed, acceleration)
		velocity.z = lerp(velocity.z, vector.z * speed, acceleration)
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), 0.15)
	move_and_slide()

func look_at_player():
	var direction = (Global.PLAYER.global_position - global_position).normalized()
	rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), 0.15)

func _on_interactable_interacted(interactor : Player):
	Global.log('hi')
	if current_attention.TALK_ENABLED:
		Global.log('talk enabled')
		current_attention.transition("Talk")
		interactor.current_attention.transition('Talk', {"TALK_TREE": TALK_TREE, "TALKING_TO": self})
