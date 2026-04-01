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

var debug_console : DebugConsole
var player_status : PlayerStatus
var level_status : LevelStatus
var npc_statuses : Array = []
var debug_scenes : Array = []


# TODO: Jesus put this somewhere else. Again, refer to Cryptr, I ended up liking what I did there.
## Object representing functionality and examples of all supported console commands.
var _commands : Dictionary = {
	"help": {
		"logic": func(_options):
			for key in _commands.keys():
				cons_log(key + '\n')
				cons_log('-- ' + _commands[key].description)
				var examples
				var params
				if len(_commands[key].examples) == 0:
					examples = "<none>"
				else:
					examples = "`" + "`, `".join(_commands[key].examples) + "`"
				if len(_commands[key].parameters) == 0:
					params = "<none>"
				else:
					params = _commands[key].parameters
				cons_log('---- Parameters: ' + params)
				cons_log('---- e.g. ' + examples + '\n'),
		"description": "Lists the available _commands of this debug console.",
		"parameters": "",
		"examples": ["help"]
	},

	"echo": {
		"logic": func(message): 
			if message.size() == 1:
				message = message[0]
			return message,
		"description": "Prints a message to the console.",
		"parameters": "Pass any text following the command to echo it to the console",
		"examples": ["echo this", "echo that", "echo this and that"]
	},

	"clear": {
		"logic": func(_options):
			debug_console.clear(),
		"description": "Clears the console",
		"parameters": "",
		"examples": ["clear"]
	},

	"set_npc_state": {
		"logic": func (options):
			if options.size() < 2:
				return "Error: Please provide an NPC name and a state to transition to"
			var npc_name = options[0]
			var npc_state_name = options[1]
			# var npc_index = Global.npcs.find_custom(func (item): return item.name == npc_name)
			# if npc_index == -1:
			# 	return "Error: NPC not found"
			# var npc = Global.npcs[npc_index]
			var npc = Global.npcs[npc_name]
			if !npc.STATE_MACHINE.has_node(npc_state_name):
				return "Error: NPC " + npc_name + " does not have that state"
			npc.current_state.transition(npc_state_name)
			return "NPC " + npc_name + " transitioned to state " + npc_state_name,
		"description": "Transitions a chosen NPC in the scene to a chosen behavior state",
		"parameters": "1. The name of the NPC. 2. The name of the state to transition to",
		"examples": ["set_npc_state Bartender MoveToPointA", "set_npc_state BarPatron01 TalkState"]
	},

	"set_level_state": {
		"logic": func (options):
			if options.size() < 1:
				return "Error: Please provide a state name to transition to"
			var state_name = options[0]
			if !Global.level.STATE_MACHINE.has_node(state_name):
				return "Error: Level does not have that state"
			Global.level.current_state.transition(state_name)
			return "Level transitioned to state " + state_name,
		"description": "Transitions the level to a chosen state",
		"parameters": "1. The name of the LevelState",
		"examples": ["set_level_state DebugState", "set_level_state TextAmandaState"]
	}
}

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


## Log a string to the debug console, if it exists.
func cons_log(message) -> void:
	# NOTE: this could get much more in depth but this will do for now
		print(message)
		if debug_console:
			if message is Array:
				for i in message.size():
					var element = message[i]
					var prefix = ''
					if i == 0:
						prefix = '> '
					_log_string(element, prefix)
			else:
				_log_string(message, '> ')


## Run a command in the debug console.
func command(command_name : String, inputs : Array, full_command : String) -> void:
	cons_log(full_command)
	if _commands.has(command_name):
		var result = _commands[command_name].logic.call(inputs)
		if result:
			cons_log(result)
	else:
		cons_log('Error: command unknown')
	cons_log('')


## Log a string to the debug console.
func _log_string(string, prefix := '') -> void:
	debug_console._history.text += '\n' + prefix + str(string)
