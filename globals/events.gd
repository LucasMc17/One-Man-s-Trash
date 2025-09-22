extends Node

## Signal fired when the player received a text message, prompting a phone notification
## and possibly locking the player into the chat state when answred until conversation is complete
signal text_received(contact : TextContact, new_messages : MessageList)

## Signal fired when the Level's current state changes
signal level_state_changed(new_state : LevelState)

## Signal fired when the current level is loaded completely
signal level_loaded()

## Signal fired when a player enters conversation with an NPC
signal conversation_begun(npc : NPC)

## Signal fired when a player selects a dialog option while in conversation with an NPC
signal dialog_chosen(npc : NPC, behavior_flag : Dictionary)

## Signal fired when a player's conversation is ended
signal conversation_ended(npc : NPC)

## Signal fired when a player's text conversation ends
signal texting_ended(contact : TextContact)

## Signal fired when an npc changes their movement state
signal npc_movement_changed(npc : NPC, new_movement : StringName, previous_movement : StringName)

## Signal fired when an npc changes their attention state
signal npc_attention_changed(npc : NPC, new_attention : StringName, previous_attention : StringName)

## Signal fired when the time changes in the level so that all in game clocks can update
signal time_changed(new_time : String)

## Signal fired when the player's bank account balance changes
signal balance_changed(new_balance : float)