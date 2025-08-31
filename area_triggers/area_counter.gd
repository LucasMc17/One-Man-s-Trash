class_name AreaCounter extends AreaTrigger

signal filled()
signal unfilled()

@export var LIMIT : int

var COUNT := 0
var FILLED := false

func handle_entered(body : Node3D):
	super(body)
	COUNT += 1
	if LIMIT > 0 && COUNT >= LIMIT:
		FILLED = true
		filled.emit()


func handle_exited(body : Node3D):
	super(body)
	if LIMIT > 0 && LIMIT == COUNT:
		FILLED = false
		unfilled.emit()
	COUNT -= 1