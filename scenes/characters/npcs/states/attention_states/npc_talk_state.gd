class_name NPCTalkState extends NPCAttentionState

func _ready():
	DISABLE_MOVEMENT = true

func physics_update(delta):
	super(delta)
	ACTOR.look_at_player()