@tool
class_name DebugBlock
extends StaticBody3D
## Block with collision and texture for blocking out levels.

# EXPORTS
@export_category("Material")
# The material to apply uniformly to this block.
@export var material : Material:
	set(val):
		material = val
		_set_properties()
@export_category("Dimensions")
# NOTE: should we have the origin of these blocks be at a corner so as to avoid adding size from the center?
## The size of the block.
@export var size := Vector3(1, 1, 1):
	set(val):
		size = val
		_set_properties()

@onready var _mesh := %MeshInstance3D
@onready var _collision := %CollisionShape3D

func _ready():
	_set_properties()


## Update the block with the latest size and materials.
func _set_properties():
	if _mesh:
		_mesh.mesh.size = size
		_mesh.mesh.material = material
	if _collision:
		_collision.shape.size = size

# REFACTORED TO BEST PRACTICE, MARCH 2026