@tool
extends PanelContainer

@export_multiline var MESSAGE := "":
	set(val):
		if TEXT:
			TEXT.text = val
			var text_size = TEXT.theme.get_font("default_font", "").get_string_size(val, 0, -1, 40)
			if text_size.x > 888:
				TEXT.custom_minimum_size.x = 888
			else:
				TEXT.custom_minimum_size.x = text_size.x
		MESSAGE = val
@onready var TEXT = %Text

func _ready():
	MESSAGE = MESSAGE
