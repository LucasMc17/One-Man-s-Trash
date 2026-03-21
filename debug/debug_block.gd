@tool
class_name DebugBlock extends StaticBody3D

# EXPORTS
@export_category("Material")
@export var material : Material:
	set(val):
		material = val
		set_properties()
@export_category("Dimensions")
@export var size := Vector3(1, 1, 1):
	set(val):
		size = val
		set_properties()

# NODES
@onready var MESH = %MeshInstance3D
@onready var COLLISION = %CollisionShape3D

func _ready():
	# if !Engine.is_editor_hint():
	set_properties()

# func _process(_delta):
# 	if Engine.is_editor_hint():
# 		set_properties()

func set_properties():
	if MESH:
		MESH.mesh.size = size
		MESH.mesh.material = material
	if COLLISION:
		COLLISION.shape.size = size
