class_name PhoneChatState
extends PhoneUIState
## The UI state for the phone's chat screen.

## The new messages being actively sent, if any.
var _new_messages : MessageList
## What is currently typed into the player's chat bar.
var _draft := ""
## How long in seconds the contact will wait before starting to respond. Actively counts down.
var _before_typing_timer := 2.0
## Whether or not the `_before_typing_timer` is currently counting down.
var _before_typing_timer_on := false
## How long in seconds the contact will take to finish typing their response. Actively counts down.
var _typing_timer := 2.0
## Whether or not the `_typing_timer` is currently counting down.
var _typing_timer_on := false
## The contact this chat is with.
var _contact : TextContact

func enter(prev_state : PhoneUIState, ext := {}):
	super(prev_state, ext)
	if ext.has("contact"):
		_contact = ext.contact
		_screen.activate(ext.contact)
	if ext.has("active") and ext.active:
		_screen.activate_draft()
		_screen.active = true
		Global.player.attention_state_machine.lock()
		Global.player_phone.state_machine.lock()
		_screen.back_button.disabled = true
	if ext.has("new_exchange") and ext.new_exchange:
		_new_messages = ext.new_exchange


func input(event):
	if _new_messages and _new_messages.messages.size() > 0 and _new_messages.messages[0] is UserMessage:
		if Input.is_action_just_pressed("enter"):
			if _draft == _new_messages.messages[0].message:
				_send()
			return
		if event is InputEventKey and event.pressed == true:
			var keycode = event.keycode
			var is_alpha = keycode >= KEY_A && keycode <= KEY_Z
			if is_alpha:
				_add_character(_new_messages.messages[0].message)


func update(delta):
	super(delta)
	if _before_typing_timer_on:
		_before_typing_timer -= delta
	elif _typing_timer_on:
		_typing_timer -= delta
	if _before_typing_timer < 0:
		_before_typing_timer = 0
		_before_typing_timer_on = false
		var text = _new_messages.messages[0]
		_start_typing(text)
	elif _typing_timer < 0:
		_typing_timer = 0
		_typing_timer_on = false
		var text = _new_messages.messages.pop_front()
		_screen.receive_text(text)
		_contact.text_exchanges[-1].messages.append(text)
		_check_next_message()


## Add a character to the draft from the player's next message in the exchange.
func _add_character(finished_message : String):
	if Global.debug.skip_typing:
		_draft = finished_message
	else:
		_draft = finished_message.left(_draft.length() + 2)
	_screen.draft = _draft


## Send the player's completed message.
func _send():
	var text = _new_messages.messages.pop_front()
	_screen.send_text(text)
	_contact.text_exchanges[-1].messages.append(text)
	_draft = ""
	_check_next_message()


## begin the process of receiving a response from the contact.
func _start_response(message: ContactMessage):
	if Global.debug.skip_wait_times:
		_before_typing_timer = 0.1
	else:
		_before_typing_timer = message.time_before_typing
	_before_typing_timer_on = true


## Cause the contact to begin typing their response.
func _start_typing(message: ContactMessage):
	if Global.debug.skip_wait_times:
		_typing_timer = 0.1
	else:
		_typing_timer = message.time_typing
	_typing_timer_on = true
	_screen.set_typing()
	_typing_timer_on = true


## Check for the next message in the exchange, or else end the conversation.
func _check_next_message():
	if _new_messages.messages.size() == 0:
		_end_conversation()
		return
	if _new_messages.messages[0] is ContactMessage:
		_start_response(_new_messages.messages[0])
		return
	else:
		_screen.activate_draft()


## Ends the conversation and allows the player to exit the chat state.
func _end_conversation():
	Events.texting_ended.emit(_contact)
	_screen.active = false
	Global.player.attention_state_machine.unlock()
	Global.player_phone.state_machine.unlock()
	_screen.back_button.disabled = false
