class_name PlayerStatus extends Panel

@onready var STATE = %State
var state : StringName:
	set(val):
		STATE.text = val
		state = val

@onready var VELOCITY = %Velocity
var velocity : String:
	set(val):
		VELOCITY.text = val
		velocity = val

@onready var DIRECTION = %Direction
var direction : String:
	set(val):
		DIRECTION.text = val
		direction = val

@onready var FPS = %FPS
var fps : String:
	set(val):
		FPS.text = val
		fps = val

func _ready():
	Global.Debug.PLAYER_STATUS = self
	if Global.Debug.debug_override or Global.Debug.show_player_status:
		visible = true
	else:
		visible = false

func _process(delta):
	fps = "%.2f" % (1.0 / delta)
