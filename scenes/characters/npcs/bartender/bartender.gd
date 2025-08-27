@tool 
class_name Bartender extends NPC

# EXPORTS
@export_category("Movement")
@export var POINT_A := Vector3.ZERO:
	set(val):
		if MP_A:
			MP_A.global_position = val
		POINT_A = val
@export var POINT_B := Vector3.ZERO:
	set(val):
		if MP_B:
			MP_B.global_position = val
		POINT_B= val

# NODES
@onready var MP_A = %MP_A
@onready var MP_B = %MP_B
