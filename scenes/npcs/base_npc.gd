@tool
class_name NPC extends AnimatableBody3D

# @export var MOVEMENT_POINTS : Array[Vector3]:
# 	set(val):
# 		if POINT_HOLDER:
# 			# print(POINT_HOLDER.get_owner(), POINT_HOLDER.get_children())
# 			for point in POINT_HOLDER.get_children():
# 				point.free()
# 			for i in val.size():
# 				var point = val[i]
# 				var marker = Marker3D.new()
# 				marker.position = point
# 				# marker.set_owner(POINT_HOLDER)
# 				# marker.gizmo_extents = 1.0
# 				POINT_HOLDER.add_child(marker)
# 				print(marker.get_parent())
# 		MOVEMENT_POINTS = val

# NODES
@onready var POINT_HOLDER = %MovementPoints