extends Node

# GLOBALS
var PLAYER : Player
var NPCS := {}
var IMPORTANT_SCENES := {}
var PLAYER_PHONE : Control
var LEVEL : Node3D

func _ready():
	var all_npcs = get_tree().get_nodes_in_group('NPCs')
	for npc in all_npcs:
		NPCS[npc.name] = npc
	var important_scenes = get_tree().get_nodes_in_group('LevelImportant')
	for scene in important_scenes:
		IMPORTANT_SCENES[scene.name] = scene