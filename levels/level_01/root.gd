extends Node3D

@onready var STATE_MACHINE = %StateMachine

var NPCS_ASKED_FOR_SCREWDRIVER := 0

var TAB : float:
	set(val):
		TAB = val
		Global.log(TAB)

var CURRENT_STATE : LevelState:
	get():
		return STATE_MACHINE.CURRENT_STATE

func _ready():
	print(Vector2.UP.normalized())
	Global.GameState.LEVEL = self
	Events.level_loaded.emit()
	Events.dialog_chosen.connect(_on_dialog_chosen)
	var mike = Global.NPCS.Mike
	var mike_chair = Global.IMPORTANT_SCENES.MikeChair
	mike.global_position = mike_chair.SIT_MARKER.global_position
	mike.current_movement.transition('Sit', { "seat": mike_chair })

func _on_dialog_chosen(npc : NPC, talk_tree : TalkTree):
	if talk_tree.NEXT_TALK_TREE is TalkTree:
		npc.TALK_TREE = talk_tree.NEXT_TALK_TREE
	if talk_tree.BEHAVIOR_FLAGS.has('SET_NPC_TALK_TREE'):
		var other_npc = talk_tree.BEHAVIOR_FLAGS.SET_NPC_TALK_TREE[0]
		var new_talk_tree = talk_tree.BEHAVIOR_FLAGS.SET_NPC_TALK_TREE[1]
		Global.NPCS[other_npc].TALK_TREE = new_talk_tree
	# if talk_tree.BEHAVIOR_FLAGS.has("CHANGE_TREE_BY_PATH"):
	# 	npc.TALK_TREE = talk_tree.BEHAVIOR_FLAGS.CHANGE_TREE_BY_PATH
	if talk_tree.BEHAVIOR_FLAGS.has("ASK_FOR_SCREWDRIVER"):
		NPCS_ASKED_FOR_SCREWDRIVER += 1
	if talk_tree.BEHAVIOR_FLAGS.has("ADD_TO_TAB"):
		TAB += talk_tree.BEHAVIOR_FLAGS.ADD_TO_TAB

func _on_bart_bathroom_oneoff_entered(_area, _body):
	Global.IMPORTANT_SCENES.BathroomDoor.is_open = false
