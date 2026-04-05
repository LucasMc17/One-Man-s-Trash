class_name ContactMessage
extends TextMessage
## A text message sent by a contact and received by the player.

## How long the contact will wait before beginning to type the text in seconds[br]
## (if the player is actively in the phone chat state when this text initializes).
@export var time_before_typing := 0.5
## How long the contact will type before sending the text in seconds[br]
## (if the player is actively in the phone chat state when this text initializes).
@export var time_typing := 2.0