extends Control

func _ready() -> void:
	$Window/Documentos.hide()
	$Window/Download.hide()
	limpar_visualizador()

# Essa função agora é sua melhor amiga: ela reseta o lado direito
func limpar_visualizador():
	$Window/ArquivosAbertos/Aviso.show()
	$Window/ArquivosAbertos/Planilha.hide()
	$Window/ArquivosAbertos/Comprovante.hide()

func _on_documentos_pressed() -> void:
	$Window/Documentos.show()
	$Window/Download.hide()
	# NOVIDADE: Limpa o que estava aberto na direita ao trocar de aba
	limpar_visualizador()

func _on_downloads_pressed() -> void:
	$Window/Download.show()
	$Window/Documentos.hide()
	# NOVIDADE: Limpa o que estava aberto na direita ao trocar de aba
	limpar_visualizador()

func _on_imagens_pressed() -> void:
	$Window/Documentos.hide()
	$Window/Download.hide()
	limpar_visualizador()

func _on_videos_pressed() -> void:
	$Window/Documentos.hide()
	$Window/Download.hide()
	limpar_visualizador()

# --- FUNÇÕES DOS ARQUIVOS (IGUAIS ANTERIORMENTE) ---

func _on_planilha_pressed() -> void:
	$Window/ArquivosAbertos/Aviso.hide()
	$Window/ArquivosAbertos/Planilha.show()
	$Window/ArquivosAbertos/Comprovante.hide()

func _on_comprovante_pressed() -> void:
	$Window/ArquivosAbertos/Aviso.hide()
	$Window/ArquivosAbertos/Comprovante.show()
	$Window/ArquivosAbertos/Planilha.hide()
