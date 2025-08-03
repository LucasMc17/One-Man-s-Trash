@tool 
class_name Bartender extends NPC

# EXPORTS
@export_category("Movement")
@export var POINT_A := Vector3.ZERO:
	set(val):
		if MP_A:
			MP_A.global_position = val
		POINT_A = val
@export var POINT_B := Vector3.ZERO:
	set(val):
		if MP_B:
			MP_B.global_position = val
		POINT_B= val
@export var TALK_TREE : TalkTree

# NODES
@onready var MP_A = %MP_A
@onready var MP_B = %MP_B

func _ready():
	MP_A.global_position = POINT_A
	MP_B.global_position = POINT_B

func _on_interactable_interacted(interactor : Player):
	if current_state._talk_enabled:
		current_state.transition("TalkState")
		interactor.current_state.transition('TalkState', {"TALK_TREE": TALK_TREE, "TALKING_TO": self})
