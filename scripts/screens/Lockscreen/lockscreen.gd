extends Control

@onready var password_input = $Password
@onready var message_label = $Message

var password_correct = "MrFabio23"

func _on_login_button_pressed():
	var password = password_input.text
	
	if password == password_correct:
		message_label.text = "Entrando..."
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://screens/desktop.tscn")
	else:
		message_label.text = "Usuário ou senha incorretos."

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_login_button_pressed()
