@tool
class_name Interactable extends Area3D

# EXPORTS
@export_group('Collision')
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

@export_group("Config")
@export var interact_button : InputEventKey
@export var max_distance : = 2.0
@export var message: String

# SIGNALS
signal interacted(interactor : Player)

# FUNCS
func interact(interactor : Player):
	interacted.emit(interactor)

# NODES
@onready var COLLISION = %CollisionShape3D

# BUILT INS
# this seems to be necessary for nested interactables, as is the case with Doors
func _ready():
	COLLISION.shape = shape
	COLLISION.position = collision_position