class_name State extends Node

signal transition(new_state_name: StringName)

func enter(previous_state):
	pass

func exit():
	pass

func update(delta: float):
	pass

func physics_update(delta: float):
	pass

func input(event: InputEvent):
	pass
