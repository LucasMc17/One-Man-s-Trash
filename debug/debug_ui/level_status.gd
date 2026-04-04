class_name LevelStatus
extends HBoxContainer
## A debug UI module representing the current level state, and information about it.[br]
## Also keeps track of the level's Timer, if it has one.

var _timer : Timer

@onready var _level_states := %LevelStates
@onready var _state := %State
@onready var _time_left := %Timer

func _ready():
	Debug.level_status = self
	if Debug.debug_override == "DEFER":
		visible = Debug.show_level_status
	Events.level_state_changed.connect(_on_level_state_changed)
	Events.level_loaded.connect(_populate_states)


func _process(_delta):
	if _timer is Timer:
		_time_left.text = str(_timer.time_left).left(5)
	else:
		_time_left.text = '0.0'


## Event listener for the global `level_state_changed` signal.
func _on_level_state_changed(new_state : LevelState) -> void:
	_state.text = new_state.name
	if new_state is LevelWaitState:
		_timer = new_state.timer
	else:
		_timer = null


## Populates the menu with all states in current level, should run once when the level is first loaded.
func _populate_states() -> void:
	for child in _level_states.get_children():
		child.queue_free()
	for level_state in World.current_level.state_machine.states.values():
		if level_state is LevelState:
			var button_scene = Button.new()
			button_scene.text = level_state.name
			button_scene.pressed.connect(func(): World.current_level.current_state.transition(level_state.name))
			_level_states.add_child(button_scene)

