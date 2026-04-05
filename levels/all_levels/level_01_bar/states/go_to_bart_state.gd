extends LevelState

func enter(previous_state, ext):
	super(previous_state, ext)
	World.npcs.Bart.get_talk_tree('bathroom_chat')
	World.important_scenes.BathroomDoor.is_locked = false
	World.important_scenes.BathroomInvisP.queue_free()
	Events.conversation_ended.connect(_on_conversation_ended)


func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)


func _on_conversation_ended(npc : NPC):
	if npc == World.npcs.Bart:
		transition('LookForScrewdriverState')
