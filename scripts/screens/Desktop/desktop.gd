extends Control

@onready var appspanels = {
	$Wifi: $WifiPanel,
	$Dock/iMessage: $iMessagePanel,
	$Dock/eMail: $eMailPanel,
	$Dock/Explorer: $ExplorerPanel
}

func _ready() -> void:
	for button in appspanels:
		button.pressed.connect(opened_app.bind(button))

func opened_app(button) -> void:
	var panel = appspanels[button]
	panel.visible = !panel.visible
	
	if panel.visible:
		panel.move_to_front()
