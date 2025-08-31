class_name AreaTriggerOneoff extends AreaTrigger

func handle_entered(body : Node3D):
	super(body)
	set_deferred("monitoring", false)
