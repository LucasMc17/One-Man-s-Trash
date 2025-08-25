extends Node

## Signal fired when the player received a text message, prompting a phone notification
## and possibly locking the player into the chat state when answred until conversation is complete
signal text_received(contact : TextContact, new_messages : MessageList)

## Signal fired when the Level's current state changes
signal level_state_changed(new_state : LevelState)

## Signal fired when the current level is loaded completely
signal level_loaded()

## Signal fired when a player's conversation is ended
signal conversation_ended(npc : NPC)

## Signal fired when a player's text conversation ends
signal texting_ended(contact : TextContact)