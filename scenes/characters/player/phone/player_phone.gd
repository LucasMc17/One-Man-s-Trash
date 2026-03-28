class_name Phone
extends MeshInstance3D
## The Player's phone as a 3d scene.

## The Y position which the phone should move toward in local space.
var _y_position := -0.19
## The Y rotation which the phone should pivot toward in local space.
var _y_rotation := 90.0:
	get():
		return deg_to_rad(_y_rotation)

func activate():
	_y_position = 0.0
	_y_rotation = 0.0

func deactivate():
	_y_position = -0.19
	_y_rotation = 90.0

# BUILT INS
func _process(_delta):
	position.y = lerp(position.y, _y_position, 0.1)
	rotation.y = lerp(rotation.y, _y_rotation, 0.1)
