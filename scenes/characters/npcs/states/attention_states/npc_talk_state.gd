class_name NPCTalkState extends NPCAttentionState

func _ready():
	DISABLE_MOVEMENT = true

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	# ACTOR.look_at(Global.PLAYER.global_position)
	ACTOR.rotation.x = 0
	ACTOR.rotation.z = 0
	# var direction = POINT.global_position - ACTOR.global_position
