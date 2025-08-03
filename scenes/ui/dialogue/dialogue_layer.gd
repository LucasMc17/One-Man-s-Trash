extends VBoxContainer

# PRELOADS
var DIALOGUE_OPTION = preload("./dialogue_option.tscn")

# EXPORTS
@export var TALK_TREE : TalkTree:
	set(val):
		if val:
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
