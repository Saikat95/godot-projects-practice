extends Area2D

var missile_speed = Vector2.ZERO;
#var health_count: = 0 setget set_count, get_count;
var health_count = 0;

func _process(delta: float) -> void:
	var move = missile_fire(delta)
	position.y = move.y * delta;
	
func missile_fire(delta) -> Vector2:
	missile_speed.y += 400;
	return missile_speed

func _on_Missile_body_entered(body: Node) -> void:
	body.queue_free();
	queue_free();
	PlayerData.health -= 1;
	get_parent().remove_health(PlayerData.health);
	health_count += 1;

func set_count(value):
	health_count = value;

func get_count():
	return health_count
