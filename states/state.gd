class_name State extends Node

signal transitioned(new_state_name: StringName, ext : Dictionary)

func transition(new_state_name : StringName, ext := {}):
	transitioned.emit(new_state_name, ext)

func enter(previous_state : State, ext : Dictionary):
	pass

func exit():
	pass

func update(delta: float):
	pass

func physics_update(delta: float):
	pass

func input(event: InputEvent):
	pass
