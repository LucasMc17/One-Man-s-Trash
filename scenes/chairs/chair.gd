@tool
class_name Chair
extends StaticBody3D
## Utility scene representing a chair which can be sat on by the player or an NPC with the sit movement state.

@export_category("Positioning")
## The position which the actor will move to when seated. Place at the top of the seat in 3D space.
@export var sit_position := Vector3.ZERO:
	set(val):
		_true_sit_position = val
		_true_sit_position.y += 1
		sit_position = val
		if _sit_marker:
			_sit_marker.position = sit_position
		if _eyeline_marker:
			_eyeline_marker.position = _true_sit_position
## The position which the actor will move to when leaving the sitting state.
@export var get_off_position := Vector3(-1, 0, 0):
	set(val):
		if _get_off_marker:
			_get_off_marker.position = val
		get_off_position = val

@export_category("Model Info")
# TODO: migrate the below to private properties.
## The 3D mesh which the chair will use as a model in game.
@export var mesh : Mesh:
	set(val):
		if _chair_mesh_instance:
			_chair_mesh_instance.mesh = val
		mesh = val
@export var mesh_position := Vector3.ZERO:
	set(val):
		if _chair_mesh_instance:
			_chair_mesh_instance.position = val
		mesh_position = val

@export_category("Collision Info")
## The position of the collision shape for this chair
@export var collision_position := Vector3.ZERO:
	set(val):
		if _collision_shape_instance:
			_collision_shape_instance.position = val
		if interactable:
			interactable.collision_position = val
		collision_position = val
## The shape of the collision object for this chair.
@export var collision_shape : Shape3D:
	set(val):
		if _collision_shape_instance:
			_collision_shape_instance.shape = val
			# NOTE: Forces the collision shape to be slightly smaller than the interact box so the player interactor can still see it
			_collision_shape_instance.scale = Vector3(0.95, 0.95, 0.95)
		if interactable:
			interactable.shape = val
		collision_shape = val

var _true_sit_position := Vector3(0, 0.5, 0)

@onready var interactable = %Interactable
@onready var _sit_marker = %SitMarker
@onready var _eyeline_marker = %EyelineMarker
@onready var _chair_mesh_instance = %ChairMesh
@onready var _collision_shape_instance = %CollisionShape
@onready var _get_off_marker = %GetOffMarker

func _ready():
	# force subscenes to access set functions
	collision_shape = collision_shape
	collision_position = collision_position

## Signal listener for interactable.
func _on_interactable_interacted(interactor : Player):
	interactor.current_movement.transition('Sit', { "seat": self, "get_off_position": interactor.position })
