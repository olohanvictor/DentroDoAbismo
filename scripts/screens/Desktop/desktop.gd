extends Control

@onready var anim = $CanvasLayer/AnimationPlayer

@onready var appspanels = {
	$Dock/iMessage: $iMessagePanel,
	$Dock/eMail: $eMailPanel,
	$Dock/Explorer: $ExplorerPanel,
	$Dock/Spotlite: $SpotlitePanel,
	$Dock/Browser: $BrowserPanel
}

func _ready() -> void:
	for button in appspanels:
		if is_instance_valid(button):
			button.pressed.connect(opened_app.bind(button))

	var botoes_vazios = [$Topbar/Config, $Topbar/Search, $Topbar/User, $Topbar/Wifi]
	
	for btn in botoes_vazios:
		if is_instance_valid(btn):
			# Aqui também forçamos o reinício para os botões da Topbar
			btn.pressed.connect(func(): 
				anim.stop() 
				anim.play("vazio")
			)

func opened_app(button) -> void:
	var panel = appspanels[button]
	
	if is_instance_valid(panel):
		panel.visible = !panel.visible
		
		if panel.visible:
			panel.move_to_front()
			
			# O TRUQUE: Paramos a animação atual antes de dar o play
			# Isso força ela a voltar para o frame 0
			anim.stop() 
			
			if button == $Dock/Spotlite or button == $Dock/Browser:
				anim.play("vazio")
			else:
				anim.play("fala")
