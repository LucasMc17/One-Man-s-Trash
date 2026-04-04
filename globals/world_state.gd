extends Node

## A string representing the current time.
var time := "6:18 PM":
	set(val):
		Events.time_changed.emit(val)
		time = val
## The character's current bank balance as a two decimal point float.
var bank_balance := 45.62:
	set(val):
		Events.balance_changed.emit(val)
		bank_balance = val
## A dictionary of the NPCs in the current level by their names. Instantiated in the `_ready` function.
var npcs : Dictionary[StringName, NPC] = {}
## Important scenes in the current level. Instantiated in the `_ready` function.
var important_scenes : Dictionary[StringName, Node3D] = {}
## A dictionary of the cameras in the level. Instantiated in the `_ready` function.
var cameras : Dictionary[StringName, Camera3D] = {}
## The currently active level.
var current_level : Node3D
## The player.
var player : Player
## The player's phone (2D UI, not 3D scene).
var player_phone : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var all_npcs = get_tree().get_nodes_in_group('NPCs')
	for npc in all_npcs:
		npcs[npc.name] = npc

	var important_scenes_array = get_tree().get_nodes_in_group('LevelImportant')
	for scene in important_scenes_array:
		important_scenes[scene.name] = scene

	var all_cameras = get_tree().get_nodes_in_group('LevelCameras')
	for camera in all_cameras:
		cameras[camera.name] = camera
