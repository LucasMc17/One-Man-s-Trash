extends VBoxContainer

## The TalkTree resource currently displayed in the dialog_layer.
@export var talk_tree : TalkTree:
	set(val):
		if val:
			if val.camera_id:
				if Global.cameras.has(val.camera_id):
					Global.player.camera.current = false
					Global.cameras[val.camera_id].current = true
				else:
					push_warning('WARNING: No Camera by that ID found')
					Global.log('WARNING: No Camera by that ID found')
			else:
				if talk_tree:
					if Global.cameras.has(talk_tree.camera_id):
						Global.cameras[talk_tree.camera_id].current = false
					Global.player.camera.current = true
			if _npc_line:
				_npc_line.text = val.dialog
			if _player_options:
				for child in _player_options.get_children():
					child.queue_free()
				for option in val.player_options:
					var button = _dialog_option.instantiate()
					button.option_clicked.connect(_on_option_clicked)
					button.text = option.prompt
					button.talk_tree = option
					_player_options.add_child(button)
				if val.exit_option.length() > 0:
					var button = _dialog_option.instantiate()
					button.text = val.exit_option
					button.is_exit = true
					_player_options.add_child(button)
		talk_tree = val

## preloaded dialog option scene
var _dialog_option = preload("./dialogue_option.tscn")

@onready var _npc_line : Label = %NPCLine
@onready var _player_options : VBoxContainer = %PlayerOptions

## Event listener.
func _on_option_clicked(new_talk_tree : TalkTree):
	talk_tree = new_talk_tree
