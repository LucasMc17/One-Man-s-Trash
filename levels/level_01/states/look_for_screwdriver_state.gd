extends LevelState

var talk_tree = load(Paths.get_dialog_path('bart', 'stool_chat'))

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.NPCS.Bart.TALK_TREE = talk_tree