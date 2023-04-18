extends Node2D

var obstacle = preload("res://Character/obstacles.tscn")
var player = preload("res://Character/dino.tscn")
onready var animatedSprite = $Player/AnimatedSprite

func _ready() -> void:
	animatedSprite.play("jump");

func _on_SpawnTimer_timeout() -> void:
	var obs = obstacle.instance();
	obs.position = Vector2(1200,490);
	add_child(obs);

func _on_Player_player_hit() -> void:
	var obs = obstacle.instance();
	$Buttons.show_gameover()


func _on_Start_pressed() -> void:
	$Buttons.start_game()
 
