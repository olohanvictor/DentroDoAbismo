extends Panel

var current_wifi = ""

var normal_style = preload("res://styles/wifipanel/buttons/normal.tres")
var selected_style = preload("res://styles/wifipanel/buttons/selected.tres")

@onready var wifi_buttons = [
	$wifi1,
	$wifi2,
	$wifi3
]

func _ready():
	for button in wifi_buttons:
		button.pressed.connect(select_wifi.bind(button))

func select_wifi(button):
	current_wifi = button.name
	
	for wifi_button in wifi_buttons:
		wifi_button.add_theme_stylebox_override("normal", normal_style)
	
	button.add_theme_stylebox_override("normal", selected_style)
