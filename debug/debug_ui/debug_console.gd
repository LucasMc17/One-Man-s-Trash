class_name DebugConsole
extends PanelContainer
## Debug Console, containing functions for logging, printing warnings and errors, and instantiating logic for all commands.

@onready var _history = %History
@onready var _command_line = %CommandLine

## Array representing the history of commands issued to the console by the user.
var _command_history := []
## A pointer indicating position within the `_command_history` array when tabbing through past commands via the arrow keys.
var _history_pointer
## Logic module for command interface
var _commands = CommandModule.new(self)
# TODO:  Give up on the single global scene approach. We'll need a separate global Debug node, like Cryptr.

func _ready():
	# TODO: This whole file needs an overhaul. See how Cryptr does it, I no longer like this format. 
	# In particular, I feel like we shouldn't need this next line, and the commands for logging to the terminal should live here, not on `Debug`
	Debug.debug_console = self
	for command in Debug.print_queue:
		Debug.log(command.message, command.min_log_level)
	Debug.print_queue.clear()
	if Debug.debug_override == "DEFER":
		visible = Debug.show_debug_console
	Debug.log('---CONSOLE READY---', 1)


func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_command_line.grab_focus()


func _input(_event):
	if _command_line.has_focus() and Input.is_action_just_pressed("up"):
		if _history_pointer == 0:
			return
		if _history_pointer != null and _history_pointer > 0:
			_get_from_history(_history_pointer - 1)
			return
		elif !_history_pointer and _command_history.size() > 0:
			_get_from_history(_command_history.size() - 1)
			return
	elif _command_line.has_focus() and Input.is_action_just_pressed("down"):
		if _history_pointer != null and _history_pointer < _command_history.size() - 1:
			_get_from_history(_history_pointer + 1)
			return


## Clears the console.
func clear() -> void:
	_history.text = ''


## Prints a single data point or a sequence as an array to the terminal.
func print(message : Variant) -> void:
		# NOTE: this could get much more in depth but this will do for now
		if message is Array:
			for i in message.size():
				var element = message[i]
				var prefix = ''
				if i == 0:
					prefix = '> '
				_history.text += '\n' + prefix + str(element)
				print(element)
		else:
			_history.text += '\n' + '>' + str(message)
			print(message)


## Wrapper function of print which also pushes a warning to the godot terminal AND the in game console.
func warn(message) -> void:
	push_warning(message)
	self.print(message)


## Wrapper function of print which also pushes an error to the godot terminal AND the in game console.
func error(message) -> void:
	push_error(message)
	self.print(message)


## Utilizes the `_history_pointer` to find a command from the `_command_history`.
func _get_from_history(pointer : int) -> void:
	_history_pointer = pointer
	_command_line.text = _command_history[pointer]
	_command_line.call_deferred("set_caret_column", 1000)


## Signal listener for text input.
func _on_command_line_text_submitted(new_text) -> void:
	_command_history.append(new_text)
	_history_pointer = null
	_commands.run(new_text)
	_command_line.text = ''


## Event listener.
func _on_history_gui_input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_command_line.call_deferred("grab_focus")
