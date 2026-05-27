extends Button

func _on_pressed() -> void:
	#var visualizador = $"../../MiddleBar/Arquivos1"
	#var sidebar = $"/root/ExplorerPanel/Window/Sidebar/Sidebar3"
	##visualizador.move_to_front()
	#visualizador.show()
	#sidebar.move_to_front()
	get_tree().change_scene_to_file("res://windows/Explorer/ExplorerDownloads.tscn")
