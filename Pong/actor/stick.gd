extends KinematicBody2D

var velocity = Vector2.ZERO;
export var speed = 300;

func _on_BallHit_area_exited(area: Area2D) -> void:
	$BallHit/HitSound.play();
