@tool
class_name DebugLabel extends Sprite3D

@onready var LABEL := %Label
@onready var VIEWPORT := %SubViewport

@export var VP_SIZE := Vector2i(500,500):
	set(val):
		if VIEWPORT:
			VIEWPORT.size = val
		VP_SIZE = val
@export_multiline var TEXT := "":
	set(val):
		TEXT = val
		write_label()

var PARAMS := {}

func change_param(param : String, new_value : String):
	PARAMS[param] = new_value
	write_label()

func write_label():
	var formatted = TEXT.format(PARAMS)
	if LABEL:
		LABEL.text = formatted

func _ready():
	texture = VIEWPORT.get_texture()
	write_label()
	VP_SIZE = VP_SIZE
