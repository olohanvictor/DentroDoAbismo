extends Control

@onready var folders_na_sidebar = [
	$Window/Sidebar/folder1,
	$Window/Sidebar/folder2,
	$Window/Sidebar/folder3,
	$Window/Sidebar/folder4,
	$Window/Sidebar/folder5,
	$Window/Sidebar/folder6,
	$Window/Sidebar/folder7
]

@onready var folder_aberto = [
	$Window/ChatLaura,
	$Window/ChatRodrigo
]

func _ready():
	$Window/Downloads.hide()
	pass


func _on_folder_2_pressed() -> void:
	$Window/Downloads.show()# Replace with function body.
