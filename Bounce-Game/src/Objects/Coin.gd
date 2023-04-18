extends Area2D

export var score: = 10;

onready var anime_play:AnimationPlayer = get_node("AnimationPlayer")

func _on_Coin_body_entered(body: Node) -> void:
	anime_play.play("vanish");
	PlayerData.score += score;
