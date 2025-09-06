extends LevelState

var talk_tree = preload('res://assets/resources/talk_trees/bart_bathroom_chat/urge_dialog.tres')

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.NPCS.Bart.TALK_TREE = talk_tree