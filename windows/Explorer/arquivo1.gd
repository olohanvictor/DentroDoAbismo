extends Button

func _on_toggled(toggled_on: bool) -> void:
	var visualizador = $"../Invalido"

	if toggled_on:
		visualizador.show()
	else:
		visualizador.hide()
