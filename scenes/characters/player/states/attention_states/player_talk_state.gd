class_name TalkState extends PlayerAttentionState

var PREV_X_ROTATION : float
var PREV_Y_ROTATION : float
var TARGET_X_ROTATION : float
var TARGET_Y_ROTATION : float
var _NEXT_STATE_NAME : StringName = ""
var _NEXT_STATE_EXT := {}
var _EXITING := false
var TALK_TREE : TalkTree
var TALKING_TO : NPC

func _ready():
	disable_movement = true
	DISABLE_INPUT = true
	CAPTURE_MOUSE = false
	Events.dialog_chosen.connect(_on_dialog_chosen)

func update(delta):
	super(delta)
	if _EXITING:
		lerp_away_from_target()
		if actor.rotation.y < PREV_Y_ROTATION + 0.01 && actor.rotation.y > PREV_Y_ROTATION - 0.01:
			if actor.CAMERA_CONTROLLER.rotation.x < PREV_X_ROTATION + 0.01 && actor.CAMERA_CONTROLLER.rotation.x > PREV_X_ROTATION - 0.01:
				super.transition(_NEXT_STATE_NAME, _NEXT_STATE_EXT)
	else:
		lerp_toward_target()

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	PREV_X_ROTATION = actor.CAMERA_CONTROLLER.rotation.x
	PREV_Y_ROTATION = actor.rotation.y

	if ext.has('TALK_TREE') and ext.has('TALKING_TO'):
		actor.talking_to = ext.TALKING_TO
		ext.TALK_TREE.activate(ext.TALKING_TO)
		actor.DIALOGUE_LAYER.TALK_TREE = TALK_TREE

	actor.DIALOGUE_LAYER.visible = true
	
	# if previous_state._movement_enabled:
	# 	keep_momentum = true
	# prev_state = previous_state
	actor.kill_camera_momentum()

func exit():
	PREV_X_ROTATION = 0.0
	PREV_Y_ROTATION = 0.0
	TARGET_X_ROTATION = 0.0
	TARGET_Y_ROTATION = 0.0
	_EXITING = false
	# keep_momentum = false
	# prev_state = null
	TALKING_TO = null

func transition(new_state_name : StringName, ext := {}):
	if !Global.player.ATTENTION_STATE_MACHINE.DISABLED:
		actor.DIALOGUE_LAYER.visible = false
		_NEXT_STATE_NAME = new_state_name
		_NEXT_STATE_EXT = ext
		_EXITING = true

func lerp_toward_target():
	actor.rotation.y = lerp_angle(actor.rotation.y, TARGET_Y_ROTATION, 0.15)
	actor.CAMERA_CONTROLLER.rotation.x = lerp_angle(actor.CAMERA_CONTROLLER.rotation.x, TARGET_X_ROTATION, 0.15)

func lerp_away_from_target():
	actor.rotation.y = lerp_angle(actor.rotation.y, PREV_Y_ROTATION, 0.15)
	actor.CAMERA_CONTROLLER.rotation.x = lerp_angle(actor.CAMERA_CONTROLLER.rotation.x, PREV_X_ROTATION, 0.15)

func _on_dialog_chosen(npc : NPC, talk_tree: TalkTree):
	TALKING_TO = npc
	TALK_TREE = talk_tree
	var target : Vector3

	if talk_tree.FOCUS_TYPE == "DEFAULT":
		target = npc.focus_marker.global_position
	elif talk_tree.FOCUS_TYPE == "NPC":
		var FOCUS_NPC = Global.npcs[talk_tree.FOCUS_NPC]
		if FOCUS_NPC is NPC:
			target = FOCUS_NPC.focus_marker.global_position
		else:
			push_warning('NO NPC BY THAT NAME FOUND')
			target = npc.focus_marker.global_position
	elif talk_tree.FOCUS_TYPE == "OBJECT":
		var FOCUS_OBJECT = Global.important_scenes[talk_tree.FOCUS_OBJECT]
		if FOCUS_OBJECT:
			target = FOCUS_OBJECT.global_position
		else:
			push_warning('NO SCENE BY THAT NAME FOUND')
			target = npc.focus_marker.global_position
	elif talk_tree.FOCUS_TYPE == "POINT":
		target = talk_tree.FOCUS_POINT
	
	var direction = target - actor.CAMERA_CONTROLLER.global_position
	var normalized = direction.normalized()
	TARGET_Y_ROTATION = atan2(-normalized.x, -normalized.z)

	var distance = sqrt(direction.x ** 2  + direction.z ** 2)
	var x_direction = Vector2(distance, direction.y)
	TARGET_X_ROTATION = atan2(x_direction.y, x_direction.x)
