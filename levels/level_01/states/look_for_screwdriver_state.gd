extends LevelState

var bart_urge = load(Paths.get_dialog_path('bart', 'bathroom_chat', 'urge'))
var bartender_dialog = load(Paths.get_dialog_path('bartender', 'ask_for_screwdriver'))
var mike_dialog = load(Paths.get_dialog_path('mike', 'ask_for_screwdriver'))
var jordan_dialog = load(Paths.get_dialog_path('jordan', 'ask_for_screwdriver'))
var josie_dialog = load(Paths.get_dialog_path('josie', 'ask_for_screwdriver'))

func enter(previous_state, ext):
	super(previous_state, ext)
	Events.conversation_ended.connect(_on_conversation_ended)
	Global.npcs.Bart.talk_tree = bart_urge
	Global.npcs.Bartender.talk_tree = bartender_dialog
	Global.npcs.Mike.talk_tree = mike_dialog
	Global.npcs.Jordan.talk_tree = jordan_dialog
	Global.npcs.Josie.talk_tree = josie_dialog


func exit():
	super()
	Events.conversation_ended.disconnect(_on_conversation_ended)


func _on_conversation_ended(npc : NPC):
	pass
	if npc == Global.npcs.Bartender:
		npc.talk_tree = null