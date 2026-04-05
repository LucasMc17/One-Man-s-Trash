class_name UserMessage
extends TextMessage
## A text message sent by the player to a text contact.

## If there are any strings in this array, the player will type and then backspace through them in sequence before typing the final message.
@export var false_starts : Array[String]
