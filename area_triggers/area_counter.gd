class_name AreaCounter extends AreaTrigger

signal filled()
signal unfilled()

@export var LIMIT : int

var COUNT := 0
var FILLED := false

func _ready():
	super()
	DEBUG_LABEL.change_param('count', make_count())
	DEBUG_LABEL.change_param('filled', "FALSE")

func make_count():
	if LIMIT < 1:
		return str(COUNT)
	else:
		return str(COUNT) + ' / ' + str(LIMIT)

func handle_entered(body : Node3D):
	super(body)
	COUNT += 1
	if LIMIT > 0 && COUNT >= LIMIT:
		FILLED = true
		filled.emit()
	DEBUG_LABEL.change_param('count', make_count())
	DEBUG_LABEL.change_param('filled', "TRUE" if FILLED else "FALSE")

func handle_exited(body : Node3D):
	super(body)
	if LIMIT > 0 && LIMIT == COUNT:
		FILLED = false
		unfilled.emit()
	COUNT -= 1
	DEBUG_LABEL.change_param('count', make_count())
	DEBUG_LABEL.change_param('filled', "TRUE" if FILLED else "FALSE")
