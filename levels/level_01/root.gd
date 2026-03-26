extends Node3D

# TODO: Again, gotta make a level class/scene which this should inherit from.

@onready var state_machine = %StateMachine

## How many NPCs the player has asked for a screwdriver.
var npcs_asked_for_screwdrivers := 0

## The amount of money the player has spent at the bar
var bar_tab : float:
	set(val):
		bar_tab = val
		Global.log(bar_tab)

# TODO: I really hate these virtual properties. Don't do this.
var current_state : LevelState:
	get():
		return state_machine.CURRENT_STATE

func _ready():
	Global.level = self
	Events.level_loaded.emit()
	Events.dialog_chosen.connect(_on_dialog_chosen)
	var mike = Global.npcs.Mike
	var mike_chair = Global.important_scenes.MikeChair
	mike.global_position = mike_chair._sit_marker.global_position
	mike.current_movement.transition('Sit', { "seat": mike_chair })


## Event listener for global event.
func _on_dialog_chosen(npc : NPC, talk_tree : TalkTree):
	if talk_tree.NEXT_TALK_TREE is TalkTree:
		npc.talk_tree = talk_tree.NEXT_TALK_TREE
	if talk_tree.BEHAVIOR_FLAGS.has('SET_NPC_TALK_TREE'):
		var other_npc = talk_tree.BEHAVIOR_FLAGS.SET_NPC_TALK_TREE[0]
		var new_talk_tree = talk_tree.BEHAVIOR_FLAGS.SET_NPC_TALK_TREE[1]
		Global.npcs[other_npc].talk_tree = new_talk_tree
	# if talk_tree.BEHAVIOR_FLAGS.has("CHANGE_TREE_BY_PATH"):
	# 	npc.talk_tree = talk_tree.BEHAVIOR_FLAGS.CHANGE_TREE_BY_PATH
	if talk_tree.BEHAVIOR_FLAGS.has("ASK_FOR_SCREWDRIVER"):
		npcs_asked_for_screwdrivers += 1
	if talk_tree.BEHAVIOR_FLAGS.has("ADD_TO_TAB"):
		bar_tab += talk_tree.BEHAVIOR_FLAGS.ADD_TO_TAB


## Event listener.
func _on_bart_bathroom_oneoff_entered(_area, _body):
	Global.important_scenes.BathroomDoor.is_open = false

# REFACTORED TO BEST PRACTICE, MARCH 2026
