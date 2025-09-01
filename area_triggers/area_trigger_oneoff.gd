class_name AreaTriggerOneoff extends AreaTrigger

# @onready var DEBUG_LABEL = %DebugLabel

@export var LISTENING := true:
	set(val):
		set_deferred("monitoring", val)
		LISTENING = val
		DEBUG_LABEL.TEXT = make_label()
	

func make_label():
	return "\n".join([
		"AREA TRIGGER listening for:",
		"SCENES: " + ", ".join([", ".join(INCLUDED.map(func (scene): return scene.name)), ", ".join(INCLUDED_BY_NAME)]),
		"GROUPS: " + ", ".join(INCLUDED_BY_GROUP),
		"",
		"LISTENING: " + ("TRUE" if LISTENING else "FALSE")
	])

func handle_entered(body : Node3D):
	super(body)
	LISTENING = false
