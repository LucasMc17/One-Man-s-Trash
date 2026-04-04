extends Node3D

# TODO: Again, gotta make a level class/scene which this should inherit from.

## How many NPCs the player has asked for a screwdriver.
var _npcs_asked_for_screwdrivers := 0
## The amount of money the player has spent at the bar.
var _bar_tab : float:
	set(val):
		_bar_tab = val
## Virtual property exposing the level's current state.
var current_state : LevelState:
	get():
		return state_machine.current_state

@onready var state_machine = %StateMachine

func _ready():
	World.current_level = self
	Events.level_loaded.emit()
	Events.dialog_chosen.connect(_on_dialog_chosen)
	var mike = World.npcs.Mike
	var mike_chair = World.important_scenes.MikeChair
	mike.global_position = mike_chair.sit_marker.global_position
	mike.current_movement.transition('Sit', { "seat": mike_chair })


## Event listener for global event.
func _on_dialog_chosen(npc : NPC, talk_tree : TalkTree):
	if talk_tree.next_talk_tree is TalkTree:
		npc.talk_tree = talk_tree.next_talk_tree
	if talk_tree.behavior_flags.has('SET_NPC_TALK_TREE'):
		var other_npc = talk_tree.behavior_flags.SET_NPC_TALK_TREE[0]
		var new_talk_tree = talk_tree.behavior_flags.SET_NPC_TALK_TREE[1]
		World.npcs[other_npc].talk_tree = new_talk_tree
	# if talk_tree.behavior_flags.has("CHANGE_TREE_BY_PATH"):
	# 	npc.talk_tree = talk_tree.behavior_flags.CHANGE_TREE_BY_PATH
	if talk_tree.behavior_flags.has("ASK_FOR_SCREWDRIVER"):
		_npcs_asked_for_screwdrivers += 1
	if talk_tree.behavior_flags.has("ADD_TO_TAB"):
		_bar_tab += talk_tree.behavior_flags.ADD_TO_TAB


## Event listener.
func _on_bart_bathroom_oneoff_entered(_area, _body):
	World.important_scenes.BathroomDoor.is_open = false

