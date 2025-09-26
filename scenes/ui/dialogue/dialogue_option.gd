extends Button

var is_exit := false
var TALK_TREE : TalkTree

signal option_clicked(talk_tree : TalkTree)

func _pressed():
	if is_exit:
		Global.PLAYER.exit_dialogue()
	else:
		TALK_TREE.activate(Global.PLAYER.talking_to)
		option_clicked.emit(TALK_TREE)
