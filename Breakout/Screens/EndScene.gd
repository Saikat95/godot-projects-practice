extends Node2D

export (String,FILE) var scene;

func _ready() -> void:
	$CanvasLayer/Score.text = "Score: " + str(PlayerData.score);
	
	if(PlayerData.health == 0):
		$CanvasLayer/Hearts.text = "Hearts left: " + str(PlayerData.health);
	else:
		$CanvasLayer/Hearts.text = "Hearts left: " + str(PlayerData.health+1);


func _on_Button_pressed() -> void:
	get_tree().change_scene(scene);
	PlayerData.health = 5;
	PlayerData.score = 0;
