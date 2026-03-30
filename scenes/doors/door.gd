@tool
class_name Door
extends Node3D
## A class representing a door which can be interacted with to open or close by the player.
## Allows for custom behavior around locking, model, size, and degree of rotation when open/closed.

@export_category("Status")
## Whether the door is currently locked.
@export var is_locked := false
## Whether the door is currently open.
@export var is_open := false:
	set(val):
		if _door_body:
			if val:
				_target_rotation = deg_to_rad(_open_degrees)
				_interactable.message = "Press [E] to close"
			else:
				_target_rotation = 0.0
				_interactable.message = "Press [E] to open"
		is_open = val

@export_category("Positioning")
## The point that the door should rotate from when opening or closing. Analogous to hinges.
@export var _pivot_position := 0.5:
	set(val):
		if _door_body:
			if !_pivot_from_right:
				_door_body.position.x = -1.0 * val
			else:
				_door_body.position.x = val
		_pivot_position = val
## Whether the door should pivot from its right side or its left.
@export var _pivot_from_right := true:
	set(val):
		if _door_body:
			if val:
				_door_body.position.x = _pivot_position
			else:
				_door_body.position.x = -1.0 * _pivot_position
		_pivot_from_right = val
## How far in degrees the door should rotate when open.
@export var _open_degrees := 90.0

@export_category("Model Info")
## The mesh to represent this door with.
@export var _mesh : Mesh:
	set(val):
		if _door_mesh:
			_door_mesh._mesh = val
		_mesh = val
## The position of the mesh.
@export var _mesh_position := Vector3.ZERO:
	set(val):
		if _door_mesh:
			_door_mesh.position = val
		_mesh_position = val

@export_category("Collision Info")
## The position of the collider for this door.
@export var _collision_position := Vector3.ZERO:
	set(val):
		if _door_collision_shape:
			_door_collision_shape.position = val
		if _interactable:
			_interactable._collision_position = val
		_collision_position = val
## The shape of the collider for this door.
@export var _collision_shape : Shape3D:
	set(val):
		if _door_collision_shape:
			_door_collision_shape.shape = val
			_door_collision_shape.scale = Vector3(0.95, 0.95, 0.95)
		if _interactable:
			_interactable.shape = val
		_collision_shape = val

## The rotation to which the door should be actively moving.
var _target_rotation := 0.0

@onready var _door_body : AnimatableBody3D = %DoorBody
@onready var _door_mesh : MeshInstance3D= %DoorMesh
@onready var _door_collision_shape : CollisionShape3D= %CollisionShape
@onready var _interactable = %Interactable

func _ready():
	is_open = is_open


func _physics_process(_delta):
	_door_body.rotation.y = lerp(_door_body.rotation.y, _target_rotation, 0.1)


## Event listener.
func _on_interactable_interacted(_interactor:Player):
	if is_open:
		is_open = false
	elif !is_locked:
		is_open = true
