extends HBoxContainer

@onready var TIME := %Time

func _ready():
	Events.time_changed.connect(_on_time_changed)

func _on_time_changed(new_time : String):
	TIME.text = new_time