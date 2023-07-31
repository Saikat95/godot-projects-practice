extends KinematicBody2D

var bullet_speed = Vector2.ZERO;

func _process(delta: float) -> void:
	var move = bullet_fire(delta)
	position.y = move.y * delta;
	
func bullet_fire(delta) -> Vector2:
	bullet_speed.y += -5000;
	return bullet_speed
