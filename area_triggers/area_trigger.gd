class_name AreaTrigger
extends Area3D
## 3D trigger area which listens for a specific actor and emits a signal when entered or exited.

## Signal emitted when the AreaTrigger is entered by one of the specific actors it listens for.
signal entered(area, body)
## Signal emitted when the AreaTrigger is exited by one of the specific actors it listens for.
signal exited(area, body)

@export_group('Triggers')
## List of listened for actors by direct reference to other instantiated scenes in world.
@export var INCLUDED : Array[Node3D]
## List of listened for actors by scene name.
@export var INCLUDED_BY_NAME : Array[StringName]
## List of listened for actors by group name.
@export var INCLUDED_BY_GROUP : Array[StringName]

## Label representing real time info to the user.
@onready var _debug_label : DebugLabel = %DebugLabel

func _ready():
	visible = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	_debug_label.change_param('scenes', ", ".join((INCLUDED).map(func (scene): return scene.name) + INCLUDED_BY_NAME))
	_debug_label.change_param('groups', ", ".join(INCLUDED_BY_GROUP))


## Utility function for determining if the body which has just interacted with the trigger is listened for or not.
func _check_elligibility(body : Node3D) -> bool:
	if INCLUDED.has(body):
		return true
	if INCLUDED_BY_NAME.has(body.name):
		return true
	var body_groups = body.get_groups()
	for group in INCLUDED_BY_GROUP:
		if body_groups.has(group):
			return true
	return false


## Signal listner.
func _on_body_entered(body : Node3D):
	if _check_elligibility(body):
		entered.emit(self, body)
		_handle_entered(body)


## Signal listner.
func _on_body_exited(body : Node3D):
	if _check_elligibility(body):
		exited.emit(self, body)
		_handle_exited(body)


## Function for unique behavior when entered by elligible actor, beyond emitting signal.[br]
## To be extended by inheriting classes.
func _handle_entered(_body : Node3D) -> void:
	pass


## Function for unique behavior when exited by elligible actor, beyond emitting signal.[br]
## To be extended by inheriting classes.
func _handle_exited(_body : Node3D) -> void:
	pass

# REFACTORED TO BEST PRACTICE, MARCH 2026