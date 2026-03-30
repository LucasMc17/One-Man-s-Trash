@tool
class_name TextContact
extends Resource
## A resource representing a contact in the player's phone, including their contact name,
## contact photo and a list of time stamped text exchanges.

## All past text exchanges with this contact in chronological order from oldest to newest
@export var text_exchanges : Array[MessageList]

## The contact's name
@export var contact_name : String

## The contact's photo. Should be 100 x 100 pixels in size
# @export var contact_photo : Image