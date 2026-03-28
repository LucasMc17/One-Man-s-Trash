class_name NPCAttentionState
extends NPCState
## Attention state for use by an NPC.

## Whether or not the NPC can currently be engaged in dialog by the player.
var talk_enabled := true

func enter(previous_state, ext):
	super(previous_state, ext)
	actor.debug_label.change_param('attention',name)
