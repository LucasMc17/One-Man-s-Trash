class_name PhoneUI
extends Control
## The 2D UI of the player's phone.

@onready var state_machine = %StateMachine

## Virtual property returning the state machine's current state.
var current_state : PhoneUIState:
	get():
		return state_machine.CURRENT_STATE

func _ready():
	Global.player_phone = self
