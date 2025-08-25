@tool
class_name Chair extends StaticBody3D

# EXPORTS
@export_category("Positioning")
@export var sit_position := Vector3.ZERO:
	set(val):
		true_sit_position = val
		true_sit_position.y += 1
		sit_position = val
		if SIT_MARKER:
			SIT_MARKER.position = sit_position
		if EYELINE_MARKER:
			EYELINE_MARKER.position = true_sit_position
@export var get_off_position := Vector3(-1, 0, 0):
	set(val):
		if GET_OFF_MARKER:
			GET_OFF_MARKER.position = val
		get_off_position = val

@export_category("Model Info")
@export var mesh : Mesh:
	set(val):
		if CHAIR_MESH:
			CHAIR_MESH.mesh = val
		mesh = val
@export var mesh_position := Vector3.ZERO:
	set(val):
		if CHAIR_MESH:
			CHAIR_MESH.position = val
		mesh_position = val

@export_category("Collision Info")
@export var collision_position := Vector3.ZERO:
	set(val):
		if COLLISION_SHAPE:
			COLLISION_SHAPE.position = val
		if INTERACTABLE:
			INTERACTABLE.collision_position = val
		collision_position = val
@export var collision_shape : Shape3D:
	set(val):
		if COLLISION_SHAPE:
			COLLISION_SHAPE.shape = val
		if INTERACTABLE:
			INTERACTABLE.shape = val
		collision_shape = val

# NODES
@onready var SIT_MARKER = %SitMarker
@onready var EYELINE_MARKER = %EyelineMarker
@onready var CHAIR_MESH = %ChairMesh
@onready var COLLISION_SHAPE = %CollisionShape
@onready var INTERACTABLE = %Interactable
@onready var GET_OFF_MARKER = %GetOffMarker

# GLOBALS
var true_sit_position := Vector3(0, 0.5, 0)

# BUILT INS
func _ready():
	# force subscenes to access set functions
	collision_shape = collision_shape
	collision_position = collision_position

func _on_interactable_interacted(interactor : Player):
	interactor.current_movement.transition('Sit', { "seat": self, "get_off_position": interactor.position })
