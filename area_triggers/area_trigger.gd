class_name AreaTrigger extends Area3D

signal entered(area, body)
signal exited(area, body)

@export_group('Triggers')
@export var INCLUDED : Array[Node3D]
@export var INCLUDED_BY_NAME : Array[StringName]
@export var INCLUDED_BY_GROUP : Array[StringName]

@onready var DEBUG_LABEL = %DebugLabel

func _ready():
	visible = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	DEBUG_LABEL.change_param('scenes', ", ".join((INCLUDED).map(func (scene): return scene.name) + INCLUDED_BY_NAME))
	DEBUG_LABEL.change_param('groups', ", ".join(INCLUDED_BY_GROUP))

func check_elligibility(body : Node3D) -> bool:
	if INCLUDED.has(body):
		return true
	if INCLUDED_BY_NAME.has(body.name):
		return true
	var body_groups = body.get_groups()
	for group in INCLUDED_BY_GROUP:
		if body_groups.has(group):
			return true
	return false

func _on_body_entered(body : Node3D):
	if check_elligibility(body):
		entered.emit(self, body)
		handle_entered(body)

func _on_body_exited(body : Node3D):
	if check_elligibility(body):
		exited.emit(self, body)
		handle_exited(body)

func handle_entered(body : Node3D):
	pass

func handle_exited(body : Node3D):
	pass
