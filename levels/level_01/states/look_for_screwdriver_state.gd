extends LevelState

var bart_urge = load(Paths.get_dialog_path('bart', 'bathroom_chat', 'urge'))
var bartender_dialog = load(Paths.get_dialog_path('bartender', 'ask_for_screwdriver'))
var mike_dialog = load(Paths.get_dialog_path('mike', 'ask_for_screwdriver'))
var jordan_dialog = load(Paths.get_dialog_path('jordan', 'ask_for_screwdriver'))
var josie_dialog = load(Paths.get_dialog_path('josie', 'ask_for_screwdriver'))

func enter(previous_state, ext):
	Global.log(mike_dialog)
	super(previous_state, ext)
	Events.conversation_ended.connect(_on_conversation_ended)
	Global.npcs.Bart.TALK_TREE = bart_urge
	Global.npcs.Bartender.TALK_TREE = bartender_dialog
	Global.npcs.Mike.TALK_TREE = mike_dialog
	Global.npcs.Jordan.TALK_TREE = jordan_dialog
	Global.npcs.Josie.TALK_TREE = josie_dialog


func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)
	Global.npcs.Bartender.INTERACTABLE.monitorable = true


func _on_conversation_ended(npc : NPC):
	pass
	if npc == Global.npcs.Bartender:
		npc.TALK_TREE = null