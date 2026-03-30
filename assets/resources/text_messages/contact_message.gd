@tool
class_name ContactMessage
extends TextMessage

@export var TIME_BEFORE_TYPING := 0.5
@export var time_before_typing := 0.5

@export var TIME_TYPING := 2.0
@export var time_typing := 2.0

func __migrate__():
	time_before_typing = TIME_BEFORE_TYPING
	time_typing = TIME_TYPING
