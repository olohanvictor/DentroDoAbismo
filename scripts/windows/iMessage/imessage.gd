extends Control

@onready var contacts = [
	$Window/contact1,
	$Window/contact2
]

@onready var chats = [
	$Window/ChatNatalia,
	$Window/ChatPauloRoger
]

func _ready():
	for button in contacts:
		button.pressed.connect(selected_chat.bind(button))

func selected_chat(button):
	if button == contacts[0]:
		for chat in chats:
			chat.hide()
		$Window/ChatPauloRoger.show()
	else:
		$Window/ChatNatalia.show()
