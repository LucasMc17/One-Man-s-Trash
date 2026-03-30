@tool
class_name UserMessage extends TextMessage

@export var FALSE_STARTS : Array[String]
@export var false_starts : Array[String]

func __migrate__():
	false_starts = FALSE_STARTS