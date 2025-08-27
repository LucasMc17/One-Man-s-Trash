class_name PlayerFreelookState extends PlayerAttentionState

func _ready():
	CAN_INTERACT = true
	CAN_USE_PHONE = true

func update(delta):
	ACTOR.update_camera(delta)
	super(delta)
