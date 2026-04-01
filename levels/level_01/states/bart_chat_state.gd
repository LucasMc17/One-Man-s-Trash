extends LevelState

func enter(previous_state, ext):
	Events.conversation_ended.connect(_on_conversation_ended)
	super(previous_state, ext)
	var bart = Global.npcs.Bart
	var player_chair = Global.important_scenes.PlayerChair
	var bart_chair = Global.important_scenes.BartChair
	bart.global_position = bart_chair.sit_marker.global_position
	Global.player.global_position = player_chair.sit_marker.global_position
	Global.player.current_movement.transition('Sit', { "seat": player_chair })
	Global.player.movement_state_machine.lock()
	bart.current_movement.transition('Sit', { "seat": bart_chair })


func exit():
	super()
	Global.player.movement_state_machine.unlock()
	Events.conversation_ended.disconnect(_on_conversation_ended)


func _on_conversation_ended(npc : NPC):
	if npc == Global.npcs.Bart:
		transition('WaitForAmandaText')