class_name State extends Node

signal transitioned(new_state_name: StringName, ext : Dictionary)

func transition(new_state_name : StringName, ext := {}):
	transitioned.emit(new_state_name, ext)

func enter(_previous_state : State, _ext : Dictionary):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func input(_event: InputEvent):
	pass
