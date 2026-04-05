@tool
class_name Interactable
extends Area3D
## Utility class for objects which the player can interact with.[br]
## Works by applying a collision shape which the player's interaction wand can collide with.[br]
## Designed to be extended by inheriting classes with more complicated rules for when an object can be interacted, or used as is in simple use cases.

## The signal emitted when this object is succesfully interacted with.
signal interacted(interactor : Player)

@export_group('Collision')
## The shape of the collision area for this interactable.
@export var shape : Shape3D:
	set(val):
		if _collision_shape:
			_collision_shape.shape = val
		shape = val
## The position of the collision area for this interactable.
@export var collision_position := Vector3.ZERO:
	set(val):
		if _collision_shape:
			_collision_shape.position = val
		collision_position = val
## Whether this interactable is currently listening for interaction.[br]
## Note that this is not a single source of truth for the elligibility of this scene for interaction, but it is the final word-- `true` does not necessarily mean you can interact with the interactable, but `false` definitely means that you cannot.
@export var _active := true

@export_group("Config")
## The key which the player can press to interact with the object.
@export var interact_button : InputEventKey
## The maximum distance in meters from which the player can interact with the object.
@export var max_distance : = 2.0
## The message which appears on the player's screen when the interactable is usable and in focus.
@export var message: String
## A descriptive key for this interactable object, usually for the purpose of blocking it's use when the player is in certain states.
@export var interactable_key : StringName

@onready var _collision_shape = %CollisionShape3D

# TODO: I think there's some work to be done here around containerizing all logic to this file.
# Really, there should only be one public function on this class which determines if the interactable is active and interacts with it if so.
# Also, the shape of this class should probably be a manually added child node, similar to the AreaTrigger class.

# NOTE: this seems to be necessary for nested interactables, as is the case with Doors
func _ready():
	_collision_shape.shape = shape
	_collision_shape.position = collision_position


## Emits the `interacted` signal when appropriate.
func interact(interactor : Player) -> void:
	interacted.emit(interactor)


## Returns the elligibility of the object for interaction. Extending classes will often add more logic here for more complicated use cases.
func get_interactive() -> bool:
	return _active


## Make the object elligible for potential interaction.
func activate() -> void:
	_active = true


## Make the object inelligible for potential interaction.
func deactivate() -> void:
	_active = false
