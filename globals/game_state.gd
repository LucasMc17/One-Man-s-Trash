extends Node

## A string representing the current time in the level, formatted as "H:MM AM/PM" (e.g. 6:18 PM)
@export var TIME := '6:18 PM':
	set(val):
		Events.time_changed.emit(val)
		TIME = val
## The character's current bank balance as a two decimal point float
@export var BANK_BALANCE := 45.62

# GLOBALS
var PLAYER : Player
var NPCS := {}
var IMPORTANT_SCENES := {}
var PLAYER_PHONE : Control
var LEVEL : Node3D
var CAMERAS := {}

func _ready():
	var all_npcs = get_tree().get_nodes_in_group('NPCs')
	for npc in all_npcs:
		NPCS[npc.name] = npc
	var important_scenes = get_tree().get_nodes_in_group('LevelImportant')
	for scene in important_scenes:
		IMPORTANT_SCENES[scene.name] = scene
	var all_cameras = get_tree().get_nodes_in_group('LevelCameras')
	for camera in all_cameras:
		CAMERAS[camera.name] = camera