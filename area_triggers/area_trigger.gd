class_name AreaTrigger extends Area3D

signal entered(area, body)
signal exited(area, body)

@export_group('Triggers')
@export var INCLUDED : Array[Node3D]
@export var INCLUDED_BY_NAME : Array[StringName]
@export var INCLUDED_BY_GROUP : Array[StringName]

var DEBUG_LABEL : DebugLabel

func make_label():
	return "\n".join([
		"AREA TRIGGER listening for:",
		"SCENES: " + ", ".join([", ".join(INCLUDED.map(func (scene): return scene.name)), ", ".join(INCLUDED_BY_NAME)]),
		"GROUPS: " + ", ".join(INCLUDED_BY_GROUP)
	])

func _ready():
	# NOTE: Not sure why i have to do it this way. Something about inheritance makes regular onready var not work in inherited classes
	DEBUG_LABEL = get_node('DebugLabel')
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	if DEBUG_LABEL:
		DEBUG_LABEL.TEXT = self.make_label()

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
