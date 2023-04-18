extends Actor

export var impulse = 1000.0;

var death = 1;

func _on_PlayerImpulse_area_entered(area: Area2D) -> void:
	velocity.y = -impulse;

func _on_EnemyDetector_body_entered(body: Node) -> void:
	get_node("Timer");
	die();


func _physics_process(delta: float) -> void:
	var direction = get_direction();
	velocity = get_move_direction(velocity,direction,speed);
	velocity = move_and_slide(velocity,FLOOR_NORMAL);

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("move_up") and is_on_floor() else 1.0
		);

func get_move_direction(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:

	var new_velocity = linear_velocity;
	new_velocity.x = direction.x * speed.x;
	new_velocity.y += gravity * get_physics_process_delta_time();
	if(direction.y == -1.0):
		new_velocity.y = direction.y * speed.y;
	return new_velocity;

func die() -> void:
	PlayerData.death += death;
	queue_free();
	
