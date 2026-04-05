class_name MessageList
extends Resource
## A custom resource representing a complete exchange of user and contact texts, complete with a time stamp indicating when it began.

## The list of messages in the exchange, in order.
@export var messages : Array[TextMessage]
## The time at which the exchange began.
@export var time_stamp := "12:00 PM"
