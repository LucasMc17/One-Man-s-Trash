@tool
class_name DebugBlock extends StaticBody3D

# EXPORTS
@export_category("Dimensions")
@export var size := Vector3(1, 1, 1)

# NODES
@onready var MESH = %MeshInstance3D
@onready var COLLISION = %CollisionShape3D

func _ready():
	if !Engine.is_editor_hint():
		MESH.mesh.size = size
		COLLISION.shape.size = size

func _process(_delta):
	if Engine.is_editor_hint():
		MESH.mesh.size = size
		COLLISION.shape.size = size
