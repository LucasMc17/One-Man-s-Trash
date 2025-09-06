extends VBoxContainer

# PRELOADS
var DIALOGUE_OPTION = preload("./dialogue_option.tscn")

# EXPORTS
@export var TALK_TREE : TalkTree:
	set(val):
		if val:
			if val.CAMERA_ID:
				if Global.CAMERAS.has(val.CAMERA_ID):
					Global.PLAYER.CAMERA.current = false
					Global.CAMERAS[val.CAMERA_ID].current = true
				else:
					push_warning('WARNING: No Camera by that ID found')
					Global.log('WARNING: No Camera by that ID found')
			else:
				if TALK_TREE:
					if Global.CAMERAS.has(TALK_TREE.CAMERA_ID):
						Global.CAMERAS[TALK_TREE.CAMERA_ID].current = false
					Global.PLAYER.CAMERA.current = true
			if NPC_LINE:
				NPC_LINE.text = val.DIALOGUE
			if PLAYER_OPTIONS:
				for child in PLAYER_OPTIONS.get_children():
					child.queue_free()
				for option in val.PLAYER_OPTIONS:
					var button = DIALOGUE_OPTION.instantiate()
					button.option_clicked.connect(_on_option_clicked)
					button.text = option.PROMPT
					button.TALK_TREE = option
					PLAYER_OPTIONS.add_child(button)
				if val.EXIT_OPTION.length() > 0:
					var button = DIALOGUE_OPTION.instantiate()
					button.text = val.EXIT_OPTION
					button.is_exit = true
					PLAYER_OPTIONS.add_child(button)
		TALK_TREE = val


# NODES
@onready var NPC_LINE = %NPCLine
@onready var PLAYER_OPTIONS = %PlayerOptions

# SIGNAL LISTENERS
func _on_option_clicked(talk_tree : TalkTree):
	TALK_TREE = talk_tree
