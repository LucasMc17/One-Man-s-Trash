extends MeshInstance3D

# EXPORTS
@export_group("Phone State")
@export var y_position := -0.183
@export var active := false

# FUNCS
func activate():
	active = true
	y_position = 0.0

func deactivate():
	active = false
	y_position = -0.183

# BUILT INS
func _process(_delta):
	position.y = lerp(position.y, y_position, 0.1)