class_name PlayerAttentionState
extends PlayerState
## A player state representing the player's current attention.

# TODO: standardize these names some. Also feels strange the mix of public and private.
## Whether or not the player can make inputs from this state.
var disable_input := false
## Whether or not the player can interact with interactrables from this state.
var can_interact := false
## Whether or not the current state should capture the mouse.
var _capture_mouse := true
## Whether or not the phone can be accessed from the current state.
var _can_use_phone := false

func enter(previous_state : State, ext : Dictionary):
	if _capture_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	super(previous_state, ext)


func update(delta):
	super(delta)
	if can_interact:
		actor.update_interactor(delta)


func input(event : InputEvent):
	super(event)
	if name != 'Phone' and _can_use_phone and event.is_action_pressed("phone"):
		transition("Phone")
	if can_interact and actor.looking_at and _compare_events(event, actor.looking_at.interact_button):
		actor.looking_at.interact(actor)
		