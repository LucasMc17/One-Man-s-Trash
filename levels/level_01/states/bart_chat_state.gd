extends LevelState

func enter(previous_state, ext):
	super(previous_state, ext)
	var bart = Global.NPCS.Bart
	var player_chair = Global.IMPORTANT_SCENES.PlayerChair
	var bart_chair = Global.IMPORTANT_SCENES.BartChair
	bart.global_position = bart_chair.SIT_MARKER.global_position
	Global.PLAYER.global_position = player_chair.SIT_MARKER.global_position
	Global.PLAYER.current_state.transition('SittingState', { "seat": player_chair })
	bart.current_state.transition('SittingState', { "seat": bart_chair })