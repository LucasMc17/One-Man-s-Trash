class_name PlayerStatus
extends PanelContainer
## Debug UI component representing info about the player.

@onready var _state_label := %State
@onready var _velocity_label := %Velocity
@onready var _direction_label := %Direction
@onready var _fps_label := %FPS

func _ready():
	Global.debug.player_status = self
	if Global.debug.debug_override == "DEFER":
		visible = Global.debug.show_player_status


func _process(delta):
	_fps_label.text = "%.2f" % (1.0 / delta)


## Update the label for the player's current velocity.
func update_velocity(new_velocity : String) -> void:
	_velocity_label.text = new_velocity


## Update the label for the player's current state.
func update_state(state_name : String) -> void:
	_state_label.text = state_name


## Update the label for the player's current direction.
func update_direction(new_direction : String) -> void:
	_direction_label.text = new_direction
