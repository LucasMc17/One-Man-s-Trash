class_name PlayerMovementState extends PlayerState

var GRAVITY_ENABLED := true

func update(delta):
	super(delta)
	if GRAVITY_ENABLED:
		PLAYER.update_gravity(delta)

# func update(delta):
	# not working yet
	# if get_script() != self.get_script(): # Simple check to see if it's the base script
	# 	push_warning('Movement states should not extend the `update` function. Extend `movement_update` instead.')
	# super(delta)
	# if !PLAYER.current_attention.DISABLE_MOVEMENT:
	# 	movement_update(delta)

# func movement_update(delta):
# 	pass

func input(event):
	# if get_script() != self.get_script(): # Simple check to see if it's the base script
	# 	push_warning('Movement states should not extend the `input` function. Extend `movement_input` instead.')
	super(event)
	if !PLAYER.current_attention.DISABLE_INPUT:
		movement_input(event)

func movement_input(event):
	pass