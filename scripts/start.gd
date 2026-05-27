extends Control
@onready var anim = $CanvasLayer/AnimationPlayer

func _on_start_pressed() -> void:
	anim.play("transicao")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://screens/lockscreen.tscn")
