extends Node

@export_group("Debug Settings")
## Controls the visibility of all debug elements:
## [br][br]ON: All debug scenes are visible, regardless of their individual visibility settings.
## [br]OFF: All debug scenes are invisible, regardless of their individual visibility settings.
## [br]DEFER: Debug scenes will default to their own individual visibility settings.
@export_enum("ON", "OFF", "DEFER") var debug_override = "DEFER":
	set(val):
		if val == "ON" or val == "OFF":
			for scene in DEBUG_SCENES:
				if scene:
					scene.visible = val == "ON"
		debug_override = val

## Controls the visibility of the player's debug console (when debug_override is set to 'DEFER')
@export var show_debug_console := false:
	set(val):
		if debug_override == "DEFER" and DEBUG_CONSOLE:
			DEBUG_CONSOLE.visible = val
		show_debug_console = val

## Controls the visibility of the player's status module (when debug_override is set to 'DEFER')
@export var show_player_status := false:
	set(val):
		if debug_override == "DEFER" and PLAYER_STATUS:
			PLAYER_STATUS.visible = val
		show_player_status = val

## Controls the visibility of NPC status modules (when debug_override is set to 'DEFER')
@export var show_npc_status := false:
	set(val):
		if debug_override == "DEFER":
			for panel in NPC_STATUSES:
				panel.visible = val
		show_npc_status = val

var DEBUG_CONSOLE : DebugConsole
var PLAYER_STATUS : PlayerStatus
var NPC_STATUSES : Array = []
var DEBUG_SCENES : Array = []

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

func _ready():
	DEBUG_SCENES = get_tree().get_nodes_in_group('debug')
	NPC_STATUSES = DEBUG_SCENES.filter(func(scene): return scene is NPCDebugPanel)
	if debug_override == "ON":
		for scene in DEBUG_SCENES:
			scene.visible = true
	elif debug_override == "OFF":
		for scene in DEBUG_SCENES:
			scene.visible = false

func _input(event):
	if event.is_action_pressed("debug"):
		if debug_override != "ON":
			debug_override = "ON"
		else:
			debug_override = "OFF"
