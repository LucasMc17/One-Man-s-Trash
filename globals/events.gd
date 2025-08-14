extends Node

## Signal fired when the player received a text message, prompting a phone notification
## and possibly locking the player into the chat state when answred until conversation is complete
signal text_received(contact : TextContact, new_messages : MessageList)