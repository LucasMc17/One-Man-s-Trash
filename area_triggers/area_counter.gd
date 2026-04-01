class_name AreaCounter
extends AreaTrigger
## AreaTrigger which tracks the number of elligible items currently inside of it.
## Can optionally have a limit and a unique signal when that limit is reached (or unreached)

## Signal emitted when the `_limit` is reached (if configured).
signal filled()
## Signal emitted when the number of present actors dips below the `_limit` after previously reaching it.
signal unfilled()

## The optional limit to the number of actors the trigger listens for before firing the `filled` signal.
@export var _limit : int

## The current count of elligible actors within the Trigger.
var _count := 0
## Boolean representing whether or not the `_count` is greater than or equal to the `_limit`.
var _filled := false

func _ready():
	super()
	_debug_label.change_param('count', _make_count())
	_debug_label.change_param('filled', "FALSE")


func _handle_entered(body : Node3D):
	super(body)
	_count += 1
	if _limit > 0 && _count >= _limit:
		_filled = true
		filled.emit()
	_debug_label.change_param('count', _make_count())
	_debug_label.change_param('filled', "TRUE" if _filled else "FALSE")


func _handle_exited(body : Node3D):
	super(body)
	if _limit > 0 && _limit == _count:
		_filled = false
		unfilled.emit()
	_count -= 1
	_debug_label.change_param('count', _make_count())
	_debug_label.change_param('filled', "TRUE" if _filled else "FALSE")


## Formats the string representing the count in the debug label.
func _make_count():
	if _limit < 1:
		return str(_count)
	else:
		return str(_count) + ' / ' + str(_limit)
