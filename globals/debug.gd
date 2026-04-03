extends Node

@export_group("Debug Info")
## Controls the visibility of all debug elements:
## [br]ON: All debug scenes are visible, regardless of their individual visibility settings.
## [br]OFF: All debug scenes are invisible, regardless of their individual visibility settings.
## [br]DEFER: Debug scenes will default to their own individual visibility settings.
@export_enum("ON", "OFF", "DEFER") var debug_override = "DEFER":
	set(val):
		if val == "ON" or val == "OFF":
			for scene in debug_scenes:
				if scene:
					scene.visible = val == "ON"
		debug_override = val

## Controls the visibility of the player's debug console (when debug_override is set to 'DEFER')
@export var show_debug_console := false:
	set(val):
		if debug_override == "DEFER" and debug_console:
			debug_console.visible = val
		show_debug_console = val

## Controls the visibility of the player's status module (when debug_override is set to 'DEFER')
@export var show_player_status := false:
	set(val):
		if debug_override == "DEFER" and player_status:
			player_status.visible = val
		show_player_status = val

## Controls the visibility of the level's status module (when debug_override is set to 'DEFER')
@export var show_level_status := false:
	set(val):
		if debug_override == "DEFER" and level_status:
			level_status.visible = val
		show_level_status = val

## Controls the visibility of NPC status modules (when debug_override is set to 'DEFER')
@export var show_npc_status := false:
	set(val):
		if debug_override == "DEFER":
			for panel in npc_statuses:
				panel.visible = val
		show_npc_status = val

@export_group("Godmode Settings")
## When set to `true`, contact messages arrive instantly during active chat state
@export var skip_wait_times := false
## When set to `true`, user text messages fill with a single keystroke during active chat state
@export var skip_typing := false

@export_group("Logging")
## Degree of frequency of console logging.
@export_enum("NONE", "NORMAL", "HIGH") var log_level := 0

var debug_console : DebugConsole
var player_status : PlayerStatus
var level_status : LevelStatus
var npc_statuses : Array = []
var debug_scenes : Array = []
## Queue of print commands which were executed before the Debug Console had loaded, to be ran as soon as it finishes.
var print_queue : Array

func _ready():
	debug_scenes = get_tree().get_nodes_in_group('debug')
	# TODO: There is work to be done here. Not sure if new solution will be a group or a class
	# npc_statuses = debug_scenes.filter(func(scene): return scene is NPCDebugPanel)
	if debug_override == "ON":
		for scene in debug_scenes:
			scene.visible = true
	elif debug_override == "OFF":
		for scene in debug_scenes:
			scene.visible = false


func _input(event):
	if event.is_action_pressed("debug"):
		if debug_override != "ON":
			debug_override = "ON"
		else:
			debug_override = "OFF"


## Log a string to the debug console. A log level of 0 will always successfully log, and will be considered an arbitrary log and push a warning as reminder to remove it before release.[br]
## Logs with a minimum log level of 1 and above are considered production logs for monitoring, not arbitrary logs to be removed.
func log(message, min_log_level := 0):
	if debug_console:
		if log_level >= min_log_level:
			debug_console.print(message)
		if min_log_level == 0:
			debug_console.warn('Arbitrary print left in code.')
			debug_console.print(message)
	else:
		print_queue.append({"message": message, "min_log_level": min_log_level})
