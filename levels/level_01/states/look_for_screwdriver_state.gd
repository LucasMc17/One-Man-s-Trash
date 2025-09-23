extends LevelState

var bart_urge = load(Paths.get_dialog_path('bart', 'bathroom_chat', 'urge'))
var bartender_dialog = load(Paths.get_dialog_path('bartender', 'ask_for_screwdriver'))
var mike_dialog = load(Paths.get_dialog_path('mike', 'ask_for_screwdriver'))

func enter(previous_state, ext):
	Global.log(mike_dialog)
	super(previous_state, ext)
	Events.conversation_ended.connect(_on_conversation_ended)
	Global.NPCS.Bart.TALK_TREE = bart_urge
	Global.NPCS.Bartender.TALK_TREE = bartender_dialog
	Global.NPCS.Mike.TALK_TREE = mike_dialog

func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)
	Global.NPCS.Bartender.INTERACTABLE.monitorable = true

func _on_conversation_ended(npc : NPC):
	pass
	if npc == Global.NPCS.Bartender:
		npc.TALK_TREE = null