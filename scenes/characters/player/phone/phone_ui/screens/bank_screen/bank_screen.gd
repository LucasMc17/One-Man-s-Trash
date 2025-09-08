extends Control

@onready var BALANCE := %Balance

func _ready():
	Events.balance_changed.connect(_on_balance_changed)

func _on_balance_changed(new_balance : float):
	BALANCE.text = str(new_balance)