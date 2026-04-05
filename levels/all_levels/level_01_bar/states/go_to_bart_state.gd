extends LevelState

var talk_tree = load(Paths.get_dialog_path('bart', 'bathroom_chat'))

func enter(previous_state, ext):
	super(previous_state, ext)
	World.npcs.Bart.talk_tree = talk_tree
	World.important_scenes.BathroomDoor.is_locked = false
	World.important_scenes.BathroomInvisP.queue_free()
	Events.conversation_ended.connect(_on_conversation_ended)


func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)


func _on_conversation_ended(npc : NPC):
	if npc == World.npcs.Bart:
		transition('LookForScrewdriverState')
