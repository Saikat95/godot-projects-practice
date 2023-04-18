extends Control

signal start_game;
signal replay_game;

func _on_StartButton_pressed() -> void:
	emit_signal("start_game");
	print("Start Buton Pressed");
	$StartButton.hide();


func _on_ReplayButton_pressed() -> void:
	emit_signal("replay_game");
	print("Replay Buton Pressed");
	$ReplayButton.hide();
