extends HBoxContainer

@onready var _npcs = %NPCs
@onready var _movement_states = %MovementStates
@onready var _attention_states = %AttentionStates

func _ready():
	_get_all_npcs()


## Utility function to clear and then re-populate the attention and movement state menus when an NPC is selected.
func _populate_states(npc : NPC) -> void:
	for child in _movement_states.get_children():
		child.queue_free()
	for child in _attention_states.get_children():
		child.queue_free()
	for state in npc.MOVEMENT_STATE_MACHINE.states.values():
		if state is NPCMovementState:
			var button_scene = Button.new()
			button_scene.text = state.name
			button_scene.pressed.connect(func (): npc.current_movement.transition(state.name))
			_movement_states.add_child(button_scene)
	for state in npc.ATTENTION_STATE_MACHINE.states.values():
		if state is NPCAttentionState:
			var button_scene = Button.new()
			button_scene.text = state.name
			button_scene.pressed.connect(func (): npc.current_attention.transition(state.name))
			_attention_states.add_child(button_scene)


## Function which finds all NPCs in the scene, creates a button for them and connects that button to the above `_populate_states` function.
func _get_all_npcs() -> void:
	for child in _npcs.get_children():
		child.queue_free()
	for npc in get_tree().get_nodes_in_group('NPCs'):
		if npc is NPC:
			var button_scene = Button.new()
			button_scene.pressed.connect(func(): _populate_states(npc))
			button_scene.text = npc.name
			_npcs.add_child(button_scene)

# REFACTORED TO BEST PRACTICE, MARCH 2026