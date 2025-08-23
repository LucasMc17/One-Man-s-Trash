@tool
class_name NPC extends CharacterBody3D

@export var TALK_TREE : TalkTree
# @export var TALK_TREES : Array[TalkTree] = []
@export var MOVE_PATHS : Array[Path3D] = []

@onready var STATE_MACHINE := %StateMachine
@onready var DEBUG_PANEL := %NPCDebugPanel

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_state : NPCState:
	get():
		if STATE_MACHINE:
			return STATE_MACHINE.CURRENT_STATE
		else:
			return null

func update_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()

func _ready():
	DEBUG_PANEL.npc_name = name

func _on_interactable_interacted(interactor : Player):
	if current_state._talk_enabled:
		current_state.transition("TalkState")
		interactor.current_state.transition('TalkState', {"TALK_TREE": TALK_TREE, "TALKING_TO": self})