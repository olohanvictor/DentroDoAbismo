extends Panel

var dragging := false
var drag_offset := Vector2.ZERO


func _ready() -> void:
	$TopBar.gui_input.connect(_on_topbar_gui_input)

func _on_topbar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

			if dragging:
				drag_offset = global_position - get_global_mouse_position()
				move_to_front()

	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() + drag_offset


func _on_top_bar_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
