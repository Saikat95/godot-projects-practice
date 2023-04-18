extends Node2D

export var  speed = 5;

func _process(delta: float) -> void:
	position.x -= speed;
