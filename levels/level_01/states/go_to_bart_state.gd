extends LevelState

var talk_tree = preload('res://scenes/characters/npcs/bart/dialog/bathroom_chat/bart_bathroom_chat.tres')

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.NPCS.Bart.TALK_TREE = talk_tree
	Global.IMPORTANT_SCENES.BathroomDoor.is_locked = false
	Global.IMPORTANT_SCENES.BathroomInvisP.queue_free()
	Events.conversation_ended.connect(_on_conversation_ended)

func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)

func _on_conversation_ended(npc : NPC):
	if npc == Global.NPCS.Bart:
		transition('LookForScrewdriverState')
