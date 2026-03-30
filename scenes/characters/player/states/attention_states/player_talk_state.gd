class_name TalkState
extends PlayerAttentionState
## The player's attention state while speaking with an NPC.

## Tracks the the player's x rotation prior to beginning conversation, for reverting after conversation is over.
var _prev_x_rotation : float
## Tracks the the player's y rotation prior to beginning conversation, for reverting after conversation is over.
var _prev_y_rotation : float
## The x rotation the player needs to rotate to to face the NPC.
var _target_x_rotation : float
## The y rotation the player needs to rotate to to face the NPC.
var _target_y_rotation : float
## The next state which the player's attention should move to when dialog ends.
var _next_state_name : StringName = ""
## The extension object to pass to the next state.
var _next_state_ext := {}
## Whether or not the player is currently exiting dialog (lerping away from target rotation).
var _exiting := false
## The TalkTree to display in the dialog layer.
var _talk_tree : TalkTree
## The NPC currently being spoken with.
var _talking_to : NPC

func _ready():
	disable_movement = true
	disable_input = true
	_capture_mouse = false
	Events.dialog_chosen.connect(_on_dialog_chosen)


func update(delta):
	super(delta)
	if _exiting:
		_lerp_away_from_target()
		if actor.rotation.y < _prev_y_rotation + 0.01 && actor.rotation.y > _prev_y_rotation - 0.01:
			if actor.camera_controller.rotation.x < _prev_x_rotation + 0.01 && actor.camera_controller.rotation.x > _prev_x_rotation - 0.01:
				super.transition(_next_state_name, _next_state_ext)
	else:
		_lerp_toward_target()


func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	_prev_x_rotation = actor.camera_controller.rotation.x
	_prev_y_rotation = actor.rotation.y

	if ext.has('talk_tree') and ext.has('talking_to'):
		actor.talking_to = ext.talking_to
		ext.talk_tree.activate(ext.talking_to)
		actor.dialog_layer.talk_tree = _talk_tree

	actor.dialog_layer.visible = true
	
	actor.kill_camera_momentum()


func exit():
	_prev_x_rotation = 0.0
	_prev_y_rotation = 0.0
	_target_x_rotation = 0.0
	_target_y_rotation = 0.0
	_exiting = false
	_talking_to = null


func transition(new_state_name : StringName, ext := {}):
	if !Global.player.attention_state_machine.disabled:
		actor.dialog_layer.visible = false
		_next_state_name = new_state_name
		_next_state_ext = ext
		_exiting = true


## Steadily move the player's camera rotation towards the target NPC.
func _lerp_toward_target() -> void:
	actor.rotation.y = lerp_angle(actor.rotation.y, _target_y_rotation, 0.15)
	actor.camera_controller.rotation.x = lerp_angle(actor.camera_controller.rotation.x, _target_x_rotation, 0.15)


## Steadily move the player's camera rotation away from the target NPC and back towards their starting rotation.
func _lerp_away_from_target() -> void:
	actor.rotation.y = lerp_angle(actor.rotation.y, _prev_y_rotation, 0.15)
	actor.camera_controller.rotation.x = lerp_angle(actor.camera_controller.rotation.x, _prev_x_rotation, 0.15)


## Event listener for dialog option chosen.
func _on_dialog_chosen(npc : NPC, talk_tree: TalkTree) -> void:
	_talking_to = npc
	_talk_tree = talk_tree
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
	
	var direction = target - actor.camera_controller.global_position
	var normalized = direction.normalized()
	_target_y_rotation = atan2(-normalized.x, -normalized.z)

	var distance = sqrt(direction.x ** 2  + direction.z ** 2)
	var x_direction = Vector2(distance, direction.y)
	_target_x_rotation = atan2(x_direction.y, x_direction.x)
