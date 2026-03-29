extends PanelContainer

## The text of the message.
var message := ""

@onready var _text := %Text

func _ready():
	_format_message()


## Utility function for filling the message text into the label, and calculating width.
func _format_message() -> void:
	_text.text = message
	var text_size = _text.theme.get_font("default_font", "").get_string_size(message, 0, -1, 40)
	if text_size.x > 888:
		_text.custom_minimum_size.x = 888
	else:
		_text.custom_minimum_size.x = text_size.x