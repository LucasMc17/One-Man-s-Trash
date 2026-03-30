@tool
class_name MessageList
extends Resource

@export var MESSAGES : Array[TextMessage]
@export var messages : Array[TextMessage]

@export var TIME_STAMP := "12:00 PM"
@export var time_stamp := "12:00 PM"

func __migrate__():
	time_stamp = TIME_STAMP
	messages = MESSAGES
