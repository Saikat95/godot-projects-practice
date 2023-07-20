extends Control


func _on_Restart_pressed() -> void:
	Music.click_sound();
	get_tree().change_scene("res://Scene/Main.tscn");


func _on_Resume_pressed() -> void:
	Music.click_sound();
	get_parent().get_node("Grid").resume_play();
