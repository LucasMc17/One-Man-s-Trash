extends TextureButton

## The name of this app.
@export var _app_name := "App Name"
## The state which this app should switch the phone to when clicked.
@export var _state_name := "StateName"

## Whether this icon should display a red notification circle.
var has_notification := false:
	set(val):
		if _notification_circle:
			_notification_circle.visible = val
		has_notification = val

@onready var _notification_circle = %NotificationCircle
@onready var _label = %Label

func _ready():
	_label.text = _app_name


## Event listener.
func _pressed():
	World.player_phone.current_state.transition(_state_name)
