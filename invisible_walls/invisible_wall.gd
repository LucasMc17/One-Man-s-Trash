class_name InvisibleWall extends StaticBody3D

@export var PLAYER_ONLY := false

func _ready():
	if PLAYER_ONLY:
		set_collision_layer_value(1, false)
