@tool
class_name TalkTree
extends Resource

@export_category('Dialog')
@export_multiline var PROMPT : String
@export_multiline var prompt : String

@export_multiline var DIALOGUE : String
@export_multiline var dialog : String

@export var PLAYER_OPTIONS : Array[TalkTree]
@export var player_options : Array[TalkTree]

@export var EXIT_OPTION : String
@export var exit_option : String

@export_category('Special Behavior')
## The unique Name property of the camera to be used for this dialogue line. Will revert to player's POV on next line if it has no unique camera
@export var CAMERA_ID : StringName
@export var camera_id : StringName

@export var NEXT_TALK_TREE : TalkTree
@export var next_talk_tree : TalkTree

## A string representing a special flag to be passed into the dialog selected global event to trigger special effects in the global scope
@export var BEHAVIOR_FLAGS : Dictionary[String, Variant]
@export var behavior_flags : Dictionary[String, Variant]

@export_category('Player Focus')
@export_enum('DEFAULT', 'NPC', 'OBJECT', 'POINT') var FOCUS_TYPE = "DEFAULT"
@export_enum('DEFAULT', 'NPC', 'OBJECT', 'POINT') var focus_type = "DEFAULT"

@export var FOCUS_NPC : StringName
@export var focus_npc : StringName

@export var FOCUS_OBJECT : StringName
@export var focus_object : StringName

@export var FOCUS_POINT : Vector3
@export var focus_point : Vector3

func activate(npc : NPC):
	Events.dialog_chosen.emit(npc, self)

func __migrate__():
	prompt = PROMPT
	dialog = DIALOGUE
	player_options = PLAYER_OPTIONS
	exit_option = EXIT_OPTION
	camera_id = CAMERA_ID
	next_talk_tree = NEXT_TALK_TREE
	behavior_flags = BEHAVIOR_FLAGS
	focus_type = FOCUS_TYPE
	focus_npc = FOCUS_NPC
	focus_object = FOCUS_OBJECT
	focus_point = FOCUS_POINT

	# NEXT_TALK_TREE.__migrate__()

	# for talk_tree : TalkTree in PLAYER_OPTIONS:
	# 	talk_tree.__migrate__()
