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
	# set(val):
	# 	PARAMS = val
	# 	write_label()

func change_param(param : String, new_value : String):
	# if PARAMS.has(param):
	PARAMS[param] = new_value
	write_label()

func write_label():
	var formatted = TEXT.format(PARAMS)
	# Global.log([TEXT, PARAMS, formatted])
	if LABEL:
		# Global.log("YUP")
		LABEL.text = formatted

func _ready():
	# var TEXTURE = ViewportTexture.new()
	# print("TEXTURE ", TEXTURE)
	# TEXTURE.viewport_path = get_path_to(VIEWPORT)
	# print("PATH ", TEXTURE.viewport_path)
	# texture = TEXTURE
	texture = VIEWPORT.get_texture()
	# TEXT = TEXT
	write_label()
	VP_SIZE = VP_SIZE
