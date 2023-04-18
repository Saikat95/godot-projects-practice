extends Node2D

var score  = 0;

func _ready() -> void:
	get_tree().paused = true;
	$GameSound.play();
	

func _on_UI_start_game() -> void:
	get_tree().paused = false;
	$UserInerface/UI/StartButton.visible = false;



func _on_Bird_hit() -> void:
	$UserInerface/UI/RetryButton.visible = true;
	$GameSound.stop();
	$GameOver.play();
