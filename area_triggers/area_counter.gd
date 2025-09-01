class_name AreaCounter extends AreaTrigger

signal filled()
signal unfilled()

# @onready var DEBUG_LABEL := %DebugLabel

@export var LIMIT : int

var COUNT := 0
var FILLED := false

func make_label():
	return "\n".join([
		"AREA COUNTER listening for:",
		"SCENES: " + ", ".join([", ".join(INCLUDED.map(func (scene): return scene.name)), ", ".join(INCLUDED_BY_NAME)]),
		"GROUPS: " + ", ".join(INCLUDED_BY_GROUP),
		"",
		str(COUNT) + ((" / " + str(LIMIT)) if LIMIT > 0 else "") + " DETECTED",
		"FILLED: " + ("TRUE" if FILLED else "FALSE")
	])

func handle_entered(body : Node3D):
	super(body)
	COUNT += 1
	if LIMIT > 0 && COUNT >= LIMIT:
		FILLED = true
		filled.emit()
	DEBUG_LABEL.TEXT = make_label()


func handle_exited(body : Node3D):
	super(body)
	if LIMIT > 0 && LIMIT == COUNT:
		FILLED = false
		unfilled.emit()
	COUNT -= 1
	DEBUG_LABEL.TEXT = make_label()
