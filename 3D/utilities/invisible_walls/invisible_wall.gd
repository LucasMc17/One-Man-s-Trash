class_name InvisibleWall
extends StaticBody3D
## An invisible wall which blocks physical bodies from passing. Can be set to affect only the player, or any body.

## Boolean representing whether or not the invisible wall will stop only the player
@export var _player_only := false

func _ready():
	if _player_only:
		set_collision_layer_value(1, false)
