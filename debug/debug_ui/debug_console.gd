class_name DebugConsole extends Panel

# NODES
@onready var History = %History
@onready var CommandLine = %CommandLine

# GLOBALS
var command_history := []
var history_pointer

# FUNCS
func get_from_history(pointer : int):
	history_pointer = pointer
	CommandLine.text = command_history[pointer]
	CommandLine.set_caret_column(1000)

# BUILT INS
func _ready():
	Global.Debug.DEBUG_CONSOLE = self
	if Global.Debug.debug_override == "DEFER":
		visible = Global.Debug.show_debug_console

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		CommandLine.grab_focus()

func _input(_event):
	if CommandLine.has_focus() and Input.is_action_just_pressed("up"):
		if history_pointer == 0:
			return
		if history_pointer != null and history_pointer > 0:
			get_from_history(history_pointer - 1)
			return
		elif !history_pointer and command_history.size() > 0:
			get_from_history(command_history.size() - 1)
			return
	elif CommandLine.has_focus() and Input.is_action_just_pressed("down"):
		if history_pointer != null and history_pointer < command_history.size() - 1:
			get_from_history(history_pointer + 1)
			return

# SIGNAL LISTENERS
func _on_command_line_text_submitted(new_text):
	command_history.append(new_text)
	history_pointer = null
	var inputs = Array(new_text.split(' '))
	var command_name = inputs.pop_front()
	# Debug.command(command_name, inputs, 'Query: ' + new_text)
	
	CommandLine.text = ''
