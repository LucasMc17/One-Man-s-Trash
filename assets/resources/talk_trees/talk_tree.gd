class_name TalkTree extends Resource

@export_category('Dialog')
@export_multiline var PROMPT : String
@export_multiline var DIALOGUE : String
@export var PLAYER_OPTIONS : Array[TalkTree]
@export var EXIT_OPTION : String

@export_category('Special Behavior')
## The unique Name property of the camera to be used for this dialogue line. Will revert to player's POV on next line if it has no unique camera
@export var CAMERA_ID : StringName
@export var NEXT_TALK_TREE : TalkTree
## A string representing a special flag to be passed into the dialog selected global event to trigger special effects in the global scope
@export var BEHAVIOR_FLAGS : Dictionary[String, Variant]

@export_category('Player Focus')
@export_enum('DEFAULT', 'NPC', 'OBJECT', 'POINT') var FOCUS_TYPE = "DEFAULT"
@export var FOCUS_NPC : StringName
@export var FOCUS_OBJECT : StringName
@export var FOCUS_POINT : Vector3

func activate(npc : NPC):
	Events.dialog_chosen.emit(npc, self)
