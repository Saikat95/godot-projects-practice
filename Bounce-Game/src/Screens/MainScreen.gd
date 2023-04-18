extends Control

export (String,FILE) var scene;

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene(scene);


func _on_QuitButton_pressed() -> void:
	get_tree().quit();
