extends LevelState

func enter(previous_state, ext):
	Events.conversation_ended.connect(_on_conversation_ended)
	super(previous_state, ext)
	var bart = Global.NPCS.Bart
	var player_chair = Global.IMPORTANT_SCENES.PlayerChair
	var bart_chair = Global.IMPORTANT_SCENES.BartChair
	bart.global_position = bart_chair.SIT_MARKER.global_position
	Global.PLAYER.global_position = player_chair.SIT_MARKER.global_position
	Global.PLAYER.current_movement.transition('Sit', { "seat": player_chair })
	Global.PLAYER.MOVEMENT_STATE_MACHINE.lock()
	bart.current_movement.transition('Sit', { "seat": bart_chair })

func exit():
	super()
	Global.PLAYER.MOVEMENT_STATE_MACHINE.unlock()
	Events.conversation_ended.disconnect(_on_conversation_ended)

func _on_conversation_ended(npc : NPC):
	if npc == Global.NPCS.Bart:
		transition('WaitForAmandaText')