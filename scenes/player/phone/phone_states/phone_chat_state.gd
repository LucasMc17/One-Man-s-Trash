class_name PhoneChatState extends PhoneUIState

var NEW_MESSAGES : MessageList
var DRAFT := ""
var TIMER := 1000.0
var TIMER_ON := false
var CONTACT : TextContact

func enter(previous_state : PhoneUIState, ext := {}):
	super(previous_state, ext)
	if ext.has("contact"):
		CONTACT = ext.contact
		SCREEN.activate(ext.contact)
	if ext.has("active") and ext.active:
		Global.PLAYER.STATE_MACHINE.lock()
		Global.PLAYER_PHONE.STATE_MACHINE.lock()
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
		DRAFT = finished_message.left(DRAFT.length() + 1)
	SCREEN.DRAFT = DRAFT

func send():
	var text = NEW_MESSAGES.MESSAGES.pop_front()
	SCREEN.send_text(text)
	CONTACT.TEXT_EXCHANGES[-1].MESSAGES.append(text)
	DRAFT = ""
	check_next_message()

func start_response(message: ContactMessage):
	if Global.Debug.skip_wait_times:
		TIMER = 0.1
	else:
		TIMER = message.TIME_TYPING
	TIMER_ON = true

func update(delta):
	if TIMER_ON:
		TIMER -= delta
	if TIMER < 0:
		TIMER = 0
		TIMER_ON = false
		var text = NEW_MESSAGES.MESSAGES.pop_front()
		SCREEN.receive_text(text)
		CONTACT.TEXT_EXCHANGES[-1].MESSAGES.append(text)
		check_next_message()

func check_next_message():
	if NEW_MESSAGES.MESSAGES.size() == 0:
		end_conversation()
		return
	if NEW_MESSAGES.MESSAGES[0] is ContactMessage:
		start_response(NEW_MESSAGES.MESSAGES[0])
		return

func end_conversation():
	Global.PLAYER.STATE_MACHINE.unlock()
	Global.PLAYER_PHONE.STATE_MACHINE.unlock()
