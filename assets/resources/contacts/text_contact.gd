class_name TextContact
extends Resource
## A resource representing a contact in the player's phone, including their contact name,
## contact photo and a list of time stamped text exchanges.

## All past text exchanges with this contact in chronological order from oldest to newest
@export var TEXT_EXCHANGES : Array[MessageList]

## The contact's name
@export var CONTACT_NAME : String

## The contact's photo. Should be 100 x 100 pixels in size
# @export var CONTACT_PHOTO : Image

# March, 2026 code refactor : save resources for last, we have some questions to answer about how to best store long conversations, and editing property names tends to destroy the data in game.