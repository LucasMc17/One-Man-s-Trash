extends HBoxContainer

@onready var NPCS = %NPCs
@onready var MOVEMENT_STATES = %MovementStates
@onready var ATTENTION_STATES = %AttentionStates

func _populate_states(npc : NPC):
	for child in MOVEMENT_STATES.get_children():
		child.queue_free()
	for child in ATTENTION_STATES.get_children():
		child.queue_free()
	for state in npc.MOVEMENT_STATE_MACHINE.states.values():
		if state is NPCMovementState:
			var button_scene = Button.new()
			button_scene.text = state.name
			button_scene.pressed.connect(func (): npc.current_movement.transition(state.name))
			MOVEMENT_STATES.add_child(button_scene)
	for state in npc.ATTENTION_STATE_MACHINE.states.values():
		if state is NPCAttentionState:
			var button_scene = Button.new()
			button_scene.text = state.name
			button_scene.pressed.connect(func (): npc.current_attention.transition(state.name))
			ATTENTION_STATES.add_child(button_scene)

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
