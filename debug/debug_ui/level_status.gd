class_name LevelStatus extends HBoxContainer

var TIMER : Timer

@onready var LEVEL_STATES = %LevelStates

@onready var STATE = %State
var state : StringName:
	set(val):
		STATE.text = val
		state = val

@onready var TIME_LEFT = %Timer
var time_left : String:
	set(val):
		TIME_LEFT.text = val
		time_left = val

func _ready():
	Global.Debug.LEVEL_STATUS = self
	if Global.Debug.debug_override == "DEFER":
		visible = Global.Debug.show_level_status
	Events.level_state_changed.connect(on_level_state_changed)
	Events.level_loaded.connect(populate_states)

func on_level_state_changed(new_state : LevelState):
	state = new_state.name
	if new_state is LevelWaitState:
		TIMER = new_state.TIMER
	else:
		TIMER = null

func _process(_delta):
	if TIMER is Timer:
		time_left = str(TIMER.time_left).left(5)
	else:
		time_left = '0.0'

func populate_states():
	for child in LEVEL_STATES.get_children():
		child.queue_free()
	for level_state in Global.LEVEL.STATE_MACHINE.states.values():
		if level_state is LevelState:
			var button_scene = Button.new()
			button_scene.text = level_state.name
			button_scene.pressed.connect(func(): Global.LEVEL.CURRENT_STATE.transition(level_state.name))
			LEVEL_STATES.add_child(button_scene)
