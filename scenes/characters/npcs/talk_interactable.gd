@tool
class_name TalkInteractable extends Interactable

@export var ACTOR : NPC

func get_interactive() -> bool:
	return super() and ACTOR.TALK_TREE != null
