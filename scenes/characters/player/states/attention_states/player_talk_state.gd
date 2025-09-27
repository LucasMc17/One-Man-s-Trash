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
	DISABLE_MOVEMENT = true
	DISABLE_INPUT = true
	CAPTURE_MOUSE = false
	Events.dialog_chosen.connect(_on_dialog_chosen)

func update(delta):
	super(delta)
	if _EXITING:
		lerp_away_from_target()
		if ACTOR.rotation.y < PREV_Y_ROTATION + 0.01 && ACTOR.rotation.y > PREV_Y_ROTATION - 0.01:
			if ACTOR.CAMERA_CONTROLLER.rotation.x < PREV_X_ROTATION + 0.01 && ACTOR.CAMERA_CONTROLLER.rotation.x > PREV_X_ROTATION - 0.01:
				super.transition(_NEXT_STATE_NAME, _NEXT_STATE_EXT)
	else:
		lerp_toward_target()

func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	PREV_X_ROTATION = ACTOR.CAMERA_CONTROLLER.rotation.x
	PREV_Y_ROTATION = ACTOR.rotation.y

	if ext.has('TALK_TREE') and ext.has('TALKING_TO'):
		ACTOR.talking_to = ext.TALKING_TO
		ext.TALK_TREE.activate(ext.TALKING_TO)
		ACTOR.DIALOGUE_LAYER.TALK_TREE = TALK_TREE

	ACTOR.DIALOGUE_LAYER.visible = true
	
	# if previous_state._movement_enabled:
	# 	keep_momentum = true
	# prev_state = previous_state
	ACTOR.kill_camera_momentum()

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
	print('leaving the talk state')
	if !Global.PLAYER.ATTENTION_STATE_MACHINE.DISABLED:
		ACTOR.DIALOGUE_LAYER.visible = false
		_NEXT_STATE_NAME = new_state_name
		_NEXT_STATE_EXT = ext
		_EXITING = true

func lerp_toward_target():
	ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, TARGET_Y_ROTATION, 0.15)
	ACTOR.CAMERA_CONTROLLER.rotation.x = lerp_angle(ACTOR.CAMERA_CONTROLLER.rotation.x, TARGET_X_ROTATION, 0.15)

func lerp_away_from_target():
	ACTOR.rotation.y = lerp_angle(ACTOR.rotation.y, PREV_Y_ROTATION, 0.15)
	ACTOR.CAMERA_CONTROLLER.rotation.x = lerp_angle(ACTOR.CAMERA_CONTROLLER.rotation.x, PREV_X_ROTATION, 0.15)

func _on_dialog_chosen(npc : NPC, talk_tree: TalkTree):
	TALKING_TO = npc
	TALK_TREE = talk_tree
	var target : Vector3

	if talk_tree.FOCUS_TYPE == "DEFAULT":
		target = npc.FOCUS_MARKER.global_position
	elif talk_tree.FOCUS_TYPE == "NPC":
		var FOCUS_NPC = Global.NPCS[talk_tree.FOCUS_NPC]
		if FOCUS_NPC is NPC:
			target = FOCUS_NPC.FOCUS_MARKER.global_position
		else:
			push_warning('NO NPC BY THAT NAME FOUND')
			target = npc.FOCUS_MARKER.global_position
	elif talk_tree.FOCUS_TYPE == "OBJECT":
		var FOCUS_OBJECT = Global.IMPORTANT_SCENES[talk_tree.FOCUS_OBJECT]
		if FOCUS_OBJECT:
			target = FOCUS_OBJECT.global_position
		else:
			push_warning('NO SCENE BY THAT NAME FOUND')
			target = npc.FOCUS_MARKER.global_position
	elif talk_tree.FOCUS_TYPE == "POINT":
		target = talk_tree.FOCUS_POINT
	
	var direction = target - ACTOR.CAMERA_CONTROLLER.global_position
	var normalized = direction.normalized()
	TARGET_Y_ROTATION = atan2(-normalized.x, -normalized.z)

	var distance = sqrt(direction.x ** 2  + direction.z ** 2)
	var x_direction = Vector2(distance, direction.y)
	TARGET_X_ROTATION = atan2(x_direction.y, x_direction.x)
