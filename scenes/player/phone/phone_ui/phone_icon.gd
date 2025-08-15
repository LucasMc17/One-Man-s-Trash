@tool
extends TextureButton

@export var NOTIFICATION := false:
	set(val):
		if NOTIFICATION_CIRCLE:
			NOTIFICATION_CIRCLE.visible = val
		NOTIFICATION = val
@export var APP_NAME := "App Name"
@export var STATE_NAME := "StateName"

@onready var NOTIFICATION_CIRCLE = %NotificationCircle
@onready var LABEL = %Label

func _ready():
	LABEL.text = APP_NAME

func _pressed():
	Global.PLAYER_PHONE.CURRENT_STATE.transition(STATE_NAME)
