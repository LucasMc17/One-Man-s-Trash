@tool
class_name AnimatedMesh
extends Node3D
## A utility class for a mesh with associated animations. This is almost always for use with inherited scenes created from importing GLB files from blender.

@onready var animation_player : AnimationPlayer= %AnimationPlayer

## Play a specific animation by name.
func play_animation(animation_name : String) -> void:
	animation_player.play(animation_name)