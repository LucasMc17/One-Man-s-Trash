extends Node

# GLOBALS
var PLAYER : Player
var NPCS := []
var PLAYER_PHONE : Control

func _ready():
	NPCS = get_tree().get_nodes_in_group('NPCs')