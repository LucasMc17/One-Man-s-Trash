class_name TalkTree
extends Resource
## A custom resource representing a single interchange of dialog between the player and an NPC.[br]
## Contains several options for what the player can say next, represented as their own distinct TalkTree resources.

@export_category('Dialog')
## What the player says to illicit a response from the NPC.
@export_multiline var prompt : String
## The NPC's response to the player's prompt.
@export_multiline var dialog : String
## Options for what the player can say next.
@export var player_options : Array[TalkTree]
## What the player can say to exit dialog (optional).
@export var exit_option : String

@export_category('Special Behavior')
## The unique Name property of the camera to be used for this dialogue line. Will revert to player's POV on next line if it has no unique camera
@export var camera_id : StringName
## Optional parameter which updates the NPC's talk tree when this dialog is accessed. Useful for switching to urge dialog after initial interaction.
@export var next_talk_tree : TalkTree
## A dictionary of strings representing a special flag to be passed into the dialog selected global event to trigger special effects in the global scope
@export var behavior_flags : Dictionary[String, Variant]

@export_category('Player Focus')
## Where the player should focus for this line of dialog. By default, the player will look at the focus point of the NPC they are speaking with.
@export_enum('DEFAULT', 'NPC', 'OBJECT', 'POINT') var focus_type = "DEFAULT"
## If `focus_type` is set to `NPC`, the unique name of the NPC to look at during this dialog.
@export var focus_npc : StringName
## If `focus_type` is set to `OBJECT`, the unique name of the object to look at during this dialog.
@export var focus_object : StringName
## If `focus_type` is set to `POINT`, the coordinates of the point to look at during this dialog.
@export var focus_point : Vector3

## Function to signal to the game that this dialog has been accessed by way of global signal.
func activate(npc : NPC):
	Events.dialog_chosen.emit(npc, self)
