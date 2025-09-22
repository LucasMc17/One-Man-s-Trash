extends Button

var is_exit := false
var TALK_TREE : TalkTree

signal option_clicked(talk_tree : TalkTree)

func _pressed():
	if is_exit:
		Global.PLAYER.exit_dialogue()
	else:
		option_clicked.emit(TALK_TREE)
		Events.dialog_chosen.emit(Global.PLAYER.talking_to, TALK_TREE.BEHAVIOR_FLAGS)
