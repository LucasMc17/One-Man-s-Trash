extends Node

# GLOBALS
var PLAYER : Player
var NPCS := []

func _ready():
	NPCS = get_tree().get_nodes_in_group('NPCs')