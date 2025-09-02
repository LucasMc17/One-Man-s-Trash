class_name NPCState extends ActorState

func enter(previous_state, ext):
	super(previous_state, ext)
	ACTOR.make_label()