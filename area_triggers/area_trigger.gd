class_name AreaTrigger extends Area3D

signal entered(area, body)
signal exited(area, body)

@export_group('Triggers')
@export var INCLUDED : Array[Node3D]
@export var INCLUDED_BY_NAME : Array[StringName]
@export var INCLUDED_BY_GROUP : Array[StringName]

var DEBUG_LABEL : DebugLabel

func _ready():
	# NOTE: Not sure why i have to do it this way. Something about inheritance makes regular onready var not work in inherited classes
	DEBUG_LABEL = get_node('DebugLabel')
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if DEBUG_LABEL:
		DEBUG_LABEL.change_param('scenes', ", ".join((INCLUDED + INCLUDED_BY_NAME).map(func (scene): return scene.name)))
		DEBUG_LABEL.change_param('groups', ", ".join(INCLUDED_BY_GROUP))

	# if DEBUG_LABEL:
		# Global.log(make_label())
		# DEBUG_LABEL.TEXT = self.make_label()

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
