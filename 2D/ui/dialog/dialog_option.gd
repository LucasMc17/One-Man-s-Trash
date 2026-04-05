extends Button

## Whether the dialog option represents an exit option.
var is_exit := false
## The TalkTree resource this option represents.
var talk_tree : TalkTree

## The signal emitted when this option is clicked and selected by the player in dialog.
signal option_clicked(talk_tree : TalkTree)

## Event listener.
func _pressed():
	if is_exit:
		World.player.exit_dialogue()
	else:
		talk_tree.activate(World.player.talking_to)
		option_clicked.emit(talk_tree)
