class_name TalkTree
extends Resource

@export_category('Dialog')
@export_multiline var prompt : String

@export_multiline var dialog : String

@export var player_options : Array[TalkTree]

@export var exit_option : String

@export_category('Special Behavior')
## The unique Name property of the camera to be used for this dialogue line. Will revert to player's POV on next line if it has no unique camera
@export var camera_id : StringName

@export var next_talk_tree : TalkTree

## A string representing a special flag to be passed into the dialog selected global event to trigger special effects in the global scope
@export var behavior_flags : Dictionary[String, Variant]

@export_category('Player Focus')
@export_enum('DEFAULT', 'NPC', 'OBJECT', 'POINT') var focus_type = "DEFAULT"

@export var focus_npc : StringName

@export var focus_object : StringName

@export var focus_point : Vector3

func activate(npc : NPC):
	Events.dialog_chosen.emit(npc, self)
