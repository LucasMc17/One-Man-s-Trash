extends Node

@onready var Debug = $Debug
@onready var GameState = $GameState

var PLAYER : Player:
	get():
		return GameState.PLAYER
var NPCS : Array:
	get():
		return GameState.NPCS
var PLAYER_PHONE : Control:
	get():
		return GameState.PLAYER_PHONE

func log(message):
	Debug.cons_log(message)
