extends Button

func _on_checkBtn_pressed() -> void:
	get_tree().change_scene("res://src/Levels/Level1.tscn")
	GlobalScore.restart()
