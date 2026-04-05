extends HBoxContainer

@onready var _time := %Time

func _ready():
	Events.time_changed.connect(_on_time_changed)


## Event listener for global signal.
func _on_time_changed(new_time : String):
	_time.text = new_time