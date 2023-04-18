extends Control

signal start_game;
signal retry_game;

func _on_StartButton_pressed() -> void:
	$StartButton.visible = false;
	emit_signal("start_game");
	#get_parent().get_parent().get_node("GameSound").play();

func _on_RetryButton_pressed() -> void:
	$RetryButton.visible = false;
	get_tree().reload_current_scene();
	emit_signal("retry_game");
