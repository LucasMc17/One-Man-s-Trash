extends Node

var PLAYER : Player
@onready var Debug = $Debug
@onready var GameState = $GameState

func log(message):
	Debug.log(message)
