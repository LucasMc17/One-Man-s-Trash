extends LevelState

var talk_tree = load(Paths.get_dialog_path('bart', 'bathroom_chat'))

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.npcs.Bart.TALK_TREE = talk_tree
	Global.important_scenes.BathroomDoor.is_locked = false
	Global.important_scenes.BathroomInvisP.queue_free()
	Events.conversation_ended.connect(_on_conversation_ended)

func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)

func _on_conversation_ended(npc : NPC):
	if npc == Global.npcs.Bart:
		transition('LookForScrewdriverState')
