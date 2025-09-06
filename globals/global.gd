extends Node

@onready var Debug = $Debug
@onready var GameState = $GameState

var PLAYER : Player:
	get():
		return GameState.PLAYER
var NPCS : Dictionary:
	get():
		return GameState.NPCS
var PLAYER_PHONE : Control:
	get():
		return GameState.PLAYER_PHONE
var LEVEL : Node3D:
	get():
		return GameState.LEVEL
var IMPORTANT_SCENES : Dictionary:
	get():
		return GameState.IMPORTANT_SCENES
var CAMERAS : Dictionary:
	get():
		return GameState.CAMERAS

func log(message):
	Debug.cons_log(message)
