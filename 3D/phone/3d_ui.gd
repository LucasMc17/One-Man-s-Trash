class_name UI3D
extends Node3D
## Class for a 2D user interface in 3D space. Useful for screens in the 3d game world. Translates click events into local, 2D space.

# TODO: this is hard coded to work with the phone ui FOR NOW. a later step will be to make it flexible to any 2d UI element.

## Used for checking if the mouse is inside the Area3D.
var _is_mouse_inside := false
## The last processed input touch/mouse event. Used to calculate relative movement.
var _last_event_pos2D := Vector2()

@onready var _subviewport : SubViewport = %SubViewport
@onready var _ui_mesh : MeshInstance3D = %MeshInstance3D
@onready var _ui_area : Area3D = %Area3D

func _ready() -> void:
	if _subviewport:
		_ui_mesh.mesh.surface_get_material(0).albedo_texture = _subviewport.get_texture()
	_ui_area.mouse_entered.connect(_mouse_entered_area)
	_ui_area.mouse_exited.connect(_mouse_exited_area)
	_ui_area.input_event.connect(_mouse_input_event)


func _unhandled_input(event: InputEvent) -> void:
	# Check if the event is a non-mouse/non-touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via Physics Picking.
			return
	_subviewport.push_input(event)


func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Get mesh size to detect edges and make conversions. This code only supports PlaneMesh and QuadMesh.
	var quad_mesh_size: Vector2 = _ui_mesh.mesh.size

	# Event position in Area3D in world coordinate space.
	var event_pos3D := event_position

	# Current time in seconds since engine start.
	var now := Time.get_ticks_msec() / 1000.0

	# Convert position to a coordinate space relative to the Area3D node.
	# NOTE: `affine_inverse()` accounts for the Area3D node's scale, rotation, and position in the scene!
	event_pos3D = _ui_mesh.global_transform.affine_inverse() * event_pos3D

	# TODO: Adapt to bilboard mode or avoid completely.

	var event_pos2D := Vector2()

	if _is_mouse_inside:
		# Convert the relative event position from 3D to 2D.
		event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)

		# Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		# We need to convert it into the following range: -0.5 -> 0.5
		event_pos2D.x = event_pos2D.x / quad_mesh_size.x
		event_pos2D.y = event_pos2D.y / quad_mesh_size.y
		# Then we need to convert it into the following range: 0 -> 1
		event_pos2D.x += 0.5
		event_pos2D.y += 0.5

		# Finally, we convert the position to the following range: 0 -> viewport.size
		event_pos2D.x *= _subviewport.size.x
		event_pos2D.y *= _subviewport.size.y
		# We need to do these conversions so the event's position is in the viewport's coordinate system.

	elif _last_event_pos2D != null:
		# Fall back to the last known event position.
		event_pos2D = _last_event_pos2D

	# Set the event's position and global position.
	event.position = event_pos2D
	if event is InputEventMouse:
		event.global_position = event_pos2D

	# Calculate the relative event distance.
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		# If there is not a stored previous position, then we'll assume there is no relative motion.
		if _last_event_pos2D == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# the previous position from the new position. This will give us the distance the event traveled from prev_pos.
		else:
			event.relative = event_pos2D - _last_event_pos2D

	# Update _last_event_pos2D with the position we just calculated.
	_last_event_pos2D = event_pos2D

	# Finally, send the processed input event to the viewport.
	_subviewport.push_input(event)


## Event listner.
func _mouse_entered_area() -> void:
	_is_mouse_inside = true
	# Notify the viewport that the mouse is now hovering it.
	_subviewport.notification(NOTIFICATION_VP_MOUSE_ENTER)


## Event listner.
func _mouse_exited_area() -> void:
	# Notify the viewport that the mouse is no longer hovering it.
	_subviewport.notification(NOTIFICATION_VP_MOUSE_EXIT)
	_is_mouse_inside = false

