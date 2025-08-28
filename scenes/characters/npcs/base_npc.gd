@tool
class_name NPC extends CharacterBody3D

@export var TALK_TREE : TalkTree
# @export var TALK_TREES : Array[TalkTree] = []
@export var MOVE_PATHS : Array[Path3D] = []

# @onready var STATE_MACHINE := %StateMachine
@onready var ATTENTION_STATE_MACHINE := %AttentionStateMachine
@onready var MOVEMENT_STATE_MACHINE := %MovementStateMachine
@onready var DEBUG_PANEL := %NPCDebugPanel

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
	DEBUG_PANEL.npc_name = name

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

func _on_interactable_interacted(interactor : Player):
	if current_attention.TALK_ENABLED:
		current_attention.transition("Talk")
		interactor.current_attention.transition('Talk', {"TALK_TREE": TALK_TREE, "TALKING_TO": self})