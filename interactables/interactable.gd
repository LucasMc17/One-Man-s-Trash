@tool
class_name Interactable extends Area3D

# EXPORTS
@export var shape : Shape3D:
	set(val):
		if COLLISION:
			COLLISION.shape = val
		shape = val
@export var collision_position := Vector3.ZERO:
	set(val):
		if COLLISION:
			COLLISION.position = val
		collision_position = val

# NODES
@onready var COLLISION = %CollisionShape3D