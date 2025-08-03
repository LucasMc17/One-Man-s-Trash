class_name NPCTalkState extends NPCState

var prev_state : NPCState

func enter(previous_state, ext): 
	super(previous_state, ext)
	prev_state = previous_state
	ACTOR.look_at(Global.PLAYER.global_position)
	# var direction = POINT.global_position - ACTOR.global_position

func exit():
	super()
	prev_state = null

func return_to_last_state():
	if prev_state:
		transition(prev_state.name)