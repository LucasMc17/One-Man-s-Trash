extends Control

@onready var _balance : Label = %Balance

func _ready():
	Events.balance_changed.connect(_on_balance_changed)


## Event listener.
func _on_balance_changed(new_balance : float):
	_balance.text = str(new_balance)