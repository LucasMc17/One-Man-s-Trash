extends LevelWaitState

func enter(previous_state, ext):
	super(previous_state, ext)
	Global.NPCS.Bart.current_movement.transition('GoToBathroom')
	var bathroom_door : Door = Global.IMPORTANT_SCENES.BathroomDoor
	Events.npc_movement_changed.connect(func (npc, new_movement, old_movement):
		if npc == Global.NPCS.Bart && new_movement == 'IdleMovement' && old_movement == 'GoToBathroom':
			bathroom_door.is_open = false)
	
