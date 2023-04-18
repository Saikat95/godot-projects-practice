extends KinematicBody2D

onready var speed = get_parent().get_node("Background").bgSpeed;

var velocity = Vector2.ZERO;

#func _physics_process(delta: float) -> void:
#	velocity.x -= speed * delta;
#	move_and_slide(velocity,Vector2.ZERO);
#	if(velocity.x < -200):
#		velocity.x = -200;

func _process(delta: float) -> void:
	position += Vector2.LEFT * speed * delta;

func _on_ScoreDetection_body_entered(body: Node) -> void:
	if (body.is_in_group("Player")):
		Global.score += 1;


func _on_Death_body_entered(body: Node) -> void:
	if(body.has_method("player_hit")):
		body.player_hit();
		

func _on_Player_player_hit() -> void:
	speed = 0;
	queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free();
