class_name PhoneChatState extends PhoneUIState

var NEW_MESSAGES : MessageList
var DRAFT := ""
var BEFORE_TYPING_TIMER := 2.0
var BEFORE_TYPING_TIMER_ON := false
var TYPING_TIMER := 2.0
var TYPING_TIMER_ON := false
var CONTACT : TextContact

func enter(previous_state : PhoneUIState, ext := {}):
	super(previous_state, ext)
	if ext.has("contact"):
		CONTACT = ext.contact
		SCREEN.activate(ext.contact)
	if ext.has("active") and ext.active:
		SCREEN.activate_draft()
		SCREEN.ACTIVE = true
		Global.PLAYER.STATE_MACHINE.lock()
		Global.PLAYER_PHONE.STATE_MACHINE.lock()
		SCREEN.BACK_BUTTON.disabled = true
	if ext.has("new_exchange") and ext.new_exchange:
		NEW_MESSAGES = ext.new_exchange

func input(event):
	if NEW_MESSAGES and NEW_MESSAGES.MESSAGES.size() > 0 and NEW_MESSAGES.MESSAGES[0] is UserMessage:
		if Input.is_action_just_pressed("enter"):
			if DRAFT == NEW_MESSAGES.MESSAGES[0].MESSAGE:
				send()
			return
		if event is InputEventKey and event.pressed == true:
			var keycode = event.keycode
			var is_alpha = keycode >= KEY_A && keycode <= KEY_Z
			if is_alpha:
				add_character(NEW_MESSAGES.MESSAGES[0].MESSAGE)

func add_character(finished_message : String):
	if Global.Debug.skip_typing:
		DRAFT = finished_message
	else:
		DRAFT = finished_message.left(DRAFT.length() + 2)
	SCREEN.DRAFT = DRAFT

func send():
	var text = NEW_MESSAGES.MESSAGES.pop_front()
	SCREEN.send_text(text)
	CONTACT.TEXT_EXCHANGES[-1].MESSAGES.append(text)
	DRAFT = ""
	check_next_message()

func start_response(message: ContactMessage):
	if Global.Debug.skip_wait_times:
		BEFORE_TYPING_TIMER = 0.1
	else:
		BEFORE_TYPING_TIMER = message.TIME_BEFORE_TYPING
	BEFORE_TYPING_TIMER_ON = true

func update(delta):
	super(delta)
	if BEFORE_TYPING_TIMER_ON:
		BEFORE_TYPING_TIMER -= delta
	elif TYPING_TIMER_ON:
		TYPING_TIMER -= delta
	if BEFORE_TYPING_TIMER < 0:
		BEFORE_TYPING_TIMER = 0
		BEFORE_TYPING_TIMER_ON = false
		var text = NEW_MESSAGES.MESSAGES[0]
		start_typing(text)
	elif TYPING_TIMER < 0:
		TYPING_TIMER = 0
		TYPING_TIMER_ON = false
		var text = NEW_MESSAGES.MESSAGES.pop_front()
		SCREEN.receive_text(text)
		CONTACT.TEXT_EXCHANGES[-1].MESSAGES.append(text)
		check_next_message()
	SCREEN.keep_scroll_at_bottom()

func start_typing(message: ContactMessage):
	if Global.Debug.skip_wait_times:
		TYPING_TIMER = 0.1
	else:
		TYPING_TIMER = message.TIME_TYPING
	TYPING_TIMER_ON = true
	SCREEN.set_typing()
	TYPING_TIMER_ON = true

func check_next_message():
	if NEW_MESSAGES.MESSAGES.size() == 0:
		end_conversation()
		return
	if NEW_MESSAGES.MESSAGES[0] is ContactMessage:
		start_response(NEW_MESSAGES.MESSAGES[0])
		return
	else:
		SCREEN.activate_draft()

func end_conversation():
	SCREEN.ACTIVE = false
	Global.PLAYER.STATE_MACHINE.unlock()
	Global.PLAYER_PHONE.STATE_MACHINE.unlock()
	SCREEN.BACK_BUTTON.disabled = false

