extends HBoxContainer

@onready var NPCS = %NPCs
@onready var STATES = %States

func _populate_states(npc : NPC):
	for child in STATES.get_children():
		child.queue_free()
	for state in npc.STATE_MACHINE.states.values():
		if state is NPCState:
			var button_scene = Button.new()
			button_scene.text = state.name
			button_scene.pressed.connect(func (): npc.current_state.transition(state.name))
			STATES.add_child(button_scene)

func _get_all_npcs():
	for child in NPCS.get_children():
		child.queue_free()
	for npc in get_tree().get_nodes_in_group('NPCs'):
		if npc is NPC:
			var button_scene = Button.new()
			button_scene.pressed.connect(func(): _populate_states(npc))
			button_scene.text = npc.name
			NPCS.add_child(button_scene)

func _ready():
	_get_all_npcs()