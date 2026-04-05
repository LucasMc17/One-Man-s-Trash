@tool
class_name TalkInteractable
extends Interactable
## Interactable instance specifically for speaking with NPCs.

## The NPC with which interacting will trigger dialog.
@export var actor : NPC

func get_interactive() -> bool:
	return super() and actor.talk_tree != null
