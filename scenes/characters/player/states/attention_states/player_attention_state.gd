class_name PlayerAttentionState extends PlayerState

# STATE ALLOWANCES
var CAPTURE_MOUSE := true
var DISABLE_MOVEMENT := false
var DISABLE_INPUT := false
var CAN_INTERACT := false
var CAN_USE_PHONE := false

# STATE LIFECYCLE
func enter(previous_state : State, ext : Dictionary):
	if CAPTURE_MOUSE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	if !CAN_INTERACT:
		PLAYER.INTERACT_LABEL.text = ''
	super(previous_state, ext)

func update(delta):
	super(delta)
	if CAN_INTERACT:
		PLAYER.update_interactor(delta)

func input(event : InputEvent):
	super(event)
	if name != 'Phone' and CAN_USE_PHONE and event.is_action_pressed("phone"):
		transition("Phone")
	if CAN_INTERACT and PLAYER.looking_at and compare_events(event, PLAYER.looking_at.interact_button):
		PLAYER.looking_at.interact(PLAYER)