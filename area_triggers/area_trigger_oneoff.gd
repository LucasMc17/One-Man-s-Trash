class_name AreaTriggerOneoff
extends AreaTrigger
## AreaTrigger which disables itself after being entered once by elligible actor.

## Boolean tracking whether the trigger is still listening for its elligible actor(s).
@export var _listening := true:
	set(val):
		set_deferred("monitoring", val)
		_listening = val
		_debug_label.change_param('listening', "TRUE" if val else "FALSE")

func _ready():
	super()
	_debug_label.change_param('listening', 'TRUE')


func _handle_entered(body : Node3D):
	super(body)
	_listening = false

# REFACTORED TO BEST PRACTICE, MARCH 2026