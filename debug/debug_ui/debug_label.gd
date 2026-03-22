@tool
class_name DebugLabel
extends Sprite3D
## Debug Label displaying information about an actor in the scene in 3d space. [br]
## Is visible through walls.

@onready var _label := %Label
@onready var _viewport := %SubViewport

# TODO: Can this be automated based on the size of the UI elements the viewport turns into its texture?
## The size of the viewport to render into 3D space as the label.
@export var _viewport_size := Vector2i(500,500):
	set(val):
		if _viewport:
			_viewport.size = val
		_viewport_size = val
## The text of the label. Designed to be formatted based on the parameters in the `params` object below and so can include variable names like `{this}`.
@export_multiline var _text := "Example text:\nLOREM IPSUM\nFOO BAR":
	set(val):
		_text = val
		_write_label()

## The parameters actively in use in the label formatting.
var _params := {}

func _ready():
	texture = _viewport.get_texture()
	_write_label()
	_viewport_size = _viewport_size


## Update a parameter in the `_params` object and reformat the label. This is the main function which should be used to update the label from external contexts.
func change_param(param : String, new_value : String) -> void:
	_params[param] = new_value
	_write_label()


## Utility function to update the text of the label with the latest parameters.
func _write_label() -> void:
	var formatted = _text.format(_params)
	if _label:
		_label.text = formatted

# REFACTORED TO BEST PRACTICE, MARCH 2026