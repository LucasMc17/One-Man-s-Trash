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
		collision_position = val
@export var collision_size := Vector3.ONE:
	set(val):
		if COLLISION_SHAPE:
			COLLISION_SHAPE.shape.size = val
		collision_size = val

# NODES
@onready var SIT_MARKER = %SitMarker
@onready var EYELINE_MARKER = %EyelineMarker
@onready var CHAIR_MESH = %ChairMesh
@onready var COLLISION_SHAPE = %CollisionShape

# GLOBALS
var true_sit_position := Vector3(0, 0.5, 0)

# BUILT INS
# func _process(_delta):
# 	SIT_MARKER.position = sit_position
# 	EYELINE_MARKER.position = true_sit_position
