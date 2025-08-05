extends Node

@onready var Debug = $Debug
@onready var GameState = $GameState

var PLAYER : Player:
	get():
		return GameState.PLAYER
var NPCS : Array:
	get():
		return GameState.NPCS

func log(message):
	Debug.log(message)
