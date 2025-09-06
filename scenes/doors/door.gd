@tool
class_name Door extends Node3D

# GLOBALS
var target_rotation := 0.0

@export_category("Status")
@export var is_locked := false
@export var is_open := false:
	set(val):
		if DOOR_BODY:
			if val:
				target_rotation = deg_to_rad(open_degrees)
				INTERACTABLE.message = "Press [E] to close"
			else:
				target_rotation = 0.0
				INTERACTABLE.message = "Press [E] to open"
		is_open = val

@export_category("Positioning")
@export var pivot_position := 0.5:
	set(val):
		if DOOR_BODY:
			if !pivot_from_right:
				DOOR_BODY.position.x = -1.0 * val
			else:
				DOOR_BODY.position.x = val
		pivot_position = val
@export var pivot_from_right := true:
	set(val):
		if DOOR_BODY:
			if val:
				DOOR_BODY.position.x = pivot_position
			else:
				DOOR_BODY.position.x = -1.0 * pivot_position
		pivot_from_right = val
@export var open_degrees := 90.0

@export_category("Model Info")
@export var mesh : Mesh:
	set(val):
		if DOOR_MESH:
			DOOR_MESH.mesh = val
		mesh = val
@export var mesh_position := Vector3.ZERO:
	set(val):
		if DOOR_MESH:
			DOOR_MESH.position = val
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
			COLLISION_SHAPE.scale = Vector3(0.95, 0.95, 0.95)
		if INTERACTABLE:
			INTERACTABLE.shape = val
		collision_shape = val

@onready var DOOR_BODY = %DoorBody
@onready var DOOR_MESH = %DoorMesh
@onready var COLLISION_SHAPE = %CollisionShape
@onready var INTERACTABLE = %Interactable

# BUILT INS
func _ready():
	is_open = is_open
	
func _physics_process(_delta):
	DOOR_BODY.rotation.y = lerp(DOOR_BODY.rotation.y, target_rotation, 0.1)

func _on_interactable_interacted(_interactor:Player):
	if is_open:
		is_open = false
	elif !is_locked:
		is_open = true
