@tool
class_name TextMessage
extends Resource

@export_multiline var MESSAGE : String
@export_multiline var message : String

func __migrate__():
	message = MESSAGE
