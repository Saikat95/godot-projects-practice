extends Node2D

onready var PaddleNode: = get_node("CanvasLayer/Paddle/Sprite");
export var next_scene:PackedScene;

func _on_ChangeRight_pressed() -> void:
	if(PaddleNode.frame == 3):
		PaddleNode.frame = 0;
	else:
		PaddleNode.frame += 1;


func _on_ChangeLeft_pressed() -> void:
	if(PaddleNode.frame == 0):
		PaddleNode.frame = 3;
	else:
		PaddleNode.frame -= 1;

func _on_Button_pressed() -> void:
	PlayerData.paddleFrame = PaddleNode.frame;
	get_tree().change_scene_to(next_scene);
