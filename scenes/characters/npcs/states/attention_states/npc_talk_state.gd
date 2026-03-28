class_name NPCTalkState
extends NPCAttentionState
## The attention state which the NPC should enter when engaged in dialog by the player.

func _ready():
	disable_movement = true


func physics_update(delta):
	super(delta)
	actor.look_at_player()