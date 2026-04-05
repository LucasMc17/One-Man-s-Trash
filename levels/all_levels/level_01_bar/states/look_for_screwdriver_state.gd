extends LevelState

func enter(previous_state, ext):
	super(previous_state, ext)
	Events.conversation_ended.connect(_on_conversation_ended)
	World.npcs.Bart.get_talk_tree("bathroom_chat", "urge")
	World.npcs.Bartender.get_talk_tree("ask_for_screwdriver")
	World.npcs.Mike.get_talk_tree("ask_for_screwdriver")
	World.npcs.Jordan.get_talk_tree("ask_for_screwdriver")
	World.npcs.Josie.get_talk_tree("ask_for_screwdriver")


func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)


func _on_conversation_ended(npc : NPC):
	if npc == World.npcs.Bartender:
		npc.talk_tree = null