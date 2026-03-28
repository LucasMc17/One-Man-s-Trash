class_name PlayerPhoneState
extends PlayerAttentionState
## The state wherein the player's attention is focused on their phone.

func _ready():
	disable_movement = true
	disable_input = true
	_capture_mouse = false


func enter(previous_state : State = null, ext := {}):
	super(previous_state, ext)
	actor.phone.activate()
	actor.kill_camera_momentum()


func exit():
	actor.phone.deactivate()
	Global.player_phone.CURRENT_STATE.transition('HomeState')


func input(event):
	if event.is_action_pressed("phone"):
		transition('Freelook')
