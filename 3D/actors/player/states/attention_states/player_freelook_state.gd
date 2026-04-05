class_name PlayerFreelookState
extends PlayerAttentionState
## The player's unrestricted free look state.

func _ready():
	can_interact = true
	_can_use_phone = true


func update(delta):
	actor.update_camera(delta)
	super(delta)
