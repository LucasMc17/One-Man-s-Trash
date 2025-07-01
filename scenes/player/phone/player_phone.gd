extends MeshInstance3D

# EXPORTS
@export_group("Phone State")
@export var y_position := -0.19
@export var y_rotation := 90.0:
	# set(val):
	# 	y_rotation = deg_to_rad(val)
	get():
		return deg_to_rad(y_rotation)
@export var active := false

# FUNCS
func activate():
	active = true
	y_position = 0.0
	y_rotation = 0.0

func deactivate():
	active = false
	y_position = -0.19
	y_rotation = 90.0

# BUILT INS
func _process(_delta):
	position.y = lerp(position.y, y_position, 0.1)
	rotation.y = lerp(rotation.y, y_rotation, 0.1)
