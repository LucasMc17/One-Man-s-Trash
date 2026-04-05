# TODO: There really should be an Actor class from which both NPC and Player inherit.
@tool
class_name NPC
extends CharacterBody3D
## The basic Non-Playable Character class for extension into specific characters.[br]
## Not an abstract class for the sake of easily adding new NPCs while testing.

## The starting dialog for this NPC.
@export var talk_tree : TalkTree
## Movement paths throughout the level which will be utilized by this character for simple movement.
@export var move_paths : Array[Path3D] = []
## The AnimatedMesh which this NPC should instantiate immediately for visuals.[br]MUST BE AnimatedMesh!
@export var _packed_mesh : PackedScene

## Animated Mesh instance which this NPC will use for visuals, after being instantiated from the packed scene passed in the `packed_mesh` exported variable.
var animated_mesh : AnimatedMesh
# TODO: Move this somewhere global.
## The force of gravity affecting this actor.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
## Virtual property returning the current attention state of this NPC.
var current_attention : NPCAttentionState:
	get():
		if attention_state_machine:
			return attention_state_machine.current_state
		else:
			return null
## Virtual property returning the current movement state of this NPC.
var current_movement : NPCMovementState:
	get():
		if movement_state_machine:
			return movement_state_machine.current_state
		else:
			return null

@onready var attention_state_machine : StateMachine = %AttentionStateMachine
@onready var movement_state_machine : StateMachine = %MovementStateMachine
@onready var debug_label : DebugLabel = %DebugLabel
@onready var focus_marker := %FocusMarker
@onready var _interactable := %Interactable

func _ready():
	animated_mesh = _packed_mesh.instantiate()
	add_child(animated_mesh)
	_interactable.interacted.connect(_on_interactable_interacted)
	debug_label.change_param('name', name)
	if Debug.debug_override == "DEFER":
		debug_label.visible = Debug.show_npc_status


## Function for increasing the NPC's downward momentum while not on the ground. Will be automatically called
## automatically in the `update` function of any NPC Movement State which has `_gravity_enabled` set to true.
func update_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()


## Function for moving the NPC towards a destination point while on the floor. Called by some specific Movement States, and can be disabled by some specific Attention States.
func update_movement(speed : float, target : Vector3, acceleration : float):
	if current_attention.disable_movement:
		return
	var direction = (target) - global_position
	if is_on_floor():
		var vector = direction.normalized()
		velocity.x = lerp(velocity.x, vector.x * speed, acceleration)
		velocity.z = lerp(velocity.z, vector.z * speed, acceleration)
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), 0.15)
	move_and_slide()


## Rotates the NPC on the y axis to face the player. Called by certain Attention States.
func look_at_player():
	var direction = (World.player.global_position - global_position).normalized()
	rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), 0.15)


## Fetch a TalkTree from this NPC's files by name. By default will also set it as their currently active talk tree.
func get_talk_tree(dialog_name : String, dialog_sub_phase := "index", set_talk_tree := true) -> TalkTree:
	var path = "res://3D/actors/npcs/all_npcs/" + name.to_camel_case() +"/dialog/" + dialog_name + "/" + dialog_sub_phase + ".tres"
	var loaded_talk_tree = load(path)
	if set_talk_tree:
		talk_tree = loaded_talk_tree
	return loaded_talk_tree


## Event listener for when the interactable is interacted with by the player.
func _on_interactable_interacted(interactor : Player):
	if current_attention.talk_enabled:
		current_attention.transition("Talk")
		interactor.current_attention.transition('Talk', {"talk_tree": talk_tree, "talking_to": self})
