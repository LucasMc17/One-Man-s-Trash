extends VBoxContainer

# EXPORTS
@export var TALK_TREE : TalkTree:
	set(val):
		if val:
			if NPC_LINE:
				NPC_LINE.text = TALK_TREE.DIALOGUE
			# if PLAYER_OPTIONS:
		TALK_TREE = val


# NODES
@onready var NPC_LINE = %NPCLine
@onready var PLAYER_OPTIONS = %PlayerOptions
