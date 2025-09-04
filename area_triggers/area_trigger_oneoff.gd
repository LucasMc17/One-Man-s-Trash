class_name AreaTriggerOneoff extends AreaTrigger

@export var LISTENING := true:
	set(val):
		set_deferred("monitoring", val)
		LISTENING = val
		DEBUG_LABEL.change_param('listening', "TRUE" if val else "FALSE")
	
func _ready():
	super()
	DEBUG_LABEL.change_param('listening', 'TRUE')

func handle_entered(body : Node3D):
	super(body)
	LISTENING = false
