@tool
class_name DebugLabel extends Sprite3D

@onready var LABEL := %Label
@onready var VIEWPORT := %SubViewport

@export var VP_SIZE := Vector2i(500,500):
	set(val):
		print(VIEWPORT)
		if VIEWPORT:
			VIEWPORT.size = val
		VP_SIZE = val
@export_multiline var TEXT := "":
	set(val):
		if LABEL:
			LABEL.text = val
		TEXT = val

func _ready():
	TEXT = TEXT
	VP_SIZE = VP_SIZE
