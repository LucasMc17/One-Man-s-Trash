class_name NPCAttentionState extends NPCState

var TALK_ENABLED := true

func enter(previous_state, ext):
	super(previous_state, ext)
	ACTOR.DEBUG_LABEL.change_param('attention',name)
