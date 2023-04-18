extends KinematicBody2D

var velocity = Vector2.ZERO;
export var speed = 300;
var direction = Vector2.ZERO;
signal damage;

func _physics_process(delta: float) -> void:
	#print(position);
	direction = get_direction();
	velocity = direction * speed;
	velocity = move_and_slide(velocity);

func get_direction() -> Vector2:
	if(position.x < 90 or position.x > 916):
		direction.x = -direction.x;
	if(position.y < 83):
		direction.y = -direction.y;
	
	return direction;

func _on_BodyCollision_body_entered(body: Node) -> void:
	if(body.name == 'Brick'):
		PlayerData.score += 10;
		body.queue_free();
		direction.y = -direction.y;
		Music.play_pop_music();
	
	if(body.name == 'Paddle'):
		direction.y = -direction.y;
		Music.play_paddle_music();


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	emit_signal("damage");


