extends Node

@onready var debug = $Debug
@onready var game_state = $GameState

# TODO: Ugh.

var player : Player:
	get():
		return game_state.player
	set(val):
		game_state.player = val
var npcs : Dictionary:
	get():
		return game_state.npcs
var player_phone : Control:
	get():
		return game_state.player_phone
	set(val):
		game_state.player_phone = val
var level : Node3D:
	get():
		return game_state.level
	set(val):
		game_state.level = val
var important_scenes : Dictionary:
	get():
		return game_state.important_scenes
var cameras : Dictionary:
	get():
		return game_state.cameras

func log(message):
	debug.log(message)
