extends LevelState

func enter(previous_state, ext):
	Events.conversation_ended.connect(_on_conversation_ended)
	super(previous_state, ext)
	var bart = World.npcs.Bart
	var player_chair = World.important_scenes.PlayerChair
	var bart_chair = World.important_scenes.BartChair
	bart.global_position = bart_chair.sit_marker.global_position
	World.player.global_position = player_chair.sit_marker.global_position
	World.player.current_movement.transition('Sit', { "seat": player_chair })
	World.player.movement_state_machine.lock()
	bart.current_movement.transition('Sit', { "seat": bart_chair })


func exit():
	super()
	World.player.movement_state_machine.unlock()
	Events.conversation_ended.disconnect(_on_conversation_ended)


func _on_conversation_ended(npc : NPC):
	if npc == World.npcs.Bart:
		transition('WaitForAmandaText')