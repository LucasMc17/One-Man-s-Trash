extends Node

## A string representing the current time in the level, formatted as "HH:MM AM/PM" (e.g. 6:18 PM)
@export var time := '6:18 PM':
	set(val):
		Events.time_changed.emit(val)
		time = val
## The character's current bank balance as a two decimal point float
@export var bank_balance := 45.62:
	set(val):
		Events.balance_changed.emit(val)
		bank_balance = val

## The player.
var player : Player
## A dictionary of the NPCs in the current level by their names.
var npcs : Dictionary[StringName, NPC] = {}
## Important scenes in the current level.
var important_scenes : Dictionary[StringName, Node3D] = {}
# NOTE: Will probably make this phone UI a global class at some point.
## The player's phone (2D UI, not 3D scene).
var player_phone : Control
# NOTE: There will probably be a global class for Levels later on.
## The current Level.
var level : Node3D
## A dictionary of the cameras in the level.
var cameras : Dictionary[StringName, Camera3D] = {}

func _ready():
	var all_npcs = get_tree().get_nodes_in_group('NPCs')
	for npc in all_npcs:
		npcs[npc.name] = npc

	var important_scenes_array = get_tree().get_nodes_in_group('LevelImportant')
	for scene in important_scenes_array:
		important_scenes[scene.name] = scene

	var all_cameras = get_tree().get_nodes_in_group('LevelCameras')
	for camera in all_cameras:
		cameras[camera.name] = camera

# REFACTORED TO BEST PRACTICE, MARCH 2026