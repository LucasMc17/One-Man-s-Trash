extends Node

@export_group("Debug Settings")
@export var debug_override := false:
	set(val):
		for scene in DEBUG_SCENES:
			if scene:
				scene.visible = val
		debug_override = val
@export var show_debug_console := false:
	set(val):
		if DEBUG_CONSOLE:
			DEBUG_CONSOLE.visible = val
		show_debug_console = val
@export var show_player_status := false:
	set(val):
		if PLAYER_STATUS:
			PLAYER_STATUS.visible = val
		show_player_status = val

var DEBUG_CONSOLE : DebugConsole
var PLAYER_STATUS : PlayerStatus
var DEBUG_SCENES := [DEBUG_CONSOLE, PLAYER_STATUS]

func log_string(string, prefix := ''):
	DEBUG_CONSOLE.History.text += '\n' + prefix + str(string)

func log(message):
	# NOTE: this could get much more in depth but this will do for now
		print(message)
		if DEBUG_CONSOLE:
			if message is Array:
				for i in message.size():
					var element = message[i]
					var prefix = ''
					if i == 0:
						prefix = '> '
					log_string(element, prefix)
			else:
				log_string(message, '> ')
