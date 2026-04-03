class_name CommandModule
extends Resource
## Logic module designed to manage all processes and information related to running
## commands through the debug terminal.
##
## Contains a list of accepted commands and the logic for detecting and executing each.

## Class representing a single command: its name, parameters, and examples of its usage.
class CommandConfig:
	## Description of the command and its utility.
	var description : String
	## Expected parameters of the command, and a brief description of each.
	var parameters : String
	## Examples of how to use the command.
	var examples : Array[String]
	## The callable to execute when this command is entered.
	var logic : Callable

	func _init(
			cc_description := "No description provided",
			cc_parameters := "None",
			cc_examples : Array[String] = [],
			cc_logic : Callable = func (_params : Array[String]): return
		):
		description = cc_description
		parameters = cc_parameters
		examples = cc_examples
		logic = cc_logic
	
	func _to_string() -> String:
		return "-- " + description + '\n-- Parameters: ' + parameters + '\n-- e.g. ' + ', '.join(examples)

## Dictionary mapping command names to corresponding information, structured as `CommandConfig` instances, as defined below.
var commands : Dictionary[StringName, CommandConfig] = {
	"help": CommandConfig.new(
			"Logs to the console all available commands, their descriptions, expected parameters, and examples of how to use them",
			"None",
			["help"],
			func (_params): help()
	),
	"echo": CommandConfig.new(
			"Prints a message to the console",
			"Pass any text following the command to echo it to the console",
			["echo this", "echo that", "echo this and that"],
			func (params): _console.print(" ".join(params))
	),
	"clear": CommandConfig.new(
			"Clears the debug console",
			"None",
			["clear"],
			func (_params): _console.clear()
	),
	"exit": CommandConfig.new(
			"Instantly exits the game and ends the process",
			"None",
			["exit"],
			func (_params): _console.get_tree().quit(0)
	)
}
## The debug console for use with the above commands.
var _console : DebugConsole


func _init(console : DebugConsole):
	_console = console


## Primary function for initiating a command from the terminal, or reporting an error if no matching command is found.
func run(full_command : String) -> void:
	_console.print(full_command)
	var params = Array(full_command.split(' '))
	var command_name = params.pop_front()
	if commands.has(command_name):
		commands[command_name].logic.call(params)
	else:
		_console.error("ERROR: Command '" + command_name + "' Not found. Run 'help' for a list of commands")


## Function for logging the `commands` dictionary to the terminal in a human readable form, as the result of the `help` command.
func help() -> void:
	var result = []
	for key in commands.keys():
		result.append(key)
		result.append(commands[key].to_string())
	_console.print(result)
