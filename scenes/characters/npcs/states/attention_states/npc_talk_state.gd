class_name NPCTalkState extends NPCAttentionState

func _ready():
	DISABLE_MOVEMENT = true

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	# ACTOR.look_at(Global.PLAYER.global_position)
	# ACTOR.rotation.x = 0
	# ACTOR.rotation.z = 0
	# var direction = (Global.PLAYER.gloabl_position - ACTOR.global_position).normalized()
	# ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, atan2(-direction.x, -direction.z), 0.15)
	# var direction = POINT.global_position - ACTOR.global_position

func physics_update(delta):
	super(delta)
	ACTOR.look_at_player()